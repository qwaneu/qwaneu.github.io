---
layout: post
title: "Connascence: Algorithm (part 5)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/algorithm-thumbnail.png
---


In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning and position. In this post, we will discuss Connascence by Algorithm.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Algorithm

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

## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Execution Order, where two elements need to agree on the order in which steps are executed.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- *Part 5 - Connascence by Algorithm*
- [Part 6 - Connascence by Execution Order](/2026/06/08/connascence-execution-order)
- [Part 7 - Connascence by Timing](/2026/06/12/connascence-timing)
- [Part 8 - Connascence by Value](/2026/06/17/connascence-value)
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
