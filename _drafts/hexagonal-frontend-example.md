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

In a [previous post](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html), we elaborated on why and how we apply [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html) in front end applications. 

We have also written about how hexagonal architecture informs test architecture. We also apply this thinking for a front end component: as we distinguish ports, adapters and domain logic, we will have unit tests, adapter integration tests, and possibly some component end-to-end tests.

In this post we will dive a bit deeper in the how and why using an example taken from the Agile Fluency Diagnostic application we are developing. The [Agile Fluency Model](https://www.agilefluency.org/) describes an agile team's pathway in a positive, inclusive way, promoting improvement. If you haven't already, checking out the [Agile Fluency Model](https://www.agilefluency.org/) may well be worth your while. Using the model includes devising diagnostics, and  investment plans for teams growth. Being licensed facilitators, we facilitate such diagnostics and guide teams in their Agile journey. Being forced to facilitate the diagnostics online, we decided to build and application for that purpose. In the diagnostic application licensed facilitators can manage their diagnostic sessions, invite teams to the sessions, and facilitate the sessions online.

We will use a specific activity as an example: creating a new diagnostic session. We will show the primary and secondary adapters, and our domain code. Here is a quick architecture sketch, to show the different objects involved and how they relate to the hexagon:

![architecture/hexagon drawing, parts explained below](/attachments/blogposts/2020/front-end-hexagon-sketch.jpg)
{: class="post-image" }

The UI components are the primary adapters, drawn in red; domain objects with view logic are in blue; the API adapters are the secondary adapters, in green.


## Primary adapters: UI Components

The front end should help the facilitator to create valid Diagnostic Sessions (sessions in short). A valid session is one that contains a valid team name, a date and a number of participants between 1 and 30. A session can be marked as 'test' session, making the number of participants fixed to 3. 

On quite a few projects we have seen developers putting such validation logic in the front-end components (in our case, that'd be Vue components). Although Vue components are a bit friendlier to testing code than, say, Anguar components, testing such front-end components can be a pain especially when their logic becomes more complicated. The clutter in the tests having to do with setting up the front end wrappers, the potential necessety to spy on the services, often obfuscate what the tests are really about: validation, or other logic. The possibility to add logic to strings withing the html like code, often makes things worse. 

We therefore, tend to try and separate the logic from the ui components and much as possible. A rule of thumb for us is: any 'if' in a UI component is an opportunity to move to the domain. Doing so, we try to keep the UI components as thin as they can possibly be, focused on displaying state and passing commands to the domain. 

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/front-end-hexagon-sketch-1.jpg" alt="architecture/hexagon drawing, focused on the domain">
  </div>
  <div>
    <p>UI component as a primary adapter:</p>
    <ul>
      <li><strong>Talks UI elements & UI integration</strong></li>
      <li><strong>Visualizes state</strong> - display data, show/hide elements</li>
      <li><strong>Does not contain logic or conditionals</strong></li>
      <li><strong>Delegates actions and decisions to the domain</strong></li> 
    </ul>
  </div>
</div>

This is what the NewDiagnosticSession Vue component looks like:

![Screenshot: 'Create a new diagnostic session' heading, fields for team name, date, session type (regular or test) and a dropdown for the number of participants. The call to action button is 'Create'](/attachments/blogposts/2020/new-diagnostic-session.png)
{: class="post-image" }

The form has inputs and a button, and opens a help box when you click on the 'i'. The code looks roughly like the code block below, leaving out some details for clarity. Take a look and pay attention not only to, how we implement submitting the form, but also how inputs are validated.

```html
<div>
  <header><h1>Create a new diagnostic session</h1></header>
  <div>
    <form class="create-session" @submit.prevent>
      <div id="create-session-team" class="input-wrapper" 
        v-bind:class="{ error: newSession.errors.teamMissing }">
        <label for="create-session-team-input">Team name:</label>
        <input id="create-session-team-input" type="text" v-model="newSession.team" 
          placeholder="team name" maxlength="100">
      </div>
      ...
      <div id="create-session-participants" class="input-wrapper" 
        v-bind:class="{ error: newSession.errors.participantsMissing }">
        <label for="create-session-participants-input">Number of participants:</label>
        <input id="create-session-participants-input" type="number" v-model="newSession.participants"   
          placeholder="number of participants">
      </div>
      <div class="buttons">
        <button class="button" type="submit" id="create-session-btn" @click="createSession">
          Create
        </button>
      </div>
    </form>
  </div>
</div>
```
```javascript
export default {
  name: 'NewDiagnosticSession',
  data: function () {
    return {
      newSession: new NewSession(),
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
  components: ...
}
```

It delegates input validation to the `NewSession` domain object, and the validation state is maintained in the `NewSession` object as well. At the moment, validation takes place on clicking `create`. Create session delegates to `facilitator.createDiagnosticSession`, which in turn delegates the validation to `NewSession`. Since new session is being observed by the component, missing fields and the like become visible in the ui.

### Injecting modules
The component receives a `facilitatorModule` object as a property. This is our 'state object'. We have decided to inject this dependency through props, because we don't like singletons or globals for managing our dependencies, nor do we like dependency injection magic. We want to be in control of our dependencies.
To activate Vue change detection on the state contained by this object, we need to include it in the data part - hence the `facilitator: this.facilitatorModule`.


This UI component is a primary adapter. Our rules of thumb:
- the component code (JS + HTML) **talks UI**, forms, Vue.js integration
- the component **visualizes state**, either from a 'module' object or local data; it shows data and shows/hides elements based on data
- it **delegates any actions or events to domain code**; in this case the button triggers the `createSession` event, which delegates to the `createDiagnosticSession` function, and passes the `NewSession` object along.
- we move any logic or conditionals to domain objects, like NewSession

These rules of thumb help us to keep our components clean and focused. As a result, the automated tests for this component are equally clean and focused. Their focus is the component showing the correct data and elements, and delegating to appropriate domain functions. Some of its tests:

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

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/front-end-hexagon-sketch-2.jpg" alt="architecture/hexagon drawing, focused on the domain">
  </div>
  <div>
    <p>Domain:</p>
    <ul>
      <li>Encapsulates <strong>view logic & behaviour</strong></li>
      <li>Consists of <strong>small, focused, plain JS/TS objects</strong></li>
      <li><strong>Translates errors</strong> to something meaningful for users</li> 
    </ul>
  </div>
</div>

Let's have a look at the domain code. First, the `FacilitatorModule`. The suffix 'Module' is chosen to fit in the Vue ecosystem. This module manages state relevant for UI components. It acts like a [Facade](https://en.wikipedia.org/wiki/Facade_pattern) and exposes only relevant state and actions from the domain to a UI component. If we were to use TypeScript, we would have made this explicit with an interface.

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

The `FacilitatorModule` manages the `currentSession` state on behalf of another component. Why did we put this in this module instead of a separate module? We will dive into this in a future blog post.

The session repository is injected via the constructor. The dependencies are wired up in `main.js`.

_We started out with [Vuex](https://vuex.vuejs.org/) for state management. Vuex is highly opinionated on structuring state management. To some extent, this is helpful, as it guides developers in structuring code in state, code that mutates state, and asynchronous actions. We found the use of Vuex modules in UI components cumbersome and verbose._

So we decided to roll our own, inspired by Vuex and our own experience with structuring domain code. We are following these guidelines:

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

The `aValidNewSession` function is an instance of the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern). A _Builder_ separates the construction of a complex object from its representation. The `aValidNewSession` Builder provides an example `NewSession` with valid data. It lets us describe variations succinctly, for instance: `aValidNewSession({ participants: '31' })`.

By moving this view logic to a compact, dedicated, plain Javascript object, we can isolate parts of the UI related behaviour and write fast, focused tests for these. Testing validation and feedback rules through the UI would be cumbersome.

## The API Adapter

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/front-end-hexagon-sketch-3.jpg" alt="architecture/hexagon drawing, focused on the API/secondary adapters">
  </div>
  <div>
    <p>Secondary adapters:</p>
    <ul>
      <li><strong>perform API calls</strong></li>
      <li><strong>map data</strong> to and from domain objects</li>
      <li><strong>handle errors</strong></li> 
    </ul>
  </div>
</div>

Let's have a look at the API adapter: the `ApiBasedSessionRepository`. We follow the [Repository Pattern](https://www.martinfowler.com/eaaCatalog/repository.html): the adapter exposes a domain oriented interface, in this case consisting of the `all` and `create` functions. We use the _axios_ library for performing API calls.

```javascript
export class ApiBasedSessionRepository {
  constructor (axiosWrapper) {
    this.axiosWrapper = axiosWrapper
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
    return this.axiosWrapper.doGet({
      url: '/diagnostic-sessions',
      failureReason: 'The sessions could not be retrieved'
    }).then(response => response.data.diagnostic_sessions.map(this._toDiagnosticSessionSummary))
  }

  create (newSession) {
    return this.axiosWrapper.doPost({
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

- `create` receives a `NewSession` object, transforms this to the API data format, and POSTs this to a backend URL. We created a wrapper around the [axios](https://github.com/axios/axios) library to encapsulate repeated boilerplate. The `doPost` function also provides error handling.
- `all` performs a GET on a backend API; it receives JSON containing an array of diagnostic session data, which is mapped to DiagnosticSessionSummary objects with the `_toDiagnosticSessionSummary` function

Here is an excerpt of its adapter integration test:

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
        diagnostic_sessions: [{
          id: '100', team: 'Pretty Programmers', 
          date: '2002-11-22', is_open: true, is_test: true 
        }]
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
        team: 'Team A', date: '2020-08-25', 
        participant_count: '3', language: 'en', is_test: true 
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

We have illustrated that API adapters are secondary adapters that:
- **perform API calls**, in this case using the [axios](https://github.com/axios/axios) library
- **map data** to and from domain objects, preferably in separate functions to make code more glanceable
- **handle errors**, convert these to a relevant error or sometimes a [Null object](http://wiki.c2.com/?NullObject)

## Summary

We have walked you through an example of how we have applied the Hexagonal Architecture pattern to a Vue.js based front end application. We have shown example code of primary adapters (the UI components), domain code (state & view logic using plain old Javascript objects), and secondary adapters (API calling/mapping code).

In a next post, we will elaborate how we structure the domain code. This is especially relevant when your front end component grows and you are looking for ways to reduce complexity.

_Credits: Thanks to Willem for editing and helping improve this post._

<aside>
  <h3>Seeing your systems through a Hexagonal lens</h3>
  <p>Making informed architecture decisions across your application landscape is a tough skill. We can support you with for instance architecture reviews, carrying out experiments and facilitating collaborative architecture sessions.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
