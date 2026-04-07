---
layout: post
title: Software architecture - critical paths
tags:
  - architecture
  - coupling
  - design
  - quality attributes
  - ports and adapters
author: Marc Evers
image: /attachments/blogposts/2026/criticalpaths-2.jpg
---

To make good architecture decisions, we need multiple perspectives on the systems we develop and the bigger systems they are part of. In this post, we will highlight one of those perspectives, that of *critical paths*. We use this perspective for example in architecture reviews.

This perspective focuses on the critical capabilities of a system and how these realized in the system - the critical paths. Looking from this perspective helps asking better questions, about system qualities, risks, risk mitigation measures, and things that help or hinder critical capabilities.

## Architecture perspectives

Systems architecture is a topic with a broad scope. In this post we focus on software architecture. Let's stick to the Grady Booch definition here:  

> Architecture represents the significant design decisions that shape a system, where significant is measured by cost of change.

We also like to see systems as providing both *functions* - what the system does, use cases, services - and *qualities* - how well the system provides its functions. This is a view inspired by Tom Gilb's work. A system's qualities rather than its functions are what makes a difference for its users - how fast, reliable, available, correct, secure, consistent, cost-effective it is.

## Critical capabilities

Not all capabilities that a system offers are equally important. Usually there are a few critical ones. A **critical capability** is a system capability that users are highly dependent on; they cannot do their job if the capability is not working as it should. 'Critical' is related to quality requirements for those capabilities, for example:
- high availability during work hours, otherwise user's cannot do their work;
- data should always be correct, because life-or-death decisions depend on it;
- mutations should be visible within a second, so that users always see up to date information.

Many capabilities turn out not to be critical in practice. The user can e.g. proceed with a workaround or try again later when it's unavailable, as long as it will be up e.g. within an hour.

To investigate criticality, we can ask questions like:
- What are the consequences of data being eventually consistent, i.e. after 1 second, 1 minute, 10 minutes?
- What is the user impact a lower quality of service, e.g. being unavailable for some time? Do users have an acceptable (manual) workaround? What quality impact does that workaround have?
- What needs to be always available, consistent, correct for users to do their job properly?
- What are consequences of inconsistency, incorrectness, unavailability? Is it merely inconvenient, does it affect a customer's primary process, does someone's life depend on it?
- What is the cost impact of lower quality of service for users and customers?

Some examples of critical capabilities:
- In The Netherlands, a general practitioner usually has 10-15 minutes to meet a patient; this means that all relevant health record data for the patient should be available for *reading* in that timeslot. *Updating* is less critical; the general practitioner could update the health records later that day, although this will incur costs of wasting some time and possibly more errors.
- When a repair crew starts the day, they need to know which addresses to visit when. The availability of agenda information at the start of the work day is critical for them for the work to take place. Planning the work for the different repair crews normally happens days or weeks before, and this capability is less critical.
- The capability to submit sessions of a conference management system is critical in particular on the day of the submission deadline, as a lot of people tend to submit on the last possible moment. Another critical capability is availability of submitted sessions for the program committee meeting (usually a group of very busy people for which the meeting cannot be rescheduled).

## Critical paths

A **critical path** is the way how a critical capability is realized within the system, e.g. how it is mapped ono different applications and services. 

Almost every software system is a system of systems, consisting of multiple services, components, applications, using multiple databases, buses, and other infrastructure services. Even our good old monolith usually has a separate frontend application running in the user's browser and a database running on a separate server.

Most critical paths span multiple parts and each part affects the critical capability. In a sense, a critical path is a choreography of multiple parts.

## Visualizing critical paths

We like to visualize critical paths. Below we provide a few (abstract) examples of how that looks like.

*Example 1:* a system consisting of a frontend application, a backend service (1) calling another backend service (2). Backend service 2 stores its data in a database. All dependencies are synchronous.

![simple application landscape with a user, a frontend, a backend service that uses another backend service, and a database](/attachments/blogposts/2026/criticalpaths-1.jpg)
{: class="post-image post-image-85" }

We can visualize a critical path by drawing a line through the services that are involved in realizing the critical capability. In this example, the critical path passes through the frontend, both backend services and the database.

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-2.jpg)
{: class="post-image post-image-85" }

*Example 2:* a system split into intake and processing. Intake consists of a frontend and a backend system (1) that puts data on a message bus asynchronously. Backend service 2 consumes this data, processes it, and presents it via the second frontend.

![application landscape with a user, a frontend, an intake backend service that uses a bus to exchange data with a processing backend service, and a second frontend](/attachments/blogposts/2026/criticalpaths-3.jpg)

If end-to-end latency of processed data becoming available is critical, the critical path crosses the intake frontend, the intake backend, the message bus, the processing backend and the second frontend:

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-4.jpg)

*Example 3:* we can zoom in on how a path is mapped within a service, to investigate data mappings and transformations. The picture below shows an application landscape with a frontend, a backend service structured according to [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html), and a database.

![application architecture with a frontend, backend and database, where the backend is structured according to hexagonal architecture](/attachments/blogposts/2026/criticalpaths-hex-1.jpg)
{: class="post-image post-image-70" }

A critical path usually touches frontend, backend and database, as visualized below. We can make the data transformations and mappings explicit on the critical path, shown by the double arrows. This is useful e.g. when investigating data correctness.

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

**Cost of change**: looking from Booch's definition of architecture, critical paths provide insights in how the architecture affects the cost of changing critical capabilities.

## Further reading

- Ruth Malan has written [a useful overview of what software architecture is](https://www.bredemeyer.com/whatis.htm).
- The qualities + functions view on systems is based on [Tom Gilb's Value Requirements approach](https://www.gilb.com/blog/Agile-Tools-for-Value-Delivery-by-Tom-Gilb)
- Michael T. Nygard, [Release It!: Design and Deploy Production-Ready Software](https://pragprog.com/titles/mnee2/release-it-second-edition/) - provides patterns on improving stability and reliability of software systems

<aside>
<h3>Want to do stuff?</h3>
<p>Pitch our architecture services here</p>
<p><a href="/contact">Learn more about our courses</a></p>
</aside>
