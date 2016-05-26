---
layout: post
title:  Software engineering in a digitized world
author: Willem
image: /attachments/blogposts/2016/mary-poppendieck.png
---

Aliveblog of Mary Poppendieck's xp2016 keynote.


1. The Cloud
2. Creativity
3. Federation of data
4. Platforms replace products

## Federate instead of duplicate

Back to the chasm, where agile was in 2004. What is in the chasm now?

How Conway's law brought us two the cloud. Amazon two pizza teams: scale with less communication by giving up immediate consistency, but going for eventual consistency instead.

Automomous teams that handle their own deployments. This is something new Amazon could sell.

# Software as a creative process

"Creators need a direct connection with what they are creating" - Brett Vincent (Willem - see also Doug Engelbart).

Shows a video by Brett Vincent with direct manipulation of code and graphics. "Much of art is discovery... Having an immediate connection allows discovery that would be impossible before" "If there is any delay in that feedback loop of seeing it and working on it... there is a whole world of ideas that will never be."

Immediate connection.

Brett Vincent video end.

Mary and Tom have a principle too: teams need an immediate connection with what they are creating. E.g. continuous deployment.

Focus on problems not features. The engineering team works on the problem, not features. Plan with hypotheses, not estimates. What is the hypothesis? What are three hypotheses? Run several experiments. Most will be wrong. If they are not wrong, we are not doing good experiments. Only half of what product managers guess would be a good idea is actually a good idea.

Almost half of product ideas are wrong (by product managers), technical people should also add things to develop.

# How the best product teams work

References [Marty Cagan](http://www.svpg.com/developer-powered-innovation) . How the best product teams work:

A funnel that looks something like this (visual in the slide is better).

![Ideas, Discovery, Delivery](https://pbs.twimg.com/media/CjXqlqAUgAAa_Op.jpg)


Test automation is like double entry bookkeeping. The goal is to find integration issues as soon as possible.Production code and tests are two automated views on the same thing. (Willem: so are solid types).

"You know you are doing structured programmin when you don't have integration problems". (I didn't get the source).

# Scale is an architecture problem

Federation is the way to scale.

Google search: federation, let it fail.

Lucene tried to follow along, struggled and finally the team gleaned HDFS and MapReduce from googles' papers.

Story about Gripen fighter, focusing on lower operational and design costs over 50+ years with each new generation. Now much cheaper than F-16 (let alone JSF). Federation is essential to keep costs down. How do I create an architecture where things are not integrated, but federated.

Integrated Federated Architecture. The planes are like a smartphone platform - trade out any component without effecting flight worthiness and certification. Every single piece can be developed in isolation.

Three week iterations, synchronize across hard and software every quarter. Every year higher level plan for the next year. They integrate every week, even though iterations are three weeks. Hardware simulators allow more frequent integration. Feedback cycle is fundamental to not let badd stuff be built on top of bad stuff.

# Platforms replace products



![Mary Poppendieck portrait](/attachments/blogposts/2016/mary-poppendieck.png)
