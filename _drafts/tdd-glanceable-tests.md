---
layout: post
title: "Glanceable tests"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
  - refactoring
author: Willem van den Ende
image: 
---

As we spend more time reading code than writing it, we'd like our code to
be glanceable. By glancing at the code, we want to quickly understand its
intent. Glanceability is a useful property, for production code as well as test
code. Test code is there to help us out, so being able to quickly grasp what the
test is about will help future us, and others, keep our tests habitable.

In the [Test Driven Development
cycle](http://localhost:8082/2021/06/24/tdd-still-relevant-in-2021.html), we
take time for refactoring the code in the last step of the cycle. In this step,
we also take time to look at our test code and refactor it when and where
necessary. One thing we strive for is *glanceable tests*.

> **Glanceable**
> 1. noting or relating to information on an electronic screen that can be understood quickly or at a glance,
> 2. enabling information on a screen to be quickly understood
> 
> From: [Dictionary.com](https://www.dictionary.com/browse/glanceable)

# Example 

Let's look at an example from the [WeReview](https://wereviewhq.com) conference
session management system we have developed: the `PlaceSpec` test, written in
PureScript).

```haskell
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

## Some tests don't require an action

Heuristics are a 

TODO Describe invariant heuristic (no action and expected outcome). Instead a
relation that always holds. (it is never empty). as alluded to in naming test
post (@@link).

`noEmptyFields` is an example of a test that is so glanceable that the test name does not add much. (see [test naming post](/2021/07/27/tdd-naming-tests.html)

Seeing this code again, I realise "converts itself" is not a great name. "Human readable text is never empty" is better. In the best `Haskell` tradition I used a one letter name for the `Place` value. No clue why I called it `e` now. Maybe for expected? Let's name it place, that reads better in the tests' call site:

```haskell
   describe "Human readable text" do
     it "is never empty" do
       quickCheck \(place :: Place) -> (humanReadable place) /== []
```

The inside is not that glanceable, especially if you haven't seen a property based test before, but at least we can understand the outside. A closer reading tells us that a number of arbitrary `Place` objects will be generated, and when made `humanReadable` it never equals an empty list.

One could wonder whether it was worth extracting two short one-liners into functions. We believe these extractions make the code more glanceable:

```haskell
shouldFailValidation e = isValid e `shouldEqual` false

shouldPassValidation e = isValid e `shouldEqual` true
```

The function names reveal intent at the places where it is used, even though
there is very little code inside of it.

If we were to inline this, we'd have to read the inside everywhere. Fewer moving
parts to read aid understanding code, and that includes tests. We do have to
make sure that the function has a clear name in the context where it is used,
otherwise these extractions hurt more than they help.

> An *Extract Method* refactoring is often more about the place where the method
> is called, than the place where it is defined.

> We prioritize making the whole more readable, even when we have to introduce
> more parts.

## Don't use an abstraction you already have when it is a bad fit

One of the tests above is about failing validation when some fields are empty:

```haskell
     it "fails when country is empty" do
       shouldFailValidation $ mkPlace (City "") (Country "")
```
At first I considered using the abstraction `invalidPlace` I had lying around instead of spelling out the empty `City` and `Country`:

```haskell
invalidPlace :: Place
invalidPlace = mkPlace (City "") (Country "")
```

As you can see in the test above, I have two different tests now, one for empty
city and one for empty country. If I was really worried, I could follow the
logic and make four of them. Having `invalidPlace` would make it less clear
_how_ the `Place` is not valid. These trade-offs often take some iteration to
get right.

Instead, I have used `invalidPlace` and its sibling `validPlace` to construct
larger objects for tests that contain a `Place`. In the larger context I don't
want to think about what exactly it is constructed of, so it makes the test more
glanceable there:

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkExpenseRequestDetail ( nonEmpty {travellingFrom = invalidPlace}))
```

But wait, what is `nonEmpty`? This was sort of clear in the context of the test,
as it had three different `it` blocks using it with a different field being set
to invalid each time. In the ... light of this post, it is not so clear. We may
have missed an opportunity for better naming. I'm tempted to show you what
`nonEmpty` is made of, but that would deny the opportunity to improve naming...

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkExpenseRequestDetail ( 
       nonEmptyExpenseRequestDetailData {travellingFrom = invalidPlace}))
```

But now the method is so long that it is no longer glanceable... let's have a
look at our data structure:

```haskell
nonEmpty ::  { travellingFrom :: Place
    , travellingTo :: Place
    , pleaseExplain :: String
    }
nonEmpty =
  {travellingFrom: validPlace,
   travellingTo: validPlace,
   pleaseExplain: "explanation"}
```

Three fields, and we wrote three tests for each field's invalid state. Dis

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkExpenseRequestDetail ( 
       validExpenseRequestDetailParameters {travellingFrom = invalidPlace}))
```

When showing this code, Marc asked, why is `expenseRequestDetail` called an
`expenseRequestDetail`? My response was that I had an expense request,
and it needed more details, where previously it didn't have many. And I
couldn't come up with a more meaningful name. The stakeholders wanted to get
some idea of expense requester's itinerary, and people may want to explain more,
so there is an explanation field.

The tests for `expense request` follow a similar pattern as the tests for Place,
with `shouldFailValidation`, objects for `empty` and `nonEmpty` etc. If I had to
construct the Place object here, it would just detract from the intent of the
test. It would merely add line noise.

# What makes a test glanceable

Let's recap, and add a bit. What makes a test glanceable?:

- **Clear names of tests and variables**: names communicatie intent rather than implementation.
- **Composed method**: having all lines of code in a function at the same level of abstraction.
- **Helper functions** that hide implementation details and express intent through good names.
- **Hiding setup details**, usually the [Given](/2021/09/02/tdd-given-when-then.html) part of the test, in a `setup`, `beforeEach` or other helper function.
- **[Test data builders](/2020/10/09/test-data-builders.html)** that help
  express different configurations of (domain) objects clearly and concisely.

# Effects

Glanceability of tests helps a lot when a test fails: we will quickly
understand the test's intent, so that we can fix it rightaway.

Glanceable tests are a form of [living
documentation](https://www.goodreads.com/book/show/34927405-living-documentation):
they will read as a specification of the production code. This facilitates
understanding of the expected behaviour of the code, and being able to change or
add new behaviour.

Writing a glanceable test also helps us in our thinking process. It's like we
are trying to tell a story to someone else - our colleagues, our future selves.

# Further reading

We learned a number of heuristics from Kent Beck's classic book [Smalltalk Best
Practice
Patterns](https://www.goodreads.com/book/show/781561.Smalltalk_Best_Practice_Patterns?ref=nav_sb_ss_1_14):

- **Composed method** - have all lines of code in a method at the same level of
  abstraction.
- **Intention revealing message** - name the method or function for the context
  in which it is used.
- **Intention revealing selector** - name the method or function for its
  meaning, not for its internal mechanics.

Re-reading the code, and discussing it with Marc surfaced assumptions I made
when writing the original code on my own. The code, and my understanding of it
improved as a consequence of taking it out of its production context and
discussing it. 

Rebecca Wirfs-Brock wrote in [Principles in Practice](http://wirfs-brock.com/PDFs/PrinciplesInPractice.pdf) (found via [this tweet](https://twitter.com/rebeccawb/status/1281248011427786752)):

>  Echoing  the  sentiments  of  the  military strategist Carl von Clausewitz,
> “Principles and rules are intended to provide a thinking man [or woman, in my
> case] with a frame of reference.” "I find it refreshing to occasionally step
> back to deeply examine why one design option seems better than another. I get
> uneasy when tribal knowledge about “the way things work around here” or vague,
> hard-to-express sentiments are the only reasons for a particular decision. I
> guarantee that if you discuss with your colleagues the nuanced reasons for
> making a particular design choice, you’ll learn more about putting design
> principles into practice. "

In his [Effective Unit Testing
book](https://www.goodreads.com/book/show/17282399-effective-unit-testing),
Lasse Koskela describes a number of testing smells that concern readability and
maintainability of unit tests.

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Writing glanceable tests is a skill. Join us in one of our Test Driven Development course to learn by doing.
  </p>
  <p><div>
    <a href="/training/test-driven-development">Check availability</a>
  </div></p>
</aside>
