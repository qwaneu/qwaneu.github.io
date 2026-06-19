---
layout: post
title: "Connascence: Heuristics for managing coupling (part 10)"
tags:
  - architecture
  - coupling
  - design
  - heuristics
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: 
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated the different types of connascence. In this post, we will discuss how to use this model to manage coupling in software and share a number of heuristics.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Managing coupling and cohesion with the connascence model

How can the connascence model help us in refactoring towards loosely coupled, highly cohesive code? In this section, we will discuss a set of refactoring guidelines based on the three dimensions of connascence.

Jim Weirich provided some rules of thumb to guide refactoring towards less coupling:

- Rule of Strength
- Rule of Locality
- Rule of Degree
- Rule of Stability

### Rule of Strength

The Rule of Strength states: try to create weakest possible connascence. 

Convert strong forms of connascence to weak forms wherever possible. Try to refactor towards static rather than dynamic connascence. Encapsulate for example connascence by identity and by value as much as possible in a module, so that the rest of the code base has connascence by type.

### Rule of Locality

As the distance between software elements increases, use weaker forms of connascence. If things are close together, stronger connascence is ok. 

So if you cannot reduce strong connascence to a weaker form, try bringing the elements as close together as possible.

### Rule of Degree

Elements with a high degree of connascence are more difficult to understand and to change. So investigate:
- Why is the degree high?  
- Are we missing an abstraction?  
- Would an extra level of indirection be helpful here?

### Rule of Stability

If two element have a strong form, low locality and high degree of connascence, then they should not change. In other words, those elements should be stable.

Remember that coupling is about things that need to change together. So if things don't need to change, we won't be affected. 

As an example, the `sprintf` in C is widely used so there is a very high degree of connascence. The function is also stable, so the risk is very low.

### Managing connascence with testing, automation and tools

We can try to reduce stronger forms of connascence as much as possible, but sometimes we are left with some dynamic connascence across codebases and across systems that will bite us sooner or later.

Automated testing can help. If we have specific values across the system landscape, we can capture this in some end-to-end test or in local, faster tests that document the value and fail whenever we change the value.

@@ +contract testing

@@test = creates more explicit (weaker strength) coupling to the two dependent elements; [add triangle picture]
test is a piece of explicit knowledge

### Detecting connascence

We mentioned earlier that the static forms of connascence (name, type, meaning, position, algorithm) can often be detected using a compiler or static analysis tools. 

Dynamic connascence is harder to catch, but version control systems can provide insights. We can analyse the git history of the code to see what parts are often changed together, a strong hint these might be coupled somehow. 

Analysing git history can also provide insights in what parts of our code are changing a lot and what parts are stable, to know where to focus on.

### Example 1

*If we put a queue between two components, have we 'decoupled' them?*

We have reduced **Connascence of Timing**, but we still have **Connascence of Algorithm** & **Meaning**

### Example 2

*Do we avoid coupling by duplicating some code instead of introducing a shared abstraction?*

We still have **Connascence of Meaning**, but the coupled elements are not
localized. We risk achieving the opposite of what we intend: even stronger coupling!

## Summary

We want 'loose coupling'. But without coupling, there is no working software. Managing coupling is an important part of our work. 

Connascence offers a language to talk about coupling and cohesion. It is not bound to a specific paradigm and applies equally to object oriented programming, functional programming, SQL, stored procedures.

Coupling is not binary! The connascence model offers three dimensions to reason about coupling: **strength**, **locality**, **degree**. 

We want to isolate strong coupling as much as possible in one place, and use weaker forms of coupling when the distance and/or degree is high.

The connascence model is not perfect. The distinction between the types is not always clear. The distinction between connascence by meaning and connascence by value is sometimes a bit diffuse. The ranking of the different types (the strength) is not always that strict in practice.

This model is still quite useful in practice, because:
- It gives a rich vocabulary to reason about forms, degrees and locality of coupling.
- It recognises that the goal is not getting rid of coupling, but rather keeping coupling explicit, limited, and manageable.
- 
## Further reading 

- [I Still Feel the Urge to Reuse Code (Even Though I Know It's Wrong)](https://www.linkedin.com/pulse/i-still-feel-urge-reuse-code-even-though-know-its-wrong-dilger-yphie/) by Martin Dilger
- Another good read from this year is [Cohesion, Modules, and Hierarchies](https://ewolff.com/2026/01/08/cohesion-modules-hierachies.html) by Eberhard Wolff
* Meilir Page-Jones, Fundamentals of OO Design in UML (1999)
* Meilir Page-Jones, [Comparing Techniques by Means of Encapsulation and Connascence](https://dl.acm.org/doi/10.1145/130994.131004), in Communications of the ACM Sept 1992 
* Jim Weirich, [The Grand Unified Theory of Software Design](www.youtube.com/watch?v=NLT7Qcn_PmI), at the Acts as Conference 2009  
* [Connascence.io](https://connascence.io)
* Vlad Khononov, [Balancing Coupling in Software Design](https://vladikk.com/page/books/) (2024)

## @@ bla

This post is part of a series on connascence and coupling. 

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm](/2026/06/03/connascence-algorithm)
- [Part 6 - Connascence by Execution Order](/2026/06/08/connascence-execution-order)
- [Part 7 - Connascence by Timing](/2026/06/12/connascence-timing)
- [Part 8 - Connascence by Value](/2026/06/17/connascence-value)
- *Part 9 - Connascence by Identity*
- Part 10 - Heuristics for managing coupling
      
<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer hands-on workshops about connascence and refactoring towards loosely coupled, highly cohesive systems.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
