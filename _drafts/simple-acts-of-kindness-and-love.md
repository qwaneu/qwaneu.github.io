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

Today we're writing about how simple acts improve feedback loops, which has a compounding effect in development teams over time. 

The title of this post has literary inspiration: 

> Saruman believes that it is only great power that can hold evil in check. But
that is not what I have found. I have found it is the small things. Everyday
deeds of ordinary folk that keeps the darkness at bay. Simple acts of kindness
and love.  
> -- Gandalf (J.R.R. Tolkien, The Hobbit)

So why then, would we do this?

> Kindness Eases Change  
> -- Olivia Butler, as quoted by [brainpickings](https://www.brainpickings.org/2020/08/23/octavia-butler-parable-leaders/) 

## What does this mean for a developer?

We want to [embrace change](https://en.wikipedia.org/wiki/Extreme_programming),
without making our lives more difficult in the process.

More specific for developers, in [Maximizing Developer
Effectiveness](https://martinfowler.com/articles/developer-effectiveness.html),
Tim Cochran writes about the importance of shortening feedback loops in
development. Fast feedback is important for developers, to prevent waiting and
task switching, and to stay in a state of flow. He specifically recommends
focusing on improving the "micro feedback loops", the fast feedback loops that
developers experience tens or hundreds of times a day. 

Putting effort in improving these, like making your unit test suite a few
seconds faster, is often hard to explain and justify. It can take some time
before you, and especially the people around you start noticing
the effects. So it seems like you are focusing on futile things, not on the
'big' problems. In the end however, it all adds up. Improvements are
multiplicative.

In this way, putting effort in small improvements has a multiplicative, even
exponential effect. Doing a tiny bit of improvement everyday can help in
breaking away from what Jim Shore calls [Stumbling through
mediocrity](https://www.jamesshore.com/v2/blog/2009/stumbling-through-mediocrity).

## Systemic effects of improving small stuff

There are some interesting things at play here, that might not be obvious
initially:
- Doing small improvements on the micro feedback loops compounds - _no
  difference plus no difference plus ... eventually equals a clear difference_
  (Gerald Weinberg's _Fast-Food Fallacy_, from [Secrets of
  Consulting](https://leanpub.com/thesecretsofconsulting)).
- Doing small improvements every day gets you in the habit of 'just doing it';
  it will require less mental effort to think about them or decide to do it.
- Growing a habit of doing many small improvements means that you get well
  versed in doing it, and over time it becomes easier to do even more
  improvements.
- _Learning to see_ - the more you do small improvements, the better you are
  able to see new improvement opportunities. You will start noticing for
  instance code smells in code that you thought was good enough a year ago.
- The multiplicative effect will manifest itself after a delay, so cause and
  effect might not obvious for others. So you may not get the credit you
  deserve: true skill is invisible.
- The multiplicative effect can eventually result in order-of-magnitude
  improvements in feedback loops, and _order-of-magnitude improvements tend to
  change the game_, [like we wrote
  earlier](/2020/11/27/paying-the-price-of-fast-tests.html).

Let's illustrate this using a diagram of effects.

![systems diagram: small improvements reduce toil, reduce technical debt, and make delivery smoother, improving productivity](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-1.jpg)
{: class="post-image" }

The impact of improvements might be small, but they do have impact. They reduce
developer toil for instance, or reduce technical debt, or make the whole
delivery process a bit more smooth. Over time, this helps improve productivity.
Now productivity in development is difficult to get a grip on, like we wrote
before in our [Under Pressure post](/2020/10/26/under-pressure.html). Here we
mean "getting more done with the same effort" (or "getting the same done with
less effort").

![systems diagram: higher productivity leads to lower commit-deploy lead time and makes more time available which can be spend on features or on more improvements](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-2.jpg)
{: class="post-image" }

Higher productivity leads to lower lead time - the time from making a change to
having it in production. It will also increase development headroom - which you
can spend on features or on more improvements. This is an explicit management
decision, which we denote by the black/white square.

![step 3](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-3.jpg)
{: class="post-image" }

Many small acts of kindness and love, especially in the inner feedback loop of
software development, have multiplicative effects: both the number of
improvements we do and the fact that the improvements affect processes and
actions that we do over and over again, every hour, every day, multiply the
impact of improvements.

![step 4 full diagram](/attachments/blogposts/2021/tdd/simple-acts-of-kindness-4.jpg)
{: class="post-image" }

So if we decide to spend the time we gain on doing even more small improvements,
we move into a virtuous cycle. Over time, we reap more and more benefits. By
investing in small improvements, we will create even more headroom over time,
which will eventually also benefit delivery of features. Getting used to making
small improvements also lowers the barrier to experiment with subsequent
improvements.

If we decide to focus on features only, we won't get the increase and we'll keep
on muddling through. Worse, toil and technical debt will accumulate and make us
less and less productive.

In practice, we have to make trade-offs between time invested in small
improvements and developing features. When we persist in doing a stream of small
improvements next to feature work, we will reap the benefits eventually. The
delayed payoff can make this a hard sell though.

## Examples

A team at a client was maintaining multiple legacy systems. They were struggling
with productivity, at least in the eyes of their internal customers. Some of the
code was twenty years old, and it was quite difficult to make changes in a
responsible way. After some tough conversations with management and customers,
they started allocating a fixed budget per sprint to work on legacy code and do
step by step improvements through refactoring. Initially, this did not show any
improvement. In a way they seemed even less productive, because they allocated
less time for customer work. After 1-2 years, the improvements started to pay
off, making it much easier, faster, cheaper to make new changes.

A team at another client maintained a single legacy system that generated all of
the revenue for the client. The client set up a separate team to develop a
replacement system from a clean sheet design. Eventually one of us guided the
new team in making small improvements - because, productivity and if you do a
new thing using the same way of working as before, you'll get the same outcome.
The original team saw this, and started allocating fourty percent of their time
to improvements. After half a year, the original team was going so fast, that
the company kept the 'legacy' product and repurposed the new development for
another market.

## Further reading & watching

When we sourced the Gandalf quote, there was a lively discussion on twitter
around Ursula Le Guinn's take on male magicians like Gandalf: 

> The Gandalf model of wizardly power – the idea, dumbly replicated by J.K. Rowling’s Dumbledore, that asexual male mages hold the world in balance – was never compatible with Le Guin’s deep unease about overt expressions of power.  
> -- as quoted in [It's not Jung, it's mine](https://www.lrb.co.uk/the-paper/v43/n02/colin-burrow/it-s-not-jung-s-it-s-mine)

This is what led us to [Olivia Butlers' work](https://www.brainpickings.org/2020/08/23/octavia-butler-parable-leaders/) around leaders. 

> This is a nonlinear relationship. The changes interact, and so batching them up increases the cost of the batch by more than the cost of the change you’re adding. Batching is less efficient.  
> -- Jessica Kerr, [When costs are nonlinear, keep it small](https://jessitron.com/2021/01/18/when-costs-are-nonlinear-keep-it-small/)

In [this video on Why Your Agile Transformation
Failed](https://www.youtube.com/watch?v=-wNH6YgZQtw), Jason Gorman illustrates
how the effect of improving the inner (build-test) feedback loop of software
gets multiplied.

A Diagram of Effects is a powerful technique to make sense of what is going on
in a team or an organization. We learned from Gerald Weinberg and recommend
his [Quality Software Management
series](http://geraldmweinberg.com/Site/QSM_vol_1.html). If you'd like to learn
more, or read our whitepaper [Promise is
Debt](/attachments/ebooks/qwan-systems-book.pdf) (PDF).

<aside>
  <p>Sometimes, we get brought in as the "agile repair shop", arriving after happy, handwaving consultants have abandoned the sinking ship of an agile transformation. Then the organisation invites us to work on some simple acts together, and then experiences effective change. We have some days available  for consulting in September and onwards.
  </p>
  <p><div>
    <a href="/consulting">Talk to us, the first conversation is free.</a>
  </div></p>
</aside>
