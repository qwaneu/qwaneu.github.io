---
layout: post
title: Fast browser tests with Cypress - First Impressions
tags:
  - architecture
author: Willem van den Ende
image:
---

Imagine your UI and end-to-end tests could run an order of magnitude faster than
they are now? Oh, you don't have end-to-end tests, because they would be too
slow and brittle? I have had that too, don't worry. Imagine then if you could
have cost-effective end-to-end tests. How would that impact your product
development?

## Fast browser tests in addition to...

As Marc and Rob have described in their series on architecting and test-driving Vue.js (see [How to keep Front End complexity in check with Hexagonal Architecture](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html) and [A Hexagonal Vue.js front-end, by example](/2020/09/25/hexagonal-frontend-example.html)), we like to have tests in our front-ends, for [anything that can possibly break](http://wiki.c2.com/?TestEverythingThatCouldPossiblyBreak). In addition to that, I like to have:

* at least a set of end-to-end tests to check few main scenarios;
* [a playground](https://storybook.js.org) for components we made or just use;
* a type system to make sure everything still hangs together, leaving time to focus on tests for interesting behaviour.

My go to tool for browser and end-to-end tests has been Selenium, at least for
the last ten years. I make a distinction between browser tests and end-to-end
tests, because if you can easily test visual components fast and in isolation,
it becomes attractive to do that as well.

Selenium is battle tested, but it has several moving parts and does not execute
particularly fast. So I tend to automate only a few scenarios, and leave the
rest to non-visual unit tests. I also tend to delay writing Selenium tests until the application is further fleshed out. The risk, that I had materialize, is that we have structured our application and the services it uses in such a way that adding browser tests has become time consuming or nigh-on impossible.

### shortcomings of non-visual tests for a front-end
Interpreting the result of the unit tests in the UI cost mental energy: you have to make the mapping between what the tests tell you, and how it looks on the screen in your imagination. For instance: It is useful to know that a specific validation failure will disable submitting on a forms model, but what does it look like?

I'm quite handy at writing unit tests, so my UI is usually not broken, and the tests pass. When the tests pass, I push a small feature to production and move on to the next part. However, that means that I tend not to look at the UI enough. If there are clumsy interaction patterns, I will not notice them.

I was one of those people who would go: "My tests are great, now I don't have to click through the UI all the time". When I hear something like that now, I cringe. I knew in theory that, apart from observing users, reflectively using the application yourself is a powerful feedback mechanism. Yet some states are hard to achieve in a test situation, and doing this in production is not necessarily feasible. So when, after a long time, I am finally brave to click through the UI, I go "Oh. this is ... bad!". And because it is slow and cumbersome, I can't immediately fix it, and the pattern repeats.

- @TODO add small DOE HERE

exploratory testing -> focus on user needs
hard to achieve states -> exploratory test cost -> minus exploratory testing -> hard to achieve states

if it hurts, do it more often:
exploratory testing -> speed of explortory testing -> minus hard to achieve states

But if everything is manual, this is still expensive, and doesn't scale. The time elapsed from an incoming user issue to first reproduction remains high (especially if it is a part of the UI we haven't worked on in a while).

### Selium works, but is tiring
Selenium helps me to see the UI in action, but watching it run the tests, including browsers spawning etc is tiring. So in effect I use it similarly to unit tests. I look at the UI I am developing, and when a test fails, but not otherwise, because the threshold is too high.

### What if we made our system fast?
End-to-end tests can be fast, if you [design the front-end and backend system(s) for fast test runs](/2020/09/17/test-architecture.html). I have done this, but in existing systems that option is not always available. Rather it is something we have to work towards. This is an area where a modular browser testing tool like Cypress can come in handy.

## Why Cypress

What is powerful about [Cypress](https://www.cypress.io/), is that it lives in
the same environment as the SPA front-end. Same language, same toolchain, same
people. Working test-first, without hand-offs and waiting was a game changer for
unit tests, and now with Cypress it can be the same for UI tests and end-to-end tests as well.

Cypress makes it easy to separate end-to-end tests and UI tests. Since the tests
are white-box, and the test-code inhabits the same space as the UI code, it is
easier to isolate small bits of the UI and test them visually, quickly. Cypress
offers support code to start where you are, possibly with end-to-end tests, and
stub out dependencies as you go.

If you start fresh, Cypress lowers the bar for developing with
[hexagons](/2020/08/20/hexagonal-architecture.html) and using the [Humble
Dialog pattern](http://xunitpatterns.com/Humble%20Object.html) instead of a tightly coupled network.

Changing the speed at which something runs by an order of magnitude is a game
changer. I've experienced this with test driven development at the unit level in the past, and once with Selenium (after architecting the application to be fast).


## background / further reading / stuff that now has partly been addd to Instead of
&#x2013; see also [testcafe - A node.js tool to automate end-to-end web testing | TestCafe](a_node_js_tool_to_automate_end_to_end_web_testing_testcafe.md)
[cypress accessible blog example](cypress_example_recipes_examples_blogs_a11y_at_master_cypress_io_cypress_example_recipes.md)
[Cypress](20200925094231-cypress.md)
