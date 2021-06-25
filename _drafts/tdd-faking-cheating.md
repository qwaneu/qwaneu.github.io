---
layout: post
title: "TDD Heuristics: Faking & Cheating"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

One way of _acting stupid in implementation_ is to let the test pass by faking it, 
for example by returning the expected value as a constant. 
This is allowed, we even recommend it! If you
can get away with faking, it means you need another test case to force yourself
to write a more generic implementation.

Faking might feel weird at the beginning, but it helps to proceed towards your 
goal in baby steps and have continuous progress. 

When we fake, we do it with simple code - no ifs, no boolean flags. We've learned that 
if we try to fake with flags or ifs, we'll code ourselves into a corner.

```java
public void deliversColaWhenChoosingCola() {
  assertThat(machine.deliver(COLA_BUTTON), is(Can.of(COLA)))
}

class VendingMachine {
  // Make it work by faking - returning a constant value:
  public Optional<Can> deliver(Choice choice) {
    return Can.of(COLA);
  }
}
```
