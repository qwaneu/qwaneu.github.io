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

![Schematic visualization of coupling between different parts of two software components using red lines to connect parts that are coupled](/attachments/blogposts/2026/connascence/connascence-visualised-2.jpg)

## Dimensions of Connascence

The connascence model uses three dimensions to reason about coupling and cohesion:

1. **Type** - also called 'strength'; this is an indicator of how easy or difficult it is to detect coupling and manage changes in coupled components;
2. **Locality** - the distance between two coupled components;
3. **Degree** - the number of components that are coupled.

The connascence types are (in order of increasing strength): Name, Type, Meaning, Position, ALgorithm, Execution, Timing, Value, Identity.
(todo: make list + anchor links?)

![connascence in three dimensions](/attachments/blogposts/2026/connascence/slide-19-degree.png)

We will discuss the connascence types and elaborate the two other dimensions along the way.

@@short overview + definition of the types

The first five types are called *static* connascence, because these can be detected using the compiler or static code checks. The other types are called *dynamic* &mdash; they are related to the dynamic behaviour of the code.

## Connascence by Name and by Type

Two components are connascent by Name or Type if they must agree on the same name or type. If a function is called `foo`, the calling code must use the same name. Renaming the function means changing the calling code. The same holds for types. Code using a type (e.g. class) must change if the type changes.

Connascence by Name or Type is very explicit. The compiler or interpreter will provide feedback if we forget a change somewhere. Automated refactoring tooling makes this kind of coupling often easy to manage.

```java
class Bar {
  void foo() { ... }
}

var bar = new Bar();
bar.foo();
```

The *locality* of coupling impacts the effort and risk in managing coupling. If the components are all in the same code base, our tooling will do most of the work, and the risk will be minimal. 

If the distance between two coupled parts is higher, e.g. a class `Customer` with attributes `name` and `address` in our code which should match our database table `Customer` with columns `Name` and `Address`. Extra tool support can help her, e.g. using an adapter integration test that covers the database integration.

![a representation of a database table CUSTOMERS with columns NAME and ADDRESS with should correspond to a class Customer with properties Name and Address](/attachments/blogposts/2026/connascence/name-table.png)

@@ Refactor to? What to do about it? not much; bring stuff closer together if you can (move towards more cohesion); use automated tests to capture coupled elements with distance

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

The *degree of connascence* makes the positional coupling quite challenging: we can probably manage two parameters, but the longer the list of parameters is, the more risky it gets. An example is the [C/C++ sprintf function](https://en.cppreference.com/w/c/io/fprintf), which has a variable parameter list that should match the format string provided.

### Refactoring Connascence by Position

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

## Connascence by Algorithm

Connascence by Algorithm means two elements are coupled because they need to agree on a shared algorithm or protocol.

~[picture showing a producer and a consumer that are coupled via a shared protocol](/attachments/blogposts/2026/connascence/algorithm.png)

We see Connascence by Algorithm whenever two services need to exchange data, e.g. over the network. To consume an API, you need to know how the API works, what data in what format is returned. This also holds for file exports/imports

The Producer code below encodes information in a byte array. which gets sent over the network.

```java
class Producer {
  public static byte[] createFullFrame(byte ident, int tstamp, int xpos, int ypos,
                                           Direction dir, Speed spd, Engine eon, CloseToOther close,
                                           Collision coll)
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

The consumer needs to know the order and meaning of the incoming bytes.

```java
class Consumer {
  public void handleMessage(byte identification, byte[] message, int length) {
    switch(decoderState) //.....
      case WAITING_FOR_INITIALFRAME:
        currentEntry.setTimestamp(CodecUtils.decodeInt32(message, Protocol.TimeStampIndex));
        currentEntry.setXPos(CodecUtils.decodeInt16(message, Protocol.XPosIndex));
        currentEntry.setYPos(CodecUtils.decodeInt16(message, Protocol.YPosIndex));
    ...
}
```

### Managing and refactoring Connascence by Algorithm

What can you do to keep Connascence by Algorithm manageable?

- Using **open & industry standard formats**. The more stable standard formats are, the less consumers & producers need to change, and the less impactful coupling is.
- Using Language independent **schemas** (e.g. JSON schema, [AVRO](https://avro.apache.org/), [Protocol Buffers](https://protobuf.dev/)), schema registries and schema versioning; schemas and schema versioning do not take away the impact of changes, but they make it explicit, visible, manageable. 
- **Contract testing** provides early feedback about producer and consumer changes.

An alternative is creating a shared library that encapsulates the protocol. Both consumer and producer use the shared library. This moves the producing and consumer code together, increasing the locality of connascence.


## Connascence by Execution Order

Connascence by Execution Order means that two elements are coupled because they need to agree on the order in which steps are executed.

In a way, imperative programming is all about execution order. We're used to things like the code below, where first need to create a TCP client, then set up a writer, and only then we can start sending data.

```java
private BinaryWriter output()
{
  if (_output != null)
    return _output;
  TcpClient client = new TcpClient(host, port);
  _output = new BinaryWriter(client.GetStream());
  return _output;
}
```

But this can get quite bad, as the next example shows. This is an excerpt from our Dirty Jobs legacy code exercise. The HandleMessage method processes frame data it receives over the network. It first creates a cache entry, and then stores the received data in that entry. At the end, it calls commit. There should be no further calls on the entry after the commit, but nothing will keep you from doing so. Any data stored after the commit will get lost however. This is a mistake waiting to happen.

```csharp
public class VehicleMessageDecoder : MessageDecoder
{
  public void HandleMessage(byte identification, byte[] message, int length)
  {
    switch (decodingState) {
      case WAITING_FOR_INITIALFRAME:
        if (message[Protocol.FrameTypeIndex] == Protocol.FullFrame) {
          currentEntry = TrackingCache.getInstance().createCacheEntry(decoderId);
          currentEntry.setTimestamp(CodecUtils.decodeInt32(message, Protocol.TimeStampIndex));
          // ... more stuff done to current entry
          currentEntry.commit();
          // ... updates done here will get lost
        }
        break;
    }
  }
}
```

### Tackling Connascence of Execution Order

What can we do about it? In this example, we can move the knowledge about the order of set and commit calls to the TrackingRepository. In this way, we make sure the HandleMessage code does not need to know about committing, it just calls a method on the repository. We have increased the *locality* of connascence here.

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

We also used a [fluent interface](@@reference!), which can also help enforcing specific ordering via the compiler.

Sometimes the set of statements in a specific order is repeated in multiple places in the code. The higher the degree of this connascence, the more painful it gets. We can reduce the degree by extracting the statements and ordering in a function and calling the functions wherever it is needed. Note that we still have Connascence by Execution within that function.

@@ Hexagonal Architecture

@@ Another example: The OpenID Connect protocol. The OpenID Connect protocol uses a specific way of orchestrating authentication/authorization between multiple servers. When using OpenID Connect, you have to deal with this strong execution order coupling, but the protocol is pretty stable which limits the actual impact. @@need to check/elaborate a bit more

## Connascence by Timing

Connascence by Timing means that two elements are coupled because they need to agree on timing.

An example: a producer produces data, a consumer processes the data, both work concurrently and asynchronously. This can be multiple threads or separate services. How do we ensure each produced value is consumer once and only once?

![a producer and consumer that exchange a value asynchronously](/attachments/blogposts/2026/connascence/producer-value-consumer.jpg)

There are different patterns and mechanisms to handle a timing dependency like this. We can use probes, semaphores, locks, promises, observables.

Alternatively, we can relax the exactly once constraint to at least once and reduce the timing coupling. This reduces synchronisation complexity, in particular for failure scenarios, but it puts a higher burden on the consumer: the consumer needs to be able to handle duplicate values. Idempotency of messages or commands can help here.

What if there is a single producer and multiple consumers, and we need to make sure each value is read exactly once, by exactly one consumer?

![single producer, multiple consumers](/attachments/blogposts/2026/connascence/queue-overtaking-2.png)

When a consumer starts reading a value, it can create a lock to ensure it is the only one reading at that moment.

![single producer, only one consumer reads at a time](/attachments/blogposts/2026/connascence/queue-overtaking-3.png)

@@Alternatively, we can partition the data, so each consumer has its own part of the data to consume. 

One particular situation where we suffer from Connascence by Timing, is in automated end-to-end testing, in particular with browser-based tests. It takes time for the system under test to process changes and make these visible, and frontend applications in particular have all kinds of asynchronous parts. Probes help a lot here and end-to-end testing frameworks like [Playwright](https://playwright.dev/) are getting better at handling timing and asynchronous behaviour in a simple way.

### Eventual consistency

We can sometimes be less strict in agreeing on timing, and settle for data being eventually consistent. Eventual consistency gives more options for the different parts of the system to eventually (within milliseconds or maybe even seconds) settle on a change.

Whether or not eventual consistency can be used is a business decision: often, having an inconsistent state for a short amount of time is good enough and it is not worth adding the complexity of tightening consistency constraints. If I transfer money with my banking app, I often see the old balance for a second in the app until the transfer is processed, which is good enough.

![single producer, only one consumer reads at a time](/attachments/blogposts/2026/connascence/eventual-consistency.jpg)

## Connascence by Value

Connascence by Value means two elements are coupled because they need to agree on a specific value. Several values in different parts of the code or in different systems need to change together, otherwise the correctness of the system will break. 

If the Organization Management service sets the type of an organization to a specific number, e.g. 22, other services that use organizations will know and use this specific value as well, e.g. in an if statement in the picture below.

![one service sets the value 22, the data passes through other services, and some other service checks if the value is 22](/attachments/blogposts/2026/connascence/cov-org-type.jpg)

Connascence by Value is somewhat similar to Connascence by Meaning, but the latter is more about meaning, conventions, usage, interpretation of values, while the Connascence by Value is about specific values. It can be more tricky, especially if the values are used in different systems and codebases, e.g. a hard coded '22' in Java code and a value 22 somewhere in a database column.

### Tackling Connascence of Execution Order

If the elements are close enough (in the same codebase), we have a few options to reduce the pain:
- We can extract the special value into constant. This reduces the connascence to Connascence by Name. If the connascence is between different code bases using the same language, we can investigate moving the value references in a shared library.
- Sometimes we can generalize the code that uses the value, and inject the special value instead of hard-coding it. This reduces it to Connascence by Type or Meaning.
- We can bring all code that knows the special value close together, e.g. in one class, and reduce it to Connascence by Meaning

## Connascence by Identity

Connascence by Identity means that two elements need to agree on the identity of something, i.e. they need to make sure they are using the exact same thing or instance.

Creating a new object instance and then using that object introduces Connascence by Identity - code like shown below knows exactly which instance it is using, namely the one it has created itself.

```java
var p = new Person();
p.doSomething();
return p;
```

Another (trivial) example: the `this` or `self` reference in instance methods always refers to the object the method was invoked on. 

These two forms of Connascence by Identity are not problematic.

However, most of our code however does not care (or should not care) about what specific instances it is using. 

@@singletons

@@hex arch: creation of dependencies in one place, inject everywhere

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
<p>We offer workshops in this area, e.g. explore coupling and cohesion through a hands-on workshop.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
