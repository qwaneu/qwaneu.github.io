---
layout: post
title: "TDD Heuristics: Test name describes action and expected result"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/chuttersnap-JChRnikx0tM-unsplash.jpg
---

We use test names or test descriptions to tell what the test is about: what is
the action or event, what is the expected result.

![picture of a stack of colorful name cards](/attachments/blogposts/2021/tdd/chuttersnap-JChRnikx0tM-unsplash.jpg)
{: class="post-image post-image-50" }

If we name our tests like this, a test case will read like a specification of
the object under test. A good test name will also make the test more readable.

## Example

Here's an example from the back-end code of our [Online Agile Fluency®
Diagnostic application](/2020/09/25/hexagonal-frontend-example.html). The
back-end component uses Python and pytest. The domain class `Facilitator`
represents facilitators who can run workshops. This class knows (among other
things) how to authenticate a facilitator. We have grouped the tests for this
reponsibility into a separate test class `TestSignIn`, part of the
`test_facilitator.py` file. 

If we would name our tests like this, the names only give a hint of what is
being tested (if we're lucky), but we'll have to inspect the test implementation
to be sure.

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

Applying the _Test name describes action and expected result_ heuristic, we get
tests that tell a more complete and precise story of how the Facilitator
behaves:

```python
class TestSignIn:
  def test_fails_when_facilitator_does_not_have_a_password_yet(self):
    ...
  def test_fails_when_password_does_not_match(self):
    ...
  def test_fails_with_blocked_is_true_when_user_is_blocked(self):
    ...
  def test_fails_with_blocked_is_true_even_when_password_does_not_match(self):
    ...
  def test_succeeds_when_user_exist_and_password_matches(self):
    ...
```

`pytest` uses naming conventions to find test classes and test functions, which
clutters the names a bit.

Testing frameworks that use a spec based format provide more options to use
descriptions for test. They allow for grouping tests and providing a description
for a group of tests. Here's another example from the Online Agile Fluency
Diagnostic application, from the front end component this time. It also has a
Facilitator domain class representing the facilitator of a workshop. The
behaviour of this Facilitator class includes validating inputs:

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

The `aValidFacilitator` function is a [test data
builder](/2020/10/09/test-data-builders.html) to construct a Facilitator
instance. The `errors` property of the facilitator object contains information
on any validation errors, currently represented by e.g. `emailMissing` which
means that the email attribute is missing or in some other way invalid.

Test names can sometimes feel superflous. If the test implementation is self-explanatory. Does the name of the test add much in the following code?

```haskell
 describe "Home route" do
    it "parsed from forward slash" do
       (match "/") `shouldEqual` Home
```

We find the ```(match "/") `shouldEqual` Home``` clearer than the name.
Although, on second reading, the name alludes to 'parsing', which is a concern
that is not necessarily obvious from the test body. But '/' being equal to the
home route in a web application is common knowledge in the domain. 

In the context of the test's implementation, this name does not add much, but
there is a context in which it is very helpful: the IDE or CI pipeline. Good,
descriptive names for tests help create an overview of all tests. The overview
becomes a kind of behaviour specification of the code.

![IDE showing a list of successful tests, which reads as a kind of specification](/attachments/blogposts/2021/tdd/tests-as-spec-in-ide.png)
{: class="post-image" }

## Effects 

Trying to catch the test's intention in the name also helps to think of what
exactly we're trying to do in the test. If it is hard to find a good name, we
probably don't understand what we are trying to capture in the test.

Before we even write the actual (failing) test, we start with the name or
description. Following the _Test name describes action and expected result_
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

This heuristic helps thinking in terms of _Given-When-Then_: the test name gives
a summary of the _When_ and the _Then_.

## Considerations

The heuristic of putting the action or event and expected result in the test
name or description is mostly applicable for example based tests, not so much on
property based tests or approval tests. For property based tests, we use the
name or description to reflect an invariant of the code under test.

When we extract the set up code and other parts of the test out into functions,
this heuristic can become less useful. If we can make the test itself short and
[glanceable](/2021/09/27/tdd-glanceable-tests.html), the test becomes self-evident. In some languages we can move the
order of our expectation function, so that it can go in the middle of a
sentence. 

If the test is glanceable, the heading above the test body may be redundant. We
will write more about _[glanceable tests](/2021/09/27/tdd-glanceable-tests.html)_ in a future post, here is a small
example from [WeReview](https://wereviewhq.com), a conference
session management system we have developed (written in [PureScript](https://www.purescript.org/)):

```haskell
 describe "A Place" do
   describe "validation" do
     it "passes when no field is empty" do
       shouldPassValidation noEmptyFields
```

[Glanceable tests](/2021/09/27/tdd-glanceable-tests.html) need good naming for their headings, as well as thoughtful
refactoring of the bodies. 

## Further reading

by Gojko Adzic
- [Behaviour Driven Development (BDD)](https://dannorth.net/introducing-bdd/)
- [Specification by Example](https://gojko.net/books/specification-by-example/) - For more inspiration, also take a look at [RSpec](http://rspec.info/).
- Some more options for naming your tests: [7 Popular Unit Test Naming
Conventions](https://dzone.com/articles/7-popular-unit-test-naming) by Ajitesh
Kumar (2014)

_WeReview_ is used by Software Acumen to organize conferences like the upcoming
[Lean Agile Exchange](https://www.leanagileexchange.net/) (online, 21-22 October
2021)

Photo by <a href="https://unsplash.com/@chuttersnap?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">CHUTTERSNAP</a> on <a href="https://unsplash.com/s/photos/name-card?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses and get to practice applying this and other heuristics. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Check availability</a>
  </div></p>
</aside>
