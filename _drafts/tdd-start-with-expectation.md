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

Write the last part of your test first: start with the expectation (or the
assert) and write the test bottom-up.

Starting the test at the end might feel strange, as you may be inclined to write
your test from top to bottom, from set-up, through invocation of production
code, to expectation. This may feel the wrong way around.

![start with the expectation, person holding a finish flag](/attachments/blogposts/2021/tdd/start-at-expectation.jpg)
{: class="post-image post-image-50" }

Think of it like writing a report - you might remember having to write reports
when you were at school: a good approach is to first write up the conclusions,
and then write the rest of the report leading to those conclusions. Writing a
test by starting with the expectation works in a similar way.

## Focus on outcomes

Focusing on the expectation first means focusing on the desired outcome.
Sometimes this is easier to express than the set-up code needed. You will also
notice duplication in set-up code more clearly. 

Starting with the expectation is harder than just copy-pasting the previous test
and changing some lines. It forces you to think of desired behaviour and
interfaces right from the beginning. You suddenly have to state clearly what you
are working towards.

From the expectation we work backwards to complete the test. We write the
minimally required set-up and code to get to our outcome.

## Example

Let's look at an example from our [Online Agile Fluency® Diagnostic
application](/2020/09/25/hexagonal-frontend-example.html). This application
supports a facilitator in running a workshop with a development team. In the code, we represent such a workshop by a concept _DiagnosticSession_. 

We would like to enable co-facilitation of workshops and add a sharing feature
to the DiagnosticSession class. So how do we start? Create a session, do
something with it? No, let's start with the expected outcome: a shared session
is accessible for the co-facilitator:

```python
def test_sharing_makes_it_accessible_for_the_secondary_facilitator():

  assert_that(session.is_accessible_for(co_facilitator), is_(True))
```

Then we can add the behaviour under test:

```python
def test_sharing_makes_it_accessible_for_the_secondary_facilitator(self):

  session.share_with(co_facilitator)
  assert_that(session.is_accessible_for(co_facilitator), is_(True))
```

And finally, we add the set-up code:

```python
def test_sharing_makes_it_accessible_for_the_secondary_facilitator(self):
  session = aValidDiagnosticSession(facilitator_id=aValidID('99'))
  co_facilitator = aValidFacilitator(id=aValidID('44'))
  session.share_with(co_facilitator)
  assert_that(session.is_accessible_for(co_facilitator), is_(True))
```

`aValidDiagnosticSession` and `aValidFacilitator` are examples of [test data builders](/2020/10/09/test-data-builders.html).

## Effects

We force ourselves to state our intent first, which helps in thinking about design. This provides a low-cost, fast feedback loop, helping us to get clear where we want to go.

It is ok to have it feel wrong and awkward. Starting with an expectation, 
we inject a little deliberate practice in your day to day work. 

Focusing a test on the outcome, helps to reduce wandering tests, clutter, and
unnecessary set-up code. We create tests that go straight to their goals.

## Legacy code

You may believe that this does not apply to legacy code. Quite the contrary:
although it can be harder to state the outcome, it will help you identify
better, less cluttered, and more focused interfaces for existing code. The
initial investment may be big, but so is the feeling of increased understanding
and relief after you've done it.

## Further reading

The idea of starting with the expectation comes from Kent Beck's [Test Driven
Development, By Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/); he describes a pattern called _Assert First_.

@@Behaviour Driven Development / Formulation link? 

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses, which focus on deliberate practice and learning by doing.
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
