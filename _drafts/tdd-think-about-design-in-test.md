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

When you write a test, you're actually writing an example of how the
code-under-test will be used. Writing a test before the production code means
you're specifying the API of the code-under-test and making this concrete in
code. The test expresses an example of both the syntax (method names, parameters) and semantics (what is the behaviour, what do the methods do).

![](/attachments/blogposts/2021/tdd/tdd-cycle-small.png)
{: class="post-image" }

An example from an exercise we use in our courses. We are designing and
implementing a model of a drinks vending machine. One of the tests that have to
do with paying for drinks is (using Python/pytest):

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

## Early, fast feedback

By expressing your design decisions precisely in code, your test will already
provide feedback about these decisions. It will give you feedback on your design
decisions, feedback about names, parameters, results, errors, call semantics,
etc. 

So take your time to think your test through and to observe the test code once
written. If you don't like what you see, change is still cheap: revisit your
decisions, rewrite the test.

The Test step of the TDD cycle is a step to think about design. This cuts both
ways: it benefits both the design of the production code and the readability of
the test.
