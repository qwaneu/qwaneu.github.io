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


When introducing a specific practice we do so to get some stated or promised benefits. Or maybe we see someone else having success with that practice.

We start experimenting with the practice, we learn about how well it is living up to the expected benefits. But we might also see some other effects! Often we find these distracting, seeing them as anomalies. But these are actually great learning opportunities, so open your mind and embrace unintended consequences.


## Knowable context, good practices

If the situation at hand is known or knowable, the effects are mostly known, or we can analyse and learn a bit more to get good results for our situation - if we look at the what context the practice is intended for and how that fits ours! Practices are patterns, solutions that resolve certain forces in a context, like we wrote about previously. 

Let's look at some examples from an agile software development context.

**Test automation** - practising test automation is mostly in the knowable area, with tooling, libraries, and know how for how to write automated tests all kinds of situations. Having automated tests provides feedback about changes and confidence to bring things to production. More and more test automation practices are evolving into good practices that are likely to bring you benefits as long as you keep the context in mind.

**Structure and state based automated tests** - test automation is generally helpful, but there are a lot of details to be filled in. How the tests are written can have a big impact on how fast they are, how maintainable they are, how well they support refactoring. A lot of the tests we see in practice are unit tests that are tightly coupled to the code's structure and/or focus on checking internal state. These tests are highly coupled to code details (compared to behaviour based tests), with the unintended consequence of making them fragile and painful when refactoring. State based and structure based tests have a limited applicability, but for general use they are not a good fit.

**Story points** - story points is a much-lamented estimation and forecasting practice intended to help a team make good enough forecasts based on the amount of work finished in the previous time period (also known as "yesterday's weather"), while staying away from time based estimations. It was meant to be used within a team, just to be able to get a good enough indication of what they can finish the next few sprints. Story points have been used way outside those boundaries, sometimes with management demanding that velocity should go up (in practice, this turns out to just inflate the numbers) or comparing teams based on their velocity (making estimations have potentially big consequences for developers, reducing the reliability of estimates).

**Cucumber / BDD** - TBD alweer zo'n voorbeeld van een uit zijn context gerukte practice

Unintended consequences for well-known practices in knowable contexts inform us about appropriate fit or not performing the practice well enough.

## Complex context, emergent practices

If we find ourselves in a complex context (i.e. not knowable, and only coherent in retrospect), we have a different dynamic. We don't have good (let alone best) practices, but instead we are discovering practices along the way.

We need to run small experiments with practices to learn how they work out for the situation we're in. We want to look for indications of success or failure, so that we can amplify or dampen quickly (preventing bet-your-company experiments)

Because the situation is unknowable by nature we need to engage and see what emerges - there will be unintended consequences (not a bug but a feature)! These might be bad (a reason to stop an experiment), and they might as well be good. Paying attention is key; keeping our mind open for what emerges enables us to grab an opportunity when it comes by.

(examples!)

Having too strong of an opinion of what the benefits should be will hinder us. It will narrow our perspective, making us look for the thing we expect, sticking to familiar patterns. We subconsciously start filtering away the outliers in the information, the undesired stuff. Or we try harder, hoping it's an anomaly that will surely go away. 

Unintended consequences are not an anomaly. They're the delta between our assumptions, wishes, hypotheses and what happens in reality.


## How to embrace unintended consequences

Some guidelines for picking up a new practice:

- Find out about the nature of the situation you are in or the problem at hand - Is it Complicated or Complex (in Cynefin terms)?
- *Complicated*: look out for unintended consequences; what do they tell you about the practice or the situational fit? 
- *Complex*: regard practices as emerging, no matter what the consultants and sales people tell you; your intended benefits are a hypothesis to test. How do you observe if it works out? How do you observe that it does not work out? How can you tune or reframe your theories and hypotheses using this new information?

Be really careful when copying a good idea from someone else. Just copying a practice that seems to be working from someone else, might or might not work for you. Especially in a complex context, the 'apparently successful practice' is actually something that emerged from experimentation, learning, tuning in that specific situation. It an end result of earlier interactions. The history of how it came to be makes the other's context unique. Learning about the history behind it, about the path they followed and the failures they had will bring you useable knowledge.

> TBD reference to cargo cult agile

## Further reading

- The distinction between knowable and unknowable and the ideas of complex context and emergent practice comes from the [Cynefin sense-making framework](https://cynefin.io/wiki/Cynefin). There are different methods available for finding out if something is knowable or complex.
- There is a nice book called [Learning Histories](https://www.learninghistories.nl/post/nieuw-boek-learning-histories-vat-krijgen-op-je-organisatiecultuur) by Rik Peters which focuses on organisational culture basically being the resultant of its history (all the events that happened). This book is currently only available in Dutch.

? https://www.cio.com/article/276364/agile-development-cargo-cult-methodology-how-agile-can-go-terribly-terribly-wrong.html


<aside>
  <p>
What practices fit your situation? Let's discover this together.
  </p>
  <p><div>
    <a href="/contact">Contact us when you're interested!</a>
  </div></p>
</aside>
