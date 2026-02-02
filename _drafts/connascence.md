---
layout: post
title: Connascence - a model for reasoning about coupling
tags:
  - architecture
  - coupling
  - design
author: Marc Evers
image: /attachments/blogposts/2026/connascence-visualised-2.jpg
---

(summary) In this post, we will describe connascence, a model that describes coupling and cohesion in multiple dimensions.

(benefits) The connascence model provides a more fine-grained model to reason about different forms and degrees of coupling. This provides more options to reduce coupling and improve cohesion. It is not the only way of looking at coupling, but it is a useful one.

It is not about removing all coupling. As we stated in the [previous post about coupling](/2026/01/23/on-coupling):

> Without coupling, we don't have working software.

We accept coupling and focus on keeping coupling explicit and manageable. 
Parts that are tightly coupled by nature we keep closely together, in other words, increasing cohesion.

We will first give a definition of connascence, and then elaborate its three dimensions. We will also discuss how this can help in managing coupling and how it helps in knowing where to refactor to.

## Connascence defined 

The concept of Connascence was introduced by Meilir Page-Jones in his work on object-oriented design. He observed that coupling and cohesion are closely related and tried to catch this by introducing a new term.

> I chose the word "connascence" from the Latin roots meaning "born together." It is etymologically close to the French "connaissance" meaning knowledge, awareness or consciousness.
> 
> An undertone of this meaning is "having intertwined destinies in life."
>
> -- Meilir Page-Jones

Two software components are connascent if:

*a change in one would require the other to be modified to maintain the overall correctness of the system*

or

*for some change, both would be required to change to maintain the overall correctness of the system*

This is illustrated below. We have two components, both components are organized in smaller parts (e.g. classes and functions):

![Schematic visualization of two software components and their parts (modules, classes, functions, types)](/attachments/blogposts/2026/connascence-visualised-1.jpg)

We can visualize parts (classes, functions, lines of code) that need to change together by connecting them using red lines:

![Schematic visualization of coupling between different parts of two software components using red lines to connect parts that are coupled](/attachments/blogposts/2026/connascence-visualised-2.jpg)

## Dimensions of Connascence

The connascence model uses three dimensions to reason about coupling and cohesion:

1. **Type** - also called 'strength'; this is an indicator of how easy or difficult it is to detect coupling and manage changes in coupled components;
2. **Locality** - the distance between two coupled components;
3. **Degree** - the number of components that are coupled.

The connascence types are (in order of increasing strength): Name, Type, Meaning, Position, ALgorithm, Execution, Timing, Value, Identity.
(todo: make list + anchor links?)

![connascence in three dimensions](/attachments/blogposts/2026/slide-19-degree.png)

We will discuss the connascence types and elaborate the two other dimensions along the way.

## Connascence by Name and by Type

Two components are connascent by Name or Type if they must agree on the same name or type. If a function is called `foo`, the calling code must use the same name. Renaming the function means changing the calling code. The same holds for types. Code using a type (e.g. class) must change if the type changes.

Connascence by Name or Type is very explicit. The compiler or interpreter will provide feedback if we forget a change somewhere. Automated refactoring tooling makes this kind of coupling often easy to manage.

The *locality* of coupling impacts the effort and risk in managing coupling. If the components are all in the same code base, our tooling will do most of the work, and the risk will be minimal. 

If the distance between two coupled parts is higher, e.g. a class `Customer` with attributes `name` and `address` in our code which should match our database table `Customer` with columns `Name` and `Address`. Extra tool support can help her, e.g. using an adapter integration test that covers the database integration.

## Connascence by Meaning

Connascence by Meaning (also known as Connascence by Convention) means that multiple components must agree on the meaning of particular values.

In the example below, apparently the return value `null` means invalid data. AS a result, the calling code depends on the meaning that `validateAndConvert` assigns to `null`.

```java
person = validateAndConvert(data)
if (person == null) throw new InvalidDataException();
```

Some other examples are:
- using integers to represent money or port numbers
- using strings to represent international phone numbers
- returning null, None or Optional.empty - what does null or None mean?

Different components need to know what the numbers mean, how to use them, what valid and invalid values are. We probably don't want negative numbers if an `int` is representing prices; and what does the int then specifically mean? Cents, Euros, Dollars?

We will always have some connascence by meaning somewhere. Eventually we will use primitives to build higher order concepts. So connascence by meaning is not bad perse. Instead, we can refactor the code that is coupled by meaning, so that everything is explicit and close together. We can e.g. encapsulate Money or Price in a type of its own, hiding the way it is represented through integers or other types from the rest of the code.

The code smells that are indicators of connascence by meaning are Magic Numbers and Primitive Obsession.

In the case of Magic Numbers or null values having a specific meaning, we can refactor this by extracting a constant or introducing an exception as the example below shows. In this way, we refactor to Connascence by Name.

```java
Person validateAndConvert(data) throws InvalidDataException {
  if (isInvalid(data) then
    throw new InvalidDataException();
  ...
  return person;
}
...
try {
  person = validateAndConvert(data)
} catch (InvalidDataException invalid) {
    ...
}
```

Another example, some code with Magic Numbers. It is not clear what the different numbers mean. The 0s also mean different things.

```csharp
public class VehicleMessageDecoder : MessageDecoder
{
  public void handleMessage(byte identification, byte[] message, int length)
  {
    switch (decodingState) {
      case 0:
        decodingState = 1;
        goto case 1;
      case 1:
        if (message[0] == 0x00) {
          currentEntry.setTimestamp(CodecUtils.decodeInt32(message, 4));
          // ...
          decodingState = 2;
          numberOfDeltas = 0;
        }
        break;
      //...
    }
  }
}
```

If we refactor to connascence by name, it becomes more clear what needs to change together.

```csharp
public class VehicleMessageDecoder : MessageDecoder
{
  public void handleMessage(byte identification, byte[] message, int length)
  {
    switch (decodingState) {
      case STARTING:
        decodingState = WAITING_FOR_INITIALFRAME;
        goto case WAITING_FOR_INITIALFRAME;
      case WAITING_FOR_INITIALFRAME:
        if (message[Protocol.FrameTypeIndex] == Protocol.FullFrame) {
          currentEntry.setTimestamp(CodecUtils.decodeInt32(message, 4));
          // ...
          decodingState = WAITING_FOR_DELTAS;
          numberOfDeltas = 0;
        }
        break;
      //...
    }
  }
}
```

## Connascence by Position

Connascence by Position means that two components need to agree on the order of values. 

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

The Degree of connascence makes the positional coupling quite challenging: we can probably manage two parameters, but the longer the list of parameters is, the more risky it gets. An example is the [C/C++ sprintf function](https://en.cppreference.com/w/c/io/fprintf), which has a variable parameter list that should match the format string provided.

Some languages allow us to refactor this to connascence by name, by using named parameters.

```javascript
class Person {
  constructor ({ name, surname, town }) {
    // ...
  }
}

new Person({ name: 'Jan', surname: 'Janssen', town: 'Utrecht' })
```

## Connascence by Algorithm

## Connascence by

## Discussion


* types not always clear; sometimes some discussion what exactly it is; try to focus on the impact instead and if/how we can make it better manageable







## Further reading 

- [I Still Feel the Urge to Reuse Code (Even Though I Know It's Wrong)](https://www.linkedin.com/pulse/i-still-feel-urge-reuse-code-even-though-know-its-wrong-dilger-yphie/) by Martin Dilger
- Another good read from this year is [Cohesion, Modules, and Hierarchies](https://ewolff.com/2026/01/08/cohesion-modules-hierachies.html) by Eberhard Wolff
* Meilir Page-Jones, Fundamentals of OO Design in UML (1999)
* Meilir Page-Jones, [Comparing Techniques by Means of Encapsulation and Connascence](www.researchgate.net/publication/220424550_Comparing_Techniques_by_Means_of_Encapsulation_and_Connascence), in Communications of the ACM Sept 1992 
* Jim Weirich, [The Grand Unified Theory of Software Design](www.youtube.com/watch?v=NLT7Qcn_PmI), at the Acts as Conference 2009  
* [Connascence.io](https://connascence.io)
* Vlad Khononov wrote a book on [Balancing Coupling in Software Design](https://vladikk.com/page/books/). We haven't read it yet, but it's on our list.




<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer workshops in this area, e.g. explore coupling and cohesion through a hands-on workshop, based on connascence, or a hands-on workshop about the SOLID design principles.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>


