---
layout: post
title: "TDD Heuristics: Start with the expectation"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/start-at-expectation.jpg
---

Write the last part of your test first: start with the assert or the expectation.

This may feel strange, as you may be inclined to write your test from top to
bottom, from set-up, through invocation of production code, to expectation. This
may feel the wrong way around.

![start with the expectation, person holding a finish flag](/attachments/blogposts/2021/tdd/start-at-expectation.jpg)
{: class="post-image post-image-50" }

## Like writing a report, when we were in school

It is like when you have to write a report (maybe remember it from when you were
at school); a good approach is to first write up the conclusions, and then write
the rest of the report leading to those conclusions. Writing a test is similar
in this way.

The test will focus on a desired outcome, which is often easier to express than
the setup code needed. You will also notice duplications in set up code more
clearly. Starting with the expectation is harder than just copy-pasting the
previous test and changing some words. It forces you to think of desired
behaviour and interfaces right from the beginning.

By starting with the expectation, we focus on the test outcomes and work
backward from there. Once the expectation is clear, we write the minimally
required setup and code to get to our outcome.

It is ok to have it feel wrong and awkward. Starting with an expectation, 
you inject a little deliberate practice in your day to day work. 

## Example

Let's look at an example from our Online Agile Fluency Diagnostic application.
With this application, a facilitator can run a workshop with a development team.
The domain code has a _diagnostic session_. To enable facilitators pairing on a
workshop, we would like to add a sharing feature to the DiagnosticSession class.
So how do we start? Do we start creating a session? No, let's start with the
expected outcome - a shared session is accessible for the co-facilitator:

```python
def test_sharing_makes_it_accessible_for_the_secondary_facilitator():

  assert_that(session.is_accessible_for(co_facilitator), is_(True))
```

Then we can add the new behaviour:

```python
def test_sharing_makes_it_accessible_for_the_secondary_facilitator(self):

  session.share_with(co_facilitator)
  assert_that(session.is_accessible_for(co_facilitator), is_(True))
```

And add the setup code:

```python
def test_sharing_makes_it_accessible_for_the_secondary_facilitator(self):
  session = aValidDiagnosticSession(facilitator_id=aValidID('99'))
  co_facilitator = aValidFacilitator(id=aValidID('44'))
  session.share_with(co_facilitator)
  assert_that(session.is_accessible_for(co_facilitator), is_(True))
```

We are using [test data builders](/2020/10/09/test-data-builders.html) here.

## Effects

We force ourselves to state our intent explicitly first, which helps in design. This is again a small, quick feedback loop, helping us to get clear where we want to go.

The test is focused on the outcome, which helps to reduce clutter, unnecessary setup code. We prevent our test from wandering around, instead it will go straight to its goal.


## Legacy code

You may believe that this does not apply to legacy code. 
Quite the contrary: it is even harder, but will help you identify better, 
less cluttered, and more focused interfaces for existing code.
The effort may be big, but so is the feeling of increased understanding and relief after you've done it.

_See also: Wishful thinking, One assert per test, Given / When / Then_
