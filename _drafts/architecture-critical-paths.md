---
layout: post
title: Software architecture - critical capabilities & critical paths
tags:
  - architecture
  - coupling
  - design
  - quality attributes
  - ports and adapters
author: Marc Evers
image: /attachments/blogposts/2026/criticalpaths-2.jpg
---
To make good architecture decisions, we need to look from multiple perspectives at the systems we develop and the bigger systems they are part of.

In this post, we will highlight one of those perspectives that we take, for example as part of an architecture review: what are the critical capabilities of the system and how these realized in the system - the critical paths.

This perspective helps us to ask better questions about system qualities, risks, risk mitigation measures, and other measures that help or hinder the critical capabilities.

## Architecture perspectives

(Software/systems) architecture is a topic with a broad scope, which we won't elaborate here. Let's stick to the definition by Grady Booch here:  

> Architecture represents the significant design decisions that shape a system, where significant is measured by cost of change.

The other thing that is relevant here is that (software) systems provide both functions (use cases, what the system does) and qualities (how well the functions are provided). The quality of what the system provides makes a difference for its users - how fast, reliable, available, correct, consistent, error-prone.

## Critical capabilities

Not all capabilities that a system offers are as important. Usually there are a few that are critical for the users of the system. Critical means that users are highly dependent on them and cannot do their job if the capability is not working as it should. 

'Critical' translates to quality requirements for those capabilities, e.g. high availability during work hours, data that should always correct and consistent, effects of mutations should be visible within a second. Many capabilities turn out not to be critical in practice. The user can e.g. proceed with a workaround or try again later when it's unavailable, as long as it will be up within an hour.

To get information about criticality, we can ask questions like:
- What are the consequences of data being eventually consistent after 1 second, or 1 minute, or 10 minutes?
- What is the user impact of the capability having a lower quality of service, e.g. being unavailable? Do they have a (manual) workaround? What quality impact does that workaround have?
e.g. what needs to be always available? or always consistent / correct (or: where the consequences of inconsistency, incorrectness, unavailability would be problematic)
- What is the cost impact of lower quality of service for users and customers?

Some examples of critical capabilities:
- In The Netherlands, a GP appointment has a timeslot of 15 minutes; this means that all relevant health record data for that patient should be available for *reading* in that timeslot. *Updating* is less critical, in the sense that updating the health records later on the day is a workaround (at the cost of wasting more precious GP time)
- When a repair crew starts the day, they need to know which addresses to visit at what times; the availability of this agenda information is critical at the start of the work day. Planning the work for the different repair crews happens days or weeks before, and this capability is less critical.
- The session submitting capability of a conference management system is critical, in particular on the day of the submission deadline, as a lot of people tend to submit on the last possible moment. Another critical capability is availability of submission information on the day of the program meeting (or the capability of exporting that data the day before).

## Critical paths

A **critical path** is the way how a critical capability is realized within the system, e.g. how it is mapped on different services.

Once er know a system's critical capabilities, er can investigate how the system realizes these and identify problems and risks. Almost every software system is a system of systems, consisting of multiple services or components and even our good old monolithic applications use database running on separate servers. 

This means that usually a critical path consists of multiple components working together. A critical path is a choreography of multiple components, services and infrastructure.

## Examples 

We like to visualize critical paths. Below we provide a few (abstract) examples of how that looks like.

*Example 1:* a system that consists of a frontend application, a backend service (1) that calls another backend service (2). Backend service 2 stores its data in a database. All dependencies between services are synchronous.

![simple application landscape with a user, a frontend, a backend service that uses another backend service, and a database](/attachments/blogposts/2026/criticalpaths-1.jpg)
{: class="post-image post-image-85" }

We can visualize a critical path by drawing a line through the services that are involved in realizing the critical capability. In this example, the critical path passes through the frontend, both backend services and the database.

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-2.jpg)
{: class="post-image post-image-85" }

*Example 2:* a system that is split up into intake and processing. Intake consists of a frontend and a backend system (1) tha puts data on a message bus asynchronously. Backend service 2 consumes data from the bus, processes it, and presents it via the second frontend.

![application landscape with a user, a frontend, an intake backend service that uses a bus to exchange data with a processing backend service, and a second frontend](/attachments/blogposts/2026/criticalpaths-3.jpg)

If end-to-end latency of processed data becoming available is critical, the critical path crosses the intake frontend, intake backend, the message bus, the processing backend and the second frontend. We can visualize it like this:

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-4.jpg)

*Example 3:* let's zoom in on how things flow through services, to investigate what data and transformations take place. The picture below shows an application landscape with a frontend, a backend service structured according to [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html), and a database.

![application architecture with a frontend, backend and database, where the backend is structured according to hexagonal architecture](/attachments/blogposts/2026/criticalpaths-hex-1.jpg)
{: class="post-image post-image-70" }

A critical path usually touches frontend, backend and database, as visualized below. We can make the data transformations and data mappings explicit on the critical path, shown by the double arrows below. These are relevant e.g. from a data correctness perspective.

![visualization of a critical path as a red line that crosses the different services, with symbols indicating where data is mapped](/attachments/blogposts/2026/criticalpaths-hex-2.jpg)
{: class="post-image post-image-70" }

## Value of critical capability & critical path analysis

Once we have visualized a critical path, we can start asking question and investigating the impact of how the critical path realizes the capability:

**Data correctness**: what data mappings and transformations take place? How do you guard correctness? What mix of automated tests is in place to provide feedback and confidence about this?

**Synchronous dependencies will reduce availability**: in example 1 above, the services call each other directly, synchronously. The availability of the capability is a function of the availabilities of the different parts involved. Without additional measures, the availability of the critical path will be less than the lowest availability of the parts.

**Using asynchronous buses or queues changes trade-offs**. Using an asynchronous bus like in example 2 can provide quicker responses, e.g. a more responses intake service vs longer inconsistency windows. Reliable, exactly-once delivery of messages through a bus or queue is also expensive, so we need to deal with e.g. at-least-once delivery of messages.

What **fallback options** are available? If in example 1 backend service 2 is down, backend service 1 could use a cached value or a default value - trading availability for consistency. Tis will degrade the quality of the capability, what level of quality is still acceptable?

In example 2, the intake of data is decoupled from availability of the processing part. What if the processing part is (temporarily) unable to keep up with the data? This affects the critical path and will decrease data consistency - **what level of quality is still acceptable?** If this is a problem, we can decide on additional measures, like adding queue monitoring for early detection or scaling out the processing part.

Are the different parts owned by a single team or by multiple teams? **Guaranteeing critical capabilities across team boundaries is more difficult**, especially when teams have different goals. This becomes even harder when systems from multiple vendors are involved.

**Auditability**: in systems where correctness is critical, auditability can also be critical - in case of incorrect data, how can we proof what has happened at each part? Can we show e.g. that the source of incorrectness is an external system that we do not have under control?

## Further reading

- Ruth Malan has written [a useful overview of what software architecture is](https://www.bredemeyer.com/whatis.htm).
- Michael T. Nygard, [Release It!: Design and Deploy Production-Ready Software](https://pragprog.com/titles/mnee2/release-it-second-edition/) - provides patterns on improving stability and reliability of software systems
- (use cases)
- The qualities + functions view on systems is based on [Tom Gilb's Value Requirements approach](https://www.gilb.com/blog/Agile-Tools-for-Value-Delivery-by-Tom-Gilb)

<aside>
<h3>Want to do stuff?</h3>
<p>Pitch our architecture services here</p>
<p><a href="/contact">Learn more about our courses</a></p>
</aside>
