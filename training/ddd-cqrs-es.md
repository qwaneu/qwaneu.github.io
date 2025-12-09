---
title: CQRS & Event Sourcing
layout: training-description
summary: Tackling complexity through CQRS and Event Sourcing with clear trade-offs
tags: [modelling, domain driven design, architecture, event storming]
---

Domain Driven Design (DDD) connects stakeholders - users, business, developers - through shared language, connecting architecture and implementation to an evolving model of the problem domain. 

In [Introducing DDD](/training/ddd-introduction.md), we introduce DDD and its main modelling patterns and practices and our [Implementing DDD](/training/implementing-ddd) course covers translating a domain model into code. This course goes a step further and zooms in on two DDD architectural patterns that can help maintaining a grip on complexity and supporting scaling an application: Command Query Responsibility Segregation (CQRS) and Event Sourcing.

**Command Query Responsibility Segregation (CQRS)** is a design pattern that separates handling commands and queries in an application. CQRS can lead to improved scalability, performance and maintenance.

**Event Sourcing** means storing the history of an application's state as a sequence of events. Instead of storing an aggregate's state, the state is dynamically derived from the events that have happened. This enables a more robust and fault-tolerant system. It also provides a clear audit trail, making it easier to recover from failures and facilitating reproducing faults when a system does not behave as expected.

## Goal

In this course, you will delve into CQRS and Event Sourcing, from concepts to code. Through a combination of theory and hands-on exercises, you will learn how to apply these patterns, including:

- separate write models and read models;
- create meaningful APIs;
- implement Event Sourcing to store events instead of current state;
- handle domain model evolution and versioning;
- optimize performance and concurrency control;
- create a view derived from an event journal.

By the end of this course, you will have a deep understanding of CQRS and Event Sourcing, including benefits, trade-offs and applicability of these patterns. You will be able to apply these concepts to your own projects to improve maintainability, scalability, and performance.

## Means

Through a mix of theory, hands-on programming exercises, and discussion, we will cover the patterns and their trade-offs. Applying Event Sourcing and CQRS requires for instance a higher initial investment. The benefits, e.g. replayable state or easier scaling, must be worth it in a particular situation. 

## Audience & prerequisites

Software developers, architects. This workshop is suitable both for junior developers who want to grow and for more senior developers who’d like to sharpen their skills. Programming experience is required for this workshop.

Prerequisites: participants should be familiar with DDD and its main patterns and they should know how these different patterns can be implemented in code. 
This is covered by these workshops:

- [Introduction to Domain Driven Design](/training/ddd-introduction.md)
- [Implementing Domain Driven Design](/training/implementing-ddd)

## Practical information

* Duration: 1 or 2 days
* Laptops required
* This training is available as in-house training only.

[Please contact us for registration](/contact)
