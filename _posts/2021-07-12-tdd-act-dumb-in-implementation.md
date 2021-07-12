---
layout: post
title: "TDD Heuristics: Act Dumb in Implementation"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/act-dumb.jpg
---

When we have written a failing test, we try to make it work in the simplest
possible way - _do the simplest thing that could possibly work_. We prefer baby
steps, so at each step we understand precisely what we are doing, even if we
have not solved the whole problem yet. Cheating and faking are allowed.

We act dumb in implementation. With 'dumb' we mean keeping it very simple
and straightforward. We do the bare minimum to make the test green, not the
tiniest bit more. We don't write complicated code or conditionals to make the
test pass. If we would need complicated code, it's simpler and better to use a
proper (but still simple) implementation instead.

![act dumb in implementation - person shrugging](/attachments/blogposts/2021/tdd/act-dumb.jpg)
{: class="post-image post-image-50" }

## Example

Let's look at another example from the drinks vending machine we [mentioned
earlier](/2021/06/28/tdd-think-about-design-in-test.html). We write a test for
_the vending machine delivers a drink when you have paid the exact price._ 

```java
@Test
public void deliversWhenPaidExactPrice() {
  ...
  machine.pay(1);
  assertThat(machine.deliver(Choice.Cola), is(Optional.of(Can.Coke)));
}
```

To make this test pass, we need to perform some comparison. Maybe you're
thinking of something like checking if the amount paid is less than or equal to
the price of the drink, but we prefer to start with just checking equality.

```java
class VendingMachine {
  public Optional<Can> deliver(Choice choice) {
    ...
    if (amountPaid == this.price) {
      ...
    }
  }
}
```

The `==` is sufficient to make our test pass, even though we know that we will
need a '>=' eventually. We don't have a test for this case yet, so we go for the
simpler equality. We know that we have to write a new test, for instance
_delivers drink when paid more than the price_. This helps us to take baby
steps.

## Effects

Even though we often have the 'proper' solution already in our heads, we apply
this guideline to take baby steps towards our goals. We frequently end up with a
simpler, more elegant solution than we initially imagined. As developers we are
good at thinking up complicated solutions and handling these, this guideline
helps us to arrive at simpler code. Which also gives us less to handle later on.

By taking small steps, we force ourselves to add tests for edge cases. We
know that `==` is not good enough, so we write an extra test that will fail
initially. It is the path of least resistance towards covering both happy paths
and edge scenarios.

We are notoriously bad at things like getting our comparators right and getting -1/+1 boundaries correct. The _Act Dumb in Implementation_ guideline helps us
getting this right from the start. It has saved us a lot of issues.

_Act Dumb in Implementation_ works well in a 'ping-pong' pair programming
setting, where one person writes the test, and the other tries to get away with
writing the bare minimum amount code needed to make the test pass. This is great
fun to do, and really sharpens our sense for what is minimal.

## Further reading

The [Do The Simplest Thing That Could Possibly
Work](https://ronjeffries.com/xprog/articles/practices/pracsimplest/) rule
originates from [eXtreme
Programming](https://www.agilealliance.org/glossary/xp). This rule focuses on
radical simplicity in your code. By keeping it in mind, you intend to refrain
from thinking ahead of all kinds of possible scenarios and creating generic
solutions. 

Keeping the working code as simple as possible, does not mean we will code
ourselves into a corner. On the contrary, we keep more options open, because
there is less code getting in the way when we need to change it later on.

Keeping things simple has all kinds of second order effects, like Kent Beck
states in this little gem found on the [Do The Simplest Thing That Could
Possibly Work page](http://c2.com/xp/DoTheSimplestThingThatCouldPossiblyWork.html) on the C2 wiki:

> There are second order effects to asking yourself "What is the simplest thing that could possibly work?" -- KentBeck
> -   You get done sooner
> -   Your work is easier to communicate
> -   Duplication is obvious, so the needs and means for refactoring are clearer
> -   Tests are easier to write
> -   The code is easier to performance tune Or, at least, there will be more scope for tuning performance
> -   You feel less stress, which enhances all of the above 

Read more about the [Simplest Thing That Could Possibly Work](https://www.artima.com/articles/the-simplest-thing-that-could-possibly-work).

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Be smart, act dumb in implementation! Join us for a Test Driven Development course. Deliberate practice and learning by doing may make your wishes come true...
  </p>
  <p><div>
    <a href="/training/test-driven-development">Check availability</a>
  </div></p>
</aside>
