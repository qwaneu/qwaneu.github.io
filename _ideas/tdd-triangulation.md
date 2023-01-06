---
layout: post
title: "TDD Heuristics: Triangulation"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

@@intro How do we ...? We triangulate from 2 or more examples

Triangulation is a TDD technique to generalize production code: 

We start with one example (one test); we make it pass by faking it. 
We add a second example. We now have two 
data points, we can generalize the production code
to suit the generic case.

```java
// start with 1 example:
public void deliversColaWhenChoosingCola() {
  assertThat(machine.deliver(COLA_BUTTON), is(Can.of(COLA)))
}
class VendingMachine {
  public Optional<Can> deliver(Choice choice) {
    return Can.of(COLA);   // fake it!
}}

// add a second example:
public void deliversColaWhenChoosingCola() {
  assertThat(machine.deliver(COLA_BUTTON), is(Can.of(COLA)))
}
public void deliversFantaWhenChoosingFanta() {
  assertThat(machine.deliver(FANTA_BUTTON), is(Can.of(FANTA)))
}
class VendingMachine {
  Map<Choice, Can> choices = ...
  public Optional<Can> deliver(Choice choice) {
    return choices.get(choice);   // generalize it
}}
```

## Further reading


https://dzone.com/articles/three-modes-of-tdd ?

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. 
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
