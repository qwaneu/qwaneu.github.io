---
layout: post
title: Managing coupling through Hexagonal Architecture
tags:
  - architecture
  - coupling
  - design
  - ports and adapters
author: Marc Evers
image: /attachments/blogposts/2026/hex-arch-incremental.jpg
---

Without coupling there is no working software, but how do we keep coupling manageable? In this post we will look at Hexagonal Architecture from a coupling perspective. In Hexagonal Architecture we decouple domain logic from frameworks and the outside world - but what does decoupling actually mean here?

## Hexagonal Architecture recap

[Hexagonal Architecture](/2020/08/20/hexagonal-architecture), also known as Ports & Adapters, is a software architecture pattern that provides guidance in structuring a component or application and managing dependencies inside the component.

Hexagonal Architecture applies the Dependency Inversion Principle at the component or service level: it puts the domain logic at the center, without any outside dependencies. Interactions with the outside world (Ports) are connected to the domain logic via Adapters which perform the mapping from outside models to domain model and the other way around.

Ports can be driving (incoming) or driven (outgoing). For driven ports, the adapters implement interfaces that are part of the domain model (the green thick lines in the picture below). Libraries and frameworks reside on the outside.

![Hexagonal Architecture overview, showing driving and driven ports, with adapters and libraries being used](/attachments/blogposts/2020/hex-main.jpg)
{: class="post-image post-image-70" }

## Hexagonal Architecture in practice

We have applied Hexagonal Architecture in many projects. It has also been embraced by the Domain Driven Design community as the default way of structuring services.

In practice, it results in domain code that is easier to understand, because it is not cluttered with all kinds of technical details like database or API mappings. We've decoupled different concerns in the code.

We have noticed something else as well. Sometimes we need to add a new feature and we find ourselves making changes across the component, touching the domain logic, the database schema, the database adapter, the API and the API adapter. If this happens, it does not really feel decoupled. It actually looks more like the [Shotgun Surgery code smell](https://www.sammancoaching.org/code_smells/shotgun_surgery.html) - having to make many small changes across the code base - or does it?

![Schematic picture of Hexagonal Architecture with a crossed red line indicating changes across all the parts](/attachments/blogposts/2026/hex-arch-crossed.jpg)
{: class="post-image post-image-70" }

## Different sources of change

The coupling & cohesion heuristic we would like to follow is: 

> If things need to change together, put them close to each other.

There are however multiple sources of change, with different impact and each with its own rate of change:
- APIs and database schemas tend to be more stable - whether it's because of other services or external parties depend on our APIs or substantial amounts of data that need to be migrated when the schema changes. 
- Frameworks and libraries evolve at their own pace, usually they evolve at a slower pace. Once in a while we need to deal with major version updates. 
- Domain logic has its own pace of changes. We want to be able to refactor and evolve the domain model as we gain insights.

When applying Hexagonal Architecture, we isolate the API, database and domain. We optimize for specific changes. The trade-off we make is accepting that some (feature) changes will cross the different parts.

Hexagonal Architecture optimizes for parts *that change at different rates*: we are organizing for *shearing layers* of change - allowing different rates of change with limited friction. The shearing layers concept comes from (building) architecture and provides a useful perspective to look at organizing code based on the stability or volatility of different parts.

> The concept of [Shearing Layers of change](https://en.wikipedia.org/wiki/Shearing_layers) was coined by the architect Frank Duffy, and it was elaborated in the wonderful book [How Buildings Learn](https://en.wikipedia.org/wiki/How_Buildings_Learn) by Stewart Brand. 
> 
> The idea indicates that buildings have different layers that change at different rates. The building site and location is quite stable and often survives a building, the structure is expensive to change so it only changes once in a while. Things like services (heating etc) wear out, and change in 7-15 years, while stuff (chairs, tables, etc) moves around frequently.
> Layers should allow for other layers to change at their own rate.

![image from the book illustrating shearing layers of change: site, structure, skin, services, space plan, stuff, and the caption "SHEARING LAYERS OF CHANGE." Because of the different rates of changes of its components, a buildings is always tearing itself apart.](/attachments/blogposts/2026/shearing-layers-book-image.jpg)
{: class="post-image post-image-50" }

## Making trade-offs

This involves making trade-offs. Optimizing for each part to evolve at its own pace comes at the cost of new features needing a series of (small) changes.

Usually we are willing to pay this price, because it enables us to be much more in control of changes:
- Framework and libraries updates affect a much smaller part of our system, reducing risks.
- We can more freely refactor the domain logic to reflect our understanding, without continuously needing to migrate data.
- A new feature that require changes across the component, we can do them in baby steps, while having have working software at any point in time; if we think a bit about the order of the baby steps, we could even deploy each change to production without impact.

Working in baby steps while keeping the code working at all time is key here. Mechanisms like dependency inversion, domain-oriented interfaces, the ability to test different concerns independently using domain logic tests, adapter integration tests, component end-to-end tests help a lot.

![Schematic picture of Hexagonal Architecture with multiple blue lines representing an incremental cross-cutting change](/attachments/blogposts/2026/hex-arch-incremental.jpg)
{: class="post-image post-image-70" }

## Hexagonal Architecture and (de)coupling

Hexagonal Architecture separates concerns that have different rates of change. APIs, adapters, databases, domain logic are still coupled, but they do not need to change all at the same time. The coupling is made explicit through interfaces and adapters.

The pattern comes with trade-offs, where being in control and the ability to do changes in baby steps come at the cost of some changes being more work.

Hexagonal Architecture was introduced over 30 years ago. There is a more recent insight that rather than creating a single big hexagon for a component or application, we'd rather split the component into smaller, more focused hexagons, to reduce complexity and impact of changes. This is worth a post of its own.

## References

- We have written a [series of posts about Hexagonal Architecture](/blog-by-tag#tag-ports-and-adapters)
- [How Buildings Learn - What happens after they're built](https://archive.org/details/howbuildingslear00bran) by Stewart Brand; there is also a [BBC series of 6 episodes](https://www.youtube.com/playlist?list=PLxFD-wxU4CoNb-gCM0-P9fjJchwUIfkep)
- Paul Dyson wrote 3 posts about [Shearing Layers in software delivery](https://pauldyson.wordpress.com/2010/04/06/shearing-layers-in-software-delivery-part-1-recognising-rates-of-change/)
- Mark Dalgarno explores Shearing Layers in [Shearing layers in Organisational Transformation — half an idea](https://markdalgarno.medium.com/shearing-layers-in-organisational-transformation-half-an-idea-9ea85eff57cc)
- Chad Fowler is writing a [series of posts on regenerative software](https://aicoding.leaflet.pub/), using the idea of Shearing Layers (or pace layering as it is called in his posts)

![Cover of the How Buildings Learn book by Stewart Brand](/attachments/blogposts/2026/how-buildings-learn-cover.jpg)
{: class="post-image post-image-30" }

<aside>
<h3>Want to learn more?</h3>
<p>We offer training courses on Hexagonal Architecture and Domain Driven Design. We can also support you in applying these in your situation.</p>
<p><a href="/contact">Learn more about our courses</a></p>
</aside>
