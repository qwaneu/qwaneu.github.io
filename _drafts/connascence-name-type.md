---
layout: post
title: "Connascence: Name and Type (part 2)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/slide-6-type-example.png
---

In the [previous post](/2026/05/08/connascence-intro), we introduced the Connascence model for coupling and cohesion. Connascence defines three dimensions of coupling: strength, degree and distance. In this post, we will discuss the weakest (and most explicit) types of connascence: **Name** and **Type**.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Name and by Type

Two elements are connascent by Name or Type if they must agree on the same name or type. If a function is called `foo`, the calling code must use the same name. Renaming the function means changing the calling code. The same holds for types. Code using a type (e.g. class) must change if the type changes.

![connascence by name and type](/attachments/blogposts/2026/connascence/slide-6-type-example.png)

Connascence by Name or Type is very explicit. The compiler or interpreter will provide feedback if we forget a change somewhere. Automated refactoring tooling makes this kind of coupling often easy to manage.

```java
class Bar {
  void foo() { ... }
}

var bar = new Bar();
bar.foo();
```

The *locality* of coupling impacts the effort and risk in managing coupling. If the elements are all in the same code base, our tooling will do most of the work, and the risk will be minimal. 

If the distance between two coupled parts is higher, e.g. a class `Customer` with attributes `name` and `address` in our code which should match our database table `Customer` with columns `Name` and `Address`. Extra tool support can help her, e.g. using an adapter integration test that covers the database integration.

![a representation of a database table CUSTOMERS with columns NAME and ADDRESS with should correspond to a class Customer with properties Name and Address](/attachments/blogposts/2026/connascence/name-table.png)
{: class="post-image post-image-70" }

## Refactoring Connascence by Name and Type

If the distance between the coupled elements is not too high (e.g. in the same codebase), the compiler or interpreter will help us catch mistakes. We want to keep it like it is. Connascence by Name or Type is often the endpoint of refactoring and not something to refactor away from. Trying to refactor away from name and type coupling will make the coupling more implicit and more painful. 

For elements further apart, we can try to move them closer together. For name coupling between code and database, our ORM library or [automated adapter integration tests](/2020/09/17/test-architecture.html#adapter-integration-tests) can help.

## What is next

In the next post, we will focus on Connascence by Meaning, where two or more elements need to agree on meaning.

## All parts in this series 

This post is a first of a series about Connascence and coupling.

- Part 1 - [Introduction](/2026/05/08/connascence-intro)
- Part 2 - *Connascence by Name and Type*
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
