---
layout: post
title: Cypress First Impressions
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

<<<<<<< Updated upstream
## Instead of Selenium, in addition to Storybook and unit tests
=======
I'm separating end-to-end tests and UI tests. I develop, or help develop
applications on a daily basis. They usually include a web-front-end. Mostly SPA,
or an MPA with a significant amount of JavaScript. The front-ends are important
to get right, because that is where most of the users live. My usual approach is
decomposing things, so that I can test things that could possibly break, e.g.
validation and logic. If I feel sufficiently motivated, or the client has enough
budget, I'll add a small amount of selenium tests. They are hard to write, slow
to run, but being able to validate 10, 20 main scenarios in an application, and
provide clear and actionable feedback to others (in an enterprise setting) or to
our team (in a startup setting) can mean the difference between the product sinking
or swimming (not exaggerating here, story may be to come another time).

Recently, to make manual testing easier, and decomposing components while
getting visual feedback, I've used [Storybook](20201001101721-storybook.md) (thanks [Rachel Davies](20201001101748-rachel_davies.md) for putting
that in a sample project). Manually testing and iterating on components in
isolation is faster, and it forces you, if ever so gently, to develop
independent components and pages. Clicking around, typing, manual testing and
iterating gives me empathy, and is definitely something that is always on my 'I
should do this more often' list. But it is also tedious, as it involves making
lots of little decisions, which leads to [Decision Fatigue](20200606212825-decision_fatigue.md) .
>>>>>>> Stashed changes

As Marc and Rob have described in their series on vue.js (architecting and
test-driving), we like to have tests in our front-ends, for anything that can
break. In addition to that, I like

* at least a set of end-to-end tests to check few main scenarios.
* a playground for components we made or just use
* a type system to make sure everything still hangs together (this leaves time to focus on tests for interesting behaviour)

My go to tool for that browser and end-to-end tests has been Selenium, for at
least the last ten years. I distinguish between browser tests and end-to-end
tests, because if you can easily test visual components fast, and in isolation,
it becomes attractive to do that as well. Selenium is battle tested, but has
several moving parts and does not execute particularly fast. So I tend to only
automate a few scenarios with that, and leave the rest to non-visual unit tests.
Those tests help, but it costs mental energy to interpret some of the results,
and I tend not to look at the UI enough, so that suboptimal interaction patterns stay in
the UI longer than they should.

End-to-end tests can be fast, if you design the front-end and backend system(s) for speed. I
have done this, but in projects with existing systems that option is not always
available.


## Why Cypress
What is powerful about [Cypress](20200925094231-cypress.md), is that it lives in the same environment as the
SPA front-end. Same language (JavaScript or something that generates it), same
toolchain, same people. Working test-first, without hand-offs and waiting was a
game changer for unit tests, and it can be the same for UI tests and end-to-end
tests.

[Cypress](20200925094231-cypress.md) makes it easy to separate end-to-end tests and UI tests. Since the tests
are white-box, and the test-code inhabits the same space as the UI code, it is
easier to isolate small bits of UI, and test them visually, quickly. Cypress
offers support code to start where you are, possibly with end-to-end tests, and
stub out dependencies as you go. If you start fresh, the bar for developing with
[hexagons](20200629174628-hexagonal_architecture.md) and use [A Humble Dialog](humble_object_at_xunitpatterns_com.md) instead of a tightly coupled network is lowered.

Changing the speed at which something runs by an order of magnitude is a game
changer. I've experienced this with TDD at the unit level in the past, and once
with Selenium (after architecting the application to be fast).

&#x2013; see also [testcafe - A node.js tool to automate end-to-end web testing | TestCafe](a_node_js_tool_to_automate_end_to_end_web_testing_testcafe.md)
[cypress accessible blog example](cypress_example_recipes_examples_blogs_a11y_at_master_cypress_io_cypress_example_recipes.md)
[Cypress](20200925094231-cypress.md)

## background / further reading / stuff that now has partly been addd to Instead of
I've used [Storybook](https://storybook.js.org) (hat tip to Rachel Davies for putting
that in [a sample project](https://github.com/tes/rolling-fields). Manually testing and iterating on components in
isolation is faster, and it forces you, if ever so gently, to develop
independent components and pages. Clicking around, typing, manual testing and
iterating gives me empathy, and is definately something that is always on my 'I
should do this more often' list. But it is also tedious, as it involves making
lots of little decisions, which leads to [Decision Fatigue](20200606212825-decision_fatigue.md) .

So, combined [Storybook](https://storybook.js.org), unit tests in the front-end, [components](20200629174628-hexagonal_architecture.md) and a few
selenium tests that run the UI end to end give me confidence. What I was missing:

-   Speed. Still felt to slow to respond to incoming suggestions for improvement
-   Visual feedback from some of the unit tests. Especially on bigger forms with
    many components and fields.

It helps me to see the UI in action, but I also don't want to watch all the test
  runs all the time, including browsers spawning etc. It also doesn't help if I
  have to wait for <span class="underline">that slow screen in the legacy app</span> every time, and wait for
  the mail to be sent, travel around the world, and received all the time.
