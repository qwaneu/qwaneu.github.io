---
layout: post
title: Slicing your Cake - Structuring your Hexagons
tags:
  - architecture
  - ports and adapters
author: Marc Evers
image: 
---

So we introduced Hexagonal Architecture, and we show how we apply it in a front end application (to be more specific, we showed how it helps us in the many trade offs and design decisions we are making when developing front end code)

## Context 

When your component grows (whether it is front end or back end, or database for that matter), it gets bigger, more complex and unwieldy. While keeping the Hexagonal concerns separated, it becomes harder to keep the domain accessible.

How can you structure your domain code in a way that keeps it modular, understandable, maintainable? And how do I prevent ending up with my routes/UI components knowing everything in the domain? (making it hard to see the impact of my changes)

## Forces

- Small components grow up (whether it is front end or back end, or database for that matter), when they bigger, they contain more concerns and become unwieldy. 
- Dependencies between different objects/functions become unclear
- You know that not everything depends on everything, but this is hard to see from the code and hard to maintain (auto-complete makes it easy to introduce new unwanted dependencies)
- Exposing all the details from the domain to primary adapters/ports (e.g. HTTP routes) makes e.g. routes depend on too many details and it becomes unclear what the actual dependencies are

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
