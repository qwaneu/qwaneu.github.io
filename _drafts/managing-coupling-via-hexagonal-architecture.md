---
layout: post
title: Managing coupling through Hexagonal Architecture
tags:
  - architecture
  - coupling
  - design
  - ports and adapters
author: Marc Evers
image: /attachments/blogposts/2026/dan-dennis-9ycXTLGNMro-unsplash.jpg
---

Without coupling there is no working software, but how do we keep coupling manageable? In this post we will look at Hexagonal Architecture from a coupling perspective. In Hexagonal Architecture we decouple domain logic from frameworks and the outside world - but what does decoupling actually mean here?

## Hexagonal Architecture recap
quick summary/reminder hex arch
+picture


## Hexagonal Architecture in practice

in practice: making changes across the picture
New feature
need to make changes in the domain logic, in the database schema, the database adapter, the API and its adapter. 

How is this 'decoupled'? It looks more like the [Shotgun Surgery code smell](https://www.sammancoaching.org/code_smells/shotgun_surgery.html) - having to make many small changes across the code base.


coupling/cohesion - put things together that change together

there are actually multiple crossing axis /reasons for change; different changes have different rates of change

APIs and database schemas tend to be harder to change - whether it's because of other services or external parties depend on our APIs or substantial amounts of data that need to be migrated when the schema changes. 
The frameworks and libraries we use evolve at their own pace. Usually they evolve at a slower pace but once in a while we need to deal with major version updates. 

The domain part has its own pace of changes. We want to be able to refactor and evolve the domain model as we gain insights.

Hex Arch optimizes for APIs, database schemas, frameworks/libraries and our domain logic to change at their own rates. Applying Hexagonal Architecture means organizing for shearing layers of change. Different parts or layers of a component change at different rates, and we organize our code to enable that change with limited friction. 

+shearing layers definition
> The concept of shearing layers was coined by the architect Frank Duffy, and it was elaborated in the wonderful book How Buildings Learn by Stewart Brand. The idea indicates that buildings have different layers that change at different rates. The building site and location is quite stable and often survives a building, the structure is expensive to change so it only changes once in a while. Things like services (heating etc) wear out, and change in 7-15 years, while stuff (chairs, tables, etc) move around quite frequently.
>
> The layers should allow for other layers to change at their own rate.
> 


(+plaatje cross-hex?)

In case of cross component changes, we can do these in small steps, one by one, while keeping the software working at all times. We have mechanisms in place like dependency inversion and domain-oriented interfaces that enable this. Being able to test the different concerns independently (domain logic tests, adapter integration tests, component-scope end-to-end tests) also helps a lot.

## Making trade-offs

This involves making trade-offs. Optimizing for each part to evolve at its own pace comes at the cost of new features needing a series of (small) changes.

Usually we are willing to pay this price, because it enables us to be much more in control of changes:
- Framework and libraries updates affect a much smaller part of our system, reducing risks.
- We can more freely refactor the domain logic to reflect our understanding, without continuously needing to migrate data.
- A new feature that require changes across the component, we can do them in baby steps, while having have working software at any point in time; if we think a bit about the order of the baby steps, we could even deploy each change to production without impact.

## Hexagonal Architecture and (de)coupling

(summarizing/reflecting)

Hexagonal Architecture separates concerns that have different rates of change. APIs, adapters, databases, domain logic are still coupled, but they do not need to change all at the same time. The coupling is made explicit through interfaces and adapters.

The pattern comes with trade-offs, where being in control and the ability to do changes in baby steps come at the cost of some changes being more work.

## References

- We wrote a serie posts on Hexagonal Architecture: ...
- How Buildings Learn
- 

<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer workshops in this area, e.g. explore coupling and cohesion through a hands-on workshop, based on connascence, or a hands-on workshop about the SOLID design principles.</p>
<p><a href="/contact">Let's have a chat</a></p>
</aside>
