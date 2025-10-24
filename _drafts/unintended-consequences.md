---
layout: post
title: Embrace unintended consequences
tags:
  - agile
  - patterns
  - complexity
  - systems thinking
  - eXtreme Programming
author: Marc Evers
image: /attachments/blogposts/2025/jackinthebox.jpg
---


We introduce a new practice to get some stated or promised benefits. Or maybe we see someone else having success with that practice. We start out experimenting and learn how well it is living up to our expectations. We might also see some other, unanticipated effects. These feel like distractions or anomalies. These are actually great learning opportunities, so open your mind and embrace these unintended consequences.


## Knowable context, good practices

If the situation at hand is knowable, the effects of a practice are mostly known, or at least with a bit of effort we can find out how to get good results for our situation - taking into account [how the practice fits our context](/2025/10/06/practices-are-patterns.html)!

Practices in a knowable context are mostly understood, but we can still run into unintended consequences. They inform us about appropriate fit or not performing the practice well enough. 

Let's look at some examples from (agile) software development. 

**Test automation** - the practice of test automation is nowadays mostly in the knowable area. Tooling, libraries, and know-how is available for writing proper automated tests for all kinds of situations. Automated tests provide feedback about changes and confidence to bring changes to production. More and more test automation practices are evolving into good practices that are likely to bring you benefits as long as you keep the context in mind.

**Behaviour-based vs structure/state-based tests** - test automation is generally helpful, but there are a lot of details to be filled in. How the tests are written can have a big impact on test speed and maintainability, and how well they support refactoring. A lot of the tests we see in practice are unit tests that are tightly coupled to the code's structure and focus on checking internal state. Being highly coupled to implementation details, they come with the unintended consequence of making them fragile and painful when refactoring. State based and structure based tests have a limited applicability, but for general use they are not a good fit. 

@TBD what context are they a good fit?

**Story points** - story points is a much-lamented estimation and forecasting practice intended to help a team make cheap but good enough forecasts based on the amount of work finished in the previous time period (also known as "yesterday's weather"), while staying away from time based estimates. It was meant to be used within a team, to get a good enough indication of what they can finish the next few sprints. Story points have been used way outside these applicability boundaries. Sometimes management demands velocity to go up (which will just inflate the numbers) or they compare teams based on their velocity.  Making estimates can then have big consequences for developers, which reduces estimation reliability.

**Cucumber / BDD** - TBD alweer zo'n voorbeeld van een uit zijn context gerukte practice


## Complex context, emergent practices

If we find ourselves in a complex context, where things are not knowable and only coherent in retrospect, things work differently. We don't have good or best practices. Instead, we are discovering practices along the way.

We need to run small experiments with practices to learn how they work out for the situation we're in. We want to look for indications of success or failure, so that we can amplify or dampen quickly (preventing bet-your-company experiments)

Because the situation is unknowable by nature we need to engage and see what emerges - there will be unintended consequences (not a bug but a feature)! These might be bad (a reason to stop an experiment), and they might as well be good. Paying attention is key; keeping our mind open for what emerges enables us to grab an opportunity when it comes by.

TBD examples!

Having too strong of an opinion of what the benefits should be will hinder us. It will narrow our perspective, making us look for the thing we expect, sticking to familiar patterns. We subconsciously start filtering away the outliers in the information, the undesired stuff. Or we try harder, hoping it's an anomaly that will surely go away. 

Unintended consequences are not an anomaly. They're the delta between our assumptions, wishes, hypotheses and what happens in reality.


## How to embrace unintended consequences

Some guidelines for picking up a new practice:

- Find out about the nature of the situation you are in or the problem at hand - Is it Complicated or Complex (in Cynefin terms)?
- *Complicated*: look out for unintended consequences; what do they tell you about the practice or the situational fit? 
- *Complex*: regard practices as emerging, no matter what the consultants and sales people tell you; your intended benefits are a hypothesis to test. How do you observe if it works out? How do you observe that it does not work out? How can you tune or reframe your theories and hypotheses using this new information?

Be really careful when copying a good idea from someone else. Just copying a practice that seems to be working from someone else, might or might not work for you. Especially in a complex context, the 'apparently successful practice' is actually something that emerged from experimentation, learning, tuning in that specific situation. It an end result of earlier interactions. The history of how it came to be makes the other's context unique. Learning about the history behind it, about the path they followed and the failures they had will bring you useable knowledge.

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
