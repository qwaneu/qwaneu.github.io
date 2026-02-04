---
layout: post
title: Give your smurf a bad name
tags:
  - heuristics
  - design
  - domain driven design
author: Willem van den Ende, Marc Evers
image: /attachments/blogposts/2026/smurf.jpg
---

Choosing good names is one of the hard parts of our job as software developers. It's also a crucial part: names have a big impact on how well others (and our future selves) will be able to understand the code and change it.

"Choose a bad name to trigger better naming" is a heuristic we often use when programming, but it also works for prose, the ordinary language people use in speaking or writing. 

> Heuristic: choose a bad name to trigger better naming

In earlier times, Willem would choose swear words for names. It lightens the mood, when working alone, but is not conducive for group work. Calling it "smurf" is another option, making it obvious it needs a better name. 

Any name that is obviously off will do. It should be painful to look at, creating an irresistible urge in the reader to replace it with something meaningful. Calling an object a "...Manager" would be a bad name for us, but many developers are used to "Manager" classes in their code, so it will not be a very good trigger. "...Smurf" definitely is.

Using a bad name can also help to detach from a vague and possibly misleading initial name. If we need to model persons in our system who play different roles, it is tempting to start with a "Person" domain object. This becomes an attractor for anything related to persons, inflating the concept and introducing data that only has meaning in specific contexts at some points in time. But once we have called the thing "Person", it becomes hard to keep your mind open that it could evolve in something else, maybe multiple concepts. Calling it a Smurf helps detach from our initial thoughts

@@more concrete example of this would be helpful?

![Series of smurf hats](/attachments/blogposts/2026/smurfs.jpg)
{: class="post-image post-image-50" }

## Further reading

- We wrote about [naming tests](/2021/07/27/tdd-naming-tests.html).
- [System of Names on the C2 Wiki](https://wiki.c2.com/?SystemOfNames) describes a pattern about naming: *"people often make assumptions based on the object names alone"* and *"revise the names of your objects to reflect their ultimate roles"*
- Domain Driven Design's [Ubiquitous Language](https://www.jamesshore.com/v2/books/aoad1/ubiquitous_language) is broader than good names alone, but it starts with having good, unambiguous, shared names, for events, commands, domain objects, subdomains, bounded contexts.
- The example sentence of this definition of prose provide pause for thought:
