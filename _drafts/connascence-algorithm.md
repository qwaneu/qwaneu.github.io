---
layout: post
title: "Connascence: Algorithm (part 5)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2026/connascence/slide-10-1-algorithm-example.png
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning and position. In this post, we will discuss Connascence by Algorithm.

Connascence defines three dimensions of coupling: strength, degree and distance, as the picture below shows. 

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }

## Connascence by Algorithm

Connascence by Algorithm means two elements are coupled because they need to agree on a shared algorithm or protocol.

![connascence by algorithm](/attachments/blogposts/2026/connascence/slide-10-1-algorithm-example.png)
{: class="post-image post-image-50" }

We see Connascence by Algorithm whenever two services need to exchange data, e.g. over the network. To consume an API, you need to know how the API works, what data in what format is returned. This also holds for file exports/imports

![picture showing a producer and a consumer that are coupled via a shared protocol](/attachments/blogposts/2026/connascence/algorithm.png)
{: class="post-image post-image-50" }

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

## Managing and refactoring Connascence by Algorithm

What can you do to keep Connascence by Algorithm manageable?

- Using **open & industry standard formats**. The more stable standard formats are, the less consumers & producers need to change, and the less impactful coupling is.
- Using Language independent **schemas** (e.g. JSON schema, [AVRO](https://avro.apache.org/), [Protocol Buffers](https://protobuf.dev/)), schema registries and schema versioning; schemas and schema versioning do not take away the impact of changes, but they make it explicit, visible, manageable. 
- **Contract testing** provides early feedback about producer and consumer changes.

An alternative is creating a shared library that encapsulates the protocol. Both consumer and producer use the shared library. This moves the producing and consumer code together, increasing the locality of connascence.


## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on Connascence by Execution Order, where two elements need to agree on the order in which steps are executed.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning]()
- [Part 4 - Connascence by Position]()
- *Part 5 - Connascence by Algorithm*
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
