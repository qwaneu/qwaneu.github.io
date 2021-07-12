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

When we have written a failing test, we try to make it work in the simplest
possible way - _do the simplest thing that could possibly work_. Cheating and
faking are allowed.

We act stupid in implementation. With 'stupid' we mean keeping it very simple
and straightforward. We do the bare minimum to make the test green, not even the
tiniest bit more. We don't write complicated code or conditionals to make the
test pass. If we would need complicated code, it's simpler and better to use the
proper (but still simple) implementation instead.

## Example

Let's look at another example from the drinks vending machine we mentioned
earlier. We write a test for: the vending machine delivers a drink when you have
paid the exact price. 
```java
@Test
public void deliversWhenPaidExactAmount() {
  ...
  machine.pay(1);
  assertThat(machine.deliver(Choice.Cola), is(expectedItem));
}
```

To make this test pass, we need to perform some comparison. Maybe you're
thinking of something like checking if the amount paid is less than or equal to
the price of the drink, but we prefer to start with just checking equality.

```java
class VendingMachine {
  public Optional<Can> deliver(Choice choice) {
    ...
    if (amountPaid == price) {
      ...
    }
  }
}
```

The `==` is sufficient to make our test pass, even though we know that
eventually we need a '>='. We don't have a test for this case yet however, so we
go for the simpler equality. In this way, we know that we have to write a new
test, for instance _delivers drink when paid more than the price_.

## Effects

Even though we often have the 'proper' solution already in our heads, we still
apply this guideline to take baby steps towards our goals. We noticed that we
tend to end up with a simpler and more elegant solution than we initially
imagined. As developers we tend to be good thinking up complicated solutions and
handling these, this guideline helps us to arrive at simpler code.

By taking the small steps, we force ourselves to add tests for edge cases. We
know that `==` is not good enough, so we write an extra test that will fail
initially. It is the path of least resistance towards covering both happy paths
and edge scenarios.

We are notoriously bad at getting our comparators right and getting the -1/+1
boundaries correct. The _Act Stupid in Implementation_ guideline helps us
getting this right. It saved us a lot of issues.

_Act Stupid in Implementation_ works well in a 'ping-pong' pair programming
setting, where one writes the test, and the other tries to get away with as
little code as possible to make it pass. 

## Further reading

The [Do the simplest thing that could possibly
work](https://ronjeffries.com/xprog/articles/practices/pracsimplest/) rule@@
originates from eXtreme Programming. This rule focuses on radical simplicity in
your code. By keeping it in mind, you intend to refrain from thinking ahead of
all kinds of possible scenarios and creating generic solutions. 

By keeping the code as simple as possible (and working), we don't code ourselves
into a corner. On the contrary, we keep more options open because there is less
code getting in the way when we need to change it later on.

Keeping things simple has all kinds of second order effects, like this little
gem from Kent Beck which we found on the [Do The Simplest Thing That Could
Possibly Work page on the C2
wiki](http://c2.com/xp/DoTheSimplestThingThatCouldPossiblyWork.html):

> There are second order effects to asking yourself "What is the simplest thing that could possibly work?" -- KentBeck
> -   You get done sooner
> -   Your work is easier to communicate
> -   Duplication is obvious, so the needs and means for refactoring are clearer
> -   Tests are easier to write
> -   The code is easier to performance tune Or, at least, there will be more scope for tuning performance
> -   You feel less stress, which enhances all of the above 

Read more about the [Simplest Thing That Could Possibly Work](https://www.artima.com/articles/the-simplest-thing-that-could-possibly-work)

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. Deliberate practice and learning by doing may make your wishes come true..
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
