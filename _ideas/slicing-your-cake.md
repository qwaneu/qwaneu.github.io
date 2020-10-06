---
layout: post
title: Slicing your Cake - Structuring your Hexagons
tags:
  - architecture
  - ports and adapters
author: Marc Evers
image: 
---

So you have the unpredictable outside world hidden behind ports, and made adapters so you can speak your domain language. Awesome. But now your domain model grows as well. How do you keep that understandable? Imagine the inside of your hexagon was a cake. How would you slice your domain?

In previous posts we introduced Hexagonal Architecture. We demonstrated how we apply it in a front end application. In particular we showed how it helps us trade off the many design desicions we make when developing front end code. In this post we describe a proto pattern "Slice the domain as cake". Slicing lets us evolve components without losing our way.

## Context 

When a component grows it gets more complex and unwieldy. While keeping the Hexagonal concerns separated, it becomes harder to keep the domain accessible. @@todo restructure last sentence. various options. 

How can you structure your domain code in a way that keeps it modular, understandable and maintainable? And how do I prevent ending up with my routes/UI components knowing everything in the domain? When everything is coupled to evrything,it is hard to see the impact a change would have.

## Forces

- Small components grow up when they grow, they contain more concerns and become unwieldy. 
- This happens wherever there are components. It could be a front-end, a back-end, a database, or sensors and actuators in an embedded system. Software is only limited by our imagination. 
- Dependencies between different objects/functions/systems become unclear
- You know that not everything depends on everything, but this is hard to see from the code.  It is also hard to maintain, for instance:  

> auto-complete is great for adding undesirable dependencies

- Exposing all the details from the domain to primary adapters/ports lets the port depend on too many details and it becomes unclear what the actual dependencies are

An example of ports would be (@@TODO write / draw this out ) would be http routes. (WE: routes are needed to serve content, render pages as well as link back to user tasks in the application from what is rendered. to complicate this, if you have a SPA +  REST then there is a partially parallel set of routes, to go with similar, but slightly different domain concerns.).


## Solution

Hexagon: divide in slices that are based on domain

Each slice presents a Facade to the primary ports; each slice can depend on one or more secondary ports.

@@plaatje met taart 

You could say that we structure the (front end) component not as a single hexagon, but as multiple ‘sub-hexagons’

## Example 

@@AFDOP Front end plaatje en wat code

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

Vertical Slice architecture (Jimmy Bogard) https://jimmybogard.com/vertical-slice-architecture/amp/ 

A domain-driven Vue.js Architecture https://medium.com/bauer-kirch/a-domain-driven-vue-js-architecture-77771c20f0da (2019)

UI as an afterthought (Michel Weststrate) https://michel.codes/blogs/ui-as-an-afterthought (2019)

Event Storming / Alberto Brandolini (Picture that explains everything???)

HT to RIGD-Loxia - when consulting around 2013, we had lots of fruitful discussions on applying Ports and Adapters to the (sometimes quite complex) Railway Engineering software they develop. We arrived at the metaphor of 'slices of cake' ('taartpunten').

WE: OCAML discourages the use of folders for organizing code (I have doubts as to  how well this scales. They recently renamed their to-javascript thing from reasonml to something else, and put that in their principles. I tried ReasonML and I could not  wrap my head around this. front-end packaging is somewhat arbitrary, but if you are consistent, it does help in finding your way around. I have only ever seen one system without folders (MAINSAIL did not support folders) and it did not end well. I may be  missing something, many people seem to be happy with it, micro frontends (and give up type safety between the comonents, or use an IDL)? embedded development on relatively small things (micro krnels)
sub-hexagons -> ?relation with micro front-ends? (there is at least one book about micro frontends now).