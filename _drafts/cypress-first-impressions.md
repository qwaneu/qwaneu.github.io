



Imagine your UI and end-to-end tests could be an order of magnitude faster than
they are now? Oh, you don't have end-to-end tests, because they would be too
slow and brittle? I have had that too, don't worry. Imagine then if you could have
cost-effective end-to-end tests. How would that impact your product development?

I'm separating end-to-end tests and UI tests. I develop, or help develop
applications on a daily basis. They usually include a web-front-end. Mostly SPA,
or an MPA with a significant amount of javascript. The front-ends are important
to get right, because that is where most of the users live. My usual approach is
decomposing things, so that I can test things that could possibly break, e.g.
validation and logic. If I feel sufficiently motivated, or the client has enough
budget, I'll add a small amount of selenium tests. They are hard to write, slow
to run, but being able to validate 10, 20 main scenarios in an application, and
provide clear and actionable feedback to others (in an enterprise setting) or to
our team (in a startup setting) can mean the difference between the product sinking
or swimming (not exagerating here, story may be to come another time).

Recently, to make manual testing easier, and decomposing components while
getting visual feedback, I've used [Storybook](20201001101721-storybook.md) (thanks [Rachel Davies](20201001101748-rachel_davies.md) for putting
that in a sample project). Manually testing and iterating on components in
isolation is faster, and it forces you, if ever so gently, to develop
independent components and pages. Clicking around, typing, manual testing and
iterating gives me empathy, and is definately something that is always on my 'I
should do this more often' list. But it is also tedious, as it involves making
lots of little decisions, which leads to [Decision Fatigue](20200606212825-decision_fatigue.md) .

So, combined [Storybook](20201001101721-storybook.md), unit tests in the front-end, [components](20200629174628-hexagonal_architecture.md) and a few
selenium tests that run the UI end to end give me confidence. What I was missing:

-   Speed. Still felt to slow to respond to incoming suggestions for improvement
-   Visual feedback from some of the unit tests. Especially on bigger forms with
    many components and fields.

It helps me to see the UI in action, but I also don't want to watch all the test
  runs all the time, including browsers spawning etc. It also doesn't help if I
  have to wait for <span class="underline">that slow screen in the legacy app</span> every time, and wait for
  the mail to be sent, travel around the world, and received all the time.

What is powerful about [Cypress](20200925094231-cypress.md), is that it lives in the same environment as the
SPA front-end. Same language (javascript or something that generates it), same
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

 
