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

In the [previous post](/2026/05/08/connascence-intro), we introduced the Connascence model for coupling and cohesion. In this post, we will discuss the two weakest, most explicit forms of connascence: **Name** and **Type**.

Two software elements are connascent if  
**a change in one would require the other to be modified to maintain the overall correctness of the system**  
or  
**for some change, both would be required to change to maintain the overall correctness of the system.**
Connascence defines three dimensions of coupling: strength, degree and distance, as the picture below shows. 

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Name and by Type

Two elements are connascent by Name or Type if they must agree on the same name or type. If a function is called `foo`, the calling code must use that name. Renaming the function means also changing the calling code. The same holds for types. Code using a type or class must change if the type changes, as show in the picture and code fragment below.

![connascence by name and type](/attachments/blogposts/2026/connascence/slide-6-type-example.png)

```java
class Bar {
  void foo() { ... }
}

var bar = new Bar();
bar.foo();
```

Connascence by Name and Type are explicit. The compiler or interpreter will provide feedback if we forget a change somewhere. Automated refactoring tooling makes this kind of coupling often easy to manage.

The *locality* of the coupling between the elements impacts the risk and the effort involved in keeping everything working correctly. If the elements are all in the same code base, our tooling will do most of the work, and the risk will be minimal. Good refactoring tools reduce the effort.

If the distance between two coupled parts is higher, the risk and effort is higher. An example is a class `Customer` with attributes `name` and `address` that should match a database table `CUSTOMER` with columns `NAME` and `ADDRESS`. These elements live in different systems (code base and database). 

![a representation of a database table CUSTOMERS with columns NAME and ADDRESS with should correspond to a class Customer with properties Name and Address](/attachments/blogposts/2026/connascence/name-table.png)
{: class="post-image post-image-70" }

## Refactoring Connascence by Name and Type

If the distance between the coupled elements is low, the compiler or interpreter will help us catch mistakes, e.g. when running unit tests. In that case, we can keep it like it is. Connascence by Name or Type is often the endpoint of refactoring and not something to refactor away from. Trying to refactor away from name and type coupling will make the coupling more implicit and more painful. 

For elements further apart, we can try to move them closer together. For name coupling between code and database, automated checks by our Object-Relational Mapping library or [automated adapter integration tests](/2020/09/17/test-architecture.html#adapter-integration-tests) can help.

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Meaning, where two or more elements need to agree on the meaning of particular values.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- Part 2 - *Connascence by Name and Type*
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm](/2026/06/03/connascence-algorithm)
- [Part 6 - Connascence by Execution Order](/2026/06/08/connascence-execution-order)
- [Part 7 - Connascence by Timing](/2026/06/12/connascence-timing)
- [Part 8 - Connascence by Value](/2026/06/17/connascence-value)
- [Part 9 - Connascence by Identity](/2026/06/24/connascence-identity)
- [Part 10 - Heuristics for managing coupling](/2026/06/29/connascence-managing-coupling)

<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer hands-on workshops about connascence and refactoring towards loosely coupled, highly cohesive systems.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
