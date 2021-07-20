---
layout: post
title: "TDD Heuristics: Test name describes action and expected result"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

We use test names or test descriptions to tell what the test is about: what is
the action or event, what is the expected result?

If we name our tests like this, a test case will read like a specification of
the object under test (in particular in a test report or when you look at your
tests collapsed in your IDE). A good test name will also make the test more
readable.

## Example

Here's an example from the back-end code of our [Online Agile Fluency®
Diagnostic application](/2020/09/25/hexagonal-frontend-example.html). The
back-end component uses Python and pytest. The domain class `Facilitator`
represents facilitators who can run workshops. This class knows (among other
things) how to authenticate a facilitator. We have grouped the tests for this
reponsibility into a separate test class `TestSignIn`, part of the
`test_facilitator.py` file. If we would name our tests like in the example
below, we do get a hint of what is being tested, but we'll have to inspect the
test to be sure.

```python
class TestSignIn:
  def test_no_password(self):
    ...
  def test_no_match(self):
    ...
  def test_blocked(self):
    ...
  def test_blocked_no_match(self):
    ...
  def test_succeeds(self):
    ...
```

Note that `pytest` uses naming conventions to find test classes and individual
test functions, which clutters the names a bit.

Applying the _Test name describes action and expected result_ heuristic, we get tests that tell a more complete and precise story of how the Facilitator behaves:

```python
class TestSignIn:
  @pytest.fixture(autouse=True)
  def setup(self):
    self.hasher = PasswordHasher()
    self.facilitator = aValidFacilitator(email='henk@qwan.eu', 
                                         hashed_password=self.hasher.hash('Str0ngP@ssw0rd'))

  def test_fails_when_facilitator_does_not_have_a_password_yet(self):
    facilitator = aValidFacilitator(email='henk@qwan.eu', hashed_password=None)
    assert_that(facilitator.authenticate('pwd', self.hasher), 
      equal_to(Failure(message='Password mismatch for \'{}\''.format(anonymize('henk@qwan.eu')))))

  def test_fails_when_password_does_not_match(self):
    ...
  def test_fails_with_blocked_is_true_when_user_is_blocked(self):
    ...
  def test_fails_with_blocked_is_true_even_when_password_does_not_match(self):
    ...
  def test_succeeds_when_user_exist_and_password_matches(self):
    ...
```

Testing frameworks that use a spec based format provide more options to use
descriptions for test. They also allow for grouping test and providing a
description for the group of tests. Here's an example from the front end code of
our [Online Agile Fluency® Diagnostic
application](/2020/09/25/hexagonal-frontend-example.html). The front end
component has a Facilitator domain class representing the facilitator of a
workshop. The behaviour of Facilitator includes validating inputs like this
excerpt shows:

```js
describe('Facilitator', () => {
  describe('when validating', () => {
    it('validates ISO date format', () => {
      const newFacilitator = aValidFacilitator({ licenseValidUntil: '20 May 2020' })
      newFacilitator.validate()
      expect(newFacilitator.errors).toEqual({ licenseValidUntilMissing: true })
    })
    it('validates email address', () => {
      const newFacilitator = aValidFacilitator({ email: 'john ' })
      newFacilitator.validate()
      expect(newFacilitator.errors).toEqual({ emailMissing: true })
    })
    ...
```

The `aValidFacilitator` function is a [test data builder]() to construct a
specific Facilitator instance. The `errors` property of the facilitator object
contains information on any validation errors, currently represented by e.g.
`emailMissing` which means that the email attribute is missing or in some other
way invalid.

@@+examples from wereview

A benefit of choosing good, descriptive names for tests is that the overview of
all tests, e.g. when running your tests from an IDE, becomes a kind of behaviour
specification of the code.

![IDE showing a list of successful tests, which reads as a kind of specification](/attachments/blogposts/2021/tdd/tests-as-spec-in-ide.png)
{: class="post-image" }

## Effects 

Trying to catch the test's intention in the name also helps to think of what
exactly we're trying to do in the test. If it is hard to find a good name, we
probably don't understand what we are trying to capture in the test.

Before we even write the actual (failing) test, we start with the name or
description. Following the _ Test name describes action and expected result_
heuristic helps working in a more behaviour driven style (BDD). This provides
better readable tests less coupled to implementation details. The tests will act
more as a form of documentation.

We are not afraid of long names, but we want to prevent long, vague sentences.
Names containing 'and' are a hint that there might be two (or more!) tests 
in there.

We refactor test names or descriptions as well! When we have better insights
into the behaviour of the system under test, we take care to update the
description to reflect our understanding and intent better, making life easier
for those who come after us (which includes ourselves).

This heuristic helps thinking [Given-When-Then](@@): the test name gives a
summary of the When and the Then.

## Considerations

The heuristic of putting the action/event and expected result in the test name
or description is mostly applicable for example based tests, not so much on
property based tests or approval tests. For property based tests, we use the
name or description to reflect an invariant of the code under test.

When we extract the set up code and other parts of the test out into functions,
this heuristic can become less useful. If we can make the test itself short and
glanceable, the test becomes self-evident. In some languages we can move the
order of our expectation function, so that it can go in the middle of a
sentence. If the test is glanceable, the string above it may be redundant. We
will write more about _glanceable tests_ in a future post, here is a small
example from the WeReview project, a conference session management system we
have developed:

@@example from WeReview
actual `shouldEqual` expected

## Further reading

@@meer!

[Specification by Example](https://gojko.net/books/specification-by-example/) by Gojko Adzic

[Behaviour Driven Development (BDD)](https://dannorth.net/introducing-bdd/)

For more inspiration, also take a look at RSpec - [rspec.info](http://rspec.info/)


_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Stop faking TDD and learn it the proper way! Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
