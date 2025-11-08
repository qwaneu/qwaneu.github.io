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

Why and when do we introduce a new practice? We see a colleague, friend, and/or influencer telling success stories about it. Eager to get the benefits, we start out experimenting and learn how well it is living up to our expectations. We also start seeing other unanticipated effects &mdash; distractions, anomalies? Or learning opportunities? In this post we advocate for embracing unintended consequences.

## Knowable context, good practices

If the situation at hand is knowable, the effects of a practice are known, or we can find out with a bit of effort how to get good results. As long as we take into account [how a practice fits our context](/2025/10/06/practices-are-patterns)!

Practices in a knowable context are largely understood, but we can still run into unintended consequences. These inform us about how well the practice fits the context, or well we are performing the practice.

Let's look at some examples from software development. 

**Test automation**: the practice of test automation is nowadays mostly in the knowable area. Tooling, libraries, and know-how is available for writing automated tests for all kinds of situations. Automated tests provide feedback about changes and confidence to bring changes to production. More and more test automation practices are evolving into good practices that are likely to bring  benefits &mdash; as long as you keep the context in mind.

**Behaviour-based vs structure/state-based tests**: test automation generally works, but there are a lot of details to be filled in. How the tests are written can have a big impact on speed, maintainability, and the ability to refactor. Many tests we see in practice are unit tests that are tightly coupled to the code structure, checking internal state. The unintended consequences are fragile tests and painful refactorings. State based and structure based automated tests have a limited applicability, e.g. for testing adapters and mapping, or for creating initial tests for existing entangled code. They are not a good fir for general use.

**Story points**: story points are a much-lamented estimation and forecasting practice intended to help a team make quick, good enough forecasts based on the amount of work finished in the previous time period &mdash; [yesterday's weather](https://martinfowler.com/bliki/YesterdaysWeather.html), while staying away from time based estimates. The applicable context of this practice lies within team boundaries. Story points have been used way outside this context. Sometimes management demands velocity to go up or compares teams based on their velocity. This will just inflate the numbers or make them lose their meaning completely. Producing estimates can then have big consequences for developers, which reduces estimation reliability and usefulness.

## Complex context, emergent practices

If the context is complex, where things are not knowable and only coherent in retrospect, things work differently. There are no good or best practices, but we are discovering practices and their applicability along the way.

We need to run small experiments to learn how a practice works in the situation we're in. We look for success and failure indicators, so that we can amplify or dampen quickly. We don't want any bet-your-company experiments...

We need to engage and see what emerges. There will be unintended consequences 
&mdash; they're a feature, not a bug! They might be bad as well as good. Paying attention is key. Keep your mind open for what emerges and grab an opportunity when it comes by.

Take **short iterations** for example, working in short timeboxes of 1-2 weeks(iterations, sprints) from an ordered backlog is a practice that was intended to provide focus for a development team and be productive without distractions and context switches. This practice is helpful where a team is e.g. is suffering under a high workload and continuously changing priorities, and not getting anything done.

In practice, we have observed all kind of different effects. Teams try but are not able to finish work within the timebox. Often they react by proposing to make the timebox longer. Other teams are successful with short iterations, but become an unsustainable "story factory", burning out developers eventually. Some teams limit their work in process, but save all finished work until the end of the sprint, making the sprint feel as bottleneck rather than being helpful.

So what is happening here? Practising short iterations does not directly result in higher productivity. Instead it creates an enabling constraint, which will initially create friction &mdash; it will make impediments to productive work visible so that you can act on it. Sometimes it leads to feelings of _"sprints don’t work"_, but the sprint is just the messenger. Which impediments will become visible depends on the context and may vary. Doing short iterations will have different consequences for different teams.

## Expect the unexpected

Focusing on the benefits a practice can narrow our perspective. We tend to look for what we expect, sticking to familiar patterns. We subconsciously filter out outliers, or we just try harder, hoping they will just go away.

Unintended consequences are not an anomaly. They're the delta between our assumptions, wishes, hypotheses and reality. They provide necessary information to steer our efforts.

## Guidelines for picking up a new practice 

Some guidelines when picking up a new practice:

- **Know the situation you are in.** What is the nature of the situation you are in? Is it complicated or complex? The [Cynefin sense-making framework](https://cynefin.io/wiki/Cynefin) can help.
- **A Complicated context means finding a good fit**: look out for unintended consequences; what do they tell you about the practice or the situational fit? Are you doing the practice as it is intended?
- **A complex context means testing hypotheses**: practices as emerging, no matter what consultants and sales people tell you. Intended benefits are a hypothesis that should be tested. How can you observe if it works out? How can you observe if it goes awry? How can you tune or reframe your hypotheses using the information that emerges?
- **Beware of copying a "good" idea from someone else**. Depending on context, it might or might not work for you. In a complex context, the "apparently successful practice" actually emerged from experimentation, learning, and tuning in a specific situation. It is a result of earlier events and interactions. The history of the system in which it emerged makes the other context unique. Learning about the history, the path they followed, and the failures they experienced is far more useful than trying to copy what they are doing.

## Further reading

- We are using the concepts of knowable and unknowable context, complex context and emergent practice from the [Cynefin sense-making framework](https://cynefin.io/wiki/Cynefin). There are different methods available for finding out if something is knowable or complex.
- Read more about enabling constraints and other types of constraints on the [Cynefin wiki](https://cynefin.io/wiki/Constraints).
- The book [Learning Histories](https://www.learninghistories.nl/post/nieuw-boek-learning-histories-vat-krijgen-op-je-organisatiecultuur) by Rik Peters offers a useful perspective on organisational culture, being the resultant of its history (all the events that have happened). This book is currently only available in Dutch.

<aside>
  <p>
What practices fit your situation? Let's discover this together, e.g. by running a Cynefin based workshop.
  </p>
  <p><div>
    <a href="/contact">Contact us when you're interested!</a>
  </div></p>
</aside>
