# Things that always need to be consistent

If something changes in the system, what parts of the system need to be
immediately consistent with that change? For a candidate aggregate, does the
whole thing always need to reflect any change immediately? Or is some delay
acceptable? If we see that for some parts having some delay is good enough, this
indicates we might have two concepts rather than one. We can try to split the
aggregate.

Let's look at two examples, from an online store:

> _"Any product that the buyer puts in their basket should be in stock."_ Is this
  a hard consistency rule or is it more lenient? If we stick to this rule in a
  strict way, things get complicated: what if multiple buyers put same item in
  basket, and there are more product instances in the baskets than in stock?
  Some buyers will drop off before checking out, so by allowing more products in
  baskets that we have in stock ("overbooking") we can have more sales.

> _"When we update the description of a product we offer in our shop, these
  changes are immediately visible in our product catalogue"_ Do these changes
  really need to be _immediately_ propagated across the whole system? What is an
  acceptable delay from a business perspective? A delay of a few seconds is
  usually acceptable. Allowing delay gives us more options in our technical
  solution, for instance in making it scale or perform well.

## A business decision

What must stay consistent is a business decision, not only a technical
constraint. 

Together with business and domain experts, discuss what is an acceptable delay
between a change and the whole system reflecting the new state. Even though
the initial answer might be "every change should be reflected immediately by the
system", in our experience this is often negotiable. 

The level of consistency is a trade-off: achieving a very high degree of
immediate consistency across the whole system is complex and expensive, so
strive for 'good-enough'. We ensure local consistency via aggregates, and
**Eventual Consistency** for the rest of the system.

@@Also gives Real Options to split up later. (prevents queries across the
domain. this has good and bad sides - less Coupling but also harder to get
answers from. Before you know it, you have a data lake).

Note that [invariant conditions](#org0f4ad32) and consistency go hand in hand.
Ensuring that specific business conditions should always hold is a different way
of looking at an aggregate that stays consistent within its boundaries.

