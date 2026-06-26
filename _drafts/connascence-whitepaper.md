---
title: Connascence - a model for reasoning about coupling
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
---

# Introduction

In this white paper, we will introduce Connascence, a model that describes coupling and cohesion in multiple dimensions. This model gives you an energy label to determine how energy efficient your coupling is.

Coupling is unavoidable. But you have to choose what kind of coupling is a good fit where. Connascence provides a fine-grained model to reason about different forms and degrees of coupling. It provides options to reduce coupling and improve cohesion. We find it provides a useful perspective on coupling, in addition to other ones.

It does not make sense to just remove all coupling. As we stated in the [previous post about coupling](/2026/01/23/on-coupling):

> Without coupling, there is no working software.

We accept coupling and deliberately decide the trade-offs. We make it explicit and manageable. We keep parts that are tightly coupled by nature closely together, increasing cohesion. For parts that are coupled but less tightly, we make sure coupling is as explicit as possible, aided by tooling and automated tests.

This post is the first of a series of posts on Connascence. So what lies ahead? We will first introduce the connascence model and give an overview of its three dimensions. In the next posts, we will elaborate the different types of connascence. Finally, we will discuss how this can help in managing coupling and how it helps in knowing where to refactor to.

# Connascence defined

Meilir Page-Jones introduced the concept of Connascence in [his work on object-oriented design](https://dl.acm.org/doi/10.1145/130994.131004) in the 1990s. He observed that coupling and cohesion are closely related and tried to catch them both using a new term:

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

# Dimensions of Connascence

Connascence introduces three dimensions to reason about coupling and cohesion:

1. **Strength** - how easy or difficult it is to detect coupling and manage changes in coupled elements;
2. **Locality** - the distance between two coupled elements;
3. **Degree** - the number of elements that are coupled.

## Strength

The nine types of connascence are, in order of increasing *strength*:

1. **Name** - two elements need to agree on the same name;
2. **Type** - two elements need to agree on the same type;
3. **Meaning** - two elements need to agree on the meaning of particular values;
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

Vlad Khononov's Balanced Coupling model mentions "sociotechnical distance", which is a useful addition. If two elements are not only far apart but also owned by different teams, the impact of coupling will be higher. If the teams are part of different organisations, it will be even worse.

### Degree

The *Degree* dimension of Connascence refers to the number of elements that are coupled, i.e. the number of elements that are affected by a specific change. More elements means more work, and a higher chance of missing one element when updating.

Adding a layer of indirection by introducing a stable abstraction helps to reduce the impact of changes, by isolating the part that changes and making the rest more stable, at the cost of some extra complexity.

![left part showing 5 elements having 'bad' coupling with red lines, right part having a new element in between, decoupling the stable part from the volatile part](/attachments/blogposts/2026/connascence/managing-degree-with-abstraction.jpg)
{: class="post-image post-image-70" }

# Putting it all together

The picture below puts everything together. The Connascence model allows to reason about coupling with the three dimensions of strength, locality and degree.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-70" }

# Connascence by Name and by Type

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


# Connascence by Meaning

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

Managing Connascence by Meaning is what we do every day. We introduce highly cohesive abstractions and reduce coupling in the rest of the code. Some code smells that are indicators of Connascence by Meaning are **Primitive Obsession**, **Magic Numbers**, and **Feature Envy**.

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

If we refactor to Connascence by Name, it becomes clearer what parts need to change together. The different meanings of the zeroes also becomes clear.

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


# Connascence by Position

Connascence by Position means that two elements need to agree on the order of values.

![connascence by position](/attachments/blogposts/2026/connascence/slide-9-position.png)
{: class="post-image post-image-50" }

Positional parameters are an example of Connascence by Position. In the code below, the line calling the `Person` constructor needs to keep the correct order as defined by the constructor signature. The compiler will not complain in case of a mistake.

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

It is useful to check if a subset (or all) of the parameters form a **Data Clump** Then we can extract a new type or class to encapsulate those, as the code fragment below shows.

> A **Data Clump** is a set of variables that belong together and travel together throughout the code.

```java
// from:
class Person {
  void Person(String name, String surname, String street, 
              String postalCode, String town) { ... }
}

// to:
record Name(String first, String last) {}
record Address(String street, String postalCode, String town) {}

class Person {
    void Person(Name name, Address address) { ... }
}
```

This reduces the Connascence by Position to Connascence by Type and encapsulates the details in the `Name` and `Address` types. We probably want to refactor this further, as we still have come positional coupling in `Name` and `Address`.


# Connascence by Algorithm

Connascence by Algorithm means two elements are coupled because they need to agree on a shared algorithm or protocol.

![connascence by algorithm](/attachments/blogposts/2026/connascence/slide-10-1-algorithm-example.png)
{: class="post-image post-image-50" }

Connascence by Algorithm occurs when two services need to exchange data, e.g. over a network. We need to know how an API works if we want to consume that API. We need to know what data in what format is returned. File exports/imports is another example of Connascence by Algorithm.

![picture showing a producer and a consumer that are coupled via a shared protocol](/attachments/blogposts/2026/connascence/algorithm.png)
{: class="post-image post-image-50" }

The `Producer` code below encodes information in a byte array, which gets sent over the network.

```java
class Producer {
  public static byte[] createFullFrame(byte ident, int tstamp, int xpos, int ypos,
                                       Direction dir, Speed spd, Engine eon, 
                                       CloseToOther close, Collision coll)
  {
    byte[] result = new byte[Protocol.FullFrameLength];
    result[0] = 0x00;
    result[Protocol.FrameLengthIndex] = Protocol.FullFrameLength;
    result[Protocol.IdentificationIndex] = ident;
    encodeInt32(tstamp, result, 4);
    encodeInt16(xpos, result, 8);
    encodeInt16(ypos, result, 10);
    ...
  }
}
```

The `Consumer` needs to know the order and meaning of the incoming bytes.

```java
class Consumer {
  public void handleMessage(byte identification, byte[] message, int length) {
    switch(decoderState) {
      case WAITING_FOR_INITIALFRAME:
        currentEntry.setTimestamp(CodecUtils.decodeInt32(message, Protocol.TimeStampIndex));
        currentEntry.setXPos(CodecUtils.decodeInt16(message, Protocol.XPosIndex));
        currentEntry.setYPos(CodecUtils.decodeInt16(message, Protocol.YPosIndex));
    ...
}
```

Connascence by Algorithm is trickier to manage than the weaker forms of connascence like Name or Type, because it often crosses system boundaries. It concerns coupling between systems that have a different lifecycle and often different owners. It tends to come with a high *distance*.

This is made worse by consumers and producers evolving at their own pace. when When the algorithm or protocol evolves, producers and consumers needs to be kept in sync. The higher the *degree* of connascence, the worse it gets: if a producer has many consumers, it becomes even more difficult for the algorithm to evolve.

## Refactoring Connascence by Algorithm

What can we do to keep Connascence by Algorithm manageable? Sometimes, we can merge producer and consumer into a single service, reducing it to Connascence by Name and Type. If multiple instances of that services are running, we still need to keep in mind that multiple versions of our protocol could be running alongside each other, e.g. during a deployment.

Often it is not possible to merge producer and consumer, so we have to deal with it. We can make our lives a bit easier however:

- Create a **shared library** that encapsulates the protocol and have both consumer and producer use it. This moves the producing and consumer code together, increasing the locality of connascence. This is not always possible and comes at the price of managing an extra dependency across multiple services.
- Use **open formats** and **industry standards**. The more stable a format is, the less consumers & producers need to change, and the less impactful coupling is.
- Use language independent **schemas** like JSON schema, [AVRO](https://avro.apache.org/), or [Protocol Buffers](https://protobuf.dev/). This allows for schema versioning and sharing through a schema registry. This does not remove the impact of changes, but it makes it more explicit. It allows us to evolve a protocol in steps with a lower risk of breaking something.
- Add **[contract tests](https://pactflow.io/blog/what-is-contract-testing/)** that provide early feedback about producer and consumer changes.
- Keep APIs **backward compatible**, so that consumers are not affected by producer changes.
- Perform explicit **lifecycle management** on APIs, through agreements with consumers, e.g. requiring consumers to upgrade to a new API version within 6 months of a change.


# Connascence by Execution Order

Connascence by Execution Order means that two elements are coupled because they need to agree on the order in which steps are executed.

![connascence by execution order](/attachments/blogposts/2026/connascence/slide-12-execution.png)
{: class="post-image post-image-50" }

What we know as imperative programming is all about execution order. We are used to things like the code below, where we first need to create a TCP client, then set up a writer, and only then we can start sending data.

```java
BinaryWriter output() {
  if (output != null)
      return output;
  TcpClient client = new TcpClient(host, port);
  output = new BinaryWriter(client.GetStream());
  return output;
}
```

But this can get complicated, as the next example shows. This is an excerpt from our [Dirty Jobs legacy code exercise](/training/mastering-legacy-code). The `HandleMessage` method processes frame data received over the network. It first creates a cache entry and then stores the received data in that cache entry. Finally, it calls `commit` to make the changes definitive. There should be no further calls on the cache entry after `commit`, but nothing will keep us from doing so. Any data stored after calling `commit` will get lost - a mistake waiting to happen.

```csharp
public class VehicleMessageDecoder : MessageDecoder
{
  public void HandleMessage(byte identification, byte[] message, int length)
  {
    switch (decodingState) {
      case WAITING_FOR_INITIALFRAME:
        if (message[Protocol.FrameTypeIndex] == Protocol.FullFrame) {
          currentEntry = TrackingCache.getInstance().createCacheEntry(decoderId);
          currentEntry.setTimestamp(
              CodecUtils.decodeInt32(message, Protocol.TimeStampIndex));
          // ... more stuff done to currentEntry
          currentEntry.commit();
          // ... updates done here will get lost
        }
        break;
    }
  }
}
```

Another example of Connascence by Execution Order is the [OpenID Connect protocol](https://openid.net/developers/how-connect-works/). OpenID Connect orchestrates authentication and authorization between multiple servers in a number of steps:

> 1. End user navigates to a website or web application via a browser.
> 2. End user clicks sign-in and types their username and password.
> 3. The RP (Client) sends a request to the OpenID Provider (OP).
> 4. The OP authenticates the User and obtains authorization.
> 5. The OP responds with an Identity Token and usually an Access Token.
> 6. The RP can send a request with the Access Token to the User device.
> 7. The UserInfo Endpoint returns Claims about the End-User.
>
> *source: [OpenID Connect](https://openid.net/developers/how-connect-works/)*

When using OpenID Connect, we have to deal with this specific ordering of execution. OpenID Connect is an open standard and the protocol is pretty stable. This limits the actual impact of the execution order constraints.

## Tackling Connascence of Execution Order

What can we do about it? Connascence by Execution Order is often inevitable. It is hard to detect from static analysis, because the ordering constraints follow from the semantics of the code.

In the `HandleMessage` example shown above, we can extract and move the knowledge about the order of `set...` and `commit` calls to a more appropriate abstraction.

We can for instance introduce a `TrackingRepository`, a small abstraction that manages the ordering constraints on updating and saving, which is shown in the code fragment below. `HandleMessage` then does not need to know about committing at the right point in time, it just calls `saveFullFrame` method on the repository. This increases the *locality* of connascence, by moving code that is coupled by ordering constraints together to a single place.

```csharp
public class VehicleMessageDecoder : MessageDecoder
{
  TrackingRepository _trackingRepository;

  public void HandleMessage(byte identification, byte[] message, int length)
  {
    switch (decodingState) {
      case WAITING_FOR_INITIALFRAME:
        if (message[Protocol.FrameTypeIndex] == Protocol.FullFrame) {
          _trackingRepository.saveFullFrame(anEntry
            .withTimestamp(CodecUtils.decodeInt32(message, Protocol.TimeStampIndex))
            .withXPos(/*....*/));
        }
        break;
    }
  }
}
```

We also use a [fluent interface](https://martinfowler.com/bliki/FluentInterface.html) here, which helps to enforce specific ordering using types. This unburdens developers of knowing what to call in which order and reduces possible mistakes.

Sometimes a set of statements in a specific order is duplicated in multiple places. The higher the *degree* of this connascence, the more painful it gets. We can reduce the degree by extracting the set of statements in a function and calling that function wherever it is needed. Note that we still have Connascence by Execution *within* that function.

### Hexagonal Architecture

[Hexagonal Architecture](/2020/08/20/hexagonal-architecture) (also known as **Ports & Adapters**) helps to reduce the impact of execution order coupling. Hexagonal Architecture puts domain logic in the center and inverts dependencies, so that storage, web and other services depend on domain logic instead of the other way around.

![Ports and Adapters overview, with a database connected to the domain via a Repository interface (Port) and an Adapter](/attachments/blogposts/2026/connascence/ports-and-adapters.png)
{: class="post-image post-image-70" }

Interacting with databases or other services often involves execution order constraints. We need to start a transaction, do updates, and then commit (or rollback) the transaction. If we let these execution order constraints seep into our domain logic, we add extra complexity to the inherent complexity of our domain. This can for example obfuscate transaction boundaries, with  failing updates as a result.

In Hexagonal Architecture, a *port* provides an abstraction in domain terms of the external systems (e.g. through a Repository interface). *Adapters* contain the mapping from domain abstractions to external systems and can encapsulate execution order constraints.


# Connascence by Timing

Connascence by Timing means that two elements are coupled because they need to agree on timing.

![connascence by timing](/attachments/blogposts/2026/connascence/slide-13-timing.png)
{: class="post-image post-image-50" }

An example of Connascence by Timing is a producer and consumer exchanging data, while working concurrently and asynchronously, e.g. in separate threads or services. How do we ensure each produced value is consumed once and only once? If we don't take any measures, we will end up with the consumer missing values and/or reading double values.

![a producer and consumer that exchange a value asynchronously](/attachments/blogposts/2026/connascence/producer-value-consumer.jpg)
{: class="post-image post-image-70" }

Different patterns and mechanisms are available to handle a timing dependency like this, by adding some form of synchronization. Examples are probes, semaphores, locks, futures, promises, and observables.

In some cases we can relax the consistency constraints somewhat. If we relax the *exactly once* constraint to *at least once*, we reduce timing coupling. This makes synchronisation less complicated, in particular for failure scenarios. It puts a higher burden on the consumer, which should allow for duplicate values. Message idempotency helps.

What if there is a single producer and multiple consumer workers, and we need to make sure each value is read exactly once by exactly one consumer?

![single producer, multiple consumers](/attachments/blogposts/2026/connascence/queue-overtaking-2.png)
{: class="post-image post-image-70" }

When a consumer starts reading a value, it can create a lock to ensure it is the only one reading at that moment, and release the lock when done. This trades off throughput for consistency, as the consumers sometimes need to wait while a value is processed.

![single producer, only one consumer reads at a time](/attachments/blogposts/2026/connascence/queue-overtaking-3.png)
{: class="post-image post-image-70" }

If we can *partition* the data and have each consumer process its own part of the data, the resulting throughput will be higher. We do need to find a good way to partition the data evenly, otherwise some consumers will be very busy, limiting how much we can scale the consumers for better throughput.

Automated end-to-end testing is another area where we have to deal with Connascence by Timing, in particular with browser-based tests. It takes time for the system under test to process changes and make these visible. Frontend applications add extra asynchronous behaviour. Probes are helpful and they are used by end-to-end testing frameworks like [Playwright](https://playwright.dev/) to handle timing and asynchronous behaviour.

We often have to deal with asynchronous, concurrent processes and the resulting Connascence by Timing. Sometimes we could remove it by replacing it with a synchronous call, but usually the async coupling is there for a good reason, like better throughput, scalability, independent deployability, or external services that are out of our control.

## Eventual consistency

A trade-off we can make is being less strict in agreeing on timing, and settle for data to be *eventually consistent* instead of immediately consistent. Eventual consistency provides more options for the different parts of the system to eventually settle on a change. What 'eventually' means depends on the context and the domain, it could be milliseconds, seconds, the next day.

![visualization of eventual consistency, a user does an update, which is propagated through an async queue to some view that is eventually consistent](/attachments/blogposts/2026/connascence/eventual-consistency.jpg)
{: class="post-image post-image-70" }

Again, there are trade-offs here. For example, eventual consistency makes it more complicated to detect that something did _not_ happen: if the visible state has not been updated for X seconds, is it still waiting for the change to propagate or did it fail? Explicit queries at some time are needed for instance, whereas a timeout, optionally with a back-off algorithm is _relatively_ simple.

> **Eventual consistency is a business decision**  
> Showing an inconsistent state for a short amount of time is often good enough. Users are able to handle this and it is not worth adding the extra complexity of stricter consistency constraints. If I transfer money with my banking app, I often see the old balance for a second in the app until the transfer is processed, which is good enough.


# Connascence by Value

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


# Connascence by Identity

Connascence by Identity means that two elements need to agree on the identity of something, i.e. they need to make sure they are using the exact same thing or instance.

![connascence by identity](/attachments/blogposts/2026/connascence/slide-15-identity.png)
{: class="post-image post-image-50" }

When we create a new object and subsequently use that object, we have Connascence by Identity between the creation and usage parts of the code. The code shown below knows exactly which instance it is using, namely the one it has created itself.

```java
var p = new Person();
p.doSomething();
return p;
```

Another example: the `this` or `self` reference in instance methods always refers to the object the method was invoked on. This coupling to identity is inevitable in this case, but also quite harmless because it is local - all contained within the same class.

These examples show that there will always be some Connascence by Identity in our code: the identity of a variable is known within its scope. If we keep the scope small, the impact is low and the connascence is well manageable. The larger the scope, the nastier it gets. This makes global variables for example problematic from a coupling point of view.

## Singletons

Over-usage of the [Singleton design pattern](https://en.wikipedia.org/wiki/Singleton_pattern) is an example of Connascence by Identity getting tricky. The intent of this pattern is to ensure there is only a single instance of a specific object. The solution is to make it difficult or impossible to create multiple instances.

Most of the code using the instance does not care about what specific instance it is using. It just wants to do its thing on whatever instance it receives. It should not know about creation of the instances and the singleton requirement. In practice, we see that singletons are accessed all over the place, introducing a lot of unnecessary identity coupling.

The example below shows code using the singleton construct directly, because it needs a `TrackingCache` instance. It uses the singleton as a global variable, not having to think about how dependencies are injected.

```csharp
public class VehicleMessageDecoder : MessageDecoder
{
  public void handleMessage(byte identification, byte[] message, int length)
  {
    switch (decodingState) {
      case WAITING_FOR_INITIALFRAME:
        if (message[Protocol.FrameTypeIndex] == Protocol.FullFrame) {
          currentEntry = TrackingCache.getInstance().createCacheEntry(decoderId);
          // ... 
        }
        break;
    }
  }
}
```

This introduces unnecessary, tight coupling, specifically increasing the *degree* of coupling on the singleton instance. Code that does not care about the specific instance gets burdened with this knowledge, making it hard to test.

## Managing Connascence by Identity

To reduce Connascence by Identity in a component, we apply **dependency injection**, by either wiring through the constructor or passing the dependency as a function parameter.

This works well e.g. with **[Hexagonal Architecture](/2020/08/20/hexagonal-architecture)**. Instantiating services and adapters takes place in one place, in a `main` function or some Spring configuration code. These are injected into the rest of the code, which takes these as explicit dependencies. This reduces the identity coupling to a single place in the code.

Whenever Connascence by Identity is unavoidable, we try to **reduce scope** and **keep it local**, within a module, class or function.


# Managing coupling and cohesion with the connascence model





# Related work

[Coupling](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) and [cohesion](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) are very old concepts in software development since the beginning. The concepts were introduced by Larry Constantine in the 1960s, and several people have tried to refine them and make them measurable.

The Connascence model dates back to the 1990s when Meilir Page-Jones wrote his books about object oriented modelling. He identified coupling and cohesion as being the same thing.

A recent addition is Vlad Khononov's Balanced Coupling model, described in his [book](https://coupling.dev/posts/learning-resources/) and on the [Balanced Coupling website](https://coupling.dev/). Khononov's model has some overlap with connascence. He defines three slightly different dimensions of coupling:

1. **Integration Strength** - comparable but with a slightly different angle than connascence strength;
2. **Distance** - what is coupled: methods, objects, packages, services, systems;
3. **Volatility** - how stable or volatile are the different coupled elements.

The volatility (or stability) of elements is referenced in the Connascence model but it does not define it as a dimension. It is a useful addition to consider explicitly, because coupling is about changing elements together. When things don't have to change, coupling is not an issue.

# Further reading

- [I Still Feel the Urge to Reuse Code (Even Though I Know It's Wrong)](https://www.linkedin.com/pulse/i-still-feel-urge-reuse-code-even-though-know-its-wrong-dilger-yphie/) by Martin Dilger
- Another good read from this year is [Cohesion, Modules, and Hierarchies](https://ewolff.com/2026/01/08/cohesion-modules-hierachies.html) by Eberhard Wolff
* Meilir Page-Jones, Fundamentals of OO Design in UML (1999)
* Meilir Page-Jones, [Comparing Techniques by Means of Encapsulation and Connascence](https://dl.acm.org/doi/10.1145/130994.131004), in Communications of the ACM Sept 1992
* Jim Weirich, [The Grand Unified Theory of Software Design](https://www.youtube.com/watch?v=NLT7Qcn_PmI), at the Acts as Conference 2009
* [Connascence.io](https://connascence.io)
* Vlad Khononov, [Balancing Coupling in Software Design](https://vladikk.com/page/books/) (2024)
