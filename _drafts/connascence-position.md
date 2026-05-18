---
layout: post
title: "Connascence: Position (part 4)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/slide-9-position.png
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type and meaning. In this post, we will discuss Connascence by Position.

Connascence defines three dimensions of coupling: strength, degree and distance, as the picture below shows. 

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Position

Connascence by Position means that two elements need to agree on the order of values. 

![connascence by position](/attachments/blogposts/2026/connascence/slide-9-position.png)
{: class="post-image post-image-50" }

An example is positional parameters. In the code below, the code that instantiates a Person needs to keep the correct order as defined by the constructor signature. There will be no compiler feedback in case of a mistake.

```java
class Person {
  constructor (String name, String surname, String town) {
    ...
  }
}
...
new Person('Jan', 'Janssen', 'Utrecht')
```

The *degree of connascence* makes the positional coupling quite challenging: we can probably manage two parameters, but the longer the list of parameters is, the more risky it gets. An example is the [C/C++ sprintf function](https://en.cppreference.com/w/c/io/fprintf), which has a variable parameter list that should match the format string provided.

## Refactoring Connascence by Position

Some languages allow us to refactor this to Connascence by Name, by using named parameters:

```javascript
class Person {
  constructor ({ name, surname, town }) { ... }
}

new Person({ name: 'Jan', surname: 'Janssen', town: 'Utrecht' })
``` 

If some or all of the parameters form a Data Clump &mdash; they belong together and travel together throughout the code &mdash; we can introduce a new type that encapsulates the attributes.

```java
// from:
class Person {
  void Person(String name, String surname, String town)
}

// to:
class Person {
  void Person(Name name, Address address)
}
```

We reduce the connascence to type and encapsulate the details inside the Name and Address types.

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Algorithm, where two elements need to agree on the order of values.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning]()
- *Part 4 - Connascence by Position*
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
