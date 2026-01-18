---
layout: post
title: On coupling and cohesion
tags:
  - architecture
  - design
author: Marc Evers
image: /attachments/blogposts/2026/dan-dennis-9ycXTLGNMro-unsplash.jpg
---

Recently, I saw two useful posts around coupling and cohesion:
- [I Still Feel the Urge to Reuse Code (Even Though I Know It's Wrong)](https://www.linkedin.com/pulse/i-still-feel-urge-reuse-code-even-th post ough-know-its-wrong-dilger-yphie/) by Martin Dilger
- [Cohesion, Modules, and Hierarchies](https://ewolff.com/2026/01/08/cohesion-modules-hierachies.html) by Eberhard Wolff

Both are worth a read.

![two coloured ropes tied together in a knot](/attachments/blogposts/2026/dan-dennis-9ycXTLGNMro-unsplash.jpg)

## Coupling and cohesion - vintage concepts

Coupling and cohesion are old concepts, still relevant; they aged well.

Independent of programming paradigm, procedural, OO, functional, low code, ...

What does coupling mean? 

How are coupling and cohesion actually two sides of the same coin?

Link to connascence

## Coupling is not binary

The connascence concept recognises degrees of coupling in three dimensions, which provides a richer language to reason about degrees of coupling and cohesion and how to manage these.

(losse post over connascence)
We hope to publish a post on connascence later this year.

(hier alleen de connascence heuristics noemen)

## Coupling vs stability/volatility

coupling is related to change and rates of change for different parts;

can be other parts a part depends on

also: changes from the domain/functionality/...

if a part is stable, any coupling does not matter

## Look ma no coupling!

We see a lot of claims that two parts have been decoupled. We think there is some nuance to that. 

Looking at Martin's example:
Not share the table but make a copy of the data, specifically only the attributes that are used.

WHat I Like: 
- reducing 'exposure' of one part to other, reducing accidental coupling - if A changes, it affects B even if B is actually not interested in the part that changes; makes the interface between the parts explicit

The coupling is reduced, but not removed

There still is coupling however! The 'exposure' is in this case reduced to id and title, but B then still is sensitive to changes in these parts. Practically, the id will probably be pretty stable, and the title as well, so the remaining coupling will be minimal.

## Events = decoupled, or maybe?

Two services exchange events asynchronously. This is often called 'decoupled'.

A -> event -> B

In this case, coupling is not binary; there is more nuance (and trade-offs) to it

We achieved decoupling in time; decoupling in reliability (A's availability does not depend on B's availability and the other way around)

There is still coupling:
- depend on the event format (which is in fact a public API of A); this is the same as for a REST API. This form of coupling is well-manageable, e.g. through contact testing, API versioning, API deprecation agreements.
- depend on the semantics of the event - how should the event be interpreted? This coupling is more subtle; can lead to some duplicated logic in A and B that is coupled i.e. if A changes, B needs to be updated as well. 
 
If B constructs objects/entities/data structures from the event for example
Would it be better then to send events + whole object? This makes the exposure of A to B larger, more fragile

## How Hexagonal Architecture (de)couples

(losse post?)
hex arch: separate concerns

there is still coupling; coupling is however explicitly mapped through adapters

this is a trade-off; it sometimes feels like for a feature you need to do a series of changes cross the hex arch (price to pay); benefit: you can do these changes in a highly controlled way, in baby steps;  

## Further reading 

- Connascence artikel
- Connascence - boek
- Vlad Khononov wrote a book on [Balancing Coupling in Software Design](https://vladikk.com/page/books/); it's still on my to-read list

<em>Credits: photo © 2020 by <a href="https://unsplash.com/@cameramandan83?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Dan Dennis</a> on <a href="https://unsplash.com/photos/brown-rope-on-blue-wooden-table-9ycXTLGNMro?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></em>
      

<aside>
<h3>TBD</h3>
<p>Explore coupling and cohesion through a hands-on workshop
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
