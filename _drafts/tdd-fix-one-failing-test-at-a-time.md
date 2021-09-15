---
layout: post
title: "TDD Heuristics: Fix one failing test at a time"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

When you are changing an API or widely used interface, it can be tempting to do
the change in one go and break a lot of tests at once, thinking you can just fix
them. You risk ending up chasing failing tests around for hours, with lack of
good feedback why they fail. And you risk breaking something along the way,
because your safety net has holes!

# Tests fail for a reason

If your next step breaks code in many places this may mean:

- your design has too many dependencies on one piece
- your tests have too much duplication
- tests share setup code where they should not

> The real art of TDD is being able to take small steps in any circumstance.

# Taking smaller steps

So how do you reduce step size?

Refactor first before adding the next test. Change the code while keeping
the behaviour. Move the code in the direction you need, so that the intended 
change just fits in. Some usfeul techniques are:

- Test cases follow common setup
- Create 'example objects', test fixtures, or builders you can reuse across
  tests
- Extract a domain specific language (DSL) that encapsulates steps in your
  tests, to isolate the effect of changes

Another way to change the signature of a widely used method, is by adding
default parameters, or a method or constructor overload in the production code,
so that existing tests and code keep working.

# Further reading

TODO

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
