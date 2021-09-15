---
layout: post
title: "TDD Heuristics: One failing test at a time"
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

When you have only one failing test, there is no doubt about what to work on
next.  When, say, 20% of your tests are failing, you have to triage, which takes
mental effort (decision fatigue). Or worse, when sometimes 20% and sometimes 25%
of your tests are failing (flickering tests), you don't know what state you are
in at all, and you cannot work on the code base with any degree of confidence.

# Tests fail for a reason

If your next step breaks code in many places, you probably have one of these issues:

- your design has too many dependencies on one piece
- your tests have too much duplication
- your tests share setup code where they should not

> The real art of TDD is being able to take small steps in any circumstance

# Taking smaller steps

The solution for having multiple failing tests is to take a smaller step. If more than one test fails, we look at the failures to understand what is happening, revert our change, and think of a smaller step to take.

So how do you reduce step size?

**Refactor first before adding the next test**. Change the code while keeping
the behaviour. Move the code in the direction you need, so that the intended 
change just fits in. Some useful techniques are:

- Test cases follow common setup
- Create 'example objects', test fixtures, or test data builders which you can
  reuse across tests
- Extract a domain specific language (DSL) that encapsulates steps in your
  tests, to isolate the effect of changes

# Example

Example: changing the signature of a widely used function.

```
TODO: example code
```

Just changing the function's signature would cause multiple tests to fail. What options do we have here?

- introduce an overload of this function with the new signature; make the
  existing function call the new function with a default value (alternatively,
  depending on your programming language, you would introduce a default
  parameter value); run the tests; if they are successful, you can decide either
  to keep both functions or start replacing calls to the old one one by one,
  running tests in between
- create a helper function in the test that wraps the call; use this helper
  function everywhere, and make sure the tests are green; now the dependency on
  the function is in one place, so it is relatively straightforward to make the
  change (strictly speaking we would still have multiple failing tests if we
  make the update, as all tests are affected through the helper function, but
  now they all fail because of that single invocation, and we're still very much
  in control)
- maybe the tests contain too many duplicated calls to the function anyway; does
  it belong to the 'Given' part of the test? Can/should we move it to the setup
  code?

# Effects

Being more in control - when there is at most one test failing, you know the
state of the code and you know how close you are to working software. You are
always either in a state to commit & share your changes or one step away from
commitable code.

A single failure provides fast, specific, actionable feedback. You know what to
do next. Many failures is more like noise, leaving you in a state of confusion.

Keeping failures limited keeps the code continuously in a working, and
ultimately deployable state. This facilitates CI/CD (continuous integration &
continuous delivery).

# Further reading

TODO

<aside>
  <p>Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
