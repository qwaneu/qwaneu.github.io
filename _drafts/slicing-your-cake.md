---
layout: post
title: Slicing your Cake - Structuring your Hexagons
tags:
  - architecture
  - ports and adapters
author: Marc Evers
image: 
---

You are happily applying the Hexagonal Architecture pattern. So you have the
unpredictable outside world hidden behind ports, and made adapters so you can
speak your domain language. Awesome. But now your domain model grows as well.
How do you keep that understandable? Imagine the inside of your hexagon was a
cake. How would you slice your domain?

In previous posts, we introduced [Hexagonal
Architecture](http://localhost:8082/2020/08/20/hexagonal-architecture.html). We
demonstrated how we apply it, both in front-end and back-end components. We
showed how it helps us trade off the many design decisions we make when
developing front-end code. In this post we describe our approach how we
structure the inside of a hexagon, the 'domain'. We present it as a proto
pattern "Slice the domain as cake". Slicing lets us evolve components without
losing our way.

## Context 

When a component grows, it gets more complex and unwieldy. Applying the
Hexagonal Architecture pattern helps to separate adapters and mapping from the
domain logic. The domain logic itself however will grow complex and unwieldy
sooner or later.

We could split up the component to tackle complexity, but it pays to focus on
good modularity first. Otherwise we'd end up with distributed complexity and
we're worse off.

How can we structure the domain code in a way that keeps it modular,
understandable and maintainable? How do we prevent ending up with my routing
code, UI components and other adapters knowing everything in the domain? When
everything is coupled to everything,it is hard to see the impact a change would
have.

## Forces

- Small components grow up. When they grow, they contain more concerns and
  become unwieldy. 
- This is not restricted to e.g. back-end components only. It could be a
  front-end, a back-end, a database, or sensors and actuators in an embedded
  system. Software is only limited by our imagination. 
- Dependencies between different objects, functions, systems become unclear.
- You know that not everything depends on everything, but this is hard to see
  from the code because everything is exposed to everything.
- Exposing primary adapters to all details from the domain code creates a strong
  dependency, making the adapters highly sensitive to change. It becomes unclear
  what the real dependencies are.

![@@plaatje van routes met allerlei al dan niet relevante dependencies]()

An example of ports would be (@@TODO write / draw this out ) would be http routes. (WE: routes are needed to serve content, render pages as well as link back to user tasks in the application from what is rendered. To complicate this, if you have a SPA +  REST then there is a partially parallel set of routes, to go with similar, but slightly different domain concerns.).

## Solution

A solution direction is to divide the core of the hexagon in slices that are
based on the domain model. Each slice presents a Facade to the primary ports
(e.g. the UI components or HTTP REST routes). Each slice can depend on one or
more secondary ports.

![@@plaatje met adapters]()

![@@plaatje met losse slices]()

The responsibilities of a slice object are:
- It is a Facade towards primary adapters; e.g. in a front-end component, it
  specifies/exposes what data a UI component can show and what actions it can
  trigger.
- It knows relevant repositories, so that it can handle side-effects -
  retrieving data, storing data, and handle asynchronous behaviour.
- It delegates behaviour and (view) domain logic as much as possible to
  behaviourally rich domain objects. 
- In a back-end component, a slice can be a Facade combining a set of related
  Command and Query objects.

![@@plaatje met slices in detail: adapter -> | -> cmd -> repo & domain object]()

You could say that we structure the (front end) component not as a single hexagon, but as multiple ‘sub-hexagons’

## Example 

In the Online Agile Fluency Diagnostic application, we have a Vue.js based
front-end component. It bundles different concerns: there is a part for
facilitators to create sessions, give participants access, and see aggregated
results; there is a survey for participants, and an administrator interface for
managing facilitators.

Inspired by how Vuex provides modularity through different 'modules', we have created a number of 'module' objects, an `admin-module`, a `diagnostic-module` and a `facilitator-module`.

![@@plaatje met wat afdop modules]()

The `diagnostic-module` provides data and actions regarding the survey. It
offers e.g. the participant's colour (we use colours to identify participants),
facilitator info, the survey questions. It offers actions like `join` (a
participant opening the survey), `retrieveQuestions` (triggered by the UI to
start retrieving survey questions asynchronously), and
`confirmAnswer`/`updateAnswer` for handling the participant filling in the
survey.

```javascript
export class DiagnosticModule extends BaseModule {
  constructor (questionRepository, sessionJoiner, ...) {
    super()
    this._questionRepository = questionRepository
    this._sessionJoiner = sessionJoiner
    ...
  }
  ...

  get color () { ... }
  get facilitator () { ... }
  get questions () { ... }

  join (sessionId, joiningId) { ... }
  retrieveQuestions (sessionId, participantId) { ... }
  confirmAnswer (question, value) { ... }
  updateAnswer (question, value) { ... }
}
```

It uses two ports, the `questionRepository` that contains questions and answers,
and the `sessionJoiner` which handles correct joining of a participant so that
he/she will see the correct survey.

## Considerations

We could have split the front-end into 3 separate front-ends: the administrator
part, the diagnostic session part (creating sessions, discussing results), and
the survey part. The trade-off here is managing 3 simpler deployables that do
have some overlapping code vs having a larger, more complicated code base. For
us the latter was preferable.

How do we determine how to split up? What design heuristics can we use for identifying slices?
- organize around the Aggregates you have found in event storming or some other
  domain modelling technique; splitting up according to domains or bounded
  contexts will probably be too course grained
- if you do user story mapping, you will have mapped out users' activities and
  tasks; user activities are candidate slices.
- group around things/functions working on the same data

What would we call these objects? We started out with 'module' borrowed from
Vuex. If we'd follow the principle of not naming objects after the pattern, we rather not postfix their names with 'Slice', 'Module', 'Service' or 'Facade'.
  
## Consequences

- package/folders reflect the slices; group the related objects
- what to do with shared / common domain objects?
- wiring: you need to instantiate 'slices' (i.e. the facades, or the sets of commands) and inject any secondary ports; usually the main function
- how to determine the size of you slice? too many: gets unwieldy; too big: we start grouping unrelated stuff
  - rules of thumb: lifecycle of data; same aggregate; same user role; what do your tests tell you

## Related (proto) patterns

- Hexagonal Architecture
- use commands / read models - queries / aggregates / policies as found in your domain analysis/event storming as the basis of your domain

## Related work

These ideas have been inspired by work of others, to mention a few:
- Jimmy Bogard's [Vertical Slice architecture](https://jimmybogard.com/vertical-slice-architecture/amp/)
- [A domain-driven Vue.js Architecture](https://medium.com/bauer-kirch/a-domain-driven-vue-js-architecture-77771c20f0da)
- Michel Weststrate, [UI as an afterthought](https://michel.codes/blogs/ui-as-an-afterthought)
- Alberto's Brandolini's Event Storming technique has also been influential in how we look at the domain

Another source of inspiration were the fruitful discussions I had with software
architects at RIGD-Loxia around 2013. We explored how to apply Hexagonal
Architecture to the (sometimes quite complex) Railway Safety Engineering
software they develop. I think the 'slices of cake' metaphor originates from
there.

A current related development is micro-frontends. Micro-frontend have as
upsides: independent evolution, scaling, support of multiple back-ends without
tangling. Some downsides are: loss of type-safety, more complicated build and
interesting choices in deployment.

WE: OCAML discourages the use of folders for organizing code (I have doubts as to  how well this scales. They recently renamed their to-JavaScript thing from reasonml to something else, and put that in their principles. I tried ReasonML and I could not  wrap my head around this. front-end packaging is somewhat arbitrary, but if you are consistent, it does help in finding your way around. I have only ever seen one system without folders (MAINSAIL did not support folders) and it did not end well. I may be  missing something, many people seem to be happy with it, micro frontends (and give up type safety between the comonents, or use an IDL)? embedded development on relatively small things (micro kernels)

sub-hexagons -> ?relation with micro front-ends? (there is at least one book about micro frontends now).

WE: static checking of dependency directions in CI (Rob and I saw that near Zaventem, _retrie_  the Haskell refactoring language also seems to support something like that). For folder structure I think it matters less _what_ you choose, as long as you stick with the convention. I gave up having a preference on where to put tests (in /test or in src/module/sometest.in.some.language )

