---
layout: post
title: "TDD Heuristics: One Assert Per Test"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

We do not like long test scenarios with loads of different asserts. 
A test case having many expectations is difficult to understand when it fails.

> ![assertsMany.jpg](assertsMany.jpg){width=180px}\  

A test should have one (and only one) reason to fail. For each mistake,
only one test should fail.

> ![oneassert.png](oneassert.png){width=180px}\  

Test one thing per test:

```java
public void savesOrderAndNotifiesOwnerIfPaid() {
  // this test asserts different behaviours:
  verify(repository).save(order);
  verify(notifier).notify("owner@x.com", orderNumber)
}

// Preferably, we split them up:
public void savesOrderIfPaid() {
  ....
  verify(repository).save(order);
}
public void notifiesOwnerIfPaid() {
  ....
  verify(notifier).notify("owner@x.com", orderNumber)
}
```

## Further reading

The One Assertion Per Test rule was originally coined by eXtreme Programmer Dave Astels (of RSpec fame) back in 2004 https://www.artima.com/weblogs/viewpost.jsp?thread=35578
