---
layout: post
title: "Connascence: Position (part 4)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/position-example.png
---


In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type and meaning. In this post, we will discuss Connascence by Position.

Connascence defines three dimensions of coupling: strength, degree and distance, as the picture below shows. 

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Position

Connascence by Position means that two elements need to agree on the order of values.

![connascence by position](/attachments/blogposts/2026/connascence/slide-9-position.png)
{: class="post-image post-image-50" }

Positional parameters are an example of Connascence by Position. In the code below, the line calling the Person constructor needs to keep the correct order as defined by the constructor signature. There will be no compiler feedback in case of a mistake.

```java
class Person {
  constructor (String name, String surname, String town) { ... }
}

new Person("Jan", "Janssen", "Utrecht")
```

The *degree of connascence* can make positional coupling quite challenging: we can manage two parameters, but the longer the list of parameters is, the more risky it gets. An example is the [C/C++ sprintf function](https://en.cppreference.com/w/c/io/fprintf), which has a variable parameter list that should match the format string provided. In the code fragment below, we need to make sure we pass the four parameters in the correct order.

```c
    int id = 143;
    double price = 6.50;
    char grade = 'A';
    const char *tag = "hardware";

    sprintf(buffer, "id: %d, name: %s, price: %.2f, tag: %c", id, name, price, tag);
```

## Refactoring Connascence by Position

Some languages allow us to refactor positional coupling to Connascence by Name, by using named parameters:

```javascript
class Person {
  constructor ({ name, surname, town }) { ... }
}

new Person({ name: 'Jan', surname: 'Janssen', town: 'Utrecht' })
``` 

Do a subset (or all) of the parameters form a **Data Clump**? Then we can extract a new type or class to encapsulate those, as the code fragment below shows.

> A **Data Clump** is a set of variables that belong together and travel together throughout the code.

```java
// from:
class Person {
  void Person(String name, String surname, String street, String postalCode, String town) { ... }
}

// to:
record Name(String first, String last) {}
record Address(String street, String postalCode, String town) {}

class Person {
    void Person(Name name, Address address) { ... }
}
```

This reduces the Connascence by Position to Connascence by Type and encapsulates the details in the Name and Address types.

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Algorithm, where two elements need to agree on the order of values.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
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
