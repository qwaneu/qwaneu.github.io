---
layout: post
title: "Connascence: Value (part 8)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/akinori-uemura--T6vP7ZGz0Q-unsplash.jpg
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning, position, algorithm, execution order, and timing. In this post, we will discuss Connascence by Value.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Value

Connascence by Value means two elements are coupled because they need to agree on a specific value. Several values in different parts of the code or in different systems need to change together, otherwise the correctness of the system will break. 

![connascence by value](/attachments/blogposts/2026/connascence/slide-14-value.png)
{: class="post-image post-image-50" }

Let's look at an example, shown in the picture below. The Organization Management service sets the type of an organization to a specific number, let's say 22. Other services that use organizations like service C will need know and use this specific value as well. The two other services are also coupled through that specific value. The services that pass on the organization data (A and B) might also be accidentally coupled if they know about the organization type values when passing on the data.

![one service sets the value 22, the data passes through other services, and some other service checks if the value is 22](/attachments/blogposts/2026/connascence/cov-org-type.jpg)

Connascence by Value looks somewhat similar to Connascence by Meaning, but the latter concerns coupling based on meaning, conventions, usage, interpretation of values, while the Connascence by Value concerns coupling on a specific value. 

Connascence by Value can be tricky, especially if the values are used in different systems and codebases, e.g. a hard coded '22' in Java code and a value 22 somewhere in a database column. When different systems are deployed at different rates, changing a specific value means we will have to deal with the old and new values co-existing for some time.

## Tackling Connascence by Value

If the coupled elements are close enough to each other (in the same codebase), there are some options to reduce the pain:
- We can extract the special value into **constant** and use the constant everywhere. This reduces it to Connascence by Name. If the connascence is between different code bases using the same language, we can investigate moving the value to a shared library.
- Sometimes we can generalize the code using the value and **inject the value** instead of hard-coding it. This reduces it to Connascence by Type or Meaning.
- We can bring all code that knows the special value close together, e.g. by **encapsulating** it in a single class, reducing it to Connascence by Meaning.

We could resort to end-to-end tests to cover values that are coupled across different systems, but these tests tend to be slow and fragile. Striving to keep the values **stable** is probably the least risky option. Instead of changing a specific value, we can e.g. add a new one and deprecate the old one.

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Identity, where two elements need to agree on the identity of something.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm](/2026/06/03/connascence-algorithm)
- [Part 6 - Connascence by Execution Order](/2026/06/08/connascence-execution-order)
- [Part 7 - Connascence by Timing](/2026/06/12/connascence-timing)
- *Part 8 - Connascence by Value*
- Part 9 - Connascence by Identity
- Part 10 - Heuristics for managing coupling

*Credits: chains thumbnail photo by <a href="https://unsplash.com/@a_uem?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Akinori UEMURA</a> on <a href="https://unsplash.com/photos/silver-chain-link-with-black-background--T6vP7ZGz0Q?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>*

<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer hands-on workshops about connascence and refactoring towards loosely coupled, highly cohesive systems.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
