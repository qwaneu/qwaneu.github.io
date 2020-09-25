---
layout: post
title: A Hexagonal Vue.js front-end, by example 
tags:
  - architecture
  - ports and adapters
  - web development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/PortsAndAdapters-8.png
---

In a [previous post](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html), we elaborated on why and how we apply [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html) in front end applications. 

We have also written about [how hexagonal architecture informs test architecture](/2020/09/17/test-architecture.html). We also apply this thinking for a front end component: as we distinguish ports, adapters and domain logic, we will have unit tests, adapter integration tests, and possibly some component end-to-end tests.

In this post we will dive a bit deeper in the how and why using an example taken from the Agile Fluency Diagnostic application we are developing. 

> The [Agile Fluency Model](https://www.agilefluency.org/) describes an agile team's pathway in a positive, inclusive way, promoting improvement. If you haven't already, checking out the [Agile Fluency Model](https://www.agilefluency.org/) may well be worth your while. Or [drop us a line](/contact) if you'd like to learn more.

Using the model includes devising diagnostic sessions and investment plans for teams to grow. As licensed facilitators, we facilitate such diagnostic sessions and guide teams in agility. When we were forced by COVID-19 to facilitate the diagnostics remotely, we decided to build an application for that purpose. In the diagnostic application facilitators can manage their diagnostic sessions, invite teams to sessions, and facilitate the sessions online.

We will use a specific activity as an example: _creating a new diagnostic session_. We will explain what decisions we made for primary and secondary ports and adapters, and for the domain code. Here is a quick architecture sketch, to show the different objects involved and how they relate to the hexagon:

![architecture/hexagon drawing, parts explained below](/attachments/blogposts/2020/front-end-hexagon-sketch.jpg)
{: class="post-image" }

The UI components are the primary adapters, drawn in red; domain objects with view logic are in blue; the API adapters are the secondary adapters, in green.

Originally, the Hexagonal Architecture pattern distinguishes primary ports - ports that _drive the system_ - and secondary ports - ports that _are driven by the system_. In this post, we use the primary/secondary terms also for the adapters that realize the primary and secondary ports.


## Primary adapters: UI Components

The front end should help the facilitator to create valid Diagnostic Sessions, sessions in short. A valid session is one that has a valid team name, a date, and a number of participants between 1 and 30. A session can be marked as 'test' session, which fixes the number of participants to 3. 

On quite a few projects we have seen developers putting such validation logic in front-end components (Vue.js components in our case). Although Vue.js components lend themselves better for fast tests, than for example Angular components, testing front-end components can still be a pain, especially when their logic becomes more complicated. The clutter in the tests having to do with setting up front end wrappers and possibly spying on services, often obfuscates what the tests are really about: validation, or other logic. The option to add logic to strings within the html template often makes things worse. 

Therefore, we separate the logic from the UI components as much as possible. Our rule of thumb here is: any 'if' in a UI component is a candidate for moving to the domain. By doing so, we try to keep the UI components as thin as they can possibly be, focused on displaying state and passing commands to the domain. 

This is what the NewDiagnosticSession Vue component looks like:

![Screenshot: 'Create a new diagnostic session' heading, fields for team name, date, session type (regular or test) and a drop-down for the number of participants. The call to action button is 'Create'](/attachments/blogposts/2020/new-diagnostic-session.png)
{: class="post-image" }

The code looks roughly like the code block below, leaving out some details for clarity. Take a look and pay attention to not only how we implement form submission, but also how inputs are validated.

```html
<div>
  <header><h1>Create a new diagnostic session</h1></header>
  <div>
    <form class="create-session" @submit.prevent>
      <TextInput id="create-session-team" v-model="newSession.team" placeholder="team name" 
        maxlength="100" :class="{ error: newSession.errors.teamMissing }">
        Team name:
      </TextInput>
      ...
      <TextInput id="create-session-participants" type="number" v-model="newSession.participants" placeholder="number of participants" 
        :disabled="newSession.isTest" :class="{ error: newSession.errors.participantsMissing }">
        Number of participants:
      </TextInput>
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

The TextInput is a small component we created to wrap an input with a label in a div.

NewDiagnosticSession delegates input validation to the `NewSession` domain object. The validation state is maintained in the `NewSession` object as well. Validation takes place on clicking the Create button. The `createSession` function delegates to `facilitator.createDiagnosticSession`, which in turn delegates the validation to `NewSession`. 

Since the NewSession object is being observed by the component, missing fields and the like are highlighted in the UI. We use a conditional class on the TextInputs for this:
```
:class="{ error: newSession.errors.teamMissing }
```

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/front-end-hexagon-sketch-1.png" alt="architecture/hexagon drawing, focused on the domain">
  </div>
  <div>
    <p>UI component as a primary adapter:</p>
    <ul>
      <li><strong>Talks UI & UI integration</strong></li>
      <li><strong>Visualizes state</strong> - display data, show/hide elements</li>
      <li><strong>Does not contain logic or conditionals</strong></li>
      <li><strong>Delegates actions to the domain</strong></li> 
    </ul>
  </div>
</div>

### Injecting modules

The component receives a `facilitatorModule` object as a property. This is our 'state object'. We have decided to inject this dependency through props, because we don't like singletons or global variables for managing our dependencies, nor do we like dependency injection magic. _We want to be in control of our dependencies._
To activate Vue change detection on the state within this object, we need to include it in the data part - hence the `facilitator: this.facilitatorModule`.

### Some rules of thumb

Some of our rules of thumb for UI components as primary adapters are:
- the component code (JavaScript + HTML) **talks UI**: it is about layout, forms, Vue.js integration, etc.
- the component **visualizes state**, either from a 'module' object or from local data; it shows data and shows/hides elements based on data
- it **delegates any actions or events to domain code**; in this case the button triggers the `createSession` event, which delegates to the `createDiagnosticSession` function, and passes the `NewSession` object along.
- we move any logic or conditionals to domain objects, like NewSession

These rules of thumb help us to keep our components clean and focused. As a result, the automated tests for this component are equally clean and focused. Their focus is the component showing the correct data and elements, and delegating to appropriate domain functions. A selection of the NewDiagnosticSession tests are shown below.

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

We have started writing a small DSL (domain specific language) around the Vue test utils (`aVueWrapperFor`), to reduce testing boilerplate: `aVueWrapperFor(NewDiagnosticSession).withProps ...`

## Domain - view logic & state

Let's have a closer look at the domain code. First, the `FacilitatorModule`. The suffix 'module' is chosen to fit in the Vue ecosystem. This module manages state relevant for UI components. It acts like a [Facade](https://en.wikipedia.org/wiki/Facade_pattern) and exposes only relevant state and actions from the domain to a UI component. If we were to use TypeScript, we would have made this explicit with an interface.

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

The `FacilitatorModule` manages the `currentSession` state on behalf of another component. Why did we put it in this module instead of a separate module? We will dive into this in a future blog post.

The session repository is injected via the constructor. The dependencies are wired in `main.js`.

_We started out with [Vuex](https://vuex.vuejs.org/) for state management. Vuex is highly opinionated on structuring state management. This is helpful to some extent, as it guides developers in structuring code in state, state mutations, and asynchronous actions. The use of Vuex modules in UI components is however cumbersome and verbose. We also found the Vuex structure too restrictive for how we want to distribute responsibilities over separate domain objects._

Inspired by Vuex and our own experience with structuring domain code, we decided to roll our own. We follow these guidelines:

- a module object is a **plain JavaScript / TypeScript object**
- it **keeps state and exposes it to UI components**, with an explicit interface when using Typescript; we want to be explicit about **what the UI needs to know** so that we are in control of dependencies in our code
- it **defines actions for UI components**; the function names reflect the language of our domain, to make explicit **what the UI can do**
- a module **delegates to other domain objects** as much as possible; we want to prevent them becoming a responsibility magnet, ending up with lots of procedural code in our modules; this would reduce readability and maintainability
- a module **knows repositories** and **handles asynchronous behaviour**; having most async behaviour only in the modules makes other domain objects simpler and easier to test
- repositories and other **dependencies are injected via the module constructor**; this forces us to think about what dependencies are needed and why, and facilitates unit testing; wiring all objects together is a separate concern, implemented by `main.js`

We are still unconvinced about the name 'module', which we borrowed from Vuex. Your suggestions for a better name are welcome.

### More domain: NewSession

A UI component with a form usually maintains state. This starts straightforward, just one or two strings, but along the way more complexity creeps in. When we were building the NewDiagnosticSession component, we saw that we had a [clump of data](https://www.martinfowler.com/bliki/DataClump.html) and some validation logic related to it. Later on, we found more logic: when a session is marked  as _test_, the number of participants will be fixed to three, because [three is the magic number ;-)](https://www.youtube.com/watch?v=YZoYEr6NdmE)

Data and corresponding logic wants to be together, so we extracted it into its own class `NewSession`:

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

`NewSession` is a stateful object: it holds a new session. After you `validate` it, it will also contain information about its validity in the `errors` property.

Its unit tests reflect the focus of `NewSession`. A selection of its tests:

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

We often use the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern) for creating objects in test code. _Builder_ separates the construction of a complex object from its representation. These builders then have the form of 

```.java
  build(aValidNewSession().withParticipantCount(31));
```

Why did we introduce this instead of just calling the object's constructor? Often we just need an valid instance of something and we do not care about the specifics, sometimes we want to control only one specific field. Repeating constructor calls is tedious and creates unnecessary coupling in tests. 

In our JavaScript code the original Builder Pattern has less added value, because functions with default parameters can do the job just fine. The `aValidNewSession` function is an instance of such a function. It provides an example `NewSession` with valid data. It lets us describe variations succinctly like above, for instance: `aValidNewSession({ participants: '31' })`.

By moving view logic to a compact, dedicated, plain JavaScript object, we can isolate UI related behaviour and write fast, focused tests for it. Testing validation and feedback rules through the UI would be cumbersome.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/front-end-hexagon-sketch-2.png" alt="architecture/hexagon drawing, focused on the domain">
  </div>
  <div>
    <p>Domain:</p>
    <ul>
      <li>Encapsulates <strong>view logic & behaviour</strong></li>
      <li>Consists of <strong>small, focused, plain JavaScript objects</strong></li>
      <li><strong>Translates errors</strong> to something meaningful for users</li> 
    </ul>
  </div>
</div>

## The API Adapter

Let's have a look at the API adapter: the `ApiBasedSessionRepository`. We follow the [Repository Pattern](https://www.martinfowler.com/eaaCatalog/repository.html): the adapter exposes a domain oriented interface, in this case consisting of the `all` and `create` functions. In Typescript we would define a `SessionRepository` interface having these two functions, so that our domain code depends on this abstraction and not on API implementation details or http library peculiarities.

We use the _axios_ library for performing API calls.

```javascript
export class ApiBasedSessionRepository {
  constructor (axiosWrapper) {
    this.axiosWrapper = axiosWrapper
  }
  ...
  all () {
    return this.axiosWrapper.doGet({
      url: '/diagnostic-sessions',
      failureReason: 'The sessions could not be retrieved'
    }).then(response => response.data.diagnostic_sessions
      .map(toDiagnosticSessionSummary))
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

export function toDiagnosticSessionSummary (data) {
  return new DiagnosticSessionSummary({
    id: data.id,
    team: data.team,
    date: data.date,
    isOpen: data.is_open,
    isTest: data.is_test
  })
}
```

This session repository offers the `create` and the `all` functions to the domain.

- `create` receives a `NewSession` object, transforms this to the API data format, and POSTs this to a back end URL. We have created a small wrapper around the [axios](https://github.com/axios/axios) library. The functions doPost and doGet encapsulate repeated boilerplate, and do generic error handling.
- `all` performs a GET on a back end API; it receives JSON containing an array of diagnostic session data, which is mapped to DiagnosticSessionSummary objects by the `_toDiagnosticSessionSummary` function.

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
      const sessionData = { id: '100', team: 'Pretty Programmers', date: '2002-11-22', 
        is_open: true, is_test: true }
      mock.onGet('http://baseurl/diagnostic-sessions').reply(200, {
        diagnostic_sessions: [sessionData]
      })
      repo.all().then(sessions => {
        expect(sessions).toEqual([toDiagnosticSessionSummary(sessionData)])
        done()
      })
    })
    it('should map session data to DiagnosticSessionSummaries', () => {
      const data = { id: '100', team: 'Pretty Programmers', date: '2002-11-22', 
        is_open: true, is_test: true }
      expect(toDiagnosticSessionSummary(data)).toEqual(new DiagnosticSessionSummary({
        id: '100',
        team: 'Pretty Programmers',
        date: '2002-11-22',
        isOpen: true,
        isTest: true
      }))
    })
    ...
  })
  describe('creating a session', () => {
    it('should return new session id', done => {
      mock.onPost('http://baseurl/diagnostic-sessions', {
        team: 'Team A', date: '2020-08-25', participant_count: '3', language: 'en', is_test: true 
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

Adapter integration tests are valuable, because they force us to understand the service we are adapting, and help us pinpoint problems if there ever are any.

The first responsibility of an API adapter is to encapsulate communicating with (back end) APIs (line 35).

The API adapter also takes care of mapping data to/from domain objects. We do this mapping explicitly, to decouple our front end code from API details. This limits the impact of back end API changes and allows our UI component to have its own view on the domain - which might differ from the way back end data is structured. We prefer to put API-domain object mappings in separate functions in the adapter, to make the code easier to read and to be able to write focused tests for the mapping (line 21). 

A third responsibility of API adapters is handling errors. They convert API errors to something meaningful within the UI component (line 50). In our application, we map error on sensible messages. Sometimes we can convert an error into a [Null object](http://wiki.c2.com/?NullObject), for example by returning an empty list if data retrieval fails.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/front-end-hexagon-sketch-3.png" alt="architecture/hexagon drawing, focused on the API/secondary adapters">
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

## Summary

We have walked you through an example of how we have applied the Hexagonal Architecture pattern to a Vue.js based front end application. We focused on a particular user need, _create a diagnostic session_. We have shown example code of primary adapters (the UI components), domain code (state & view logic using plain old JavaScript objects), and secondary adapters (code that calls APIs and maps data).

We do not pose this as a best practice. Instead, we made a series of considerations, _trade-offs_ and _design decisions_ informed by our experience with front end code and hexagonal architecture, and guided by different concerns we ran into when developing our application. Our journey is probably more valuable to you than the specific code that came from it.

In a follow-up post, we will elaborate how we structure the domain code. This is especially relevant when your front end component grows and you are looking for ways to reduce complexity.

_Credits: many thanks to Willem for editing and helping improve this post._

<aside>
  <h3>Seeing your systems through a Hexagonal lens</h3>
  <p>Making informed architecture decisions across your application landscape is a tough skill. We can support you with for instance architecture reviews, carrying out experiments and facilitating collaborative architecture sessions.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
