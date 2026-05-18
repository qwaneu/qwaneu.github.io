---
layout: post
title: "Connascence: Meaning (part 3)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/slide-8-meaning.png
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated on the two most explicit forms of connascence: [name and type](). In this post, we will discuss Connascence by Meaning, which is as much about cohesion as it is about coupling.

Connascence defines three dimensions of coupling: strength, degree and distance, as the picture below shows. 

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Meaning

Connascence by Meaning (also known as Connascence by Convention) means that multiple elements must agree on the meaning of particular values.

![connascence by meaning](/attachments/blogposts/2026/connascence/slide-8-meaning.png)
{: class="post-image post-image-50" }

An example of connascence by meaning is the use of integers to represent monetary amounts. Every piece of code that uses those integers must know how to interpret the values - Eurocents or Euros? Euros or Dollars? Is the value allowed to be negative? What operations are valid on these numbers? We can add to monetary amounts, we can multiply a monetary amount by a scalar value. It does not make sense to multiply two monetary amounts.

In the example below, apparently the return value `null` of function `validateAndConvert` means invalid data. The calling code depends on the meaning that `validateAndConvert` assigns to `null`.

```java
person = validateAndConvert(data)
if (person == null) throw new InvalidDataException();
```

Some other examples are:
- using integers to port numbers, which should be in the range from 0 to 65535 with 0-1023 being system ports;
- using strings to represent email addresses, which are defined in RFCs [5322](https://www.rfc-editor.org/rfc/rfc5322) and [6854](https://www.rfc-editor.org/rfc/rfc6854);
- using strings to represent international phone numbers;
- returning null, None or Optional.empty to signal no results found, or some exceptional situation - what does null or None actually mean?

Different elements need to know what the numbers mean, how to use them, what valid and invalid values are. We will always have connascence by meaning somewhere in our code. We use primitives to build higher order concepts, introducing assumptions about how these concepts are represented using strings or integers. 

So connascence by meaning is not inherently bad. We do like to have all assumptions about meaning explicit and close to each other. We can refactor the code so that all assumptions are encapsulated and hidden behind types or interfaces. The implementation of the abstraction will be highly coupled - in other words, it is highly *cohesive*. Other code will be coupled to the abstraction (connascence by name and type) and not to specific primitives or assumptions about meaning.

+mooi plaatje erbij

### Refactoring Connascence by Meaning

Managing connascence by meaning is what we do on a daily basis: we introduce abstractions that are highly cohesive and reduce the coupling in the rest of the code. There are a few code smells that are indicators of connascence by meaning, in particular **Primitive Obsession**, **Magic Numbers**, and **Feature Envy**.

**Primitive obsession** is code that is using primitive types all over the place. Usually this means that there are concepts hidden in the code, which can be extracted by encapsulating the primitives and moving the associated behaviour.

In the case of **Magic Numbers**, including `null` values having a specific meaning, we can refactor this to connascence by name, by extracting a constant or introducing an exception as the example below shows.

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

Another example, some code with Magic Numbers. It is not clear what the different numbers mean. The zeroes also mean different things.

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

@@iets over feature envy?

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Position, where two elements need to agree on the order of values.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- Part 3 - *Connascence by Meaning*
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
