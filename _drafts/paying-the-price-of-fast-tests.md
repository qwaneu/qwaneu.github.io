---
layout: post
title: Paying the price of fast(er) tests
tags:
  - continuous delivery
  - systems thinking
  - test driven development
author: Marc Evers, Rob Westgeest, Willem van den Ende
image:
---

We are great fans of Test Driven Development (TDD). It is one of the good
software development practices that keeps on serving us well. The TDD cycle -
test, fail, run, refactor - is all about getting rich feedback fast & early,
feedback about your design decisions, about your test, about your code. It
thrives on fast tests.

Integration and UI based tests tend to be slow and fragile. They usually don't
provide the direct feedback on your work and do not lend themselves for TDD as
we mean it.

We have noticed some recent developments where slow types of tests have become
an order of magnitude faster: tests for Vue.js components and Cypress based
tests for testing web UIs. This order of magnitude speed-up changes the game,
but not only for the better we found. In this post we will dive into the
consequences of having fast tests.

@@plaatje van oude schilderende vrouw?

## Fast Vue.js components test are great?

Vue components are easy to test. Vue test utils helps a lot (still a bit low
level, but you can build your own DSL around it). These tests also run fast and
will be part of your automated test suite. Running all your front end tests in
seconds.

In our online Agile Fluency Diagnostic application, we currently have over 170 UI component tests that run in less that 4 seconds.

@@ stukje diagram

This is great ... however it can have unintended consequences / nudge you
towards less optimal design decisions.

We are aware of this; we consciously decide to put view logic in its own
classes, used by the component. But even for us the temptation is there, and
sometimes an innocent `if` or a tiny bit of logic creeps into our UI components.
And then it starts to grow (luckily we know how to refactor that code quickly
out of the UI components)

When testing of UI components is difficult and/or slow, you tend to move logic
out of components, to their own classes/functions. In this way you can have good
fast tests/feedback for most of the things.

Because the Vue component tests are so fast, it is tempting to add logic to
components and cover the logic by sufficient tests. But if you do this, your
components will get more and more complicated, mixing views and view logic.
Mixing up concerns.

@@ diagram met loop

It is tempting to create more complicated UI components with interesting logic,
but we noticed that we then start losing time on figuring out failing tests (the
tests are fast, but the feedback is still not always good, as often with
integration tests). Furthermore, by mixing UI integration and view logic, we
tend to introduce bugs because it gets complicated. Mixing concerns creates a
cross product of concerns, and too many paths to cover.

## Cypress

@@same holds for cypress:


## bla

We are aware of this; we consciously decide to put view logic in its own
classes, used by the component. But even for us the temptation is there, and
sometimes an innocent if or a tiny bit of logic creeps into our UI components.
And then it starts to grow (luckily we know how to refactor that code quickly
out of the UI components)

This is not the fault of Vue/Vue test utils! And this post is by no means a critique on how Vue facilitates component testing. What is important here is that as a developer, you understand the effects of things like this (way faster feedback for UI components)
## Conclusions

## References
