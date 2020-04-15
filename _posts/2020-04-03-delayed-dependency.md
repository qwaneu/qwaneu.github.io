---
layout: post
title:  Delayed dependency. Two steps forward, one step back.
tags:
  - accessibility
  - continuous delivery
author: Willem van den Ende
---

Yesterday I thought I pushed out another iteration of our attempt at making the
QWAN website more accessible. Turns out I didn't. While adjusting details,
reading CSS and accessibility documentation and blogposts, I missed the fact
that the shiny assets pipeline I added does not actually build on github.

So I started to do more reading on how to add more continuous integration. I
experienced friction. I read some more. Procrastinated. Then checked how many
assets I had added to the pipeline so far. Two instances of our logo, nothing
else. I decided to move them together with the rest of the images, and leave the
assets pipeline for local experimentation.

Not optimal, but this way I got the satisfaction of moving forward, and I bought
myself time to read and experiment. Continuous delivery is an activity we do,
supported by tools where necessary. A continuos integration setup tends
to be stick around, so we better keep it as simple as possible.
We have one that works without maintenance on our part, the github pages
default setup. The benefit of delaying this decision is that we can decide how much
additional work to incur in the future, while being more specific about the
benefits.

Some reading on friction that popped up in my twitter feed:

- [Ideaflow by Janelle Arty Star](https://leanpub.com/ideaflow)
