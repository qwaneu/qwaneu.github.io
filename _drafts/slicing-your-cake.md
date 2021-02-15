---
layout: post
title: Slicing your Cake - Structuring your Hexagons
tags:
  - architecture
  - ports and adapters
author: Marc Evers
image: /attachments/blogposts/2021/annie-spratt-oudLkxglHuM-unsplash.jpg
---

You are happily applying the [Hexagonal Architecture
pattern](/2020/08/20/hexagonal-architecture.html). You have hidden the
unpredictable outside world behind ports and adapters, so you can speak your
domain language. Awesome! But now your domain model grows as well. How do you
keep that understandable? Imagine the inside of your hexagon was a cake. How
would you slice your domain?

![birthday cake image](/attachments/blogposts/2021/annie-spratt-oudLkxglHuM-unsplash.jpg)
{: class="post-image" }

In previous posts, we introduced [Hexagonal
Architecture](/2020/08/20/hexagonal-architecture.html). We demonstrated how we
apply it, both in [front-end](/2020/09/25/hexagonal-frontend-example.html) and
[back-end](/2021/01/04/hexagonal-backend-example.html) components. We showed how
it helps us to trade off the many design decisions we make when developing
front-end and back-end code. In this post, we describe our approach how we
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
- This is not restricted to back-end components only. It could be a
  front-end, a back-end, a database, or sensors and actuators in an embedded
  system. Software is only limited by our imagination. 
- Dependencies between different objects, functions, systems become unclear.
- You know that not everything depends on everything, but this is hard to see
  from the code because everything is _exposed_ to everything.
- Exposing primary adapters to all domain code details creates a strong
  dependency, making the adapters highly sensitive to change. It becomes unclear
  what the real dependencies are.

## Solution

A solution direction is to divide the core of the hexagon in slices that are
based on the domain model. Each slice presents a Facade to the primary ports, e.g. UI components or HTTP REST routes. Each slice can depend on one or
more secondary ports, e.g. a repository or messaging.

![slicing your cake pattern](/attachments/blogposts/2021/slicing-your-cake.jpg)
{: class="post-image post-image-70" }

The responsibilities of a slice are:
- It acts as a Facade towards primary adapters; e.g. in a front-end component,
  it specifies/exposes what data a UI component can show and what actions it can
  trigger.
- It knows relevant repositories, so that it can handle side-effects -
  retrieving data, storing data, and it can handle any associated asynchronous
  behaviour.
- It delegates behaviour and (view) domain logic as much as possible to
  behaviourally rich domain objects. 
- A slice can expose a set of related Command and Queries (Read Models).

![slicing a hexagon](/attachments/blogposts/2021/slicing-a-hexagon.jpg)

An alternative way of describing this is to say that we structure a component
not as a single hexagon, but as multiple sub-hexagons.

## An example 

In the Online Agile Fluency® Diagnostic application we have developed, we have a
Vue.js based front-end component. It bundles different concerns: there is a part
for facilitators to create diagnostic sessions, give participants access, and
see aggregated results; there is a survey for participants, and an administrator
interface for managing facilitator accounts.

We started out using [Vuex](vuex.vuejs.org/). Vuex is highly opinionated about
how to structure the logic and state management related to front end components,
and provides guidance of [What to Put
Where](/2020/12/23/what-to-put-where.html). We found it to be highly integrated
and coupled with our front end components, which made writing focused tests for
the logic harder among other things. 

So we decided to roll our own way of handling logic and state in plain
JavaScript. Inspired by how Vuex provides modularity through different
'modules', we created a number of 'module' objects, an `AdminModule`, a
`DiagnosticModule` and a `FacilitatorModule`.

![Online Agile Fluency Diagnostic tool slices](/attachments/blogposts/2021/slicing-afdop.jpg)
{: class="post-image post-image-50" }

The `diagnostic-module` slice provides data and actions regarding the diagnostic
session and the associated survey.

```javascript
export class DiagnosticModule {
  constructor (questionRepository, sessionJoiner, ...) {
    this._questionRepository = questionRepository
    this._sessionJoiner = sessionJoiner
    ...
  }
  
  get color () { ... }
  get facilitator () { ... }
  get questions () { ... }

  join (sessionId, joiningId) { ... }
  retrieveQuestions (sessionId, participantId) { ... }
  updateAnswer (question, value) { ... }
  ...
}
```

A module is implemented by a plain JavaScript class. We explicitly inject any
dependencies, in this case two ports, the `questionRepository` that contains
questions and answers, and the `sessionJoiner` which handles correct joining of
a participant so that he/she will see the correct survey.

The module exposes properties to the UI components, like the color and the
facilitator's name. It also exposes actions that can be initiated from the UI
components, like `retrieveQuestions` to start retrieving survey questions
asynchronously, `join` for a participant joining a session and `updateAnswer`
for changing an answer in the survey.

The module only exposes data and actions that are relevant to the UI components,
the rest is private. UI components do not have access to repositories for
instance.

## Considerations

The DiagnosticModule class is quite a big slice of the cake: it does a lot,
handling diagnostic sessions for facilitators and surveys for workshop
participants. We could split it up into smaller slices. 

How do we determine the
size of a slice? If we have many small slices, it may get unwieldy. If a slice
is large, we tend to group unrelated things that have different reasons to change. Some design heuristics for
splitting a hexagon into slices:
- Organize around the [Aggregates](https://www.martinfowler.com/bliki/DDD_Aggregate.html) 
  you have found in event storming or some other
  domain modelling technique; splitting up according to domains or bounded
  contexts will probably be too course grained.
- If you do user story mapping, you will have mapped out users' activities and
  tasks; you could slice by user activity.
- Group around objects/functions working on the same data.
- Group data and actions related to specific user roles.
- Put data with different lifecycles in separate slices.

_Naming the slices_: we borrowed the 'module' term from Vuex. We could also
have called it 'DiagnosticSessionSlice', or just 'DiagnosticSessions' following
the principle of not naming objects after the pattern applied. We'd rather not
call them 'service' because this is already an overloaded term with little
meaning of its own.

_What to do with shared objects?_ We can put these in one or more shared folders
or libraries on which different slices depend.

_Wiring the component_: you need to instantiate 'slices' and inject any
secondary ports. In our Vue.js based component, this is done from the main
function.

We could have split the front-end component into 3 separate
front-ends based on our different users: the administrator part, the diagnostic
session management part, and the survey part. The trade-off here is managing 3
simpler deployables that do have some overlapping code vs having a larger, more
complicated code base. For us the latter was preferable.

## Related work

These ideas have been inspired by work of others, to mention a few:
- Jimmy Bogard's [Vertical Slice architecture](https://jimmybogard.com/vertical-slice-architecture/amp/)
- [A domain-driven Vue.js Architecture](https://medium.com/bauer-kirch/a-domain-driven-vue-js-architecture-77771c20f0da)
- Michel Weststrate, [UI as an afterthought](https://michel.codes/blogs/ui-as-an-afterthought)
- Alberto's Brandolini's [Event Storming](https://www.eventstorming.com/) technique has also been influential in how we look at the domain.

Another source of inspiration were the fruitful discussions I had with software
architects at [RIGD-Loxia](https://www.rigd-loxia.nl/) a number of years ago. We
explored how to apply Hexagonal Architecture to the (sometimes quite complex)
Railway Safety Engineering software they develop. I think the 'slices of cake'
metaphor originates from there.

A current related development is micro-frontends. Micro-frontend have as
upsides: independent evolution, scaling, support of multiple back-ends without
tangling. Some downsides are: loss of type-safety, more complicated builds and
'interesting' choices in deployment.

The Slicing your Cake pattern is also related to the [Micro Front-ends
pattern](https://martinfowler.com/articles/micro-frontends.html). In a way,
micro front-ends are cake slices taken to the extreme. Slice your front-end cake
in modular parts will facilitate splitting it up in micro front-ends later.

_Credits:_
- _Photo credits: <span>Photo by <a href="https://unsplash.com/@anniespratt?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Annie Spratt</a> on <a href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>_
- _Thanks to Willem for reviewing and encouraging me to get this published._

<aside>
  <h3>Seeing your systems through a Hexagonal lens</h3>
  <p>Making informed architecture decisions across your application landscape is a tough skill. We can support you with for instance architecture reviews, carrying out experiments and facilitating collaborative architecture sessions.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>

