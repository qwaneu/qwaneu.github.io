---
layout: post
title: "TDD Heuristics: Act stupid in implementation"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

_Do the simplest thing that could possibly work_ in production code,
so that the test will pass. Cheating and faking are allowed.

Stupid means very simple, not complicated. We don't write
conditionals to cheat; when it becomes complicated or difficult to
cheat, we stop cheating and go for the simplest good solution.

An example: if we need to add a comparison to make a test pass, we prefer
to start with ==, not with >=, because there is probably no test yet 
that requires the greater than.

```java
public void deliversItemWhenPaid() {
  ...
  machine.pay(1);
  assertThat(machine.deliver(), is(expectedItem));
}
class VendingMachine {
  public Optional<Can> deliver(Choice choice) {
    ...
    if (amountPaid == price) { 
      // not >=, unless we have a test that demands it!
    }
  }
}
```

This feels awkward, because we write almost nothing. We 'know' what the implementation should be. 
But quite often we don't. So we go for the simplest thing and we end up with a much simpler 
and more elegant solution than we initially imagined.
