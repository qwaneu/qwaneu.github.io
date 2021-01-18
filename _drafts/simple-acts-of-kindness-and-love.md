---
layout: post
title: Simple acts of kindness and love
tags:
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers, Willem van den Ende
image: 
---

> "Saruman believes that it is only great power that can hold evil in check. But
that is not what I have found. I have found it is the small things. Everyday
deeds of ordinary folk that keeps the darkness at bay. Simple acts of kindness
and love." -- Gandalf (J.R.R. Tolkien, The Hobbit)

In [Maximizing Developer
Effectiveness](https://martinfowler.com/articles/developer-effectiveness.html),
Tim Cochran writes about the importance of shortening feedback loops in
development. Fast feedback is important for developers, to prevent waiting and
task switching, and to stay in a state of flow. He specifically recommends
focusing on improving the "micro feedback loops", the fast feedback loops that
developers experience tens or hundreds of times a day. 

Putting effort in improving these, e.g. making your unit test suite a few
seconds faster, is often hard to explain and justify. It can take some time
before you, and especially the people around you start noticing
the effects. So it seems like you are focusing on futile things, not on the
'big' problems. In the end however, it all adds up. Improvements are
multiplicative.

In this way, putting effort in small improvements has a multiplicative, even
exponential effect. Doing a tiny bit of improvement everyday can help in
breaking away from what Jim Shore calls [Stumbling through
mediocrity](https://www.jamesshore.com/v2/blog/2009/stumbling-through-mediocrity).

![@@consultants diagram of exponential improvement]()

## Systemic effects of improving small stuff

There are some interesting things at play here, that might not be obvious
initially:
- doing small improvements on the micro feedback loops compounds - it is 'no
  noticeable change' + 'no noticeable change' + 'no noticeable change' + ... =
  'definitely noticeable change' (@@ref Secrets of Consulting)
- doing small improvements every day gets you in the habit of just doing these
  improvements; it will require less mental effort to think about them or decide
  to do it
- growing a habit of doing many small improvement means that you get well versed in doing
  it. This means that you will grow better at it over time, making it easier to
  do even more improvements
- "learning to see" - the more you do the small improvements, the better you are
  able to see new opportunities for improvement. You will start noticing all kinds of code smells in code that a year ago you
  thought was good enough
- the multiplicative effect will manifest itself after a delay, so cause and
  effect might not obvious for others. You also may not get the credit you
  deserve: true skill is invisible
- the multiplicative effect can eventually result in order-of-magnitude
  improvements in feedback loops, and
  [order-of-magnitude improvements tend to change the game, like we wrote
  earlier](/2020/11/27/paying-the-price-of-fast-tests.html).

![@@diagram of effects]()

## Examples

A team at a client that was maintaining multiple legacy systems was struggling
with 'productivity' (at least in the eyes of their internal customers). Some of
the code was 20 years old, and it was quite difficult to make changes in a
responsible way. After some tough conversations with management and customers,
they started allocating a fix budget per sprint to work on the legacy code, do
step by step improvements through refactoring. Initially this did not show any
improvement (in a way they were even less productive for their customers because
they allocated less time for customer work). On the longer term (1-2 years) the
improvements had started to make a big differences, making it much easier,
faster, cheaper to make new changes.

## Further reading

Ursula Le Guinn on male magicians like Gandalf (I know, I suggested Gandalf, and then inevitably something pops up in my twitter feed.)
