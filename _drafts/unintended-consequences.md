---
layout: post
title: Embracing unintended consequences
tags:
  - agile
  - patterns
  - complexity
  - systems thinking
  - eXtreme Programming
author: Marc Evers
image: /attachments/blogposts/2025/jackinthebox.jpg
---

Why do we introduce a new practice? We see a colleague/friend/influencer telling success stories about it. Eager to get those benefits, we start out experimenting and learn how well it is living up to our expectations. We also start seeing other unanticipated effects - distractions, anomalies? Or learning opportunities? In this post we advocate for embracing unintended consequences.

## Knowable context, good practices

If the situation at hand is knowable, the effects of a practice are known, or we can find out with a bit of effort how to get good results - taking into account [how the practice fits our context](/2025/10/06/practices-are-patterns)!

Practices in a knowable context are largely understood, but we can still run into unintended consequences. These inform us about how well the practice fits the context, or well we are performing the practice.

Let's look at some examples from (agile) software development. 

**Test automation** - the practice of test automation is nowadays mostly in the knowable area. Tooling, libraries, and know-how is available for writing automated tests for all kinds of situations. Automated tests provide feedback about changes and confidence to bring changes to production. More and more test automation practices are evolving into good practices that are likely to bring  benefits - as long as you keep the context in mind.

**Behaviour-based vs structure/state-based tests** - test automation generally works, but there are a lot of details to be filled in. How the tests are written can have a big impact on speed, maintainability, and the ability to refactor. Many tests we see in practice are unit tests that are tightly coupled to the code structure, checking internal state. The unintended consequences are fragile tests and painful refactorings. State based and structure based automated tests have a limited applicability, but for general use they are not a good fit. 

@TBD what context are they a good fit?

**Story points** - story points is a much-lamented estimation and forecasting practice intended to help a team make quick, good enough forecasts based on the amount of work finished in the previous time period ("yesterday's weather"), while staying away from time based estimates. The applicable context of this practice lies within team boundaries. Story points have been used way outside this context. Sometimes management demands velocity to go up (which will just inflate the numbers) or compares teams based on their velocity. Making estimates can then have big consequences for developers, which reduces estimation reliability and usefulness.

## Complex context, emergent practices

If we are in a complex context, where things are not knowable and only coherent in retrospect, things work differently. We don't have good or best practices, but we are discovering practices and their applicability along the way.

We need to run small experiments to learn how a practice works in the situation we're in. We want to look for success and failure indicators, so that we can amplify or dampen quickly. We don't want our experiment to turn into a bet-your-company experiment...

Because the situation is unknowable we need to engage and see what emerges - there will be unintended consequences - they're not a bug but a feature! They might be bad but also good. Paying attention is key; keeping our mind open for what emerges enables us to grab an opportunity when it comes by.

TBD examples!

Having too strong of an opinion of what the benefits should be will hinder us. It will narrow our perspective, making us look for the thing we expect, sticking to familiar patterns. We subconsciously start filtering away the outliers. Or we try harder, hoping the anomaly will just go away. 

Unintended consequences are not an anomaly. They're the delta between our assumptions, wishes, hypotheses and what happens in reality.

## How to embrace unintended consequences

Some guidelines when picking up a new practice:

- Find out about the nature of the situation you are in or the problem at hand - Is it complicated or complex? The Cynefin framework can help here.
- *Complicated*: look out for unintended consequences; what do they tell you about the practice or the situational fit? Are you doing the practice as it is intended?
- *Complex*: practices as emerging, no matter what consultants and sales people tell you. Your intended benefits are a hypothesis to test. How can you observe if it works out? How can you observe if it does not work out? How can you tune or reframe your hypotheses using the emerging information?
- Be careful in copying a "good" idea from someone else. Depending on context, it might or might not work for you. Especially in a complex context, the "apparently successful practice" actually emerged from experimentation, learning, and tuning in a specific situation. It is a result of earlier interactions. The history of the system in which it emerged makes the other context unique. Learning about the history, the path they followed, and the failures they had is way more useful than copying the practice.

## Further reading

- The distinction between knowable and unknowable and the ideas of complex context and emergent practice comes from the [Cynefin sense-making framework](https://cynefin.io/wiki/Cynefin). There are different methods available for finding out if something is knowable or complex.
- There is a nice book called [Learning Histories](https://www.learninghistories.nl/post/nieuw-boek-learning-histories-vat-krijgen-op-je-organisatiecultuur) by Rik Peters which focuses on organisational culture basically being the resultant of its history (all the events that happened). This book is currently only available in Dutch.

<aside>
  <p>
What practices fit your situation? Let's discover this together.
  </p>
  <p><div>
    <a href="/contact">Contact us when you're interested!</a>
  </div></p>
</aside>
