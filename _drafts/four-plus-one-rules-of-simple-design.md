---
layout: post
title: The 4 plus 1 Rules of Simple Design
tags:
  - productivity
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers, Willem van den Ende
image: 
---

How to keep the design of your code simple? We strive for simple code. It is something we pay attention to in the Refactoring step of the Test Driven Development cycle. But what is 'simple'? How do we stay away from discussion about taste or "simplicity is in the eye of the beholder?". 

Kent Beck introduced the Rules of Simple design, a heuristic consisting of a set of 4 ordered rules that focus on what "simple" means for the design of code.Based on our experience, we have added a fifth rule to make the heuristic more context-aware.

## The four rules of Simple Design

The Rules of Simple design state that the design of our code should satisfy these rules, in order of priority:

```
1. passes all tests
2. reveals intention
3. contains no duplication 
4. has fewest elements
```

**Passes all tests** - we only refactor on green tests, so if tests are failing, we first fix these.

**Reveals intention** - our code is not just a solution but it is also a means of communication between developers (and between you and future you). Being understandable is key to sustainable delivery. We want our code to express all intentions explicitly in using the constructs that our programming languages offers us (classes, methods, variables). Because we often only really understand our problem once we have written the solution, refactoring is essential for putting in the code all the things that we learned.

**Contains nu duplication** - duplication means that the same concept is expressed in multiple places in our code. As a result, there is coupling between these pieces of code - if we change one location, the others should be changed as well. Especially if the coupling is implicit, it will introduce defects sooner or later. This rule is about making sure that every relevant concept has a single place in the code. It is not about literal duplication but about (implicit, hidden) coupling.

**Has fewest elements** - once the tests pass, we have expressed all relevant intentions and there is no duplication, we try to minimize the elements - classes, functions, methods, types, ...

## Something special about rule 2 & 3

At first sight, revealing intention and no duplication look like two different things, but they are actually two sides of the same coin. This is expressed by the **Once And Only Once (OAOO)** principle from Extreme Programming.

Once And Only Once means that every relevant concept needs to have its place in the code (it should have a place at least once) and that concept should not be duplicated - it should be expressed only once, in a single place.

This not only helps make code explicitly communicate its intent, but also makes it predictable, in the sense that know where to find things and you can be sure that that place is the only place where to look. It helps in deciding [what to put where](/2020/12/23/what-to-put-where) and what to find where.

## The fifth rule

Having worked with many different teams and developers of different background and experience levels, we have added a fifth rule: 

```
5. the code should be at an abstraction level the whole team can understand
```

We have worked in multiple teams where a few highly experienced developers wrote dense code at a high level of abstraction. This is not a bad thing per se, but in those cases the more junior developers did not have the experience level to work with the resulting code. This is particularly relevant when external developers join the team for a limited time period. The code they leave behind should be manageable by the remaining team.

@@something about habitability of code

## Further reading

- Martin Fowler has a [good description of the Beck Design Rules](https://martinfowler.com/bliki/BeckDesignRules.html)
- The source of these rules is the Simple Design practice as described in *eXtreme Programming Explained 1st edition* (p. 57): "Every piece of design in the system must be able to justify its existence on these terms."
- A [discussion about Once And Only Once on the C2 Wiki](https://c2.com/xp/OnceAndOnlyOnce.html)
- Debasish Ghosh, [Habitability and Piecemeal Growth](https://debasishg.blogspot.com/2006/02/habitability-and-piecemeal-growth.html), some ruminations on Richard Gabriel's concept of habitability of software

<aside>
<h3>Let's keep things simple</h3>
<p>Let's explore together how you can apply Simple Design in your code base, for instance through a coding dojo or training course.
</p>
<div>
<a href="/contact">Talk to us</a>
</div>
</aside>
