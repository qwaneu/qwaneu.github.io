---
layout: post
title: TDD & Hexagonal Architecture in front end - a journey
tags:
  - architecture
  - patterns
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/ports-and-adapters.jpg
---

Over the years, we have done our share of UI and front end development. Long long time ago with SmallTalk, Visual Basic and Delphi, building web applications with server side rendering and React, and being involved in Angular projects at several clients.

Earlier this year we created a front end application with [Vue.js](https://vuejs.org/) and [Vuex](https://vuex.vuejs.org/), for a private [Agile Engineering course](/training/agile-engineering). We created a simple web shop to let participants experience how Test Driven Development (TDD), object oriented design and the [Hexagonal Architecture pattern](/2020/08/20/hexagonal-architecture.html) work out in a front end application.

We found that vue.js as a web UI framework and Vuex as a state management library lend themselves reasonably well for working in a test-driven way. We like the fast unit test cycle for Vue components: we can run a suite of component tests in seconds, getting continuous and fast feedback on our work. It facilitates us in going through the TDD cycle: write a test, see it fail, make it work, and refactor.

We also like that Vue.js behaves more like a library than a framework, unlike e.g. Angular. The main difference is a framework is in control, you write your code to fit with the framework; when using a library you are in control. We like to be in control and wire our components together from a proper main.js.

Vuex forces you to think in the pattern of state - actions - commits. It also allows to split your state into different modules. This can be helpful to structure your code and separate concerns. It helps in thinking ‘hexagonally’ - separating the view-domain logic from the UI code (the components).

We found a number of things that felt awkward, like:
- The feedback from failing component tests (a unit test for a custom Vue.js based component) can be cryptic or misleading. An mistake within the component sometimes prevents the component from being mounted, resulting in some unhelpful 'undefined' messages.
@@example
- Even though Vue.js/Vuex behave mostly like libraries, we found ourselves struggling with some of their idiosyncrasies: you do need to know how it works and adjust your own code accordingly.
- Although the [Vue Test Utils](https://vue-test-utils.vuejs.org/) library greatly facilitates writing component tests, the tests still feel cumbersome and noisy at times, especially when there is view behaviour we want to test drive. An example of this is a submit button that is only enabled when all validation constraints on the inputs are satisfied:
@@example test
- The way Vuex integrates with Vue components becomes noisy and leads to strong coupling between Vuex state objects and UI components. Testing this either means testing the UI component and the Vuex state object in an integrated way (large scope of the test, lower quality of test feedback) or mocking/stubbing the different action and commit functions (leading to tests highly coupled to implementation details, which is not how you're supposed to apply mocking or stubbing).
@@example code

Early spring this year, an opportunity arose: as [Agile Fluency](https://www.agilefluency.org/) facilitators, we were in the middle of running a series of team fluency workshops, when the lockdown hit. We were facilitating these workshops in person. Each workshop has the participants fill in quesionaires, which was done with pen and paper.

For our first remote workshop we used Google Forms & Sheets, but we decided to develop a proper web based application for this, so that we can practice what we preach. After initial successes with a dirt road version, we shared the application with Agile Fluency Project founders Jim Shore (of [Art of Agile Development fame](https://www.jamesshore.com/v2/projects/lunch-and-learn/art-of-agile-development)) and Diana Larsen (of [agile retrospectives fame](https://pragprog.com/titles/dlret/agile-retrospectives/)). We decided to further develop the application for broader use within the Agile Fluency community.

We intend to share our learnings on hexagonal front end architecture and design in a series of posts, mostly as proto-patterns - remember, **there are no best practices! It is all about trade-offs**.

We intend to cover the following proto-patterns, using examples from our application:
- Hexagonal architecture applied to a Vue.js application: what are the ports, adapters, and the domain
- Pragmatic state management
- Keep UI components flat & simple, move all behaviour to the domain
- Primary & Secondary ports & adapters in front end
- Slicing the cake: how to make a front-end hexagon modular
- Test driving API adapters
- ...

## Can't wait?

In the meanwhile, here is some recommended further reading on test driven development on the front end. TDD is as useful for front end code as it is for back end code.
- [GeePaw Hill, TDD on the Front End](https://www.geepawhill.org/2020/03/11/tdd-on-the-front-end/)
- [Sarah Dayan, An Introduction to TDD with Vue.js](https://noti.st/sarahdayan/4PecIH/an-introduction-to-tdd-with-vue-js)
- [Josh Justice, Outside-In Frontend Development ](https://outsidein.dev/)
- [Our recent post on the Hexagonal Architecture pattern](/2020/08/20/hexagonal-architecture.html)

<aside>
  <h3>Want to learn more?</h3>
  <p>We offer courses and workshops on Agile Engineering, Domain Driven Design and Hexagonal Architecture. </p>
  <p><div>
    <a href="/training">Learn more about our courses</a>
  </div></p>
</aside>
