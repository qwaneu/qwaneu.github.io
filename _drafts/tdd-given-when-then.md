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
behaviour of the system under test?

Given-When-Then and Arrange-Act-Assert are two similar ways of structuring your
test cases to make them easier to understand at a glance. This test structure
also helps to keep your test focused on a single concern.

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
Arrange-Act-Assert is a similar pattern from the eXtreme Programming community:

## Example

Here's a small example from the drinks vending machine case we use in our courses, using Ruby this time:
  
```ruby
# Given a configured machine
machine = VendingMachine.new
machine.configure(Choice.Cola, Can.Coke);

# When I choose Cola
canOfChoice = machine.deliver(Choice.Cola)

# Then I expect a can of Coke
canOfChoice.should == Can.Coke
```

Note that we normally don't put given/when/then or arrange/act/assert comments
in our test code. We try to keep our tests simple and straightforward, often
extracting setup code into a `before` or in separate functions, and/or using
test data builders. We strive for _glanceable_ tests, where we can see the
given, the when and the then parts rightaway.

## Effects

Given-When-Then and Arrange-Act-Assert help us focus on behaviour of the system
under test. They help us keeping focused on what we are actually trying to cover
in a test. They keep us from having our tests wandering around.

The behaviour-focus of Given-When-Then nudges us towards seeing the thing we're
testing (whether it's an object, module, system) more as a black box. This helps
prevent tests highly coupled to implementation details. Given-When-Then helps a
bit more here than Act-Arrange-Assert, which is a bit more focused on the
mechanics of the test.

The patterns are also suitable for formulating acceptance test scenarios, and
help involve everyone in the conversation - developers, testers, product owner,
etc.

## Further reading

The Arrange-Act-Assert pattern comes from Bill Wake. He has done a [nice
write-up](http://xp123.com/articles/3a-arrange-act-assert/).

The Given-When-Then way of writing scenarios comes from Dan North and Chris
Matts, who [introduced the concept of Behaviour Driven Development
(BDD)](https://dannorth.net/introducing-bdd/) in the early 2000s. 

[Specification by Example](https://gojko.net/books/specification-by-example/) by Gojko Adzic

[The BDD Books - Formulation, Document examples with Given/When/Then](https://leanpub.com/bddbooks-formulation) by Seb Rose and Gáspár Nagy

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Given that you strive to become better at software development, When you attend one of our courses, Then ... Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
