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

Where do I start when test-driving a new piece of code? All options are open,
but we risk getting stuck because of the blank-piece-of-paper feeling. We want
to take small steps towards the end result, so we follow the 0, 1, N rule of
thumb: we start with some 'zero' case, then make it work for a single case, then
generalize it to multiple cases.

![0-1-N.jpg](/attachments/blogposts/2021/tdd/0-1-N.jpg)
{: class="post-image post-image-50" }

## 0

We start with the 'zero' case, e.g. there is nothing available, there is no
supply, there are no choices to be made. This could also be a negative case,
like like an order cannot be found. We are already thinking of next test cases,
to keep focus, we move these out of our heads and park them on our todo list
(+link Emily).

The 'zero' case is usually straightforward to fake. It allows us to get the
basics in place, like a new class with a method with the correct signature. We
postpone more complicated decisions about data structures, iteration, mapping,
etc. We get a bit of feedback earlier on and we buy ourselves some time to think
about the code we're growing.

If we would test-drive a vending machine, we would start
with the ```deliversNothingWhenEmpty``` test,

```python
def example: pass
```

## 1

After we have finished the 'zero' case, we write a test for the singular case.
We focus on getting the code to work for just this case. Even if you are already
thinking dictionaries, collections, streams for making it work for any number,
postpone this for a moment, we'll get to that in the 'N' step.

then do ```deliversColaWhenChoosingCola``` - a single choice. 

```python
def example: pass
```

## N

After we have finished the singular case, we write a test for multiple cases.
This test forces us to generalize the code, still in the simplest possible way.
By taking the 0 and 1 steps first, we have given our brain some extra time to
percolate on a fitting design.

Finally, we do ```deliversCanOfChoice```, which allows us to generalize.

```python
def example: pass
```

## Effects

You are likely to find more cases after you start, 
getting over that 'blank piece of paper' feeling is often the biggest hurdle.

Starting with a negative case prevents you from only writing tests for
happy paths. It is also often the smallest step you can take. 
Completing a step feels good and prepares you to take the next.
Before you know it you may have a whole suite of these things.

## Further reading

The 0, 1, N heuristic is related to the _Starter Test_ and _One to Many_ patterns in Test Driven Development, By Example by Kent Beck.

[James Grenning proposed the ZOMBIES acronym](http://blog.wingman-sw.com/tdd-guided-by-zombies) for writing tests:
(Z)ero, (O)ne, (M)any, (B)oundary behaviors, (I)nterface definition, (E)xercise
exceptional behaviour, (S)imple scenarios-simple solutions.
