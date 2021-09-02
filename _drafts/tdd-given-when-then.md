---
layout: post
title: "TDD Heuristics: Given-When-Then or Arrange-Act-Assert"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/gwt.png
---

How do I structure my tests, so that they are understable and focused on the
behaviour of the system under test? Given-When-Then and Arrange-Act-Assert are
two similar ways of structuring your test cases to make them easier to
understand at a glance. This test structure also helps to keep your test focused
on a single concern.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2021/tdd/gwt.png" alt="letters: G W T">
  </div>
  <div>
<p style="text-align: left; padding-bottom: 0.3em;">
<strong>Given</strong> a state or situation (which you set up in the test)
</p>
<p style="text-align: left; padding-bottom: 0.3em;">
<strong>When</strong> I do something or an event happens 
n </p>
<p style="text-align: left; padding-bottom: 0.3em;">
<strong>Then</strong> I expect an outcome (assert) or interaction between collaborators (mock verify)
</p>
  </div>
</div>

Or

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2021/tdd/aaa.png" alt="letters: A A A">
  </div>
  <div>
<p style="text-align: left; padding-bottom: 0.3em;">
<strong>Arrange</strong> a state or situation (which you set up in the test)
</p>
<p style="text-align: left; padding-bottom: 0.3em;">
<strong>Act</strong> to do something or an event happens 
n </p>
<p style="text-align: left; padding-bottom: 0.3em;">
<strong>Assert</strong> the expected an outcome collaborator interaction
</p>
  </div>
</div>

Given-When-Then originates from Behaviour Driven Development. Thinking
Given-When-Then helps to think in terms of behaviour rather than internal state.
Arrange-Act-Assert is a similar pattern from the eXtreme Programming community.

## Example

Here's an example from the drinks vending machine case we use in our courses, using Ruby this time:
  
```ruby
# Given a configured machine
machine = VendingMachine.new
machine.configure(Choice.Cola, Can.Coke);

# When I choose Cola
canOfChoice = machine.deliver(Choice.Cola)

# Then I expect a can of Coke
canOfChoice.should == Can.Coke
```

Note that we normally don't put "given/when/then" or "arrange/act/assert"
comments in our test code. We try to keep our tests simple and straightforward,
often extracting setup code into a `before`, like we did [in the previous post](2021/08/27/tdd-one-assert-per-test.html). We also use 
[test data builders](/2020/10/09/test-data-builders.html) instead of or in addition to a setup code. We strive for _glanceable_ tests, where we can see the
_given_, the _when_ and the _then_ parts rightaway. It acts more as an idiom than a literal implementation.

## Effects

Given-When-Then focuses on behaviour of the system under test: what are we actually trying to do?
It prevents our tests from wandering around.

The behaviour focus of Given-When-Then nudges us towards treating the _thing under test_
as a black box - whether it's a function, object, module, or
system. This reduces coupling of tests to implementation.
We find Given-When-Then more helpful for this than Act-Arrange-Assert, which is more
focused on the internal mechanics of the test.

This idiom also works to formulate acceptance test scenarios, and
can draw wider audience into the conversation, e.g. developers, testers, product owners, managers and users.

## Further reading

The [_Arrange-Act-Assert_ idiom](http://xp123.com/articles/3a-arrange-act-assert/) originates from Bill Wake. 

We learnt the *Given-When-Then* way of writing scenarios from Dan North and Chris
Matts, who [introduced the concept of Behaviour Driven Development
(BDD)](https://dannorth.net/introducing-bdd/) in the early 2000s. 

To learn more about behaviour driven development and writing good scenarios, we recommend the books:
- [Specification by Example](https://gojko.net/books/specification-by-example/) by Gojko Adzic
- [Formulation, Document examples with Given/When/Then](https://leanpub.com/bddbooks-formulation) by Seb Rose and Gáspár Nagy

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Given that you strive to become better at software development, When you attend one of our courses, Then join us for a Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
