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

> Saruman believes that it is only great power that can hold evil in check. But
that is not what I have found. I have found it is the small things. Everyday
deeds of ordinary folk that keeps the darkness at bay. Simple acts of kindness
and love. -- Gandalf (J.R.R. Tolkien, The Hobbit)

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
- growing a habit of doing many small improvement means that you get well versed
  in doing it. This means that you will grow better at it over time, making it
  easier to do even more improvements
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

Let's illustrate this using a diagram of effects.

![step 1](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-1.jpg)
{: class="post-image" }

The impact of improvements might be small, but they do have impact, they reduce
developer toil for instance, or reduce technical debt, or make the whole
delivery process a bit more smooth. Over time, this helps improve productivity.
Now productivity in development is difficult to get a grip on, like we wrote
before in our [Under Pressure post](/2020/10/26/under-pressure.html). Here we
mean "getting more done with the same effort" (or "getting the same done with
less effort").

![step 2](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-2.jpg)
{: class="post-image" }

Higher productivity leads to lower lead time - the time from making a change to
having it running in production. It will also increase development capacity -
which you can decide to spend on features or decide to spend on more
improvements (the black/white square is a management decision - the organization
gets to decide here).

![step 3](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-3.jpg)
{: class="post-image" }

The important thing with many small acts of kindness and love, especially in the
inner feedback loop of software development (i.e. build-test-integrate), is the
multiplicative effects: both the number of small improvements we do and the fact
that the improvements affect processes and actions that we do over and over
again, every hour, every day, multiply the impact of improvements

![step 4 full diagram](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-4.jpg)
{: class="post-image" }

So if we decide to spend our gained capacity on doing even more small
improvements, we get a virtuous cycle. Over time, we reap more and more
benefits. This means that by investing in the small improvements, we will create
even more capacity over time, which will eventually also benefit delivery of
features. If we decide to focus on features only, we don't get the increase and
we keep on muddling through.

In practice, we have to make trade-offs between time invested in small
improvements and developing features. Still, as we persist in doing a stream of
small improvements next to feature work, it will pay off eventually. The delayed
payoff could make this hard to sell. 

## Example

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

## Further reading & watching

Ursula Le Guinn on male magicians like Gandalf (I know, I suggested Gandalf, and then inevitably something pops up in my twitter feed.)

https://jessitron.com/2021/01/18/when-costs-are-nonlinear-keep-it-small/

In [this video on Why Your Agile Transformation
Failed](https://www.youtube.com/watch?v=-wNH6YgZQtw), Jason Gorman illustrates
the effect of improving the inner (build-test) feedback loop of software
development and how improving that loop has much more impact than improving the
outer loops. The effect of small improvements in the inner get multiplied.

lower lead time - the time from making a change to having it running in production @@DORA/Accelerate

A Diagram of Effects is a powerful technique to make sense of what is going on
in a team or an organization. We learned in from Gerald Weinberg and recommend
his [Quality Software Management
series](http://geraldmweinberg.com/Site/QSM_vol_1.html). If you'd like to learn
more, or read our whitepaper [Promise is
Debt](/attachments/ebooks/qwan-systems-book.pdf) (PDF).

<aside>
  <p>TDB
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
