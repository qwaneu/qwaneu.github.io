---
layout: post
title: "TDD Heuristics: Think about design in test"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
  - heuristics
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/Think-about-design.png
---

When writing a test, we don't just think about how to formulate the test. We
think about **design** - the design of the code-under-test and the context in
which it fits. Writing a test is an act of design.

## Where is design in Test Driven Development?

Looking at the [TDD cycle](/2021/06/24/tdd-still-relevant-in-2021.html), we can
ask ourselves: where is the design step?

![tdd cycle: test - fail - pass - refactor](/attachments/blogposts/2021/tdd/tdd-cycle-small.png)
{: class="post-image" }

**Spoiler: Design is in all the steps.**

A test is an example of how the code-under-test will be used. Writing a test
before the production code means you're specifying the API of the
code-under-test and making this concrete in code. The test expresses an example
of both the syntax - method names, parameters - and semantics - what is the
behaviour, what do the methods do.

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

## Example 

Let's look at an example from one of our [course](/training) exercises. In this
exercise, we are test-driving the design and implementation of a drinks vending
machine model. One of the tests that have to do with paying for drinks is:

```python
# Using Python & pytest
class VendingMachine:
  def configure(self, choice, can, price):
    ...
  def insert(self, amount):
    ...
  def deliver(self, choice):
    ...

def test_delivers_when_paid_enough():
  machine = VendingMachine()                      # 1
  machine.configure(Choice.Cola, Can.Coke, 2)     # 2
  machine.insert(2)                               # 3
  result = machine.deliver(Choice.Cola)           # 4
  assert_that(result, equal_to(Can.Coke))
```

We create a VendingMachine object (1). We configure its choices (buttons)
through a *configure* function, and we decided to pass the price as a third
parameter here (2). We also decided to represent the price by integers,
something we will probably get to regret sooner rather than later. It is unclear
whether it represents cents, euros, dollars, tokens...

> Aside: we rarely see course participants introduce a Money concept at this
> point, or at all. Many of us remain blissfully unaware of how complicated
> Money can be to represent properly. Quite often we even see [floating point
> numbers used to represent
> money](https://spin.atomicobject.com/2014/08/14/currency-rounding-errors/).
> Ignorance is bliss. Until it bites you.

We decided that to get a priced drink, we first need to insert money (3)
and then choose a drink (4).

Code is unambiguous, we need to be precise in how the code-under-test is going
to work. Like in this small example, we are making (micro) design decisions all
along the way.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2021/tdd/Think-about-design.png" alt="cutting a plank with a saw">
  </div>
  <div>
    <p><strong>Writing a test is an act of design</strong></p>
  </div>
</div>

## Early, fast feedback

By expressing your design decisions precisely in code, your test will already
provide feedback about these decisions: e.g. names, parameters, results,
errors, call semantics, data structure, interfaces and composition - how the
parts fit together.

So take your time to think your test through. Then observe the test code once
written. If you don't like what you see, change is still cheap: revisit your
decisions, rewrite the test.

The *Test* step of the TDD cycle is a step to think about design. This cuts both
ways: it benefits both the design of the production code and the readability of
the test.

The *Refactor* step is also a great place to think about design. Once the rush
to produce shiny new code and the anxiety of "will this work" have waned, we can
now calmly consider if this code is any good, and how well it resolves the
forces for our design. We might delve into this later.

## Conclusion

A design is a side-effect of working test-first. Working mechanically, by just
following the steps is not enough. A _good_ design requires thinking _all_ the
time - before, during and after writing a test. 

We are capable of getting a complicated design under test. We prefer not to. If
we can get an understandable, maintainable design with understandable, effective
tests, we are happy. We won't settle for anything less.

## Reading

> That is why test-driven development is a big win. Writing tests first forces
> you to focus on thinking about the interface before you design and code it.
> Making those tests work becomes a relentless way of getting observable
> behaviour to work rather than letting crufty untested code pile up.  
> -- [Little things add up](http://wirfs-brock.com/blog/2005/09/05/little-things-add-up/), Rebecca Wirfs-Brock

- Kent Beck, [Test Driven Development, By
  Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/) (2002)
- Steve Freeman and Nat Pryce, [Growing Object Oriented Software, Guided
  by Tests](http://www.growing-object-oriented-software.com/) (2008)

"Think about design in test" is a heuristic, not a hard rule. We haven't defined heuristics yet. Oops. In the meantime, have a read through [Growing Your Personal Design Heuristics Toolkit](http://wirfs-brock.com/blog/2019/03/20/growing-your-personal-design-heuristics/) by Rebecca Wirfs-Brock if you'd like to get a grasp on what a heuristic is, and what heuristics could do for you (especially your own).

<aside>
  <p>If you want to show us how to write proper tests with money, why not join us for one of our Test Driven Development courses, which focus on deliberate practice and learning by doing.
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
