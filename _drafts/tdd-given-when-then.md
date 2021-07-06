---
layout: post
title: "TDD Heuristics: Given-When-Then or Arrange-Act-Assert"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

@@intro

Given-When-Then and Arrange-Act-Assert are two similar ways of structuring your
test cases to make them easier to understand at a glance. This test structure
also helps to keep your test focused on a single concern.

> _Given_ a state or situation (which you set up in the test)
>
> _When_ I do something or an event happens 
>
> _Then_ I expect an outcome (assert) or interaction between collaborators (mock verify)

Given-When-Then originates from Behaviour Driven Development. Thinking
Given-When-Then helps to think in terms of behaviour rather than internal state.
Arrange-Act-Assert is a similar pattern from the eXtreme Programming community:


An example:
  
```ruby
# Given a filled machine

machine = VendingMachine.new
machine.fill(...);

# When I choose Cola
canOfChoice = machine.deliver(Choice.COLA)

# Then I expect a can of Cola
canOfChoice.should == Can.CanOfCola
```


## Further reading

@@meer!

The Arrange-Act-Assert pattern comes from Bill Wake. He has done a [nice
write-up](http://xp123.com/articles/3a-arrange-act-assert/).

@@bdd / cucumber / formulation link?

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Stop faking TDD and learn it the proper way! Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
