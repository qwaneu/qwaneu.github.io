---
layout: post
title: "Connascence: Execution Order (part 6)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/flowchart-whiteboard.jpg
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning, position and algorithm. In this post, we will discuss Connascence by Execution Order.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Execution Order

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

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Timing, where two elements need to agree on timing.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm](/2026/06/03/connascence-algorithm)
- *Part 6 - Connascence by Execution Order*
- [Part 7 - Connascence by Timing](/2026/06/12/connascence-timing)
- [Part 8 - Connascence by Value](/2026/06/17/connascence-value)
- [Part 9 - Connascence by Identity](/2026/06/24/connascence-identity)
- Part 10 - Heuristics for managing coupling

<em>Credits: Flowchart thumbnail Photo by <a href="https://unsplash.com/@wocintechchat?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Christina @ wocintechchat.com M</a> on <a href="https://unsplash.com/photos/person-writing-on-dry-erase-board-tYVkjjMYFBo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></em>

*Updated 10-6-2026: added a paragraph about ports and adapters*

<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer hands-on workshops about connascence and refactoring towards loosely coupled, highly cohesive systems.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
