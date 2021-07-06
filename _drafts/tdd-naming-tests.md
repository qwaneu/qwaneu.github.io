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

![]() @@add screenshot of list of tests


```java
// A nondescriptive name: 
public void testDeliver() { ...

// We prefer: 
public void deliversCanWhenPaidEnough() { ...
```

## Effects 

Trying to catch the test's intention in the name also helps to think of what
exactly we're trying to do in the test. If it is hard to find a good name, we
probably don't understand what we are trying to capture in the test.

We are not afraid of long names, but we want to prevent long, vague sentences.
Names containing 'and' are a hint that there might be two (or more!) tests 
in there.

This heuristic helps thinking Given-When-Then: the test name gives a summary 
of the When and the Then.

## Further reading

@@meer!


For more inspiration, take a look at RSpec - [rspec.info](http://rspec.info/)


_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Stop faking TDD and learn it the proper way! Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
