---
layout: post
title: "TDD Heuristics: One failing test at a time"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2022/ronan-furuta--Zjf67HKrls-unsplash.jpg
---

When you are changing an interface or API that is widely used, it can
be tempting to do the change in one go and break a lot of tests at once,
assuming you can just fix them. You risk ending up chasing failing tests around
for hours, with lack of good feedback why they fail. Furthermore, you risk
breaking something along the way, because you have created holes in your safety
net!

When you make sure that there is only one failing test at any point in time,
there is no doubt about what to work on next. If you have many tests failing at
the same time, you have to decide where to start, which takes extra mental
effort (decision fatigue). Worse, when a substantial part of your tests are
failing, you don't know what state you are in at all, and you cannot work on the
code base with any degree of confidence.

# Tests fail for a reason

If your next step breaks many tests at the same time, you probably have one of
these issues:

- your design has too many dependencies on one part
- your tests have too much duplication
- your tests share setup code where they should not

> The art of Test Driven Development is being able to take a small next step in any circumstance.

# Taking smaller steps

The solution for having multiple failing tests is to take a smaller step. If
more than one test fails, we look at the failures to understand what is
happening, revert our change, and think of a smaller step to take.

![footsteps in the sand on the beach](/attachments/blogposts/2022/ronan-furuta--Zjf67HKrls-unsplash.jpg)
{: class="post-image post-image-30" }

So how do you reduce step size?

**Refactor first before adding the next test**. Change the code while keeping
the behaviour, so that all tests stay green. Move the code in the direction you
need, so that the intended change just fits in. Some useful techniques are:

- **Test cases follow common setup** - we group tests that have a common setup,
  which will reduce test setup duplication. We will post more about this
  heuristic later on.
- Create **example objects**, **test fixtures**, or [test data
  builders](/2020/10/09/test-data-builders.html) which encapsulate specific
  dependencies and allow reuse across tests.
- Extract a **domain specific language** (DSL) that encapsulates steps in your
  tests, to isolate the effect of changes.

# Example

Let's look an example from the [Agile Fluency](https://www.agilefluency.org/)®
Diagnostic application that [we wrote about
before](/2020/08/26/hexagonal-vue.journey.html). The backend component, written
in Python, has a Facilitator class with a function to extend the facilitator's
license by a year. This function looks like this:

```python
class Facilitator:
  ...
  def extend_license(self):
    current_expiry_date = self.license_valid_until
    try:
      new_license_valid_until = current_expiry_date.replace(year=current_expiry_date.year + 1)
    except ValueError:
      new_license_valid_until = current_expiry_date + timedelta(days=366)
    return replace(self, license_valid_until=new_license_valid_until)
```

Some of the tests are:

```python
class TestExtendLicense:
  def test_extends_the_license_for_a_year(self):
    facilitator = aValidFacilitator(license_valid_until=date(2020,1,29))
    assert_that(facilitator.extend_license().license_valid_until, equal_to(date(2021,1,29)))

  def test_handles_29th_of_feb_and_makes_if_march_first(self):
    facilitator = aValidFacilitator(license_valid_until=date(2020,2,29))
    assert_that(facilitator.extend_license().license_valid_until, equal_to(date(2021,3,1)))
    ...
```

The tests are using test data builders to set up a facilitator. A facilitator
has a `license_valid_until` date property that we check.

We would like to change the signature of the `extend_license` function to have a
`days` parameter, representing the number of days to extend the license. This
could also be months or an absolute date, but this doens't matter for now.

Just making the change would break all existing tests that use `extend_license`,
and possibly other tests that indirectly touch this function. What other options
do we have here?

- Introduce the parameter using a **default value**. The tests should remain
  green. You can then start adding parameter values to the tests, one by one,
  and remove the default value when all invocations have been changed. In some
  programming languages like Java, you would introduce an **overload for the
  function** instead of using a default value.
- Create a **helper function** in the test that wraps the call. Use this helper
  function everywhere, and make sure the tests remain green. You have isolated the dependency on the function in this helper function, so it is relatively straightforward to make the change. Strictly speaking you would still have multiple failing tests if you make the change, as all tests are affected through the helper function. They fail, however, because of that single invocation and you are much more in control.
- Perhaps the tests contain too many duplicated calls to the function anyway.
  Does the invocation belong to the ['Given'
  part](/2021/09/02/tdd-given-when-then.html) of the test? Should we **move it
  to the setup code?** In the tests shown above, this is not the case. The
  invocations of `extend_license` are the behaviour under test - they are part
  of the 'When', not the 'Given'.

# Effects

The main effect of applying this heuristic is being more in control. When there
is just one test failing, you know the state of the code and you know how close
you are to working software. You are always either in a state to commit & share
your changes or one step away from commitable code.

A single failure provides fast, specific, actionable feedback. You know what to
do next. Multiple failures produce noise, leaving you in a state of confusion.

Keeping test failures low keeps your code continuously in a working, and
ultimately deployable state. This facilitates continuous integration &
continuous delivery (CI/CD).

# Further reading

- Mike Hill wrote a series of posts about the value of taking baby steps: [Many
  More Much Smaller Steps](https://www.geepawhill.org/2021/09/29/many-more-much-smaller-steps-first-sketch/)

_Credits: Photo by <a href="https://unsplash.com/@ronan18?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Ronan Furuta</a> on <a href="https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>_  

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
