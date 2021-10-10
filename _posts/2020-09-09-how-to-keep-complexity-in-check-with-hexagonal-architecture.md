---
layout: post
title: How to keep Front End complexity in check with Hexagonal Architecture
tags:
  - architecture
  - ports and adapters
  - web development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/PortsAndAdapters-8.png
---

Front ends tend to start out simple, often as 'just' a form or a grid showing data that comes from a backend. It looks like 'just' a visual layer on top of backend APIs. When a front end evolves and grows, it inevitably becomes more complex. We then need to take a good hard look at the UX/UI and overall architecture.

To mention a few:

- _guide users through specific flows_, e.g. anonymous users vs admins, variations in data that trigger different scenarios, while the backend APIs are flow agnostic
- _provide timely feedback_ on input, to prevent mistakes
- _manage expectations with feedback_ so that our users continuously know what is happening and what is expected of them, e.g. spinners when waiting, check marks for correct input, specific validation feedback
- _don't distract or confuse_, e.g. hide buttons for actions that are not possible yet, hide functionalities not available to the current user role
- _combine data_ from multiple APIs and present it in a coherent way
- _present data understandably_, as some APIs might not match the user's view of the world 100%
- _move a concern over to the front end_, for instance implement a shopping basket in the front end, to prevent extra complexity in the backend for managing shopping basket state

## Hexagonal Architecture to manage complexity

Having applied [Hexagonal Architecture](/2020/08/20/hexagonal-architecture) to back end components, well-structured monoliths and desktop client applications, we have found that thinking hexagonally helps to keep complexity manageable.

![ports and adapters](/attachments/blogposts/2020/ports-and-adapters.jpg)
{: class="post-image post-image-50" }

It allows us to focus on domain logic and business rules and it facilitates independent evolution of different services/components. It also allows for better automated testing of all these concerns. Hexagonal Architecture distinguishes:

| Port | set of interactions with outside world |
| Adapter | translates from and to outside world |
| Domain | model of the domain, independent of frameworks; in the language of our stakeholders |

For our current project, the online [Agile Fluency](https://www.agilefluency.org/)® Diagnostic, we are developing a [Vue.js](https://vuejs.org/) based frontend, a Python/Flask based backend and a relational database. To manage complexity and facilitate evolution, we decided to apply hexagonal architecture to both frontend and backend. We will focus specifically on how this worked out for the Vue.js frontend and what decisions we took, and why.

Let's zoom out and see our application as a network of connected hexagons:

![application as a network of hexagons](/attachments/blogposts/2020/hextesting-01.jpg)
{: class="post-image post-image-50" }

## Hexagons applied to front end

So in front end code, a number of concerns come together: user interface code, integration with the UI library , validation & feedback logic, state management, user flow logic, backend API integration.

What if we looking at a front end component through a hexagonal lens? What is the domain, what are the ports, what are the adapters?

Let's look at a sample [Vue.js](https://vuejs.org/) and [Vuex](https://vuex.vuejs.org/) based front end application, a web shop we developed as an exercises in our courses. We have a few UI components, like a ProductList. We have a store that can retrieve the available from some backend API and which holds the current list of products.

![vue.js application main concepts: UI components, store, API access](/attachments/blogposts/2020/PortsAndAdapters-3.png)
{: class="post-image" }

### Ports

- the UI is our the primary port through which users drive the front end application
- interactions with other services like backend components are our secondary ports
- any intents for which we need browser functionality are also ports, like local storage or alerts

### Primary adapters

We see the Vue.js based UI components as primary adapters. This includes the component code, its HTML and its CSS. These UI components are heavily dependent on Vue.js and related libraries.

This adapter code will have its own automated tests, which is greatly facilitated by the Vue.js test library. It allows us to run all UI component tests in seconds.
Our front end is about domain concepts (facilitators, diagnosticSessions), we get these from backend APIs but we still translate these to our own classes in the front end code to decouple the front end from back end API evolution (we want to facilitate independent evolution of our different components and their APIs) but also to safeguard from interesting vulnerabilities that could occur when we just base our code on the objects coming in from the backend; backend API classes/functions are our secondary ports

### Domain

So what is 'domain logic' in this case? Front end components run in the user's browser - an untrusted environment, so backend components are responsible for business rules, with the intent of ensuring correctness and consistency. In a front end, we do have domain related logic related, but its intent is to facilitate, guide, enable the user: **view logic** or **view models**.

The state and store objects are part of our domain; they sit on the edge of the domain and provide an interface to the UI components. In this way, they act as a [Facade](https://en.wikipedia.org/wiki/Facade_pattern) towards the domain code.

Our Agile Fluency Diagnostic front end knows about domain concepts like _facilitators_ and _diagnosticSessions_. We get these as data from backend APIs, but we still translate these to our own classes in the front end code to decouple from APIs and facilitate independent evolution of components and their APIs.

### Secondary adapters

Secondary adapters contain the code that encapsulates API calls and translates the data to our domain.

We created adapters for the interaction with backend APIs. They act as [Repositories](https://www.martinfowler.com/eaaCatalog/repository.html) in our domain, like a `ProductRepository` that offers an `allAvailable()` function to get all available products. We create these adapters independently using test driven development.

In our online Agile Fluency Diagnostic application for instance, we have an ApiBasedSessionRepository that offers `all` and `byId` to the domain, to get all sessions or a specific one.

```javascript
class ApiBasedSessionRepository {
  ...
  _toDiagnosticSessionSummary (data) {
    return new DiagnosticSessionSummary({
      id: data.id, team: data.team,
      date: data.date, isOpen: data.is_open, isTest: data.is_test })
  }

  all () {
    return this.axios.get('/diagnostic-sessions')
      .then(response => response.data.diagnostic_sessions.map(
        this._toDiagnosticSessionSummary))
  }

  byId (sessionId) {
    ...
  }
}
```

The backend API adapters also take care of mapping from/to our domain objects, like the `_toDiagnosticSessionSummary` function in the example. We make this mapping explicit, to:
- allow independent evolution of different components
- represent the domain objects (resources) explicitly in our front end code, to make it easier for ourselves as developers
- shield against malicious JS stuff coming in
- allow contract based testing

### The application through a Hexagonal lens

If we look at our application through a Hexagonal lens, we see domain objects (plain Javascript) in the center, state objects at the boundary, Vue.js based UI components as primary adapters and repositories as secondary adapters encapsulating interaction with backend APIs.

![UI components, store, API adapter put in a hexagon](/attachments/blogposts/2020/PortsAndAdapters-8.png)
{: class="post-image" }

So we have quite some adapter code (all the UI components) in our front end. Some numbers for the online Agile Fluency Diagnostic application:

| domain / view logic | 37% |
| UI component adapters | 53% |
| API adapters | 9% |
| main.js | 1% |

### Zooming in on the domain

How do we structure our view domain? Instead of putting all logic in the (Vuex) store objects, we introduce domain objects - plain Javascript/Typescript classes - to represent concepts and their responsibilities. Store objects delegate as much as possible to plain Javascript domain objects.

These domain objects don't tend to be very responsibility-heavy. They start out as data classes and gain some logic along they way. We end up with simple objects that are very easy to understand and well testable.

We also tend to move logic, e.g. validation, from the UI components to domain objects, which makes our UI components simpler and our logic easier to test. We will elaborate this in a future post.

## Consequences

Like we said before, Hexagonal Architecture is an architectural pattern, not a best practice. It comes with trade-offs and consequences:

Separating these concerns allows us to decouple the view logic from the UI structure, styling, and details. It allows the front end to evolve independently from the backend.

Using the Hexagonal lens helps us with [WTPW - What To Put Where]((/2020/12/23/what-to-put-where.html)): a new validation rule for adding a facilitator? _put it in the NewFacilitator domain object_; better visualization of password strength? _in the UI component_; do we need to map a backend API peculiarity? _in the API adapter_.

Mapping data in the API adapters comes with a bit of extra effort of writing the mapping code. This is a trade-off and is usually worth it in our experience.

Adding a new feature, like adding a new property to Facilitator, can result in the [code smell](/shop) called [Shotgun Surgery](https://blog.ndepend.com/shotgun-surgery/): we need to make changes in several places, in the UI component (add a new text field), in the domain (extend the domain object, add a validation rule), in the adapter (map the new property to/from the backend API). Again a trade-off, the changes themselves tend to be small, so we think the price is worth paying here.

Applying the Hexagonal lens also triggers some follow up questions:
- what to do with the logic in our UI components, like disabling a button when the input is not valid?
- how to structure the view domain in detail?
- structuring the core of the hexagon: how can we make the domain part more modular?

Keep an eye on our blog, we will dive deeper into these questions and our experiences.

## References

- [Growing Object Oriented Software guided by Tests](http://www.growing-object-oriented-software.com/) book by Steve Freeman & Nat Pryce.
- The [original article on Hexagonal Architecture](https://alistair.cockburn.us/hexagonal-architecture/) by Alistair Cockburn
- Instead of UI Library, feel free to read browser APIs, [Frameworkless Front-End Development](https://github.com/Apress/frameworkless-front-end-development)) is a solid introduction to using Vanilla JS.
- [The first post in this series](/2020/08/26/hexagonal-vue.journey.html)
- [Interview with Alistair Cockburn part 1](https://jmgarridopaz.github.io/content/interviewalistair.html) and [part 2](https://jmgarridopaz.github.io/content/interviewalistair2.html), which includes the history of Hexagonal Architecture (question #2 of part 1)

Editing - Willem van den Ende

_Updated on 10-10-2021: replaced dead history link_

<aside>
  <h3>Want to learn more?</h3>
  <p>We offer courses and workshops on Agile Engineering, Domain Driven Design and Hexagonal Architecture. </p>
  <p><div>
    <a href="/training">Learn more about our courses</a>
  </div></p>
</aside>
