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

To make good architecture decisions, we need multiple perspectives on the systems we create and evolve. In this post, we will highlight one of those perspectives: *critical paths*. We use this perspective for example in architecture reviews.

The critical paths perspective focuses on the critical capabilities of a system and how these realized in the system. Looking at a system in this way helps asking better questions, about system qualities, risks, risk mitigation measures, and things that help or hinder critical capabilities.

## Architecture perspectives

Systems architecture is a very broad topic and 'architecture' has many different definitions. In this post we focus on software architecture and  stick to Grady Booch's definition:

> Architecture represents the significant design decisions that shape a system, where significant is measured by cost of change.

We also look at systems as providing both *functions* - what the system does, use cases, services - and *qualities* - how well the system provides its functions. System qualities rather than its functions make a difference for its users - how fast, reliable, available, correct, secure, consistent, cost-effective the system is. This view is inspired by Tom Gilb's work. 

## Critical capabilities

Not all system capabilities are equally important. Usually there are a few critical ones. A **critical capability** is one that users are highly dependent on. They cannot do their job if the capability is not working or substantial losses will occur. 'Critical' relates to quality requirements for these capabilities, for example:
- the main functions should always be available during work hours, otherwise users cannot do their work;
- data should always be correct, because life-or-death decisions depend on it;
- mutations should be visible within a second, because users always need the latest information.

Many capabilities turn out not to be critical in practice. The user can proceed with a workaround or try again later when a capability is not available. To investigate criticality, we can ask questions like:

- What are the consequences of data being eventually consistent, i.e. after 1 second, 1 minute, 10 minutes?
- What is the user impact of a lower quality of service, e.g. being unavailable for some time? Do users have an acceptable (manual) workaround? What quality impact does that workaround have?
- What needs to be always available, consistent, correct for users to do their job properly?
- What are consequences of inconsistency, incorrectness, unavailability? Is it merely inconvenient, does it affect a customer's primary process, does someone's life depend on it?
- What is the cost impact of lower quality of service for users and customers?

Some examples of critical capabilities:
- In The Netherlands, a general practitioner meets 10-15 minutes with a patient. All relevant health record data for the patient should be available for *reading* in that timeslot. *Updating* is less critical: the general practitioner could update the health records later that day, although this will waste some time and possibly introduce mistakes.
- When a repair crew starts the day, they need to know which addresses to visit, at what times. The availability of agenda information at the start of the work day is critical for them, otherwise no repairs will take place. Planning the work for the repair crews normally happens days or weeks before, and is less critical.
- For a conference management system, submitting sessions of is critical in particular on the day of the submission deadline, as a lot of people submit on the last possible moment. Availability of submitted sessions is critical right before the program committee meeting take place. 

## Critical paths

A **critical path** is the way how a critical capability is realized within the system - how it is mapped onto different applications and services. 

Most software systems are a systems of systems. They consist of multiple services, components, applications, using multiple databases, message buses, and other infrastructure services. Even our good old monolith usually has a separate frontend application running in the browser and a database running on a separate server.

Critical paths usually span multiple parts of a system and each part affects the critical capability. In a way, a critical path is a choreography of multiple parts.

## Visualizing critical paths

We like to visualize critical paths. Below we provide a few examples of how that can look like.

*Example 1:* a system consisting of a frontend application, a backend service (1) calling another backend service (2). Backend service 2 stores its data in a database. All dependencies are synchronous.

![simple application landscape with a user, a frontend, a backend service that uses another backend service, and a database](/attachments/blogposts/2026/criticalpaths-1.jpg)
{: class="post-image post-image-85" }

We visualize a critical path by drawing a line through the services that are involved in a critical capability. In this example, the critical path passes through the frontend, both backend services and the database.

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-2.jpg)
{: class="post-image post-image-85" }

*Example 2:* a system has an intake part and a processing part. Intake consists of a frontend and a backend system (1) that puts data on a message bus asynchronously. Backend service 2 consumes this data, processes it, and presents it via the second frontend.

![application landscape with a user, a frontend, an intake backend service that uses a bus to exchange data with a processing backend service, and a second frontend](/attachments/blogposts/2026/criticalpaths-3.jpg)

If end-to-end latency of processed data is critical, the critical path crosses the intake frontend, the intake backend, the message bus, the processing backend and the second frontend:

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-4.jpg)

*Example 3:* we can zoom in on how a path is realized within a service, to investigate data mappings and transformations. The picture below shows an application landscape with a frontend, a backend service structured according to [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html), and a database.

![application architecture with a frontend, backend and database, where the backend is structured according to hexagonal architecture](/attachments/blogposts/2026/criticalpaths-hex-1.jpg)
{: class="post-image post-image-70" }

A critical path touches frontend, backend and database, as visualized below. We can make the data transformations and mappings explicit on the critical path, shown by the double arrows. This is useful e.g. to investigate data correctness risks.

![visualization of a critical path as a red line that crosses the different services, with symbols indicating where data is mapped](/attachments/blogposts/2026/criticalpaths-hex-2.jpg)
{: class="post-image post-image-70" }

## What critical path analysis brings

Once we have visualized a critical path, we can investigate the impact of how the critical path realizes the capability and start asking questions:

**Data correctness**: what data mappings and transformations take place? How do you guard correctness? What mix of automated tests is in place to provide feedback and confidence about this?

**Synchronous dependencies will reduce availability**: in example 1 above, the services call each other directly, synchronously. The availability of the whole path is a function of the availabilities of the different parts involved. Without additional measures, the availability of the critical path will be less than the lowest availability of the parts.

**Using asynchronous buses or queues changes trade-offs**. Using an asynchronous bus like in example 2 can provide quicker responses on the intake side vs longer inconsistency windows of processed data becoming available. Making this work reliably involves some extra complexity and skills as well. Reliable, exactly-once message delivery is expensive, so we need to deal with e.g. at-least-once delivery of messages.

What **fallback options** are available? If in example 1 backend service 2 is down, backend service 1 could use a cached value or a default value - trading availability for consistency. This will degrade the quality of the capability What level of quality is still acceptable?

In example 2, intake of data is decoupled from availability of the processing part. What if the processing part is temporarily unable to keep up with the data? This affects the critical path and will decrease data consistency. **What level of quality is still acceptable?** If necessary,, we can take additional measures, like adding queue monitoring for early detection or scaling out the processing part.

Are the different parts owned by a single team or by multiple teams? **Guaranteeing critical capabilities across team boundaries is more difficult**, especially when teams have different goals. This becomes even harder when systems from multiple vendors are involved.

**Auditability**: if correctness is critical, auditability will often also be critical. If data is incorrect data, how can we proof what has happened at each part? Can we show e.g. that the source of incorrectness is an system from an external vendor that is out of our control?

**Cost of change**: looking from Booch's definition of architecture, critical paths provide insights in how the architecture affects the cost of changing critical capabilities.

## Further reading

- Ruth Malan has written [a great overview of what software architecture is](https://www.bredemeyer.com/whatis.htm).
- The qualities + functions view on systems is based on [Tom Gilb's Value Requirements approach](https://www.gilb.com/blog/Agile-Tools-for-Value-Delivery-by-Tom-Gilb)
- Michael T. Nygard, [Release It!: Design and Deploy Production-Ready Software](https://pragprog.com/titles/mnee2/release-it-second-edition/) - provides patterns on improving stability and reliability of software systems
- A follow up step from analysing critical capabilities and paths can be defining [Service Level Indicators (SLI) and Service Level Objectives (SLO)](https://cloud.google.com/blog/products/devops-sre/sre-fundamentals-sli-vs-slo-vs-sla)

_Credits: thanks to Willem for feedback on the draft post and [Patrick Vine](https://agilitymatters.wordpress.com/about/) for making me aware of the critical paths idea._

<aside>
<h3>Wondering about your critical paths?</h3>
<p>We offer architecture reviews and audits, to give you insights in your system's critical capabilities, critical paths, and risks.</p>
<p><a href="/contact">Let's start a conversation</a></p>
</aside>
