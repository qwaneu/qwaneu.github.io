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


# Hexagonal example in Ruby

# Test Driving Adapters - SMTP client in Python

# Test Driving Adapters - database based repository

# Hexagons & dependencies - why we don't use dependency injection frameworks

# Hexagons: DB transaction & domain

# Hexagons and pure domain:

representing username uniqueness as an explicit domain concept; "lazily evaluated assumption" allows pure domain code

# testing vue component met v-model (data in, events out)

# testing routes with mirroring (using the production behaviour of collaborators/mapping functions)

# UI components are dumb & flat

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

# WTPW Example: Introducing 'test' diagnostic sessions in AFP

We introduced 'test' sessions for facilitators to try out stuff without consequences (and for us to see how the system is used for real). To prevent unintended usage of test sessions, we fix the number of participants to 3. Where do we put the 'test' concern en the '3 participants' business rule?

# The political economy of legacy code

Source: discussion Marc/Willem 15-12-2020

Use new people wisely
- new people means feedback, e.g. about implicit knowledge

# Domain knowledge vs Business knowledge

Triggered by AF Diagnostics and AFD statements

Domain knowledge != Business knowledge

Optimizing Zone: optimize for product decision making (needs business knowledge as well as domain knowledge)

# Only rolling forward

At client some years ago we embarked on a journey towards continuous delivery.

One of the decisions we made is to not do rollback of releases, only roll-forward.

To do this, the delivery process should be sufficiently smooth. If something
happens, you should be able to make a change, review-commit-test-build within
minutes rather than hours.

If you are able to do this, it will make your release process simpler: there is
just one release process, you will not have processes or procedures for hotfixes
etc. So less complexity (also organizational), and being more in control.

# Feature toggle musings by Willem

- WE - I have feature toggles seen work, surprisingly well. And at the same time, multiple ways of authorizing access to features (flages, but also other interfaces. logic everywhere). Removing feature flags would make the product inoperable. 

# NDVEA: Niet Denken Voor Een Ander

i.m. Hans Walkate

# Language Matters

"words mean things" - Geert Bossuyt
- improve -> grow
- assessment -> diagnostic
- help -> ?
- problem/solution -> forces/tension, resolve/reinforce/dampen
- causal -> dispositional
