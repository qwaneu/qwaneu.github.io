---
layout: post
title: "Connascence: Meaning (part 2)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: 
---

In the [previous post](/2026/05/08/connascence-intro), we introduced the Connascence model for coupling and cohesion. Connascence defines three dimensions of coupling: strength, degree and distance. In this post, we will discuss the weakest (and most explicit) types of connascence: **Name** and **Type**.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Meaning

Connascence by Meaning (also known as Connascence by Convention) means that multiple elements must agree on the meaning of particular values.

![connascence by meaning](/attachments/blogposts/2026/connascence/slide-8-meaning.png)

In the example below, apparently the return value `null` means invalid data. AS a result, the calling code depends on the meaning that `validateAndConvert` assigns to `null`.

```java
person = validateAndConvert(data)
if (person == null) throw new InvalidDataException();
```

Some other examples are:
- using integers to represent money or port numbers
- using strings to represent international phone numbers
- returning null, None or Optional.empty - what does null or None mean?

Different elements need to know what the numbers mean, how to use them, what valid and invalid values are. We probably don't want negative numbers if an `int` is representing prices; and what does the int then specifically mean? Cents, Euros, Dollars?

We will always have some connascence by meaning somewhere. Eventually we will use primitives to build higher order concepts. So connascence by meaning is not bad perse. Instead, we can refactor the code that is coupled by meaning, so that everything is explicit and close together. We can e.g. encapsulate Money or Price in a type of its own, hiding the way it is represented through integers or other types from the rest of the code.

+this is cohesion (met een mooi plaatje erbij?)

### Refactoring Connascence by Meaning

Code smells that are indicators of connascence by meaning are Magic Numbers and Primitive Obsession.

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

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Position, where two elements need to agree on the order of values.

- Part 1 - [Introduction](/2026/05/08/connascence-intro)
- Part 2 - [Connascence by Name and Type]()
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
