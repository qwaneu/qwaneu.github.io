---
layout: post
title: Architecture views - critical paths
tags:
  - architecture
  - coupling
  - design
  - quality attributes
  - ports and adapters
author: Marc Evers
image: 
---

A useful perspective in systems & software architecture is looking at what the critical capabilities and critical paths - how those capabilities are realized in the system architecture. This perspective helps to ask important questions e.g. about risks, quality requirements, and identify useful measures to guarantee critical capabilities.

# Architecture (bit of broader context)

Architecture = multiple perspectives, multiple views; different views help answer different questions

Systems of systems 

Systems realize capabilities - matching our users/stakeholders needs

needs consist of functions (what. 'use cases') + qualities (how well, e.g. how available, responsive, correct, consistent); 

# Critical paths 

Critical paths = critical capabilities that the systems offers and how these map onto the systems architecture

critical capabilities are tied to user needs. Systems offer different capabilities, but these are not all as important. 
is about both functions and qualities - how well the system supports those functions
e.g. what needs to be always available? or always consistent / correct (or: where the consequences of inconsistency, incorrectness, unavailability would be problematic)
@@concrete voorbeelden zou handig zijn; 
voorzichtig met Nedap voorbeelden:
- health report; accessing/available for reading/ is crucial, writing less (as fallback can write some notes and enter it later; not same quality, not desirable, but can work)
- agenda for employees (care providers, or: sales people?): knowing where to go (availability for reading) at start of day is crucial, writing less (assuming that most appointments are made some time in advance)
- resuscitation policy
- (ZorgDomein) finding care (vs being able to update the care a hospital offers)

# Critical paths view

Investigating how critical capabilities are realized by the system helps evaluating / find improvements / find risks

Especially when we work with systems of systems; this most systems; a multi-services landscape + integrate with multiple off-the shelf systems and external services.
But also for monolithic applications

# some (abstract) examples 

Example 1: a system with a frontend application, a backend service 1 that calls backend service 2; backend service 2 stores its data in a database. All dependencies between services are synchronous.

![simple application landscape with a user, a frontend, a backend service that uses another backend service, and a database](/attachments/blogposts/2026/criticalpaths-1.jpg)

We can depict a critical path by drawing a (red) line through the services that are involved in realizing the critical path. In this example, the critical path goes from frontend through both services and the database.

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-2.jpg)

Example 2: a system with an intake part, consisting of a frontend and a backend system, which puts data on a message bus (asynchronously). The processing part consumes the data from the bus and presents it via the second frontend.

![application landscape with a user, a frontend, an intake backend service that uses a bus to exchange data with a processing backend service, and a second frontend](/attachments/blogposts/2026/criticalpaths-3.jpg)

If the critical path is about end-to-end latency (making processed data available within limited time bounds), we can visualize this:

![visualization of a critical path as a red line that crosses the different services](/attachments/blogposts/2026/criticalpaths-4.jpg)

Example 3: we can also zoom in a bit on how things flow through services, in particular to see what mappings and transformations take place. The picture below shows a simple application landscape with a frontend, a backend that is structured according to [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html), and a database.

![application architecture with a frontend, backend and database, where the backend is structured according to hexagonal architecture](/attachments/blogposts/2026/criticalpaths-hex-1.jpg)

A critical path usually touches frontend, backend and database, as depicted below. We can also make the points where data is transformed / mapped explicit (here shown by the double arrows). These points are relevant e.g. from a data correctness perspective.

![visualization of a critical path as a red line that crosses the different services, with symbols indicating where data is mapped](/attachments/blogposts/2026/criticalpaths-hex-2.jpg)

# What questions does this view help to ask?

- correctness: what data mappings and transformations take place? how do you guard correctness? e.g. with a mix of automated tests
- (example 1) the services call each other directly, synchronously; the availability of the capability as a whole is a function of the availabilities of the different parts involved; without additional stuff, the availability of the critical path will be less than the lowest availability of the involved parts
- using async buses or queues changes the trade-offs, e.g. quicker responses vs longer inconsistency windows
- what fallback options are available? (example 1) if the 2nd service is down, service 1 could use a cached value or a default value (trading availability for consistency); this degrades quality of the capabilities; what is still acceptable?
- (example 2) the 'intake' of data is decoupled from availability of the processing part; what if the processing part is (temporarily) unable to keep up with the data? this affects the critical path - what is still acceptable? (put queue monitoring in place for early detection); we can scale out the processing part if necessary
- 'auditability' - if correctness is critical, how can we proof what happened at each step / part?
- Are the different parts that are involved owned by a single team or multiple teams? Guaranteeing critical capabilities across team boundaries can become more difficult, especially when teams have different goals.

## References

- Michael T. Nygard, [Release It!: Design and Deploy Production-Ready Software](https://pragprog.com/titles/mnee2/release-it-second-edition/) - provides patterns on improving stability and reliability of software systems
- 

<aside>
<h3>Want to do stuff?</h3>
<p>Pitch our architecture services here</p>
<p><a href="/contact">Learn more about our courses</a></p>
</aside>
