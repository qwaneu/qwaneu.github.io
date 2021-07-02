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

When making it work, _do the simplest thing that could possibly work_ in
production code, so that the test will pass. Cheating and faking are allowed.

We act stupid in implementation. With 'Stupid' we mean keeping it very simple
and straightforward. We do the bare minimum to make the test green, not even the
tiniest bit more. We don't write complicated code or conditionals to make the
test pass. If we would need complicated code, it's simpler and better to use the
proper (but still simple) implementation instead.

## Example

Another example for our drinks vending machine: it delivers a drink when you
have paid the exact price. To make a test for this case pass, we will need some
comparison. We prefer to start with just checking equality and not add
greater/lesser than yet, although we will need that eventually.

```java
public void deliversWhenPaid() {
  ...
  machine.pay(1);
  assertThat(machine.deliver(Choice.Cola), is(expectedItem));
}

class VendingMachine {
  public Optional<Can> deliver(Choice choice) {
    ...
    if (amountPaid == price) { // not >=, unless we have a test that demands it!
      ...
    }
  }
}
```

This feels awkward, because we write almost nothing. We 'know' what the
implementation should be; we know that we eventually should have a greater than
or equal operator here. But we don't have a test for this case yet, so we go for
the slightly simpler equality.

## Effects

Even though we often think we already know the 'proper' solution, we still apply
this guideline to take baby steps towards our goals. We noticed that we often
end up with a simpler and more elegant solution than we initially imagined. As
developers we tend to be good thinking up complicated solutions and handling
these, this guideline helps us to arrive at simpler code.

By taking the small steps, we force ourselves to add tests for edge cases. We
know that the == is not good enough, so we write an extra test (_delivers item
when paid too much_) that will fail initially. It is the path of least
resistance towards covering both happy paths and edge scenarios.

Acting Stupid in Implementation works well in a 'ping-pong' pair programming
setting, where one writes the test, and the other tries to get away with as
little code as possible to make it pass. 

## Further reading

@@links!


_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. Deliberate practice and learning by doing may make your wishes come true..
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
