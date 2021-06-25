---
layout: post
title: "TDD Heuristics: Think about design in test"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/Think-about-design.png
---

When writing a test, we don't just think about how to formulate the test. We think about design - the design of the code-under-test and the context in which it fits. Writing a test is an act of design. 

Looking at the [TDD cycle](/2021/06/24/tdd-still-relevant-in-2021.html), we can ask ourselves: where is the design step?

![tdd cycle: test - fail - pass - refactor](/attachments/blogposts/2021/tdd/tdd-cycle-small.png)
{: class="post-image" }

**Spoiler: Design is in all the steps.**

A test is an example of how the code-under-test will be used. Writing a test
before the production code means you're specifying the API of the
code-under-test and making this concrete in code. The test expresses an example
of both the syntax (method names, parameters) and semantics (what is the
behaviour, what do the methods do).

This is a post in our [series on Test Driven Development, Heuristics & Guidelines](/blog-by-tag#tag-test-driven-development).

## Example 

Let's look at an example from an exercise we use in our courses. We are
designing and implementing a model of a drinks vending machine. One of the tests
that have to do with paying for drinks is (using Python/pytest):

```python
def test_delivers_when_paid_enough():
  machine = VendingMachine()                    # 1
  machine.configure(Choice.Cola, Can.Coke, 2)   # 2
  machine.insert(2)                             # 3
  result = machine.deliver(Choice.Cola)         # 4
  assert_that(result, equal_to(Can.Coke))
```

We create a VendingMachine object (1). We configure its choices (buttons)
through a configure function, and we decided to pass the price as a third
parameter here (2). We also decided to represent the price by integers, a
decision we will probably start regretting pretty soon. It is already unclear
whether it represents cents, euros, dollars, tokens...

We also decided that to get a paid drink, we first need to insert money (3) and then choose a drink (4).

## Act of design

As code is unambiguous, you need to be precise in how the code-under-test is going to work. You are making (micro) design decisions while doing this.

![Think about design in test](/attachments/blogposts/2021/tdd/Think-about-design.png)
{: class="post-image" }

> Writing a test is an act of design

## Early, fast feedback

By expressing your design decisions precisely in code, your test will already
provide feedback about these decisions: .e.g. 
names, parameters, results, errors, call semantics, data strucure, interfaces and composition (how the parts fit together).

So take your time to think your test through. Then observe the test code once
written. If you don't like what you see, change is still cheap: revisit your
decisions, rewrite the test.

The Test step of the TDD cycle is a step to think about design. This cuts both
ways: it benefits both the design of the production code and the readability of
the test.

The Refactor step is also a great place to think about design. The rush to produce shiny new code, and the anxiety of 'will this work' has waned, now we can calmly consider if this is any good, and how well it resolves the forces for our design. We will delve in to this later.

## Conclusion

A design is a side-effect of working test-first. Working mechanically, following the steps is not enough. A _good_ design requires thinking _all_ the time - before, during and after writing a test. 

We are capable of getting a complicated design under test. We prefer not to. If we can get an understandable, maintainable design and understandable, effective tests, than we are happy. We won't settle for anything less.

## Reading

[Little things add up](http://wirfs-brock.com/blog/2005/09/05/little-things-add-up/), by Rebecca Wirfs-Brock:

> That is why test-driven development is a big win. Writing tests first forces you to focus on thinking about the interface before you design and code it. Making those tests work becomes a relentless way of getting observable behavior to work rather than letting crufty untested code pile up.

- Kent Beck, [Test Driven Development, By
  Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/) (2002)
- Steve Freeman and Nat Pryce, [Growing Object Oriented Software, Guided
  by Tests](http://www.growing-object-oriented-software.com/) (2008)
