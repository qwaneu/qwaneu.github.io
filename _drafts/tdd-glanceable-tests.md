---
layout: post
title: "Glanceable tests"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
  - refactoring
author: Willem van den Ende, Marc Evers, Rob Westgeest
image: 
---

As we spend more time reading code than writing it, we'd like our code to
be glanceable. By glancing at the code, we want to quickly understand its
intent. Glanceability is a useful property, for production code as well as test
code. Test code is there to help us out, so being able to quickly grasp what the
test is about will help future us, and others, keep our tests habitable.

Glanceable, as defined by [Dictionary.com](https://www.dictionary.com/browse/glanceable):

_adjective Digital Technology_.
1. noting or relating to information on an electronic screen that can be understood quickly or at a glance:  
  _glanceable data;_  
  _a glanceable scoreboard_.
2. enabling information on a screen to be quickly understood:  
  _a glanceable design;_  
  _glanceable interfaces_.

# When

In the TDD cycle, we take time for refactoring the code in the last step of the cycle. In this step, we also take time to look at our test code and refactor it when and where necessary.

# Example 

Let's look at an example from Wereview: the `PlaceSpec` test (written in PureScript).

```haskell
type PlaceSpec = forall eff. Spec (random :: RANDOM | eff) Unit

placeSpec :: PlaceSpec
placeSpec = do
 describe "A Place" do
   it "implements Eq on all its' fields" $
     quickCheck \(r :: Place) -> r === r
   it "can write and read itself to a javascript (Foreign) object" $
     quickCheck \(ev :: Place) -> (read (toFire ev)) === (Right ev)
   describe "converts itself into human readable text" do
     it "is never empty" do
       quickCheck \(e :: Place) -> (humanReadable e) /== []
   describe "validation" do
     it "fails when no fields have been filled in" do
       shouldFailValidation (default :: Place)
     it "passes when no field is empty" do
       shouldPassValidation noEmptyFields
     it "fails when city is empty" do
       shouldFailValidation $ mkPlace (City "") (Country "non empty country")
     it "fails when country is empty" do
       shouldFailValidation $ mkPlace (City "") (Country "")
```

Describe invariant heuristic (no action and expected outcome). Instead a
relation that always holds. (it is never empty). as alluded to in naming test
post (@@link).

`noEmptyFields` is an example of a test that is so glanceable that the test name does not add much. (see [test naming post](TODO: linkje))

"converts itself" is not a great name. "human readable text is never empty"

One could wonder whether it was worth extracting two short one-liners into functions. We believe these extractions help making the code more glanceable:

```haskell
shouldFailValidation :: forall eff a. (Valid a) => a -> Aff eff Unit
shouldFailValidation e = isValid e `shouldEqual` false

shouldPassValidation :: forall eff a. (Valid a) => a -> Aff eff Unit
shouldPassValidation e = isValid e `shouldEqual` true
```

The name helps reveal intent at the places where it is used, even though there
is very little code inside of it.

We elide the `shouldEqual` true and how to pass the thing into `isValid`. Fewer
moving parts when reading can help understanding code, and that includes tests,
as long as the function has a clear name in the context where it is used.

At first I considered using the abstraction below for the empty city and
country, like so:

```haskell
invalidPlace :: Place
invalidPlace = mkPlace (City "") (Country "")
```

As you can see in the test above, I have two different tests now, one for empty
city and empty country. If I was really worried, I could make four of them.
Having `invalidPlace` would make it less clear _how_ the Place is not valid.
This often takes some iteration to get it right.

Instead, I have used `invalidPlace` and its' sibling `validPlace` to construct
larger objects for test that contain a `Place`. In the larger context I don't
want to think about what exactly it is constructed of, so it makes the test more
glanceable there:

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation $ mkExpenseRequestDetail $ nonEmpty {travellingFrom = invalidPlace}
```

The tests for `expense request` follow a similar pattern as the tests for Place,
with `shouldFailValidation`, objects for `empty` and `nonEmpty` etc. If I had to
construct the Place object here, it would just detract from the intent of the
test. It would merely add line noise.

# What makes a test glanceable

- clear names (of tests and variables) that communicatie intent rather than implementation
- composed method - all lines of code at the same level of abstraction
- helper functions that hide implementation details and express intent through good names
- setup details (the 'Given' - link to GWT post) hidden in a setup/before or other helper function
- [test data builders](TODO Linkje), to express different configurations of (domain) objects/data clearly and concisely

# Effects

Having glanceable tests helps a lot when a test fails: we will quickly
understand the test's intent, so that we're able to fix it rightaway.

Glanceable tests are a form of [living documentation](TODO: linkje toevoegen):
they will read as a specification of the production code. This facilitates
understanding of the expected behaviour of the code, and being able to change or
add new behaviour.

Writing a glanceable test also helps us in our thinking process; it's like a
story we are trying to tell to someone else (our colleagues, our future selves).

# Further reading

In his classic book Smalltalk Best Practice Patterns, Kent Beck decsribes two idioms: Intention Revealing Message and Intention Revealing Selector
Intention revealing code - 

the word glanceable originates from the 1950s (dictionary.com)

In his Effective Unit Testing book, Lasse Koskela describes a number of testing
smells that concern readability and maintainability of unit tests.

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>...
  </p>
  <p><div>
    <a href="/training/test-driven-development">Check availability</a>
  </div></p>
</aside>
