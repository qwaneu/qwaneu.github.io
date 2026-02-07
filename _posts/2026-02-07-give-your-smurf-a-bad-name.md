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

Choosing good names is one of the hardest parts of our job as software developers. It's also a crucial part: names have a big impact on how well others (and our future selves!) will be able to understand the code and change it.

"Choose a bad name to trigger better naming" is a heuristic we often use when programming, but it also works for prose, the ordinary language people use in speaking or writing. 

> Heuristic: **choose a bad name to trigger better naming**

In earlier times, Willem would choose swear words for names. It lightens the mood, when working alone, but is not conducive for group work. Calling it "smurf" is another option, making it obvious it needs a better name. 

Any name that is obviously off will do, urging the reader to replace it with something meaningful. Calling an object a *...Manager* would be a bad name for us, but many developers are used to Manager classes in their code. *...Smurf* works better.

Using a bad name can also help to detach ourselves from vague, misleading initial names. If our domain talks about locations, we are tempted to start out with a "Location" domain object. This becomes an attractor for anything location related: a location can be an organizational unit with employees joining and leaving over time, or a place where specific services are offered, or a unit of financial processing. While these different faces of "Location" overlap, they are not the same thing. 

Once we start calling something a "Location", it becomes hard to keep our minds open for alternative perspectives. Calling it a "Smurf" can help.

![Series of smurf hats](/attachments/blogposts/2026/smurfs.jpg)
{: class="post-image post-image-30" }

## Further reading

- We wrote about [naming tests](/2021/07/27/tdd-naming-tests.html) earlier, as part of our series on [unit testing & TDD heuristics](/blog-by-tag#tag-test-driven-development).
- [System of Names on the C2 Wiki](https://wiki.c2.com/?SystemOfNames) describes a pattern about naming: *"people often make assumptions based on the object names alone"* and *"revise the names of your objects to reflect their ultimate roles"*
- Domain Driven Design's [Ubiquitous Language](https://www.jamesshore.com/v2/books/aoad1/ubiquitous_language) is broader than good names alone, but it starts with having good, unambiguous, shared names, for events, commands, domain objects, subdomains, bounded contexts.
