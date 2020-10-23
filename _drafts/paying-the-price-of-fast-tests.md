---
layout: post
title: Paying the price of fast tests
tags:
  - continuous delivery
  - systems thinking
author: Marc Evers, Rob Westgeest, Willem van den Ende
image:
---

## Effects of fast tests

## Fast Vue.js components test are great?

Vue components are easy to test. Vue test utils helps a lot (still a bit low level, but you can build your own DSL around it). These tests also run fast and will be part of your automated test suite. Running all your front end tests in seconds.

This is great ... however it can have unintended consequences / nudge you towards less optimal design decisions.

When testing of UI components is difficult and/or slow, you tend to move logic out of components, to their own classes/functions. In this way you can have good fast tests/feedback for most of the things.

Because the Vue component tests are so fast, it is tempting to add logic to components and cover the logic by sufficient tests. But if you do this, your components will get more and more complicated, mixing views and view logic. Mixing up concerns.

We are aware of this; we consciously decide to put view logic in its own classes, used by the component. But even for us the temptation is there, and sometimes an innocent if or a tiny bit of logic creeps into our UI components. And then it starts to grow (luckily we know how to refactor that code quickly out of the UI components)

This is not the fault of Vue/Vue test utils! And this post is by no means a critique on how Vue facilitates component testing. What is important here is that as a developer, you understand the effects of things like this (way faster feedback for UI components)

## Cypress

@@same holds for cypress:

## Conclusions

## References
