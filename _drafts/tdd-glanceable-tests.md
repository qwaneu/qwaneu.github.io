---
layout: post
title: "Glanceable tests"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
  - refactoring
author: Willem van den Ende
image: /attachments/blogposts/2021/tdd/xeyes-1.png
---

As we spend more time reading code than writing it, we'd like our code to
be glanceable. By glancing at the code, we want to quickly understand its
intent. Glanceability is a useful property, for production code as well as test
code. Test code is there to help us out, so being able to quickly grasp what the
test is about will help future us, and others, keep our tests habitable.

![xeyes screenshot](/attachments/blogposts/2021/tdd/xeyes-1.png)
{: class="post-image" }

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

In this post we'll discuss some of the micro trade-offs that go into making tests glanceable.

# Example 

Let's look at an example from the [WeReview](https://wereviewhq.com) conference
session management system we have developed: the `PlaceSpec` test, written in
PureScript).

```haskell
placeSpec = do
 describe "A Place" do
   it "implements Eq on all its' fields" $
     quickCheck \(r :: Place) -> r === r
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

This is a fair amount of code, let's look at some of the aspects that we believe
make this more, and in some places less, glanceable.

## Some tests don't require an action

Heuristics are flexible, and made for quick decisions. We make use of that
flexibility here, by quickly going against the grain of a heuristice we
described earlier: [Test name describes action and expected
result](/2021/07/27/tdd-naming-tests.html).

Look at the "it is never empty" test. There is no action and expected outcome,
but a relation that always holds. We call this the _invariant heuristic_.
Apologies for the easter egg of a heurstic-in-a-heuristic, we may write about
the invarariant heuristic properly at some point.

`noEmptyFields` is an example of a test that is so glanceable that the test name does not add much. 

Seeing this code again, I realise "converts itself" is not a great name. "Human
readable text is never empty" is better. In the best `Haskell` tradition I used
a one letter name for the `Place` value. No clue why I called it `e` now. Maybe
for expected value? Let's name it `place`, that reads better in the tests' call
site:

```haskell
   describe "Human readable text" do
     it "is never empty" do
       quickCheck \(place :: Place) -> (humanReadable place) /== []
```

The inside is not that glanceable, especially if you haven't seen a property
based test before, but at least we can understand the outside. Let us try to
read this code together.

How can we read this? A developer new to a team, when we read code together, 
insisted on naming all the operators in words. This turned out to be
enlightening, and I thought I should do that more often (and I still should).
Maybe we should have a _pronounce the operators_ heuristic for code reading.

What do we see here? The `\==` operator is specific to the quickCheck library I
use, so we could name it 'never equals'. Now we read 'for all generated places,
a humanReadable place `never equals` the empty list'.

Extract for glanceability
-------

We extracted two oneliners for pass and fail validation into functions. One
could wonder whether it was worth extracting these two, because they are very
short. We believe these extractions make the code more glanceable:

```haskell
shouldFailValidation e = isValid e `shouldEqual` false

shouldPassValidation e = isValid e `shouldEqual` true
```

The function names reveal intent at the places where it is used, even though
there is very little code inside of it.

If we were to inline this, we'd have to read the inside everywhere. A few
symbols don't hurt so much, but it adds up and eventually it becomes line
noise. Fewer moving parts aid in understanding code, and that includes
tests. We do have to make sure that the function has a clear name in the context
where it is used, otherwise these extractions hurt more than they help.

> An *Extract Method* refactoring is often more about the place where the method
> is called, than the place where it is defined.

> We prioritize making the whole more readable, even when we have to introduce
> more parts.

One of the goals of encapsulation is letting the whole pay for the price of the
parts. If we don't need to look inside functions, because the name and parameters are clear, then it
matters less how many layers there are.

## Don't use an abstraction you already have when it is a bad fit

One of the tests above is about failing validation when some fields are empty:

```haskell
     it "fails when country is empty" do
       shouldFailValidation $ mkPlace (City "") (Country "")
```
At first I considered re-using the abstraction `invalidPlace` we already had lying around instead of spelling out the empty `City` and `Country`. `invalidPlace` is defined as follows:

```haskell
invalidPlace :: Place
invalidPlace = mkPlace (City "") (Country "")
```

As you can see in the test above, we have exactly two different tests now, one
for empty city and one for empty country. If we were really worried, we could
follow the logic and make four of them. Having `invalidPlace` would make it less
clear _how_ the `Place` is not valid. These trade-offs often take some iteration
to get right.

Some extractions make sense in a larger context
-----

Moving on from the example above, we look at a test for a client of `Place`, the
poorly named `ExpenseRequestDetail`. 

@@note similar patterns make glanceability repeatable
The tests for `expense request` and its `detail` follow a similar pattern as
the tests for Place, with `shouldFailValidation`, objects for `empty` and
`nonEmpty`, etc.

In the test below we have used `invalidPlace` to construct a larger objects for
test. In this larger context we don't want to think about what exactly a
`Place`` is constructed of, so it makes the test more glanceable:

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkExpenseRequestDetail ( nonEmpty {travellingFrom = invalidPlace}))
```

We use `shouldFailValidation` again, but wait, what is `nonEmpty`? 

This made sense at the time of writing the test, as it had three neighbouring
`it` blocks that used `nonEmpty` with a different field being set to invalid
each time. Looking at it again, we noticed having to read and re-read the blocks
together in order to make sense of a single one. That is not particularly
glanceable. We may have missed an opportunity for better naming. We are tempted
to show you what `nonEmpty` is made of, but that would deny us the opportunity
to improve said naming...

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkExpenseRequestDetail ( 
       nonEmptyExpenseRequestDetailData {travellingFrom = invalidPlace}))
```

we renamed `nonEmpty` to `nonEmptyExpenseRequestDetailData` But now the method
is so long that it is no longer glanceable. Let's have a look at our data
structure:

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

Three fields, and we wrote three tests for each field's invalid state. We use
[PureScript's record update
syntax](https://github.com/purescript/documentation/blob/master/language/Records.md#record-update)
to change one value in turn. The non empty expense request detail starts out
its' life as a valid object. In other languages we might have used a [Test Data
Builder](/2020/10/09/test-data-builders.html).

After some back and forth, we settled on `validExpenseRequestDetailParameters`
for now. Not shorter, but slightly less bad than what we had:

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkExpenseRequestDetail ( 
       validExpenseRequestDetailParameters {travellingFrom = invalidPlace}))
```

Why is the glanceability here less than desired?

Notes on the synthesis of poorly named things
----

When Willem showed this code to Marc,he asked, 

> why is`expenseRequestDetail` called an `expenseRequestDetail`?

Willems response was that he had an expense request, and it needed more details,
where previously it didn't have many. And he couldn't come up with a more
meaningful name at the time. Willem said: "The stakeholders wanted to get some idea of expense
requester's itinerary", and people may want to explain more, so there is an
explanation field. Willem made it and named it as best as he could at the time, and
moved on. Hearing himself say `Itinerary`, this may have beeen a better name in hindsight.

It is never to0 late to rename
-----

Now we can use the new name `Itinerary` in our spec:

```haskell
it "fails when travellingFrom is not valid" do
   shouldFailValidation ( mkItinerary ( 
       validItineraryValues {travellingFrom = invalidPlace}))
```

Enough code already. 

# These are just some of my glanceable things

- **Intention revealing names**: test descriptions and function names communicatie intent rather than implementation.
- **Composed method**: having all lines of code in a test at the same level of abstraction.
- **Helpers** that hide implementation details and express intent through good
  names. E.g. custom matchers and custom assertions.
- **Hiddden setup details**, usually the
  [Given](/2021/09/02/tdd-given-when-then.html) part of the test, in a `setup`,
  `beforeEach` or injecting initial state.
- **Exposed relevant data** expected values in a test should be understandable without cross-referencing.
- **Wisely (un)used annotations** the test body should be self contained.
- **[Test data builders](/2020/10/09/test-data-builders.html)** express
  different configurations of domain objects clearly and concisely.

# Effects

Glanceability of tests supports us when a test fails: we will quickly
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

In [Effective Unit Testing
book](https://www.goodreads.com/book/show/17282399-effective-unit-testing),
Lasse Koskela describes a number of testing smells that concern readability and
maintainability of unit tests.

Eyes pictures credits: [Linux xeyes tool](https://www.x.org/releases/X11R7.6/doc/man/man1/xeyes.1.xhtml).

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside> <p>Writing glanceable tests is a skill that becomes better with
  practice. Join us in one of our Test Driven Development course to learn by
  doing. </p> <p><div> <a href="/training/test-driven-development">Check
  availability</a> </div></p> </aside>

![xeyes screenshot](/attachments/blogposts/2021/tdd/xeyes-2.png)
