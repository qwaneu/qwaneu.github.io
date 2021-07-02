---
layout: post
title: "TDD Heuristics: 0, 1, N"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/0-1-N.jpg
---

Where do we start when test-driving a new piece of code? All options are open,
but we risk getting stuck because of the blank-piece-of-paper feeling. Because
we want to take small steps towards the end result, use the 0, 1, N guideline:
we start with some 'zero' or edge case, then make it work for a single case,
then generalize it to multiple cases.

![0-1-N.jpg](/attachments/blogposts/2021/tdd/0-1-N.jpg)
{: class="post-image post-image-50" }

## 0

We start with the 'zero' case, e.g. there is nothing available, there is no
supply, there are no choices to be made. This could also be a negative case,
like an order that cannot be found. We might already be thinking of next test
cases, but to keep focus, we move these out of our heads and park them on our
todo list - see e.g. [TDD with a
list](https://www.sammancoaching.org/learning_hours/small_steps/tdd_with_a_list.html).

The 'zero' case is usually straightforward to implement in a simple way; often
we can just fake it. It does allow us to get the basics in place, like a new
class with a method having the correct signature. We can postpone more
complicated decisions about data structures, iteration, mapping, etc. We get a
bit of feedback earlier on and we buy ourselves some time to think about the
code we're growing.

If we would be test-driving code to implement a drinks vending machine, we would
start with _delivers nothing when there are no choices available_ as the zero
case.

```python
def delivers_nothing_when_no_choices_available()
  ...
  assert_equal(machine.deliver(Choice.COLA), equal_to(Can.Nothing))
```

This triggers us to create a `VendingMachine` class having a `deliver` method, but there's not much to the implementation yet.

## 1

After we have implemented the 'zero' case, we write a test for the singular
case. We focus on getting the code to work for just this case. Even if we are
already thinking of a generic solution with dictionaries, collections, or streams, we postpone this for now. We will get to that in the 'N' step.

For the drinks vending machine, _delivers a coke when choosing cola_ could be
the 1 step.

```python
def delivers_coke_when_choosing_cola()
  ...
  assert_equal(machine.deliver(Choice.COLA), equal_to(Can.Coke))
```

Again, we keep the implementation as simple as possibler - we'll write more
about that later.

## N

After we have finished the singular case, we write a test for multiple cases.
This test forces us to generalize the code. By taking the 0 and 1 steps first,
we have given our brain some extra time to percolate on a good design.

For the drinks vending machine, we write the _delivers a can of choice_ test. 

```python
def delivers_can_of_choice()
  ...
```

## Effects

The 0, 1, N guidelines helps getting over that 'blank piece of paper' feeling,
which is often the biggest hurdle to get started. You don't need to have a
complete overview of all the next tests to write. You are likely to find more
cases after you start,

Starting with a negative case prevents you from only writing tests for the happy
flow. It is often the smallest step you can take. Completing a step feels good
and prepares you to take the next. Before you know it you may have a whole suite
of these things.

## Further reading

The 0, 1, N heuristic is related to the _Starter Test_ and _One to Many_
patterns in the [Test Driven Development, By Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/) book by Kent Beck.

[James Grenning proposed the ZOMBIES acronym](http://blog.wingman-sw.com/tdd-guided-by-zombies) for writing tests:
- (Z)ero
- (O)ne
- (M)any
- (B)oundary behaviors
- (I)nterface definition
- (E)xercise exceptional behaviour
- (S)imple scenarios-simple solutions.

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. Deliberate practice and learning by doing may make your wishes come true..
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
