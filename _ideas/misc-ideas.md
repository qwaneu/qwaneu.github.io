# On Pairing

Different views of what it actually is/means
-> instance of collaboration (see also post by Dave Nicolette)

Effects of pair programming/collaboration:
- learning
- senior/junior (see intermittent collaboration article)
- shared coding standards
- knowledge diffusion
- skill diffusion
- way of working diffusion
- less mistakes
- fun & joy

Forms:
- full day / intermittent

# Cypress & Exploratory Testing

# Library of Unread Books

-> Umberto Eco

# Testing heuristics

- test connections rather than things (source: Geepaw Hill)

# 4 Rules of Simple Design + 1

https://martinfowler.com/bliki/BeckDesignRules.html
QWAN: Rule 5: code should be at a level the whole team can understand

Habitability of code (Richard Gabriel)
http://debasishg.blogspot.com/2006/02/habitability-and-piecemeal-growth.html 

# QWAN take on the Testing Quadrants


# Hexagonal Architecture Posts

## Hexagonal example in Ruby

## Test Driving Adapters - SMTP client in Python

## Test Driving Adapters - database based repository

## Hexagons & dependencies - why we don't use dependency injection frameworks

## Hexagons: DB transaction & domain

## Hexagons and pure domain:

representing username uniqueness as an explicit domain concept; "lazily evaluated assumption" allows pure domain code

## testing vue component met v-model (data in, events out)

## testing routes with mirroring (using the production behaviour of collaborators/mapping functions)

## Wrapping dates, logging and UUIDs in our own concepts

"We sometimes tolerate libraries in the center: libraries are not in control and are less intrusive. But we tend to even wrap lower level library concepts like logging, date/time, and UUIDs, because these still tend to get in the way[plaatje met de libs]" (WE: maybe expand a little bit: we only use a fraction, which we want to document, and we insulate ourselves from changes in these dependencies. This lowers the cost of testing and replacing them when necessary)

“It’s a thing”; we find our code makes assumptions about the strings or ints, sometimes just a little (though spread out over the code)

Example: dates as UTC; Python/SQAlchemy+SQLite does not save timezones; we have our own Clock, we have some UTC timezone knowledge in several places (e.g. re-adding the timezone when a datetime is read from the db)

https://codeblog.jonskeet.uk/2019/03/27/storing-utc-is-not-a-silver-bullet/


## UI components are dumb & flat

UI component only concerns UI; so each component is a bit of html structure, css, and data / state wiring; 

We follow the data in / events out principle from Vue (and Angular?); or: data in, function calls out:
- no decisions or logic in the UI code; everything is delegated to either state/modules/slices that contain view-domain logic or view/domain objects that capture the behaviour
  <2x example>
- Also means e.g.: if button becomes enabled triggered by validation, the validation and logic is encapsulated in a class; the component just renders the state/data of this object

Vue.js follows the [MVVM (Model-View-ViewModel) pattern](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm); we regard the UI component as just the view (even though Vue.js allows detailed state and behaviour definition in the component) and we create JS/TS classes that are the View Models.

Consequences:
- Component tests become more straightforward: we only need to test if a component renders data correctly (easier to understand, faster)
- All the view logic is encapsulated in small classes and is easier and faster to unit test
- We get more, small, single purpose classes that need a good name
View logic is easier to reuse (not the primary goal, but a nice side benefit)
- ‘Modules’ are the primary ports/facade view <-> domain

Background information
- [Humble Object pattern](https://martinfowler.com/bliki/HumbleObject.html)

## Effects of testability

Vue components are easy to test. Vue test utils helps a lot (still a bit low level, but you can build your own DSL around it). These tests also run fast and will be part of your automated test suite. Running all your front end tests in seconds.

This is great ... however it can have unintended consequences / nudge you towards less optimal design decisions.

When testing of UI components is difficult and/or slow, you tend to move logic out of components, to their own classes/functions. In this way you can have good fast tests/feedback for most of the things.

Because the Vue component tests are so fast, it is tempting to add logic to components and cover the logic by sufficient tests. But if you do this, your components will get more and more complicated, mixing views and view logic. Mixing up concerns.

We are aware of this; we consciously decide to put view logic in its own classes, used by the component. But even for us the temptation is there, and sometimes an innocent if or a tiny bit of logic creeps into our UI components. And then it starts to grow (luckily we know how to refactor that code quickly out of the UI components)

This is not the fault of Vue/Vue test utils! And this post is by no means a critique on how Vue facilitates component testing. What is important here is that as a developer, you understand the effects of things like this (way faster feedback for UI components)

