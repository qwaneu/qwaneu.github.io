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

We are great fans of Test Driven Development (TDD). It has served us well over
the years. The TDD cycle - test, fail, run, refactor - is all about getting rich
feedback fast, feedback about design decisions, about the test, about your code.
It thrives on fast tests. We also want to test-drive our adapter integration and
UI tests. These tend to be slow and fragile, and their feedback is low quality.

There are some recent developments where slow types of tests have become an
order of magnitude faster, for instance testing [Vue.js](https://vuejs.org)
components and [Cypress](https://www.cypress.io/) based web UI tests. This order
of magnitude speed-up changes the whole game, but not only for the better we
found. In this post we will dive into the consequences of having fast tests.

## Fast Vue.js components tests

Vue components are easy to test. The [Vue test
utils](https://vue-test-utils.vuejs.org/) library helps a lot. Even though its
API is a bit low level, you can wrap it in your own DSL. These tests run
blazingly fast together with any unit tests, in seconds. In our online Agile
Fluency Diagnostic application, we currently have over 170 UI component tests
that run in less that 4 seconds.

Having fast tests facilitates defect prevention and learning by providing
immediate feedback on our actions. This contributes to code quality, product
quality and speed of development. in other words, these help your
[productivity](/2020/10/26/under-pressure.html#productivity).

![beneficial effects of fast tests](/attachments/blogposts/2020/fast-test-effects-1.jpg)

**So fast UI tests are great ... but they can have unintended consequences and
nudge you towards less optimal design decisions.**

When testing of UI components is difficult and slow, we tend to move logic out
of UI components, into classes/functions of their own with their own tests. It
is just too much a hassle to test everything in UI component tests. Separating
the concerns allow fast tests for most of the logic.

Because the UI component tests are so fast, it is tempting to add logic to
components and cover the logic by sufficient tests. The speed of the tests is no
longer an impediment. The consequence of this however is that you mix UI and
logic, and the UI components grow more and more complicated. The tests will need
to cover both UI specifics and logic so their scope also grows. The wider the
scope of a test, the harder the test becomes to understand and the less helpful
the feedback from failing tests will be.

We start losing time on figuring out failing tests. Furthermore, by mixing UI
integration and view logic, we start introducing bugs because it gets
complicated. Mixing concerns creates a cross product of concerns, and too many
paths to cover in tests.

![negative effects of fast tests](/attachments/blogposts/2020/fast-test-effects-2.jpg)

Ultimately, this increases the number of mistakes, reduces code quality and
reduces speed of development. It starts negating the positive effects of fast
tests, and we could even end up in a situation were eventually we become less
productive.

Once we are aware of this, we can consciously decide to put view logic in its
own classes and functions. Even for us the temptation remains, and sometimes an
innocent `if` or a tiny bit of logic creeps into our UI components, and
complexity starts growing. Luckily we know how to refactor that code quickly out
of the UI components.

We are not saying the Vue component testing is bad. On the contrary, having UI
component tests running in milliseconds is great. But it also removes an
impediment for making UI code complicated. It happens before you know it, but as long as we are aware of this, we can act upon it. **So listen to your tests.** 

## Fast Cypress end-to-end tests

We see something similar with [Cypress](https://cypress.io), a recent web
testing tool that also changes the game by being an order of magnitude faster.
[We wrote about this earlier](/2020/10/23/cypress-first-impressions.html). The
Cypress developers made different trade-offs than e.g. Selenium/WebDriver, by
having the test run in the browser next to the web application code.

Cypress tests run very fast and stable, compared to Selenium/WebDriver based
tests. They also provide good quality feedback, for instance by records the DOM
state at each step allowing you to see the path that lead to a test failure.

The fast running tests and good visual feedback enables us to quickly write UI
tests. Cypress facilitates stubbing back-end calls conveniently, so we tend to
write component end-to-end tests, with tests having the whole front end
component as their scope.

This is quite powerful for example if you need to get an existing front end
component under test. If we mostly write end-to-end tests like these however, we
move a way from focused unit and adapter-integration tests. This will not help
in keeping our front end code well-structured and loosely coupled. @@link post

Furthermore, every component starts simple, but it will grow over time. So
covering all the different paths, covering combinations of UI state, view logic,
back-end API integration through UI based end to end tests becomes cumbersome.
Getting high coverage becomes eventually impossible because of the combinatorial
explosion.

As long as we are aware of these effects, we can [consciously decide on our test
architecture](/2020/09/17/test-architecture.html) for our front end component,
and have a suitable mix of unit tests, adapter integration tests and end-to-end
tests. Again, we have to consciously decide this, because the slowness of
writing and running UI tests is no longer an impediment that keeps us from doing
too much in UI based end-to-end tests.

## Conclusions

Like Willem said in an [earlier post](/2020/10/23/cypress-first-impressions.html), **changing the speed at which something runs by an order of magnitude is a game changer**.

As our game changes, we need to stay aware of what other effects the changes
have. In what directions will our tooling guide us if we don't pay enough
attention? As long as we make conscious decisions, we can keep playing the game
at our advantage.

In UI components, we tend to be strict and move any view logic to its own classes and functions. Keeping these concerns separated helps us in keeping the component's complexity manageable. 

This is not the fault of Vue.js or Cypress and this post is by no means a
critique on the approach these tools take. We are actually quite happy with
technology that facilitates rapid feedback. As a developer, it pays to understand the effects of game changers like these, so that you can apply them at your advantage.

<aside>
  <h3>Rightsize your automated tests</h3>
  <p>Getting a good mix of automated tests and making appropriate trade-offs can be a challenge. We can support you with workshops, architecture and code reviews, or working in your teams.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
