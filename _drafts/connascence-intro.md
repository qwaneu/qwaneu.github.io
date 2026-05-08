---
layout: post
title: "Connascence: a model for reasoning about coupling (part 1)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence-visualised-2.jpg
---

In this post, we will introduce Connascence, a model that describes coupling and cohesion in multiple dimensions. This model gives you an energy label to determine how energy efficient your coupling is.

Coupling is unavoidable. But you have to choose what kind of coupling is a good fit where. Connascence provides a fine-grained model to reason about different forms and degrees of coupling. It provides options to reduce coupling and improve cohesion. We find it provides a useful perspective on coupling, in addition to other ones. 

It does not make sense to just remove all coupling. As we stated in the [previous post about coupling](/2026/01/23/on-coupling):

> Without coupling, there is no working software.

We accept coupling and deliberately decide the trade-offs. We make it explicit and manageable. We keep parts that are tightly coupled by nature closely together, increasing cohesion. For parts that are coupled but less tightly, we make sure coupling is as explicit as possible, aided by tooling and automated tests.

This post is the first of a series of posts on Connascence. So what lies ahead? We will first introduce the connascence model and give an overview of its three dimensions. In the next posts, we will elaborate the different types of connascence. Finally, we will discuss how this can help in managing coupling and how it helps in knowing where to refactor to.

## Connascence defined 

The concept of Connascence was introduced by Meilir Page-Jones in [his work on object-oriented design](https://dl.acm.org/doi/10.1145/130994.131004) in the 1990s. He observed that coupling and cohesion are closely related and tried to catch them both using a new term:

> I chose the word "connascence" from the Latin roots meaning "born together." It is etymologically close to the French "connaissance" meaning knowledge, awareness or consciousness.
> 
> An undertone of this meaning is "having intertwined destinies in life."
>
> -- Meilir Page-Jones

>Two software elements are connascent if:
>
> **a change in one would require the other to be modified to maintain the overall correctness of the system**
>
> or
>
> **for some change, both would be required to change to maintain the overall correctness of the system.**

A software element can be a function, a class, database table or schema, a package, a component, an application, a (micro)service, a subsystem. The picture below illustrates this definition of connascence. It shows two elements, both of them consisting of smaller parts, e.g. classes and functions:

![Schematic visualization of two software elements and their parts (modules, classes, functions, types)](/attachments/blogposts/2026/connascence/connascence-visualised-1.jpg)
{: class="post-image post-image-70" }

We can visualize elements that need to change together by connecting them with red lines:

![Schematic visualization of coupling between different parts of two software elements using red lines to connect parts that are coupled](/attachments/blogposts/2026/connascence/connascence-visualised-2.jpg)
{: class="post-image post-image-70" }

This definition of connascence (and coupling) is already useful on its own. It shifts our focus from dependencies to elements that need to be kept consistent with each other. 

It makes conversations about duplication more pragmatic: removing duplication is not about extracting identical pieces of code, but rather about putting things together that need to change together. Code similarity is an indicator for possible coupling, not something that must be refactored.

## Dimensions of Connascence

Connascence introduces three dimensions to reason about coupling and cohesion:

1. **Strength** - how easy or difficult is it to detect coupling and manage changes in coupled elements;
2. **Locality** - the distance between two coupled elements;
3. **Degree** - the number of elements that are coupled.

### Strength

The 9 types of connascence are, in order of increasing *strength*:

1. **Name** - two elements need to agree on the same name;
2. **Type** - two elements need to agree on the same type;
3. **Meaning**  - two elements need to agree on the meaning of particular values;
4. **Position** - two elements need to agree on the order of values;
5. **Algorithm** - two elements need to agree on a shared algorithm or protocol;
6. **Execution Order** - two elements need to agree on the order in which steps are executed;
7. **Timing** - two elements need to agree on timing;
8. **Value** - two elements need to agree on a specific value;
9. **Identity** - two elements need to agree on the identity of something - they need to make sure they use the same thing.

We can visualize this from green to red, as a kind of energy label for coupling:

![9 types connascence from weak to strong, from green to red](/attachments/blogposts/2026/connascence/slide-15-identity.png)
{: class="post-image post-image-70" }

The first five are called *static* connascence, because these can usually be detected from the code, using a compiler or static code checks. The other types are called *dynamic* &mdash; they are related to the dynamic behaviour of the code.

![9 types of connascence with 5 static and 4 dynamic types](/attachments/blogposts/2026/connascence/slide-16-dynamics.png)
{: class="post-image post-image-70" }

The static types of connascence, in particular Name, Type and Meaning, are the most explicit forms of coupling. The stronger types of connascence are more implicit.

### Locality

The *Locality* dimension of connascence refers to the distance between two coupled elements. The higher the distance, the more difficult it is to detect the coupling. Especially when the elements are in different applications, code bases or systems, the coupling becomes quite implicit and hard to manage.

Vlad Khononov's Balanced Coupling model mentions "socio-technical distance", which is a useful addition. If two elements are not only far apart but also owned by different teams, the impact of coupling will be higher. If the teams are part of different organisations, it will be even worse.

### Degree

The *Degree* dimension of Connascence refers to the number of elements that are coupled, i.e. the number of elements that are affected by a specific change. More elements means more work, and a higher chance of missing one element when updating.

Adding a layer of indirection by introducing a stable abstraction helps to reduce the impact of changes, by isolating the part that changes and making the rest more stable, at the cost of some extra complexity.

![left part showing 5 elements having 'bad' coupling with red lines, right part having a new element in between, decoupling the stable part from the volatile part](/attachments/blogposts/2026/connascence/managing-degree-with-abstraction.jpg)
{: class="post-image post-image-70" }

## Putting it all together

The picture below puts everything together. The Connascence model allows to reason about coupling with the three dimensions of strength, locality and degree.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-70" }

## Related work

[Coupling](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) and [cohesion](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) are very old concepts in software development since the beginning. The concepts were introduced by Larry Constantine in the 1960s, and several people have tried to refine them and make them measurable.

The Connascence model dates back to the 1990s when Meilir Page-Jones wrote his books about object oriented modelling. He identified coupling and cohesion as being the same thing.

A recent addition is Vlad Khononov's Balanced Coupling model, described in his [book](https://coupling.dev/posts/learning-resources/) and on the [Balanced Coupling website](https://coupling.dev/). Khononov's model has some overlap with connascence. He defines three slightly different dimensions of coupling:

1. **Integration Strength** - comparable but with a slightly different angle than connascence strength;
2. **Distance** - what is coupled: methods, objects, packages, services, systems;
3. **Volatility** - how stable or volatile are the different coupled elements.

The volatility (or stability) of elements is referenced in the Connascence model but it does not define it as a dimension. It is a useful addition to consider explicitly, because coupling is about changing elements together. When things don't have to change, coupling is not an issue.

## Further reading 

- [I Still Feel the Urge to Reuse Code (Even Though I Know It's Wrong)](https://www.linkedin.com/pulse/i-still-feel-urge-reuse-code-even-though-know-its-wrong-dilger-yphie/) by Martin Dilger
- Another good read from this year is [Cohesion, Modules, and Hierarchies](https://ewolff.com/2026/01/08/cohesion-modules-hierachies.html) by Eberhard Wolff
* Meilir Page-Jones, Fundamentals of OO Design in UML (1999)
* Meilir Page-Jones, [Comparing Techniques by Means of Encapsulation and Connascence](https://dl.acm.org/doi/10.1145/130994.131004), in Communications of the ACM Sept 1992 
* Jim Weirich, [The Grand Unified Theory of Software Design](www.youtube.com/watch?v=NLT7Qcn_PmI), at the Acts as Conference 2009  
* [Connascence.io](https://connascence.io)
* Vlad Khononov, [Balancing Coupling in Software Design](https://vladikk.com/page/books/) (2024)


## All parts in this series 

This post is a first of a series about Connascence and coupling.

- Part 1 - Introduction
- Part 2 - Connascence by Name and Type
- Part 3 - Connascence by Meaning
- Part 4 - Connascence by Position
- Part 5 - Connascence by Algorithm
- Part 6 - Connascence by Execution Order
- Part 7 - Connascence by Timing
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
