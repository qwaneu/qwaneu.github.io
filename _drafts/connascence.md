---
layout: post
title: Connascence - a model for reasoning about coupling
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence-visualised-2.jpg
---

In this post, we will describe connascence, a model that describes coupling and cohesion in multiple dimensions. This model gives you an energy label to determine how energy efficient your coupling is.

Coupling is unavoidable. But you have to choose what kind of coupling is a good fit where.

The connascence model provides a fine-grained model to reason about different forms and degrees of coupling. It provides options to reduce coupling and improve cohesion. We find it a useful perspective on coupling, in addition to to other ones. It is not about removing all coupling. As we stated in the [previous post about coupling](/2026/01/23/on-coupling):

> Without coupling, there is no working software.

We accept coupling and deliberately decide the trade-offs. We focus on keeping it explicit and manageable. We keep parts that are tightly coupled by nature closely together, increasing cohesion.

For parts that are coupled but less tightly, we make sure the coupling is as explicit as possible, aided by tooling and automated tests.

In this post, we will introduce the connascence model, starting with its definition, then elaborating the three dimensions. After this, we will provide guidelines and considerations on how to reduce coupling and increase cohesion using the model.

@@This is a longer post, we have not (yet) managed to make it shorter. So what lies ahead? We will first give a definition of Connascence, and then elaborate its' three dimensions. We will also discuss how this can help in managing coupling and how it helps in knowing where to refactor to.

## Connascence defined 

The concept of Connascence was introduced by Meilir Page-Jones in his work on object-oriented design in the 1990s. He observed that coupling and cohesion are closely related and tried to catch them both using a new term.

> I chose the word "connascence" from the Latin roots meaning "born together." It is etymologically close to the French "connaissance" meaning knowledge, awareness or consciousness.
> 
> An undertone of this meaning is "having intertwined destinies in life."
>
> -- Meilir Page-Jones

Two software elements are connascent if:

*a change in one would require the other to be modified to maintain the overall correctness of the system*

or

*for some change, both would be required to change to maintain the overall correctness of the system*

A software element can be a function, a class,  database tabel or schema, a package, a component, an application, a (micro)service, a subsystem. 

The picture below illustrates the definition of connascence. It shows two elements, both of them consisting of smaller parts (e.g. classes and functions):

![Schematic visualization of two software elements and their parts (modules, classes, functions, types)](/attachments/blogposts/2026/connascence/connascence-visualised-1.jpg)

We can visualize different parts that need to change together by connecting them with red lines:

![Schematic visualization of coupling between different parts of two software elements using red lines to connect parts that are coupled](/attachments/blogposts/2026/connascence/connascence-visualised-2.jpg)

This definition of connascence (and coupling) is already useful on its own. It shifts our focus from dependencies to what parts need to be kept consistent with each other. This also helps to make conversations about duplication more pragmatic. Removing duplication is not about extracting identical or similar pieces of code, but rather about putting things together that need to change together. Code similarity is an indicator for possible coupling, not something that always has to be refactored.

## Dimensions of Connascence

The connascence model introduces three dimensions to reason about coupling and cohesion:

1. **Strength** or type - how easy or difficult it is to detect coupling and manage changes in coupled elements;
2. **Locality** - the distance between two coupled elements;
3. **Degree** - the number of elements that are coupled.

We will define the three dimensions and then elaborate the 9 types of connascence with examples.

### Strength

The 9 types of connascence are, in order of increasing strength:

1. **Connascence by Name** - two elements need to agree on the same name;
2. **Connascence by Type** - two elements need to agree on the same type;
3. **Connascence by Meaning**  - two elements need to agree on the meaning of particular values;
4. **Connascence by Position** - two elements need to agree on the order of values;
5. **Connascence by Algorithm** - two elements need to agree on a shared algorithm or protocol;
6. **Connascence by Execution Order** - two elements need to agree on the order in which steps are executed;
7. **Connascence by Timing** - two elements need to agree on timing;
8. **Connascence by Value** - two elements need to agree on a specific value;
9. **Connascence by Identity** - two elements need to agree on the identity of something, i.e. they need to make sure they use the same thing.

We can visualize this from green to red, as a kind of energy label for coupling:

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)

The first five are called *static* connascence, because these can be detected using a compiler or static code checks. The other types are called *dynamic* &mdash; they are related to the dynamic behaviour of the code.

![9 types of connascence with 5 static and 4 dynamic](/attachments/blogposts/2026/connascence/slide-16-dynamics.png)

The static types of connascence, and especially Name, Type and Meaning, are explicit forms of coupling. The stronger types of connascence become more implicit.

### Locality

The Locality dimension of connascence refers to the distance between two coupled elements. The higher the distance, the more difficult it is to detect the coupling. Especially when the elements are in different applications, code bases or systems, the coupling becomes quite implicit and hard to manage.

In Vlad Khononov's Balanced Coupling model, he mentions "socio-technical distance", which is a useful addition. If two elements are not only far apart but are also owned by different teams, he impact of coupling will be higher. If the teams are part of different organisations, it will be even worse.

### Degree

The Degree dimension of Connascence refers to the number of elements that are coupled, i.e. the number of elements that are affected by a specific change. More elements means more work, and a higher chance of missing one element when updating.

Adding a layer of indirection by introducing a stable abstraction helps to reduce the impact of changes, by isolating the part that changes and making the rest more stable.

![left part showing 5 elements having 'bad' coupling with red lines, right part having a new element in between, decoupling the stable part from the volatile part](/attachments/blogposts/2026/connascence/managing-degree-with-abstraction.jpg)

## Connascence by Name and by Type

Two elements are connascent by Name or Type if they must agree on the same name or type. If a function is called `foo`, the calling code must use the same name. Renaming the function means changing the calling code. The same holds for types. Code using a type (e.g. class) must change if the type changes.

![connascence by name and type](/attachments/blogposts/2026/connascence/slide-6-type-example.png)

Connascence by Name or Type is very explicit. The compiler or interpreter will provide feedback if we forget a change somewhere. Automated refactoring tooling makes this kind of coupling often easy to manage.

```java
class Bar {
  void foo() { ... }
}

var bar = new Bar();
bar.foo();
```

The *locality* of coupling impacts the effort and risk in managing coupling. If the elements are all in the same code base, our tooling will do most of the work, and the risk will be minimal. 

If the distance between two coupled parts is higher, e.g. a class `Customer` with attributes `name` and `address` in our code which should match our database table `Customer` with columns `Name` and `Address`. Extra tool support can help her, e.g. using an adapter integration test that covers the database integration.

![a representation of a database table CUSTOMERS with columns NAME and ADDRESS with should correspond to a class Customer with properties Name and Address](/attachments/blogposts/2026/connascence/name-table.png)

@@ Refactor to? What to do about it? not much; bring stuff closer together if you can (move towards more cohesion); use automated tests to capture coupled elements with distance

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

Connascence by Position means that two elements need to agree on the order of values. 

![connascence by position](/attachments/blogposts/2026/connascence/slide-9-position.png)

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

![connascence by algorithm](/attachments/blogposts/2026/connascence/slide-10-1-algorithm-example.png)

We see Connascence by Algorithm whenever two services need to exchange data, e.g. over the network. To consume an API, you need to know how the API works, what data in what format is returned. This also holds for file exports/imports

![picture showing a producer and a consumer that are coupled via a shared protocol](/attachments/blogposts/2026/connascence/algorithm.png)

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

![connascence by execution order](/attachments/blogposts/2026/connascence/slide-12-execution.png)

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

![connascence by timing](/attachments/blogposts/2026/connascence/slide-13-timing.png)

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

There are trade-off here. For example, eventual consistency makes it more complicated to detect that something did _not_ happen. Explicit queries at some time are needed for instance, whereas a timeout, optionally with a back-off algorithm is _relatively_ simple.

## Connascence by Value

Connascence by Value means two elements are coupled because they need to agree on a specific value. Several values in different parts of the code or in different systems need to change together, otherwise the correctness of the system will break. 

![connascence by value](/attachments/blogposts/2026/connascence/slide-14-value.png)

If the Organization Management service sets the type of an organization to a specific number, e.g. 22, other services that use organizations will know and use this specific value as well, e.g. in an if statement in the picture below.

![one service sets the value 22, the data passes through other services, and some other service checks if the value is 22](/attachments/blogposts/2026/connascence/cov-org-type.jpg)

Connascence by Value is somewhat similar to Connascence by Meaning, but the latter is more about meaning, conventions, usage, interpretation of values, while the Connascence by Value is about specific values. It can be more tricky, especially if the values are used in different systems and codebases, e.g. a hard coded '22' in Java code and a value 22 somewhere in a database column.

### Tackling Connascence by Value

If the elements are close enough (in the same codebase), we have a few options to reduce the pain:
- We can extract the special value into constant. This reduces the connascence to Connascence by Name. If the connascence is between different code bases using the same language, we can investigate moving the value references in a shared library.
- Sometimes we can generalize the code that uses the value, and inject the special value instead of hard-coding it. This reduces it to Connascence by Type or Meaning.
- We can bring all code that knows the special value close together, e.g. in one class, and reduce it to Connascence by Meaning

## Connascence by Identity

Connascence by Identity means that two elements need to agree on the identity of something, i.e. they need to make sure they are using the exact same thing or instance.

![connascence by identity](/attachments/blogposts/2026/connascence/slide-15-identity.png)

Creating a new object instance and then using that object introduces Connascence by Identity - code like shown below knows exactly which instance it is using, namely the one it has created itself.

```java
var p = new Person();
p.doSomething();
return p;
```

Another example: the `this` or `self` reference in instance methods always refers to the object the method was invoked on. This coupling to identity is inevitable in this case, but also quite harmless because it is local - all contained within the same class.

### Singletons

Connascence by Identity gets more tricky if it extends beyond these cases. Over-usage of the Singleton pattern is one example. The underlying concern is that there should be a single instance of an object. So we should focus on the creation of this object and make creating multiple instances difficult or impossible. 

However, most of our code however does not care (or should not care) about what specific instances it is using. The code using a Singleton object should not know about it being a singular object instance. 

In practice, the calling code uses the singleton construct directly, like the example below shows for the TrackingCache instance. The code is not so much using singletons to guard against multiple instances, but also as a convenient global variable.

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

This introduces unnecessary coupling, specifically it increases the *degree* of coupling on the singleton instance. Code that does not care about the specific instance gets burdened with this knowledge. This makes the code hard to test for example.

### Managing Connascence by Identity

To reduce connascence by identity in a component, we apply dependency injection. This works well e.g. with Hexagonal Architecture. Instantiating services and adapters takes place in one place, in a `main` function or some Spring configuration code. These are injected into the rest of the code, which takes these as explicit dependencies. This reduces the identity coupling to a single place in the code, reducing the degree.

We also recommend keeping connascence by identity local, confined to a class or a function.

## Managing coupling and cohesion with the connascence model

How can the connascence model help us in refactoring towards loosely coupled, highly cohesive code? In this section, we will discuss a set of refactoring guidelines based on the three dimensions of connascence.

Jim Weirich provided some rules of thumb to guide refactoring towards less coupling:

- Rule of Strength
- Rule of Locality
- Rule of Degree
- Rule of Stability

### Rule of Strength

The Rule of Strength states: try to create weakest possible connascence. 

Convert strong forms of connascence to weak forms wherever possible. Try to refactor towards static rather than dynamic connascence. Encapsulate for example connascence by identity and by value as much as possible in a module, so that the rest of the code base has connascence by type.

### Rule of Locality

As the distance between software elements increases, use weaker forms of connascence. If things are close together, stronger connascence is ok. 

So if you cannot reduce strong connascence to a weaker form, try bringing the elements as close together as possible.

### Rule of Degree

Elements with a high degree of connascence are more difficult to understand and to change. So investigate:
- Why is the degree high?  
- Are we missing an abstraction?  
- Would an extra level of indirection be helpful here?

### Rule of Stability

If two element have a strong form, low locality and high degree of connascence, then they should not change. In other words, those elements should be stable.

Remember that coupling is about things that need to change together. So if things don't need to change, we won't be affected. 

As an example, the `sprintf` in C is widely used so there is a very high degree of connascence. The function is also stable, so the risk is very low.

### Managing connascence with testing, automation and tools

We can try to reduce stronger forms of connascence as much as possible, but sometimes we are left with some dynamic connascence across codebases and across systems that will bite us sooner or later.

Automated testing can help. If we have specific values across the system landscape, we can capture this in some end-to-end test or in local, faster tests that document the value and fail whenever we change the value.

@@ +contract testing

@@test = creates more explicit (weaker strength) coupling to the two dependent elements; [add triangle picture]
test is a piece of explicit knowledge

### Detecting connascence

We mentioned earlier that the static forms of connascence (name, type, meaning, position, algorithm) can often be detected using a compiler or static analysis tools. 

Dynamic connascence is harder to catch, but version control systems can provide insights. We can analyse the git history of the code to see what parts are often changed together, a strong hint these might be coupled somehow. 

Analysing git history can also provide insights in what parts of our code are changing a lot and what parts are stable, to know where to focus on.

### Example 1

*If we put a queue between two components, have we 'decoupled' them?*

We have reduced **Connascence of Timing**, but we still have **Connascence of Algorithm** & **Meaning**

### Example 2

*Do we avoid coupling by duplicating some code instead of introducing a shared abstraction?*

We still have **Connascence of Meaning**, but the coupled elements are not
localized. We risk achieving the opposite of what we intend: even stronger coupling!

## Summary

We want 'loose coupling'. But without coupling, there is no working software. Managing coupling is an important part of our work. 

Connascence offers a language to talk about coupling and cohesion. It is not bound to a specific paradigm and applies equally to object oriented programming, functional programming, SQL, stored procedures.

Coupling is not binary! The connascence model offers three dimensions to reason about coupling: **strength**, **locality**, **degree**. 

We want to isolate strong coupling as much as possible in one place, and use weaker forms of coupling when the distance and/or degree is high.

The connascence model is not perfect. The distinction between the types is not always clear. The distinction between connascence by meaning and connascence by value is sometimes a bit diffuse. The ranking of the different types (the strength) is not always that strict in practice.

This model is still quite useful in practice, because:
- It gives a rich vocabulary to reason about forms, degrees and locality of coupling.
- It recognises that the goal is not getting rid of coupling, but rather keeping coupling explicit, limited, and manageable.

## Related work

[Coupling](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) and [cohesion](https://en.wikipedia.org/wiki/Coupling_(computer_programming)) are very old concepts in software development since the beginning. The concepts were introduced by Larry Constantine in the 1960s, and several people have tried to refine them and make them measurable.

The Connascence model dates back to the 1990s and we still find it useful. It brings together coupling and cohesion as basically the same thing.

A recent addition is Vlad Khononov's Balanced Coupling model, described in his [book](https://coupling.dev/posts/learning-resources/) and on the [Balanced Coupling website](https://coupling.dev/). Khononov's model has some overlap with connascence. He defines three slightly different dimensions of coupling:

1. **Integration Strength** - comparable but with a slightly different angle than connascence strength
2. **Distance** - methods, objects, packages, services, systems
3. **Volatility** - how stable or volatile are the different coupled elements; volatility/stability is referenced in the Connascence model but not recognised as a dimension. It is a useful dimension that we've also mentioned in the guidelines.

## Further reading 

- [I Still Feel the Urge to Reuse Code (Even Though I Know It's Wrong)](https://www.linkedin.com/pulse/i-still-feel-urge-reuse-code-even-though-know-its-wrong-dilger-yphie/) by Martin Dilger
- Another good read from this year is [Cohesion, Modules, and Hierarchies](https://ewolff.com/2026/01/08/cohesion-modules-hierachies.html) by Eberhard Wolff
* Meilir Page-Jones, Fundamentals of OO Design in UML (1999)
* Meilir Page-Jones, [Comparing Techniques by Means of Encapsulation and Connascence](www.researchgate.net/publication/220424550_Comparing_Techniques_by_Means_of_Encapsulation_and_Connascence), in Communications of the ACM Sept 1992 
* Jim Weirich, [The Grand Unified Theory of Software Design](www.youtube.com/watch?v=NLT7Qcn_PmI), at the Acts as Conference 2009  
* [Connascence.io](https://connascence.io)
* Vlad Khononov, [Balancing Coupling in Software Design](https://vladikk.com/page/books/).


<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer workshops in this area, e.g. explore coupling and cohesion through a hands-on workshop.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
