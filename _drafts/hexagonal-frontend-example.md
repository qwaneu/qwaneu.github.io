---
layout: post
title: Hexagonal Front End - An Example
tags:
  - architecture
  - ports and adapters
  - web development
author: Marc Evers
image: /attachments/blogposts/2020/PortsAndAdapters-8.png
---

In a [previous post](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html), we elaborated on how we apply [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html) in front end applications. 
{: class="post-image" }

We have also written about how hexagonal architecture informs test architecture. We also apply this thinking for a front end component: as we distinguish ports, adapters and domain logic, we will have unit tests, adapter integration tests, and possibly some component end-to-end tests.

Let's look at an example, with code!, taken from the Agile Fluency Diagnostic application we are developing. 

![screenshot of the online agile fluency diagnostic, showing a form to create a new diagnostic session followed by a a list of 'my diagnostic sessions'](/attachments/blogposts/2020/online-afd.png)
{: class="post-image post-image-50" }

We will use a specific activity as an example: creating a new diagnostic session. We will show the primary and secondary adapters, and our domain. Here is a quick architecture sketch, to show the different objects involved and how they relate to the hexagon:

![architectuur/hexagon drawing, parts explained below](/attachments/blogposts/2020/front-end-hexagon-sketch.jpg)
{: class="post-image" }

UI adapter: red, (view) domain objects: blue, API adapter: green

## Primary adapters: UI Components

This is our new NewDiagnosticSession Vue component:

![Screenshot: 'Create a new diagnostic session' heading, fields for team name, date, session type (regular or test) and a dropdown for the number of participants. The call to action button is 'Create'](/attachments/blogposts/2020/new-diagnostic-session.png)
{: class="post-image" }

The form has inputs and a button, and opens a help box when you click on the 'i'. The code looks roughly like this, we have left some details out for clarity:

```html
<template>
  <div>
    <header class="event__header">
      <h1>Create a new diagnostic session</h1>
    </header>
    <HelpBox id="create-session-help" :helper="helper">...</HelpBox>
    <div>
      <form class="create-session" @submit.prevent>
        <div id="create-session-team" class="input-wrapper" 
            v-bind:class="{ error: newSession.errors.teamMissing }">
          <label for="create-session-team">Team name:</label>
          <input type="text" v-model="newSession.team" placeholder="team name" maxlength="100">
        </div>
        ...
        <div id="create-session-participants" class="input-wrapper" 
            v-bind:class="{ error: newSession.errors.participantsMissing }">
          <label for="create-session-participants">Number of participants:</label>
          <input type="number" v-model="newSession.participants" placeholder="number of participants">
        </div>
        <div class="buttons">
          <button class="button" type="submit" id="create-session-btn" @click="createSession">
            Create
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
```
```javascript
<script>
import ...

export default {
  name: 'NewDiagnosticSession',
  data: function () {
    return {
      newSession: new NewSession(),
      helper: new Helper(),
      facilitator: this.facilitatorModule,
    }
  },
  props: {
    facilitatorModule: {
      type: Object,
      required: true
    },
    ...
  },
  ...
  methods: {
    createSession () {
      this.facilitator.createDiagnosticSession(this.newSession)
    }
  },
  components: { HelpBox, HelpBoxToggle }
}
</script>
```

It delegates input validation to the NewSession domain object (see below). The Help Box toggling is delegated to another, small, single purpose domain object Helper.

It gets a facilitatorModule object as a property. This is our 'state object'. We have decided to inject this dependency through props, because we don't like singletons or globals for managing our dependencies, nor do we like dependency injection magic. We want to be in control of our dependencies.
To activate Vue change detection on the state contained by this object, we need to include it in the data part - hence the `facilitator: this.facilitatorModule`.

So we regard this UI component as a primary adapter. Our rules of thumb:
- the component code (JS + HTML) **talks UI**, forms, Vue.js integration
- the component **visualizes state** (either from a 'module' object or its local data), i.e. show data, show/hide elements based on data
- it **delegates any actions or events to domain code**; in this case the button triggers the `createSession` event, which delegates to the `createDiagnosticSession` function, and passes the new `Session` along.
- we move any logic or conditionals to domain objects, like NewSession

As a result, the automated tests for this component are focused. Their focus is the component showing the correct data and elements, and delegating to appropriate domain functions. Some of its tests:

```javascript
describe('New Diagnostic Session.vue', () => {
  describe('creating a new session', () => {
    let wrapper, facilitatorModule
    beforeEach(async () => {
      facilitatorModule = new class extends FacilitatorModule {
        createDiagnosticSession = jest.fn()
      }()
      wrapper = aVueWrapperFor(NewDiagnosticSession)
        .withProps({ facilitatorModule })
        .withRealIcons()
        .mount()
    })
    it('delegates to the repository when all fields are filled in properly', () => {
      wrapper.find('#create-session-team input').setValue('Team A')
      wrapper.find('#create-session-date input').setValue('2020-11-12')
      wrapper.find('#create-session-language select').setValue('de')
      wrapper.find('#create-session-participants input').setValue('5')
      wrapper.find('#create-session-btn').trigger('click')
      expect(facilitatorModule.createDiagnosticSession).toHaveBeenCalledWith(aValidNewSession({ 
        team: 'Team A', 
        date: '2020-11-12', 
        participants: '5', 
        language: 'de', 
        isTest: false 
      }))
    })
    it('shows an error on missing values', async () => {
      wrapper.vm('newSession').validate()
      await wrapper.find('#create-session-btn').trigger('click')
      expect(wrapper.find('#create-session-team').classes()).toContain('error')
      expect(wrapper.find('#create-session-date').classes()).toContain('error')
      expect(wrapper.find('#create-session-participants').classes()).toContain('error')
    })
  })
  ...
})
```

We have started a small DSL around the Vue test utils (`aVueWrapperFor`), to reduce testing boilerplate.

## Domain - view logic & state

Let's have a look at the domain code. First, the FacilitatorModule. The suffix 'Module' is chosen to fit in the Vue ecosystem. This module manages state relevant for UI components. It acts like a [Facade](https://en.wikipedia.org/wiki/Facade_pattern) and exposes only relevant state and actions from the domain to a UI component. If we were to use TypeScript, we would have made this explicit with an interface.

```javascript
export class FacilitatorModule extends BaseModule {
  constructor (sessionRepository) {
    super()
    this.sessionRepository = sessionRepository
    this._currentSession = undefined
    ...
  }

  get currentSession () {
    return this._currentSession
  }

  retrieveDiagnosticSession (sessionId) {
    return this.handleAllErrorsFor(
      this.sessionRepository.byId(sessionId).then(
        diagnosticSession => { this._currentSession = 
	                       diagnosticSession })
    )
  }

  createDiagnosticSession (newSession) {
    return newSession.whenValid(() => {
      const result = this._createDiagnosticSession(newSession)
      newSession.reset()
      return result
    })
  }

  _createDiagnosticSession (newSession) {
    return this.sessionRepository.create(newSession)
      .then(() => this.retrieveDiagnosticSessions())
      .catch(error => this._failed(error.message))
  }
  ...
}
```

The `FacilitatorModule` manages the `currentSession` state on behalf of another component.

The session repository is injected via the constructor. The dependencies are wired up in `main.js`.

_We started out with [Vuex](https://vuex.vuejs.org/) for state management. Vuex is highly opinionated on structuring state management. To some extent, this is helpful, as it guides developers in structuring code in state, code that mutates state, and asynchronous actions. We found the use of Vuex modules in UI components cumbersome and verbose._

So we decided to roll our own, inspired by Vuex and our own experience with structuring domain code. We follow these guidelines:

- a module object is plain Javascript / TypeScript
- it keeps state and exposes it to UI components
- it defines actions for UI components; the function names reflect domain language
- the module knows repositories, handles async behaviour and errors
- a module object delegates as much as possible to other domain objects
- module dependencies are injected via its constructor; we have separate wiring code (`main.js`)

We are still unconvinced about the name 'module', which we borrowed from Vuex. Your suggestions for a better name are welcome.

## More domain: NewSession

A UI component with a form often maintains state. In `NewSession`, we saw that we had a clump of data and some validation logic related to it. Later on, we found some more logic: when someone marks a session as _test_, the number of participants gets set to a fixed amount of three, because [three is the magic number ;-)](https://www.youtube.com/watch?v=YZoYEr6NdmE). Data and corresponding logic wants to be together, so we extracted it into its own class, `NewSession`.

```javascript
export class NewSession {
  constructor () {
    this.reset()
  }

  reset () {
    this.errors = {}
    this.team = ''
    this.date = ''
    this.participants = ''
    ...
  }
  ...
  validate () {
    const errors = {}
    if (this.team === '') {
      errors.teamMissing = true
    }
    if (this.date === '') {
      errors.dateMissing = true
    }
    if (this.participants === '') {
      errors.participantsMissing = true
    }
    const numberOfParticipants = parseInt(this.participants, 10)
    if (isNaN(this.participants) || numberOfParticipants < 1 || numberOfParticipants > 30) {
      errors.participantsMissing = true
    }
    this.errors = errors
  }

  whenValid (onSuccess) {
    this.validate()
    if (this.isValid()) { onSuccess() }
  }

  isValid () {
    return !(this.errors.teamMissing || this.errors.dateMissing || this.errors.participantsMissing)
  }
}
```

`NewSession` is a stateful object: it holds a new session; when you `validate` it, it will also contain information about its validity (`errors`).

The tests reflect the focus of `NewSession`. A selection of its tests:

```javascript
import { NewSession, aValidNewSession } from '@/domain/new-session'

describe('A new session', () => {
  it('is valid when all fields are filled in properly', () => {
    const validSession = aValidNewSession()
    validSession.validate()
    expect(validSession.isValid()).toBe(true)
    expect(validSession.errors).toEqual({})
  })
  it('is not valid if there are more than 30 participants', () => {
    const newSession = aValidNewSession({ participants: '31' })
    newSession.validate()
    expect(newSession.isValid()).toBe(false)
    expect(newSession.errors).toEqual({
      participantsMissing: true
    })
  })
  it('calls the onSuccess callback when valid', () => {
    let called = false
    aValidNewSession().whenValid(() => { called = true })
    expect(called).toBe(true)
  })
  it('does not call the onSuccess callback when not valid', () => {
    let called = false
    new NewSession().whenValid(() => { called = true })
    expect(called).toBe(false)
  })
  ...
})
```

The `aValidNewSession` function is an instance of the[Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern). A _Builder_ separates the construction of a complex object from its representation. The `aValidNewSession` Builder provides an example `NewSession` with valid data. It lets us describe variations succinctly, for instance: `aValidNewSession({ participants: '31' })`.

By moving this view logic to a compact, dedicated, plain Javascript object, we can isolate part of the UI related behaviour and write faster, more focused tests for these. Testing validation and feedback rules through the UI would be cumbersome.

## The API Adapter

Let's have a look at the API adapter: the `ApiBasedSessionRepository`.

API adapters are secondary adapters that:
- **perform API calls**, in this case using the _axios_ library
- **map data** to and from domain objects
- **handle errors**

```javascript
export class ApiBasedSessionRepository extends SessionRepository {
  constructor (axios) {
    super()
    this.axios = axios
  }

  _toDiagnosticSessionSummary (data) {
    return new DiagnosticSessionSummary({
      id: data.id,
      team: data.team,
      date: data.date,
      isOpen: data.is_open,
      isTest: data.is_test
    })
  }
  ...

  all () {
    return this.axios.doGet({
      url: '/diagnostic-sessions',
      failureReason: 'The sessions could not be retrieved'
    }).then(response => response.data.diagnostic_sessions.map(this._toDiagnosticSessionSummary))
  }

  create (newSession) {
    return this.axios.doPost({
      url: '/diagnostic-sessions',
      data: {
        team: newSession.team,
        date: newSession.date,
        participant_count: newSession.participants,
        language: newSession.language,
        is_test: newSession.isTest
      },
      failureReason: 'The session could not be created'
    }).then(response => response.data.id)
  }
  ...
}
```

This session repository offers the `create` and the `all` functions to the domain.

- `create` receives a `NewSession` object, transforms this to the API data format, and POSTs this to a backend URL. We use our own wrapper around the [axios](https://github.com/axios/axios) library for this, so that we can encapsulate repeated boilerplate.
- `all` performs a GET on a backend API; it receives JSON containing an array of diagnostic session data, which is mapped to DiagnosticSessionSummary objects with the `_toDiagnosticSessionSummary` function

Here is an excerpt of its' adapter integration test:

```javascript
describe('The API based session repository', () => {
  let mock, repo, session

  beforeEach(() => {
    const axios = Axios.create({ baseURL: 'http://baseurl' })
    mock = new AxiosMockAdapter(axios)
    repo = new ApiBasedSessionRepository(new AxiosWrapper(axios))
  })
  describe('getting all sessions', () => {
    it('should return a list of sessions', done => {
      mock.onGet('http://baseurl/diagnostic-sessions').reply(200, {
        diagnostic_sessions: [{ id: '100', team: 'Pretty Programmers', date: '2002-11-22', is_open: true, is_test: true }]
      })
      repo.all().then(sessions => {
        expect(sessions).toEqual([new DiagnosticSessionSummary({
          id: '100',
          team: 'Pretty Programmers',
          date: '2002-11-22',
          isOpen: true,
          isTest: true
        })])
        done()
      })
    })
    ...
  })
  describe('creating a session', () => {
    it('should return new session id', (done) => {
      mock.onPost('http://baseurl/diagnostic-sessions', {
        team: 'Team A', 
        date: '2020-08-25', 
        participant_count: '3', 
        language: 'en', 
        is_test: true 
      }).reply(201, { id: '100' })
      repo.create(aValidNewSession({ 
        team: 'Team A', 
        date: '2020-08-25', 
        participants: '3', 
        language: 'en', 
        isTest: true 
      })).then(sessionId => {
        expect(sessionId).toEqual('100')
        done()
      })
    })
    it('should fail with a reason when the call fails', done => {
      mock.onPost('http://baseurl/diagnostic-sessions').reply(500, { message: 'failed' })
      repo.create(aValidNewSession()).catch(error => {
        expect(error.message).toMatch('The session could not be created')
        done()
      })
    })
  })
  ...
})
```

Adapter tests are valuable, because they force us to understand the service we are adapting, and help us pinpoint problems if there ever are any.

We hope we have illustrated that API adapters are secondary adapters that:
- **perform API calls**, in this case using the [axios](https://github.com/axios/axios) library
- **map data** to and from domain objects, preferably in separate functions to make code more glanceable
- **handle errors**, converting these to a relevant thing or an error

## Summary

We have walked you through an example of how we have applied the Hexagonal Architecture pattern to a Vue.js based front end application. We have shown example code of primary adapters (the UI components), domain code (state & view logic using plain old Javascript objects), and secondary adapters (API calling/mapping code).

In a next post, we will elaborate how we structure the domain code. This is especially relevant when your front end component grows and you are looking for ways to reduce complexity.

<aside>
  <h3>Seeing your systems through a Hexagonal lens</h3>
  <p>Making informed architecture decisions across your application landscape is a tough skill. We can support you with for instance architecture reviews, carrying out experiments and facilitating collaborative architecture sessions.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
