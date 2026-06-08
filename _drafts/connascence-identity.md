---
layout: post
title: "Connascence: Identity (part 9)"
tags:
  - architecture
  - coupling
  - design
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: 
---

In the previous posts, we [introduced the Connascence model as a model of coupling](/2026/05/08/connascence-intro) and elaborated connascence by name, type, meaning, position and algorithm. In this post, we will discuss Connascence by Identity.

Connascence is a model for reasoning about coupling and defines three dimensions of coupling: strength, degree and distance, as the picture below shows.

![connascence in three dimensions, from green to red](/attachments/blogposts/2026/connascence/slide-19-degree.png)
{: class="post-image post-image-50" }


## Connascence by Identity

Connascence by Identity means that two elements need to agree on the identity of something, i.e. they need to make sure they are using the exact same thing or instance.

![connascence by identity](/attachments/blogposts/2026/connascence/slide-15-identity.png)
{: class="post-image post-image-50" }

Creating a new object instance and then using that object introduces Connascence by Identity - code like shown below knows exactly which instance it is using, namely the one it has created itself.

```java
var p = new Person();
p.doSomething();
return p;
```

Another example: the `this` or `self` reference in instance methods always refers to the object the method was invoked on. This coupling to identity is inevitable in this case, but also quite harmless because it is local - all contained within the same class.

## Singletons

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

## Managing Connascence by Identity

To reduce connascence by identity in a component, we apply dependency injection. This works well e.g. with Hexagonal Architecture. Instantiating services and adapters takes place in one place, in a `main` function or some Spring configuration code. These are injected into the rest of the code, which takes these as explicit dependencies. This reduces the identity coupling to a single place in the code, reducing the degree.

We also recommend keeping connascence by identity local, confined to a class or a function.



## What's next

This post is part of a series on connascence and coupling. In the next post, we will focus on what we can to manage connascence and coupling in our software.

- [Part 1 - Introduction](/2026/05/08/connascence-intro)
- [Part 2 - Connascence by Name and Type](/2026/05/13/connascence-name-type)
- [Part 3 - Connascence by Meaning](/2026/05/21/connascence-meaning)
- [Part 4 - Connascence by Position](/2026/05/29/connascence-position)
- [Part 5 - Connascence by Algorithm](/2026/06/03/connascence-algorithm)
- [Part 6 - Connascence by Execution Order](/2026/06/08/connascence-execution-order)
- [Part 7 - Connascence by Timing]()
- [Part 8 - Connascence by Value]()
- *Part 9 - Connascence by Identity*
- Part 10 - Heuristics for managing coupling

<em>Credits: Flowchart thumbnail Photo by <a href="https://unsplash.com/@wocintechchat?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Christina @ wocintechchat.com M</a> on <a href="https://unsplash.com/photos/person-writing-on-dry-erase-board-tYVkjjMYFBo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></em>
      
<aside>
<h3>Decouple more deliberately!</h3>
<p>We offer hands-on workshops about connascence and refactoring towards loosely coupled, highly cohesive systems.
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
