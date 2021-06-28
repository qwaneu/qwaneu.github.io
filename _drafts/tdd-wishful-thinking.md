---
layout: post
title: "TDD Heuristics: Wishful thinking"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/wishful-2.png
---

Write the test based on how you wish the object under test could be used. Then
make it work. Don't let yourself be limited by constraints and implementation
details... nothing is holding you back! Just write it as you'd wish it to be...

![tdd cycle: test - fail - pass - refactor](/attachments/blogposts/2021/tdd/tdd-cycle-small.png)
{: class="post-image" }

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

## Writing the code you wish you had

By writing test scenarios this way, we can get feedback about our 
design ideas without having to implement them first. This enables us to 
steer the design just in time, based on specific examples in code. It is a bit 
like sketching an [interaction diagram](https://en.wikipedia.org/wiki/Unified_Modeling_Language#Interaction_diagrams) on a very precise digital napkin.

[Thinking about design in
test](/2021/06/28/tdd-think-about-design-in-test.html) is often an act of
wishful thinking, because we are expressing a piece of design in our test that
is about to come to life. 

![Wishful thinking](/attachments/blogposts/2021/tdd/wishful-2.png)
{: class="post-image" }

## Wishful thinking in practice

Let's return to the drinks vending machine test from the previous post. We want
the vending machine to deliver a priced drink when we pay enough. 

```python
# Using Python & pytest
def test_delivers_when_paid_enough():
  bin = Bin()
  machine = VendingMachine(bin=bin) # 1
  machine.configure_choice(Choice.Cola, Can.Coke).with_price(Money.euro(2)) # 2
  machine.insert(Money.euro(2))
  machine.deliver(Choice.Cola)
  bin_contents = bin.retrieve() # 3
  assert_that(bin_contents, equal_to(Can.Coke))
```

We wish for the machine to have a bin as a structural dependency (1). To
configure choices and prices, we would like to have an internal DSL ([domain
specific language](https://martinfowler.com/dsl.html)), chaining the
`with_price` call to the `configure_choice` call. This time we want to do money
properly, for instance with a `euro` creation function on a Money class (2).
Calling `deliver` on the machine drops a drink (hopefully) in the bin, which we
empty using `retrieve` (3).

The code is just a wish in the test, it doesn't exist yet. But it already gives
us feedback about this approach. If we don't like what we see, change is still
very cheap.

We also use wishful thinking for instance when we kind of get stuck
writing a test because the new idea does not readily fit the currently existing
code. By wishful thinking, we don't let ourselves be constrained by the current
solution (for now), but just express how we imagine it to be. Once we have
expressed that, we can evaluate and see what it means for the existing code.

If we get stuck in a design discussion or need to be more precise than just
drawing the lines and boxes on the whiteboard, we can do wishful thinking to
express our train of though and share with our colleagues. It is a cheap and
fast way to get feedback.

BDD with Cucumber is another way to do wishful thinking - write scenarios in natural language, and postpone considerations about realising that wish in code (or otherwise).

## Further reading

The practice of wishful thinking has been around for a while. As far as we know,
it comes from: _Abelson, Sussman & Sussman_, [Structure and Interpretation of
Computer Programs](https://mitpress.mit.edu/sites/default/files/sicp/index.html)

We use [Interaction diagrams](https://en.wikipedia.org/wiki/Unified_Modeling_Language#Interaction_diagrams) sparingly. If we do use them while writing tests we find the [sequence diagram](https://en.wikipedia.org/wiki/Sequence_diagram) on a napkin or whiteboard useful. Especially with potentially complicated interactions or mock objects.

The [Growing Object Oriented Software book](http://www.growing-object-oriented-software.com/) calls this "Write the Test That You'd Want to Read".

In his [video series about Test Driven Development](https://www.jamesshore.com/v2/projects/lunch-and-learn), Jim Shore calls it 'Programming by Intention': 
1. call the functions you wish you had
2. comment it out
3. implement the missing functions
4. test, uncomment, fix up

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Learn wish driven development (WDD) and join us for one of our Test Driven Development courses, which focus on deliberate practice and learning by doing.
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>

