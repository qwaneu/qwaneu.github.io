---
layout: post
title: "Connascence: Timing (part 7)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: 
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning, position, algorithm, and execution order. In this post, we will discuss Connascence by Execution Order.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Timing

Connascence by Timing means that two elements are coupled because they need to agree on timing.

![connascence by timing](/attachments/blogposts/2026/connascence/slide-13-timing.png)

An example: a producer produces data, a consumer processes the data, both work concurrently and asynchronously. This can be multiple threads or separate services. How do we ensure each produced value is consumer once and only once?

![a producer and consumer that exchange a value asynchronously](/attachments/blogposts/2026/connascence/producer-value-consumer.jpg)

There are different patterns and mechanisms to handle a timing dependency like this. We can use probes, semaphores, locks, promises, observables.

Alternatively, we can relax the exactly once constraint to at least once and reduce the timing coupling. This reduces synchronisation complexity, in particular for failure scenarios, but it puts a higher burden on the consumer: the consumer needs to be able to handle duplicate values. Idempotency of messages or commands can help here.

What if there is a single producer and multiple consumers, and we need to make sure each value is read exactly once, by exactly one consumer?

![single producer, multiple consumers](/attachments/blogposts/2026/connascence/queue-overtaking-2.png)

When a consumer starts reading a value, it can create a lock to ensure it is the only one reading at that moment.

![single producer, only one consumer reads at a time](/attachments/blogposts/2026/connascence/queue-overtaking-3.png)

@@Alternatively, we can partition the data, so each consumer has its own part of the data to consume. 

One particular situation where we suffer from Connascence by Timing, is in automated end-to-end testing, in particular with browser-based tests. It takes time for the system under test to process changes and make these visible, and frontend applications in particular have all kinds of asynchronous parts. Probes help a lot here and end-to-end testing frameworks like [Playwright](https://playwright.dev/) are getting better at handling timing and asynchronous behaviour in a simple way.

## Eventual consistency

We can sometimes be less strict in agreeing on timing, and settle for data being eventually consistent. Eventual consistency gives more options for the different parts of the system to eventually (within milliseconds or maybe even seconds) settle on a change.

Whether or not eventual consistency can be used is a business decision: often, having an inconsistent state for a short amount of time is good enough and it is not worth adding the complexity of tightening consistency constraints. If I transfer money with my banking app, I often see the old balance for a second in the app until the transfer is processed, which is good enough.

![single producer, only one consumer reads at a time](/attachments/blogposts/2026/connascence/eventual-consistency.jpg)

There are trade-off here. For example, eventual consistency makes it more complicated to detect that something did _not_ happen. Explicit queries at some time are needed for instance, whereas a timeout, optionally with a back-off algorithm is _relatively_ simple.

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Value, where two elements need to agree on a specific value.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm]()
- [Part 6 - Connascence by Execution Order]()
- *Part 7 - Connascence by Timing*
- Part 8 - Connascence by Value
- Part 9 - Connascence by Identity
- Part 10 - Heuristics for managing coupling

<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer hands-on workshops about connascence and refactoring towards loosely coupled, highly cohesive systems.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
