---
layout: post
title: TDD & Hexagonal Architecture in front end - a journey
tags:
  - architecture
  - patterns
  - ports and adapters
  - web development
  - test driven development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/PortsAndAdapters-9.png
---

Over the years, we have done our share of UI and front end development. Long long time ago with SmallTalk, Visual Basic and Delphi, building web applications with server side rendering and React, and being involved in Angular projects at several clients. Recently we have been building front ends based on Vue.js. In a series of blog posts, we are going to share how we approach (hexagonal) architecture, test driven development, and incremental design in the front end.

Earlier this year we created a front end application with [Vue.js](https://vuejs.org/) and [Vuex](https://vuex.vuejs.org/), for a private [Agile Engineering course](/training/agile-engineering). We created a simple web shop to let participants experience how Test Driven Development (TDD), object oriented design and the [Hexagonal Architecture pattern](/2020/08/20/hexagonal-architecture.html) work out in a front end application.

![Ports and Adapters in front end with vue.js](/attachments/blogposts/2020/PortsAndAdapters-9.png)
{: class="post-image post-image-50" }

Early spring this year, an opportunity arose: as [Agile Fluency®](https://www.agilefluency.org/) facilitators, we were in the middle of running a series of team fluency workshops, when the lockdown hit. We were facilitating these workshops in person. Each workshop has the participants fill in questionnaires, which was done with pen and paper.

We created a first solution based on Google Forms & Sheets for our first remote workshop, but we decided to develop a proper web based application for this, so that we can practice what we preach. After initial successes with a dirt road version, we shared the application with Agile Fluency Project founders Jim Shore (of [Art of Agile Development fame](https://www.jamesshore.com/v2/projects/lunch-and-learn/art-of-agile-development)) and Diana Larsen (of [Agile Retrospectives fame](https://pragprog.com/titles/dlret/agile-retrospectives/)). We decided to further develop the application for broader use within the Agile Fluency community.

## First impressions

We found that vue.js as a web UI framework and Vuex as a state management library lend themselves reasonably well for working in a test-driven way. We like the fast unit test cycle for Vue components: we can run a suite of component tests in seconds, getting continuous and fast feedback on our work. It facilitates us in going through the TDD cycle: **write a test, see it fail, make it work, and refactor**.

![test driven development cycle](/attachments/blogposts/2020/tdd-cycle.png)
{: class="post-image post-image-50" }

We also like that Vue.js behaves more like a library than a framework, unlike e.g. Angular. The main difference is a framework is in control, you write your code to fit with the framework; when using a library you are in control. We like to be in control and wire our components together from a proper main.js.

Vuex forces you to think in the pattern of *state - actions - mutations*. It also allows to split your state into different modules. This can be helpful to structure your code and separate concerns. It helps in thinking ‘hexagonally’ - separating the view-domain logic from the UI code (the components).

## Second thoughts

We found a number of things that felt awkward, like:

### Cryptic feedback breaks the TDD flow

The feedback from failing component tests (a unit test for a custom Vue.js based component) can be cryptic or misleading. A mistake within the component sometimes prevents the component from being mounted, resulting in some unhelpful 'undefined' messages. If I make a typo in my view code, I could get an error message like below, accompanied by impressive stack trace containing the actual error, without a reference to the actual line of source code with the mistake:

```
  ● The Admin.vue › creating a facilitator › delegates creation to the admin module when all data is correct

    TypeError: Cannot read property 'find' of undefined

      28 |   describe('creating a facilitator', () => {
      29 |     it('delegates creation to the admin module when all data is correct', async () => {
    > 30 |       wrapper.find('#create-facilitator-name-input').setValue('John')
         |               ^
      31 |       wrapper.find('#create-facilitator-email-input').setValue('john@mail.com')

      at Object.<anonymous> (tests/unit/views/TheAdmin.spec.js:30:15)
```
And the actual error, buried in stack traces:
```
 TypeError: Cannot read property 'isAdmin' of undefined
```

**We like our test feedback to be specific so that we quickly know what's wrong and where to fix it. If we need to make sense of a message like the one above and start debugging, it will break the flow of the TDD cycle.**

### Complying with libraries/frameworks

Even though Vue.js and Vuex behave mostly like libraries, we found ourselves struggling with some of their idiosyncrasies: you do need to know how it works and adjust your own code accordingly. An example from the online Agile Fluency application we are working on, this is about participants who join an online workshop.

```javascript
  // expressed using Vuex actions and mutations:
  const actions = {
    join ({ commit }, { sessionId, joiningId }) {
      sessionJoiner.join(sessionId, joiningId)
        .then(session => commit('setSession', session))
        .catch(error => commit('failed', error.message))
    },
  }
  const mutations = {
    setSession (state, session) {
      state._session = session
    },
    failed (state, message) {
      state._message = message
    }
  }
}
```

We have to _know_ that a commit is needed on resolution or rejection of a promise, and we have to know that the commits are associated with the mutations. Not only do we have to know this, which is implicit knowledge, but it also obfuscates our intent. We really just want to save the resulting session in a member variable on the resolving promise, and save the error message on failure. If we would express the same logic in plain javascript, it looks like:

```javascript
  join (sessionId, joiningId) {
    return this.sessionJoiner.join(sessionId, joiningId)
      .then(session => { this._session = session })
      .catch(error => { this._message = error.message })
  }
```

### Noisy tests

Although the [Vue Test Utils](https://vue-test-utils.vuejs.org/) library greatly facilitates writing component tests, the tests still feel cumbersome and noisy at times, especially when there is view behaviour we want to test drive. An example of this is a submit button that is only enabled when all validation constraints on the inputs are satisfied:

```javascript
  it('disables the reset-button after successfully changing password', async () => {
    wrapper.find('#new-password').setValue('s3cret!')
    await wrapper.find('#new-password-confirm').setValue('s3cret!')
    await wrapper.find('#reset-button').trigger('click')
    expect(wrapper.find('#reset-button').attributes().disabled).toBeTruthy()
  })
```
Although it is short and Vue Test Utils makes it relatively easy to write fast UI component tests, the intent of the test tends to disappear a bit behind the testing mechanisms. We also need some _awaits_ to make sure input changes have been processed fully. **We'd like our test to be [glanceable](/2021/09/27/tdd-glanceable-tests.html): at a glance, we'd to understand the _given_, the _when_ and the _then_ of a test.** Growing our own  higher level DSL (domain specific language) around Vue Test Utils could help here.

### High coupling

The way Vuex integrates with Vue components becomes noisy and leads to strong coupling between Vuex state objects and UI components. Testing this either means testing the UI component and the Vuex state object in an integrated way (large scope of the test, lower quality of test feedback) or mocking/stubbing the different action and commit functions (leading to tests highly coupled to implementation details, which is not how you're supposed to apply mocking or stubbing).

An example component that is tightly coupled to the Vuex store (this.$store):

```javascript
export default {
  name: 'TheDiagnosticJoiner',
  computed: {
    color () {
      return this.$store.getters['diagnostic/color']
    },
    diagnosticSession () {
      return this.$store.getters['diagnostic/session']
    },
    message () {
      return this.$store.getters['diagnostic/message']
    },
    ...
  },
  mounted () {
    this.$store.dispatch('diagnostic/join', { sessionId: this.sessionId, joiningId: this.joiningId })
  },
  ...
}
```

![diagnostic-joiner-vuex](/attachments/blogposts/2020/diagnostic-joiner-vuex.jpg)
{: class="post-image" }

To work around the tight coupling between the Vue view and the Vuex store implementation details, we test the view integrated with the Vuex store and verify effects of its behaviour indirectly, on a third object: the SessionJoiner, which encapsulates a call to a backend API.

```javascript
describe('The Diagnostic Joiner.vue', () => {
  let wrapper, joiner, join

  function aDiagnosticJoinerWithSessionJoiner (props) {
    return mount(TheDiagnosticJoiner, {
      store: store(undefined, joiner),
      propsData: props,
      localVue
    })
  }

  describe('when session retrieval succeeds', () => {
    beforeEach(() => {
      joiner = new SessionJoiner()
      join = jest.spyOn(joiner, 'join').mockImplementation((sessionId, participantId) =>
        Promise.resolve(new ParticipantSession(
          sessionId,
          'the-participant-id',
          'the-color',
          'the facilitator')))
      wrapper = aDiagnosticJoinerWithSessionJoiner({
        sessionId: 'the-session',
        joiningId: 'the-joining-id'
      })
    })
    it('gets the session', () => {
      expect(join).toHaveBeenCalledWith('the-session', 'the-joining-id')
    })
    it('shows the facilitator', () => {
      expect(wrapper.text()).toMatch('the facilitator')
    })
  })
})
```

The consequence is that the test covers view concerns as well as behavioral (domain) concerns. The large scope of the test (View, Vuex store, Vuex framework wiring) results in poor feedback at times.

**We want our test to focus on the behaviour of the object/component, preferably in isolation.**

## Discovering better ways...

We intend to share our learnings on hexagonal front end architecture and design in a series of posts, mostly as proto-patterns - remember, **there are no best practices! It is all about trade-offs**.

We intend to cover the following proto-patterns, using examples from our application:
- Hexagonal architecture applied to a Vue.js application: what are the ports, adapters, and the domain
- Pragmatic state management
- Keep UI components flat & simple, move all behaviour to the domain
- Primary & Secondary ports & adapters in front end
- Slicing the cake: how to make a front-end hexagon modular
- Test driving API adapters
- ... and probably more - [let us know](/contact) if there is anything you're specifically interested in!

## Can't wait?

In the meanwhile, here is some recommended further reading on test driven development on the front end. TDD is as useful for front end code as it is for back end code.
- [GeePaw Hill, TDD on the Front End](https://www.geepawhill.org/2020/03/11/tdd-on-the-front-end/)
- [Sarah Dayan, An Introduction to TDD with Vue.js](https://noti.st/sarahdayan/4PecIH/an-introduction-to-tdd-with-vue-js)
- [Josh Justice, Outside-In Frontend Development ](https://outsidein.dev/)
- [Our recent post on the Hexagonal Architecture pattern](/2020/08/20/hexagonal-architecture.html)

_Many thanks to Willem for reviewing & feedback!_

<aside>
  <h3>Want to learn more?</h3>
  <p>We offer courses and workshops on Agile Engineering, Domain Driven Design and Hexagonal Architecture. </p>
  <p><div>
    <a href="/training">Learn more about our courses</a>
  </div></p>
</aside>
