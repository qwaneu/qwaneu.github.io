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
an order of magnitude faster: tests for [Vue.js](https://vuejs.org) components
and [Cypress][https://www.cypress.io/] based tests for testing web UIs. This
order of magnitude speed-up changes the game, but not only for the better we
found. In this post we will dive into the consequences of having fast tests.

## Fast Vue.js components test are great?

Vue components are easy to test. [Vue test
utils](https://vue-test-utils.vuejs.org/)) helps a lot (still a bit low level,
but you can build your own DSL around it). These tests also run fast and will be
part of your automated test suite. Running all your front end tests in seconds.

In our online Agile Fluency Diagnostic application, we currently have over 170 UI component tests that run in less that 4 seconds.

Having fast tests enables defect prevention and learning by providing immediate feedback on our actions. This contributes to code quality, product quality and speed of development ('productivity').

![beneficial effects of fast tests](/attachments/blogposts/2020/fast-test-effects-1.jpg)

This is great ... however it can have unintended consequences and nudge you
towards less optimal design decisions.

When testing of UI components is difficult and/or slow, you tend to move logic
out of components, to their own classes/functions. In this way you can have good
fast tests/feedback for most of the things.

Because the Vue component tests are so fast, it is tempting to add logic to
components and cover the logic by sufficient tests. But if you do this, your
components will get more and more complicated, mixing views and view logic.
Mixing up concerns.

![negative effects of fast tests](/attachments/blogposts/2020/fast-test-effects-2.jpg)

It is tempting to create more complicated UI components with interesting logic,
but we noticed that we then start losing time on figuring out failing tests (the
tests are fast, but the feedback is still not always good, as often with
integration tests). Furthermore, by mixing UI integration and view logic, we
tend to introduce bugs because it gets complicated. Mixing concerns creates a
cross product of concerns, and too many paths to cover.

We are aware of this; we consciously decide to put view logic in its own
classes, used by the component. But even for us the temptation is there, and
sometimes an innocent `if` or a tiny bit of logic creeps into our UI components.
And then it starts to grow (luckily we know how to refactor that code quickly
out of the UI components)

So, we are not saying the Vue component testing is bad. On the contrary, having
UI component tests running in milliseconds is a great thing to have. But it also
facilitates making UI code complicated. This happens before you know it, so we
need to be aware of this. Listen to your tests. 

## Cypress

We see similar effects with [Cypress](https://cypress.io), a relatively new web
testing tool that changes the game by being an order of magnitude faster. [We
wrote about this earlier](/2020/10/23/cypress-first-impressions.html). The
Cypress developers made different trade-offs than e.g. Selenium/WebDriver, by
having the test run in the browser next to the web application code.

Cypress tests run very fast and stable (especially compared to WebDriver based
test), and they provide relatively good quality feedback. Cypress records the
state of the DOM at each step for instance which allows you to see the path that
lead to a test failure.

Because of the fast running and fast visual feedback enables us to quickly write
UI tests. The scope of the tests is the whole front end component. Cypress also
facilitates stubbing back-end calls conveniently, so we tend to write component
end-to-end tests.

This is actually quite powerful for example if you need to get an existing front
end component under test. However if we mostly write end-to-end tests like
these, we move a way from more focused unit tests and adapter-integration tests
(UI component tests), which will not help in keeping our front end code
well-structured and loosely coupled. 

Furthermore, every component starts simple, but it will grow over time. So
covering all view logic and other paths in the front end code through UI based
end to end tests becomes cumbersome and eventually impossible.

As long as we are aware of these effects, we can [consciously decide on our test architecture](/2020/09/17/test-architecture.html) for our front end component, and have a suitable mix of unit tests, adapter integration tests and end-to-end tests.

## Conclusions

Like Willem said in the [earlier post](/2020/10/23/cypress-first-impressions.html), **changing the speed at which something runs by an order of magnitude is a game changer**.

As our game changes, we need to keep being aware of what that means and what
directions our tooling will guide us if we don't pay attention. As long as we
make conscious decisions, we can keep playing the game at our advantage.

So we consciously decide to put view logic in its own classes, used by the
component. But even for us the temptation is there, and sometimes an innocent if
or a tiny bit of logic creeps into our UI components. And then it starts to grow
(luckily we know how to refactor that code quickly out of the UI components)

Again, it is not the fault of Vue or Cypress. This post is by no means a
critique on the approach Vue and Cypress take. We are actually quite happy with
technology that facilitate rapid feedback like this. What is important here is
that as a developer, you understand the effects of things like this.

<aside>
  <h3>Rightsize your automated tests</h3>
  <p>Getting a good mix of automated tests and making appropriate trade-offs can be a challenge. We can support you with workshops, architecture and code reviews, or working in your teams.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
