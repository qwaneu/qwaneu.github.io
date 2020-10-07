---
layout: post
title: Test driving a command line interface in Python
tags:
  - continuous delivery
  - architecture
  - test driven development
author: Rob Westgeest
image: /attachments/blogposts/2020/cli.png
---

Testing a command line interface (CLI) should be just like testing a REST interface. A CLI is an adapter concern that we can test drive, separate from the business logic. In this post I'll show an approach to test drive the command line interface of an application in Python.

## Context

I am writing a utility application to create and manage invoices for clients. You may wonder why, because there are many bookkeeping applications available for this. My current bookkeeping application offers an invoicing module for an additional fee, but it is too limited for my use.

My application needs to generate PDF invoices for clients really easily. It should work for different organisational units as well, for example, my business, for my wife's, who sends out many small invoices, and for some personal business as well.

## Why CLI

For now I need something quickly, so that I can generate repeated invoices for a client.

Later, I may want to:
* grow the number of invoices 
* integrate with the bookkeeping application, 
* mail the invoices, 
* make it easy for my wife to use it, 
* and so on 

So I thought I'd create a CLI first and keep the option for a web front-end open. 

## Testing issues with scripts

I have used several command argument parsers for multiple personal projects and never bothered to test them. First of all, they were personal projects and no other user would be bothered by glitches in the command line. A second reason is that scripts can be a pain to test: calling a script and capturing the output to see what it is doing is one thing. But what if the script generates (binary) files, makes changes to a database, integrates with APIs and has some business logic as well? Then integrated tests become a pain. Simply calling the script from the command line and observing the effects in several places doesn't cut it.

In the past 18 months, I have been working for a large organisation where many teams and individuals use Python scripts to automate smaller and bigger tasks. Most of those scripts integrate stuff much like I mentioned above. Typically, the developers have no clue how start testing those scripts, even though the scripts play a crucial role in IT and business processes. 

## Hexagonal approach

My invoicing app will start as a script, but one with real stuff to do. It needs to deal with tax rules like VAT and potentially others. It will maintain rules around generating invoice numbers, payment periods, and totals. It will make it possible to manage customers and generate invoices with as few user input as possible. It will produce PDF output and needs to deal with multiple organisation units: my business, my wife's business, and some personal things.

I decided to apply [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html) or _Ports and Adapters_ architecture to structure the script code. The picture below shows the architecture of the script: we have a CLI adapter dealing with the command line stuff, a repository adapter for storing customers and invoices, and a PDF adapter for generating PDFs. The domain logic and business rules (including invoicing logic and tax rules) are in the centre.

![invoicer-hexagonal-view](/attachments/blogposts/2020/Invoicer-cli-post-hexagonal-view.png)

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

As a first step, I want to list the customers, so that I can select one to send an invoice to. In the Ports and Adapters perspective, it looks like:

![hexagon list customers](/attachments/blogposts/2020/Invoicer-cli-post-list-customers.png)

The `CustomerCli` delegates the list action to the `ListCustomers` query, which in turn gets the customers from the  repository. Note that we have drawn the `InMemoryCustomerRepository` in the domain here. We are not very consistent in where we put such an in-memory repository. Sometimes we regard it as an adapter, for instance when it is replacing a real database adapter as a fake. On the other hand it doesn't adapt anything. It is a thing on its own, with no relation to the outside world. This all a matter of perspective and intent. 

> Overdesign? You may argue that, in this case, the query object is a bit overkill. Why not let the command line interface get the customers from the repository directly? In this case, we could do that; we merely want to make clear how it would look like if the query object would a bit more complicated.

My first test for the `CustomerCli` looks like:

~~~python
class TestCustomerCli:
    def test_list_customers_shows_a_list_of_customer_names_and_codes_in_texts(self):
        runner = CliRunner()
	result = runner.invoke(invoicer_app, ['customers', 'list'])
        assert_that(result.output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

I chose to group the test cases in classes and have multiple groups of tests in a file, because it helps the readability of the test suite.

After getting the failure:

```
E       NameError: name 'invoicer_app' is not defined
```

Adding code step by step, the implementation looks similar to the click example above:

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

The test works and it is good enough to get acquainted with `click`, but I am not happy with the situation. What I have specified is that whatever happens, listing customers produces "QWAN Quality Without A Name". Somehow I need to be able to influence the result:

~~~
Given querying all customers produces a list with just "Quality Without A Name"
When listing all customers through the CLI
Then "QWAN  Quality Without A Name" is the result.
~~~

To do that, we need to be able to influence the result whatever the `list` function is interacting with. 

The issue with most easy-to-use libraries like `click` (or `flask` for HTTP interfaces), is that the typical examples you find online use top level functions. Even though they have testing support, they seem to focus on integrated testing only. They do not describe how you can inject the library as a dependency.

## Injecting dependencies

Before moving on, I remove the `list()` implementation to prevent false positives:

~~~python
@customers.command()
def list():
    pass
~~~

We like to be in control of our dependencies. Dependency injection should not be some magic process. So in the _Given-When-Then_ example above, my test should look like: 

~~~python
class TestCustomerCli:
    def test_list_customers_shows_a_list_of_customer_names_and_codes_in_texts(self):
        runner = CliRunner()
        # Given the allCustomersQuery produces a customer with 
        #   short_hand="QWAN" and name="Quality Without A Name")
        result = runner.invoke(invoicer_app, ['customers', 'list'])
        assert_that(result.output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

To make the test complete, I need something the code below. I introduce a `CustomerCli` class and inject a stub for the customer query. The stub returns a list with one customer.

~~~python
class TestCustomerCli:
    def test_list_customers_shows_a_list_of_customer_names_and_codes_in_texts(self):
        runner = CliRunner()
        customer_query = Mock()
        CustomerCli(customer_query)
        customer_query.return_value = [
            aValidCustomer(short_hand="QWAN", name="Quality Without A Name")]
        result = runner.invoke(invoicer_app, ['customers', 'list'])
        assert_that(result.output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

`aValidCustomer` is our pyhtonic variation of the builder pattern that we often use for creating instances of complicated object structures in tests. `Customer` is a tree structure and has a bunch of attributes. `aValidCustomer` creates an example customer instance and allows us to focus on the attributes that are relevant for the test.

Running the test above results in:

~~~
>       CustomerCli(customerQuery)
E       NameError: name 'CustomerCli' is not defined
~~~

So step by step I define the customer CLI:

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

I'm not sure if `click` would actually work with instance methods. To try this out, I change the `customers` and `list` functions into methods in `CustomerCli`:

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

This gives the same failure, but is it actually calling `list`? Let's try the cheat-implementation again.

~~~python
class CustomerCli:
    # ...
    @customers.command()
    def list(self):
        print('QWAN\tQuality Without A Name')
~~~

Nope it does not, still the same failure. Apparently, `click` only works with plain functions. I recall a trick that I used for Flask routes. I created a `register` method in the route classes and used inner functions. 

I move the `customers` and `list` methods to inner functions of a `register` method that takes the `invoicer_app` function as an argument. In Python, this is quite a small step. Its a bit of indenting and removing `self` parameters:

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

Now let's replace the cheat-implementation with something real:

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

This works, but only for one customer. I need to add a test for multiple customers. As a small refactoring, I rename the current test to `test_list_customers_formats_a_customers_short_hand_and_name`. The new test looks like:

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
        result = runner.invoke(invoicer_app, ['customers', 'list'])
        assert_that(result.output, equal_to('''QWAN\tQuality Without A Name\nFRSH\tFresh Bakery\n'''))
~~~

I generalise the `list` implementation to use the whole list instead of just the first element:

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
        result = self.runner.invoke(invoicer_app, ['customers', 'list'])
        assert_that(result.output, equal_to('QWAN\tQuality Without A Name\n'))

    def test_list_customers_shows_a_list_of_customers(self):
        self.customer_query.return_value = [
            aValidCustomer(short_hand="QWAN", name="Quality Without A Name"),
            aValidCustomer(short_hand="FRSH", name="Fresh Bakery")
            ]
        result = self.runner.invoke(invoicer_app, ['customers', 'list'])
        assert_that(result.output, equal_to('''QWAN\tQuality Without A Name\nFRSH\tFresh Bakery\n'''))
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
        result = self.run_cli('customers', 'list')
        assert_that(result.output, equal_to('QWAN\tQuality Without A Name\n'))

    def test_list_customers_shows_a_list_of_customers(self):
        self.customer_query.return_value = [
            aValidCustomer(short_hand="QWAN", name="Quality Without A Name"),
            aValidCustomer(short_hand="FRSH", name="Fresh Bakery")
            ]
        result = self.run_cli('customers', 'list')
        assert_that(result.output, equal_to('''QWAN\tQuality Without A Name\nFRSH\tFresh Bakery\n'''))
~~~

## Testing End-to-End through the command line 

In our [test architecture post](https://www.qwan.eu/2020/09/17/test-architecture.html), we elaborated on choosing end-to-end-ness of tests. With my current CLI test setup, I made it possible to choose end-to-end-ness and still manage the context of my end to end test with ease. The current test setup allows me to create a setup with in-memory repositories for customers, invoices, etc.

Say my `main` code would look like this:

~~~python
if __name__ == '__main__':
    app = build_cli(customer_repository=InMemoryCustomerRepository.with_standard_customers())
    app()
~~~

Then, if I choose end-to-end-ness for my test as covering the whole script with an in-memory repository, the resulting end to end test looks like this:

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
        self.customer_repository.save(aValidCustomer(
            short_hand="QWAN", name="Quality Without A Name")),
        result = self.run_cli('customers', 'list')
        assert_that(result.output, equal_to('QWAN\tQuality Without A Name\n'))
~~~

The distinction between the CLI adapter integration test and the end to end test is small in this example, because the query example itself is extremely simple. But you'll get the idea:
1. **It is quite doable to test a CLI adapter in isolation**
2. **You can play with test scope once you have a well defined place to wire the application**

## Conclusion

Test driving a Command Line Interface is definitely doable. It needs a bit of a testing mindset, some creativity, and looking for libraries that help you just enough. 
I created a basis for test driving my command line interface, which allowing me to develop my application in a sustainable way. 

<aside>
  <h3>Want to apply unit testing or test driven development where it seems hard or impossible?</h3>
  <p>We offer workshops on Test Driven Development in legacy code and we can mentor your team in applying it successfully in your own environment.</p>
  <p><div>
    <a href="/training">Learn more about our workshops</a>
  </div></p>
</aside>
