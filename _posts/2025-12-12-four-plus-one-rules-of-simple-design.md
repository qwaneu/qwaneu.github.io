---
layout: post
title: The 4 plus 1 Rules of Simple Design
tags:
  - productivity
  - feedback 
  - refactoring
  - test driven development
  - systems thinking
author: Marc Evers, Willem van den Ende
image: 
---

We strive for simple code. It is something we pay attention to in the Refactoring step of the Test Driven Development cycle. But what is "simple"? How do we stay away from discussions about taste or "simplicity is in the eye of the beholder?".

In his original eXtreme Programming Explained book, Kent Beck introduced the **Rules of Simple design**, a heuristic consisting of a set of 4 ordered rules that focus on what "simple" means for the design of code. 

Based on our experience, we have added a fifth rule to make the heuristic more context-aware. Willem came up with the fifth one a while back, and posted it on a social media platform. This lead to a lively discussion. One could consider that rule 5 is a special case, or an acceptance criterion of rule 2. What do you make of that? We'd appreciate your feedback.

We've found the added emphasis on the readers and later editors of the code useful over the years.

## The four rules of Simple Design

The Rules of Simple design state that the design of our code should satisfy these rules, in order of priority:

```
1. passes all tests
2. reveals intention
3. contains no duplication 
4. has fewest elements
```

**Passes all tests** &mdash; we only refactor on green tests, so if a test is failing, we first fix it.

**Reveals intention** &mdash; our code is not just a solution for now, but also a means of communication with other developers (including future you). Being understandable is key to sustainable delivery. We want our code to express all intentions explicitly, by using the constructs that our programming languages offers us (classes, methods, functions, types, variables). Often, we only really understand our problem once we have written the solution, so refactoring is essential for putting everything we learned in the code.

**Contains no duplication** &mdash;duplication means that the same concept is expressed in multiple places. This introduces coupling between these parts - if we change one, the others should be changed as well. Especially if the coupling is implicit, it will introduce defects sooner or later. This rule is not about literal duplication, but about (implicit, hidden) coupling. Make sure that every relevant concept has a single place in the code. 

**Has fewest elements** &mdash; once the tests are passing, we have expressed all relevant intentions and there is no duplication, we try to minimize the elements &mdash; classes, functions, methods, types.

## Something special about rule 2 & 3

At first sight, revealing intention and no duplication look like two different things, but they are actually two sides of the same coin. This is captured by the **Once And Only Once (OAOO)** principle from Extreme Programming.

Once And Only Once means that every relevant concept needs to have its place in the code (*at least once*) and that the concept should not be duplicated; it should be expressed in a single place (*only once*).

This not only helps make code explicitly communicate its intent, but also makes it predictable.,Everyone knows where to find things and we can be sure that this is the only place where to look. It helps in deciding [what to put where](/2020/12/23/what-to-put-where) and what to find where.

## The fifth rule

Having worked with many different teams and developers of different background and experience levels, we have added a fifth rule: 

```
5. the code should be at an abstraction level the whole team can understand
```

We have worked in multiple teams where a few highly experienced developers wrote dense, highly abstract code. This is not a bad thing per se, but in those cases the more junior developers did not have the experience level to work with the resulting code. This is particularly relevant when external developers join the team for a limited time period. The code they leave behind should be manageable by the rest of the team.

Willem was confronted with this, when working in a team, where in order to ship, the code had to be significantly less abstract than what he was used to. Getting an appreciation from a teammate on a tiny abstraction with documentation was great, and also a bit confusing. Somebody noticed, and it was just the right abstraction, revealing intent to everyone. 

There is a strong relation here with Richard Gabriel's notion of **habitable software**, from his book [Patterns of Software](https://www.dreamsongs.com/Files/PatternsOfSoftware.pdf) (PDF):

> What are some of the things that contribute to uninhabitable programs? Over-use of abstraction and inappropriate compression come to mind. 

The discourse that follows this quote is worth (re-)reading. As sense of ownership of a program's code and design can be directly correlated to how comfortable everyone involved finds it to work with.

*So what do you think. 5th rule, or rule 2a?*

## Further reading

- Martin Fowler has a [good description of the Beck Design Rules](https://martinfowler.com/bliki/BeckDesignRules.html)
- The source of these rules is the Simple Design practice as described in *eXtreme Programming Explained 1st edition* (p. 57): "Every piece of design in the system must be able to justify its existence on these terms."
- A [discussion about Once And Only Once on the C2 Wiki](https://c2.com/xp/OnceAndOnlyOnce.html).
- Debasish Ghosh, [Habitability and Piecemeal Growth](https://debasishg.blogspot.com/2006/02/habitability-and-piecemeal-growth.html), ruminations on Richard Gabriel's concept of habitability of software
- [Care about habitable code, and how to achieve it](https://bluefruit.co.uk/quality/care-about-habitable-code-how-achieve/) in embedded software, by Emily. No reference to Richard Gabriel, but does include some specific suggestions.
- Mathias Verraes wrote a post about duplication and the "Don't Repeat Yourself" (DRY) principle: [DRY is about Knowledge. Code duplication is not the issue](https://verraes.net/2014/08/dry-is-about-knowledge/)
- [The wet codebase](https://www.deconstructconf.com/2019/dan-abramov-the-wet-codebase) by Dan Abramov (of React); he talks about the benefits and costs of abstraction: *"It is hard to explain all the trade-offs to then next generation, they don't have the context to decide when it is a bad idea. (...) When we teach something to the next generation we should explain what are the benefits, and what we are trading away."*
  
*Updated on 5 January 2026:*
- *added references, a link to Mathias Verraes's post on DRY and a link to Dan Abramov's post on Wet codebase*

<aside>
<h3>Let's keep things simple</h3>
<p>Let's explore together how you can apply Simple Design in your code base, for instance through a coding dojo, hands-on course or us working with you on your system.
</p>
<p>
<a href="/contact">Talk to us</a>
</p>
</aside>
