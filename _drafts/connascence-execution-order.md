---
layout: post
title: "Connascence: Execution Order (part 6)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: 
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning, position and algorithm. In this post, we will discuss Connascence by Execution Order.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }


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

## Tackling Connascence of Execution Order

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

We also used a [fluent interface](https://martinfowler.com/bliki/FluentInterface.html), which can also help enforcing specific ordering via the compiler.

Sometimes the set of statements in a specific order is repeated in multiple places in the code. The higher the degree of this connascence, the more painful it gets. We can reduce the degree by extracting the statements and ordering in a function and calling the functions wherever it is needed. Note that we still have Connascence by Execution within that function.

@@ Hexagonal Architecture

@@ Another example: The OpenID Connect protocol. The OpenID Connect protocol uses a specific way of orchestrating authentication/authorization between multiple servers. When using OpenID Connect, you have to deal with this strong execution order coupling, but the protocol is pretty stable which limits the actual impact. @@need to check/elaborate a bit more


## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Timing, where two elements need to agree on timing.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm]()
- *Part 6 - Connascence by Execution Order*
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
