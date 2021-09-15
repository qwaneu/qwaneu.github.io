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

From Wereview - PlaceSpec.

``` purescript
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

Describe invariant heuristic (no action and expected outcome). Instead a relation that always holds. (it is never empty). as alluded to in naming test post (@@link).

noEmptyFields is an example of a test that is so glanceable that the test name does not add much. (see test naming post)

"converts itself" is not a great name. "human readable text is never empty"

One could wonder whether it was worth extracting two short one-liners into functions. We believe these extractions help making the code more glanceable:
```
shouldFailValidation :: forall eff a. (Valid a) => a -> Aff eff Unit
shouldFailValidation e = isValid e `shouldEqual` false

shouldPassValidation :: forall eff a. (Valid a) => a -> Aff eff Unit
shouldPassValidation e = isValid e `shouldEqual` true
```
The name helps reveal intent at the places where it is used, even though there is very little code inside of it.

we elide the `shouldEqual` true and how to pass the thing into isValid. Fewer moving parts when reading can help understanding code, and that includes tests, as long as the function has a clear name in the context where it is used.

At first I considered using the abstraction below for the empty city and country, like so:

```
invalidPlace :: Place
invalidPlace = mkPlace (City "") (Country "")
```

As you can see in the test above, I have two different tests now, one for empty city and empty country. If I was really worried, I could make four of them. Having invalidPlace would make it less clear _how_ the Place is not valid. This often takes some iteration to get it right.

Instead, I have used `invalidPlace` and its' sibling `validPlace` to construct larger objects for test that contain a `Place`. In the larger context I don't want to think about what exactly it is constructed of, so it makes the test more glanceable there:

```
it "fails when travellingFrom is not valid" do
   shouldFailValidation $ mkExpenseRequestDetail $ nonEmpty {travellingFrom = invalidPlace}
```

The tests for `expense request` follow a similar pattern as the tests for Place, with shouldFailValidation, objects for empty and nonEmpty etc. If I had to construct the Place object here, it would just detract from the intent of the test. It would merely add line noise.

# Further reading

Intention revealing code - smalltalk best practice patterns

the word glanceable originates from the 1950s (dictionary.com)
