---
layout: post
title: Test drive a command line interface in python
tags:
  - continuous delivery
  - architecture
  - test driven development
author: Rob Westgeest

---

Testing the command line interface (CLI) should be just like testing a REST interface. A CLI is an adapter concern that we can test drive, separate from the business logic. In this post I'll show an approach to test drive the command line interface of an application in Python.

## Context

I am writing a utility application to create and manage invoices for clients. You may wonder why, because there are many bookkeeping applications available for this. My current bookkeeping application offers an invoicing module for an additional fee, but it is too limited for my use.

My application needs to generate PDF invoices for clients really easily. It should work for different organisational units as well, for example, my business, for my wife's, who sends out many small invoices, and for some personal business as well.

## The choice for a CLI

Since I need something quickly - generate repeated invoices for a client - and grow later - maybe integrate with the bookkeeping application, mailing the invoices, making it easy for my wife to use it and so on - I decided to make a command line interface (let's call it a script) first and maybe create a web front-end later. 

## Testing issues with scripts

I have used several command argument parsers for multiple personal projects and never bothered to test them. First of all being where personal projects, no other user would be bothered by glitches in the command line. A second reason is that scripts can be a pain to test: calling a script and capturing the output to see what it is doing is one thing. But what if the script generates (binary) files, makes changes to a database, integrates with APIs and has some business logic as well? Then integrated tests becomes a pain and simply calling the script from the command line and observing the effects in several places doesn't cut it.

In the past 18 months, I have been working for a big organisation where lots of teams and individuals use Python scripts to automate smaller and bigger tasks. Most of those scripts integrate stuff much like I mentioned above. Typically, the developers have no clue how start testing those scripts, even though the scripts often play a crucial role in IT and business processes. 

## Hexagonal approach

My invoicing app will start as a script, but one with real stuff to do. It needs to deal with tax rules (VAT and potentially others). It will maintain rules around generating invoice numbers, payment periods, and totals. It will make it possible to manage customers and generate invoices with as few user input as possible. It will produce PDF output and needs to deal with multiple organisation units: my business, my wife's business, and some personal things.

@@take hex approach + plaatje + link

Testing business rules focuses on the domain, testing the adapter integration with storage of invoices and customers (whatever that storage is, we haven't decided yet) is a separate issue. 

Testing the command line interface should be just like testing a REST interface. It is an adapter concern that we can test drive, separate from the business logic. 

## Introducing 'Click'

[Click](https://click.palletsprojects.com/){:target="_blank"} is an easy to use Python based argument parser, once you understand its model. It supports nested groups of commands and arguments, and options for each of the levels. For example:

~~~python
@click.group(name='aws') # root level group
def my_app():
    pass

@my_app.group()          # sub level group within the root level group
def s3():
    pass

@s3.command()            # command within the sub level group 
def ls():
    print('invoke list')
~~~

This would make it possible to parse:

~~~bash
aws s3 ls
~~~ 

The decorators `command` and `group` accept arguments to specify options and parameters for the groups and commands, so that it is easy to enable your script to parse:

~~~bash
aws --verbose s3 --account-name my-account ls my-bucket
~~~

It even has a `CliRunner()` for testing, to enable you to invoke a command like this:

~~~python
runner = CliRunner()
runner.invoke(my_app, ['s3', 'ls'])
~~~

## Getting to work

As a first step, I want to list the customers, so that I can select one to send an invoice to. In the Ports and Adapters perspective, it would look like:

![hexagon list customers](blah.png)

My first test is:

~~~python
class TestCustomerCli:
    def test_list_customers_shows_a_list_of_customer_names_and_codes_in_texts(self):
        runner = CliRunner()
        assert_that(runner.invoke(invoicer_app, ['customers', 'list']).output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

> I know pytest has a different opinion on structuring tests and I don't have to make a test case class. We still like to use test case classes to group tests and have multiple groups of tests in a file, because it helps the readability of the test suite.

After getting the failure:

```
E       NameError: name 'invoicer_app' is not defined
```

and adding code step by step, the implementation looks like this (similar to the click example above):

~~~python
@click.group(name='invoicer')
def invoicer_app():
    pass

@invoicer_app.group()
def customers():
    pass

@customers.command()
def list():
    print('QWAN\tQuality Without A Name')
~~~

## The problem with this approach 

The test works and is good enough to get acquainted with `click`, but I am not happy with the situation. What I have specified is that whatever happens, listing customers produces "QWAN, Quality Without A Name". Somehow I need to be able to influence the result:

~~~
Given @@my querying all customers produces a list with just "Quality Without A Name"
When listing all customers through the CLI
Then "QWAN  Quality Without A Name" is the result.
~~~

To do that, we need to be able to influence the result whatever the `list` function is interacting with. 

The issue with most easy-to-use libraries like `click` (or `flask` for HTTP interfaces), is that the typical examples use top level functions. Even though they have testing support, they seem to focus on integrated testing. They don't describe how to injecting dependencies using their framework. @@uitwerken

## Injecting dependencies

Before moving on, I remove the `list()` implementation to prevent false positives:

~~~python
@customers.command()
def list():
    pass
~~~

We like to maintain control over our dependencies. Dependency injection should not be some magic process. So in my using the Given, When, Then Example above, my test should look like: 

~~~python
class TestCustomerCli:
    def test_list_customers_shows_a_list_of_customer_names_and_codes_in_texts(self):
        runner = CliRunner()
        # Given the allCustomersQuery produces a customer with 
        #   short_hand="QWAN" and name="Quality Without A Name")
        resulting_output = runner.invoke(invoicer_app, ['customers', 'list']).output
        assert_that(resulting_output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

To make the test complete, I need something like:

~~~python
class TestCustomerCli:
    def test_list_customers_shows_a_list_of_customer_names_and_codes_in_texts(self):
        runner = CliRunner()
        customer_query = Mock()
        CustomerCli(customer_query)
        customer_query.return_value = [aValidCustomer(short_hand="QWAN", name="Quality Without A Name")]
        resulting_output = runner.invoke(invoicer_app, ['customers', 'list']).output
        assert_that(resulting_output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

This results in:
~~~
>       CustomerCli(customerQuery)
E       NameError: name 'CustomerCli' is not defined
~~~

So step by step I define the customer cli:
~~~python
class CustomerCli:
    def __init__(self, customer_query):
        pass
~~~

resulting in:
~~~
E       AssertionError: 
E       Expected: 'QWAN\tQuality Without A Name\n'
E            but: was ''
~~~

I'm not sure if `click` would actually work with instance methods. To try this out, I move the `customers` and `list` functions as methods in the CustomerCli:

~~~python
class CustomerCli:
    def __init__(self, customer_query):
        pass

    @invoicer_app.group()
    def customers(self):
        pass

    @customers.command()
    def list(self):
        pass
~~~

This gives the same failure, but is it actually calling `list`? Let's try the fake implementation again.

~~~python
class CustomerCli:
    # ...
    @customers.command()
    def list(self):
        print('QWAN\tQuality Without A Name')
~~~

Nope it does not, still the same failure. Apparently, `click` only works with plain functions. I recall a trick that I used for Flask routes. I created a `register` method in the route classes and used inner functions. 

I move the `customers` and `list` methods to inner functions of a `register` method that takes the invoicer_app function as an argument. In Python, this is quite a small step. A bit of indenting, removing `self` parameters:

~~~python
class CustomerCli:
    def __init__(self, customer_query):
        pass
        
    def register(self, invoicer_app):
        @invoicer_app.group()
        def customers():
            pass

        @customers.command()
        def list():
            print('QWAN\tQuality Without A Name')
~~~

...BAM! Green test. It works! Ship it! ;-) 

Now let's remove the fakes:

~~~python
class CustomerCli:
    def __init__(self, customer_query):
        self._customer_query = customer_query

    def register(self, invoicer_app):
        @invoicer_app.group()
        def customers():
            pass

        @customers.command()
        def list():
            customer = self._customer_query()[0]
            print('{}\t{}'.format(customer.short_hand, customer.name))
~~~

This works, but only for one customer. I need to ad a test for multiple customers. As a small refactoring, I rename the current test to `test_list_customers_formats_a_customers_short_hand_and_name`@@. The new test looks like:

~~~python
class TestCustomerCli:
    # ...
    def test_list_customers_shows_a_list_of_customers(self):
        runner = CliRunner()
        customer_query = Mock()
        CustomerCli(customer_query).register(invoicer_app)
        customer_query.return_value = [
            aValidCustomer(short_hand="QWAN", name="Quality Without A Name"),
            aValidCustomer(short_hand="FRSH", name="Fresh Bakery")
            ]
        resulting_output = runner.invoke(invoicer_app, ['customers', 'list']).output
        assert_that(resulting_output, equal_to('''QWAN\tQuality Without A Name\nFRSH\tFresh Bakery\n'''))
~~~

I generalise the `list` implementation to use the whole lists instead of just the first element:

~~~python
class CustomerCli:
    # ...
    def register(self, invoicer_app):
        # ...
        @customers.command()
        def list():
            for customer in self._customer_query():
                print('{}\t{}'.format(customer.short_hand, customer.name))
~~~

There's some duplication in the tests, so I clean them up a bit:

~~~python
class TestCustomerCli:
    @pytest.fixture(autouse=True)
    def setup(self):
        self.runner = CliRunner()
        self.customer_query = Mock()
        CustomerCli(self.customer_query).register(invoicer_app)
    
    def test_list_customers_formats_a_customers_short_hand_and_name(self):
        self.customer_query.return_value = [aValidCustomer(short_hand="QWAN", name="Quality Without A Name")]
        resulting_output = self.runner.invoke(invoicer_app, ['customers', 'list']).output
        assert_that(resulting_output, equal_to('QWAN\tQuality Without A Name\n'))

    def test_list_customers_shows_a_list_of_customers(self):
        self.customer_query.return_value = [
            aValidCustomer(short_hand="QWAN", name="Quality Without A Name"),
            aValidCustomer(short_hand="FRSH", name="Fresh Bakery")
            ]
        resulting_output = self.runner.invoke(invoicer_app, ['customers', 'list']).output
        assert_that(resulting_output, equal_to('''QWAN\tQuality Without A Name\nFRSH\tFresh Bakery\n'''))
~~~

Still not happy with the invoke noise that repeats itself in both tests, I extract this in a new method. This method may eventually be pulled up in a superclass, but let's not get ahead of myself.

~~~python
class TestCustomerCli:
    @pytest.fixture(autouse=True)
    def setup(self):
        self.runner = CliRunner()
        self.customer_query = Mock()
        CustomerCli(self.customer_query).register(invoicer_app)
    
    def run_cli(self, *arguments):
        return self.runner.invoke(invoicer_app, arguments)

    def test_list_customers_formats_a_customers_short_hand_and_name(self):
        self.customer_query.return_value = [aValidCustomer(short_hand="QWAN", name="Quality Without A Name")]
        resulting_output = self.run_cli('customers', 'list').output
        assert_that(resulting_output, equal_to('QWAN\tQuality Without A Name\n'))

    def test_list_customers_shows_a_list_of_customers(self):
        self.customer_query.return_value = [
            aValidCustomer(short_hand="QWAN", name="Quality Without A Name"),
            aValidCustomer(short_hand="FRSH", name="Fresh Bakery")
            ]
        resulting_output = self.run_cli('customers', 'list').output
        assert_that(resulting_output, equal_to('''QWAN\tQuality Without A Name\nFRSH\tFresh Bakery\n'''))
~~~

## Testing End-to-End through the command line 

In our [test architecture post](https://www.qwan.eu/2020/09/17/test-architecture.html), we elaborated on choosing end-to-end-ness of tests. With my current CLI test setup, I made it possible to choose end-to-end-ness and still manage the context of my end to end test with ease. 

The current test setup allows me to create a setup with in-memory repositories for customers, invoices, etc.

Say my main would look like this:

~~~python
if __name__ == '__main__':
    app = build_cli(customer_repository=InMemoryCustomerRepository.with_standard_customers())
    app()
~~~

then, assuming end to endness up to an in memory repostory, my end to end test  will look like this:

~~~python
class TestCustomerList:
    @pytest.fixture(autouse=True)
    def setup(self):
        self.runner = CliRunner()
        self.customer_repository = InMemoryCustomerRepository()
        self.app = build_cli(customer_repository=self.customer_repository)
    
    def run_cli(self, *arguments):
        return self.runner.invoke(self.app, arguments)

    def test_list_customers_shows_a_list_of_customers(self):
        self.customer_repository.save(aValidCustomer(short_hand="QWAN", name="Quality Without A Name")),
        resulting_output = self.run_cli('customers', 'list').output
        assert_that(resulting_output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

The distinction between the cli adapter integration test and end to end test is small in this example, because the query example is extremely simple. But you'll get the idea, that: 1) it is quite doable to test the cli adapter in isolation, and 2) you can play around with test scope once you have a well defined place to wire the application.

## Conclusion

Test driving a CLI is definitely doable. It needs a bit of a testing mindset, creativity and looking for libraries that help you just enough. 
I created a basis for test driving my command line interface, allowing me to develop in a sustainable way. 

<aside>
  <h3>Want to apply unit testing or test driven development in places that seem not suitable?</h3>
  <p>We offer workshops on Test Driven Development on legacy code and we can mentor your team in applying it successfully in your own environment.</p>
  <p><div>
    <a href="/training">Learn more about our workshops</a>
  </div></p>
</aside>
