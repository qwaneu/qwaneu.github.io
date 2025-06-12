---
title: Domain Driven Design - Advanced Topics
layout: other
summary: Tackling Complexity with Patterns and clear trade-offs
tags: [modelling, domain driven design, architecture, event storming]
---

Goal
--

Gain a deep understanding and hands-on experience of CQRS and Event Sourcing. From concepts to code.

Means
----
** TODO link to introducing DDD course**
Domain-driven design (DDD) connects stakeholders (including the users) through shared language. But the devil is in the details.  This course day connects architecture and implementation to an evolving model of the problem domain. 

While the Implementing DDD course makes a beginning with translating a domain model into code, this workshop goes a step further into two DDD architectural patterns that, when needed, can maintain a grip on complexity and support scaling an application: Command Query Responsibility Segregation (CQRS** and Event Sourcing.

**Command Query Responsibility Segregation (CQRS)** is a design pattern that separates the responsibilities of handling commands and queries in an application. CQRS can lead to improved scalability, performance and maintenance.

**Event Sourcing*** is about storing the history of an application's state as a sequence of events. Applying this pattern leads to storing events that have happened on an aggregate, and deriving the current state from the events. This approach results in a more robust and fault-tolerant system, as it provides a clear audit trail, makes it easier to recover from failures and facilitates reproducing faults when a system does not behave as expected.

Attendees perform hands-on exercises on both, and we will, as always, discuss trade-offs. For instance, Applying Event Sourcing and CQRS requires a higher initial investment. The benefits of e.g. replayable state or easier scaling must be worth it in a particular situation. Design patterns solve a problem in a context, and DDD patterns are no exception. If the context is not a good fit, don't apply the pattern.

Audience & prerequisites
---

Software developers, architects; this workshop is suitable both for junior developers who want to grow and for more senior developers who’d like to sharpen their skills. Programming experience is required for this workshop.

Prerequisites courses:
---
Introduction to Domain Driven Design
Implementing Domain Driven Design
