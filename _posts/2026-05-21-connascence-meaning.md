---
layout: post
title: "Connascence: Meaning (part 3)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/connascence-cohesion.jpg
---


In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated on the two most explicit forms of connascence: [name and type](/2026/05/13/connascence-name-type). In this post, we will discuss Connascence by Meaning, which is as much about cohesion as it is about coupling.

Connascence defines three dimensions of coupling: strength, degree and distance, as the picture below shows. 

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Meaning

Connascence by Meaning means that multiple elements must agree on the meaning of particular values. This is also known as Connascence by Convention.

![connascence by meaning](/attachments/blogposts/2026/connascence/slide-8-meaning.png)
{: class="post-image post-image-50" }

An example of Connascence by Meaning is the use of integers to represent monetary amounts. Code that uses those integers must know how to interpret the values. Is it Euro cents or whole Euros? Euros or Dollars? Is the value allowed to be negative? What operations are valid on these numbers? We can add monetary amounts, we can multiply a monetary amount by a scalar value, but it does not make sense to multiply two monetary amounts.

The code below shows another example. Apparently the return value `null` of function `validateAndConvert` means invalid data. The calling code depends on the meaning that `validateAndConvert` assigns to `null`.

```java
person = validateAndConvert(data)
if (person == null) throw new InvalidDataException();
```

Other examples:
- using integers to represent port numbers; port numbers should be in the range from 0 to 65535 with 0-1023 being system ports;
- using strings to represent email addresses; valid values are defined by RFCs [5322](https://www.rfc-editor.org/rfc/rfc5322) and [6854](https://www.rfc-editor.org/rfc/rfc6854);
- using strings to represent international phone numbers;
- returning `null`, `None` or `Optional.empty` to signal no results found, or some exceptional situation - what does the `null` or `None` value actually mean?

Different elements need to know what these numbers and text values mean, how to use them, and what valid and invalid values are.

We will always have Connascence by Meaning somewhere in our code. We use primitives to build higher order concepts and encode assumptions about how these concepts are represented using strings or integers. So Connascence by Meaning is not bad. 

We do like to have all assumptions about meaning explicit and close to each other. We can refactor so that all assumptions are encapsulated in an abstraction, hidden behind a type or interface. The implementation details of the abstraction will be tightly coupled - it is highly **cohesive**, like the picture below shows. Other code will be coupled to the abstraction (Connascence by Name and Type) and not to specific primitives or assumptions about meaning.

![big circle representing a cohesive element containing highly coupled sub-elements, other elements are connected to it, but not to its internals](/attachments/blogposts/2026/connascence/connascence-cohesion.jpg)
{: class="post-image post-image-30" }

## Refactoring Connascence by Meaning

Managing Connascence by Meaning is what we do on a daily basis. We introduce highly cohesive abstractions and reduce coupling in the rest of the code. Some code smells that are indicators of Connascence by Meaning are **Primitive Obsession**, **Magic Numbers**, and **Feature Envy**.

**Primitive obsession** is code that uses primitive types all over the place. Usually this means hidden concepts, which can be extracted by encapsulating the primitives and moving the behaviour to the new abstraction.

**Magic Numbers** means using special literal values that have an implicit meaning. This includes the use of `null` values. We can refactor this to Connascence by Name or Type, by extracting a constant or introducing an exception as the code fragment below shows.

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

The next code fragment shows another example of code with Magic Numbers. It is not clear what 0, 1, 2, and 0x00 mean. Do the different zeroes actually mean the same thing?

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

If we refactor to Connascence by Name, it becomes more clear what parts need to change together. The different meanings of the zeroes also becomes clear.

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

Let's look at another example. The code below shows a piece of shopping cart logic. It computes the total including taxes using `Money` and `Item` data classes. The shopping cart code has intimate knowledge about how money works: it knows how to add amounts and how to apply tax rates.

```kotlin
data class Money(val amount: BigDecimal)

data class Item(val name: String, val price: Money)

class ShoppingCart {
    ...
    fun calculateTotalWithTax(taxRate: BigDecimal): Money {
        var totalAmount = BigDecimal.ZERO
        for (item in items) {
            totalAmount = totalAmount.add(item.price.amount)
        }
        val taxMultiplier = BigDecimal.ONE.add(taxRate)
        val finalAmount = totalAmount.multiply(taxMultiplier)
        return Money(finalAmount)
    }
}
```

We can refactor this by extracting `add` and `withTax` functions and moving these to `Money`, so that `Money` encapsulates the meaning of the BigDecimal values.

```kotlin
data class Money(val amount: BigDecimal = BigDecimal.ZERO) {
    fun add(other: Money): Money = Money(amount.add(other.amount))

    fun withTax(taxRate: BigDecimal): Money {
        val taxMultiplier = BigDecimal.ONE.add(taxRate)
        return Money(amount.multiply(taxMultiplier))
    }
}

data class Item(val name: String, val price: Money)

class ShoppingCart {
    ...
    fun calculateTotalWithTax(taxRate: BigDecimal): Money {
        var totalAmount = Money()
        for (item in items) {
            totalAmount = totalAmount.add(item.price)
        }
        return totalAmount.withTax(taxRate) 
    }
}
```

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Position, where two elements need to agree on the order of values.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- *Part 3 - Connascence by Meaning*
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm](/2026/06/03/connascence-algorithm)
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
