---
layout: post
title: Extreme Vibe Coding
tags:
- LLM 
author: Willem van den Ende
image: 
---

Wouter Lagerweij and I will be running the [eXtreme Vibe Coding](/sessions/2025/extreme_vibe_coding.html) session in a one hour slot at XP Days Benelux 2025, in the Kapellerput in Heeze, NL on 27 or 28 November. We will be there for both days, and probably the pre-conference dinner.

What I like about XP days, is that it is still a place for experimental sessions like this one. And it makes space for hands-on sessions that are also somehat technical in nature.

I got a message from the XP Days Programme Committee last Saturday, asking if our
session [eXtreme Vibe Coding](/sessions/2025/extreme_vibe_coding.html) could be done in 60 instead of the proposed 90 minutes. It can, but it might be a bit more live demo than hands-on work by the participants. 

I see now that we didn't put the timetable for the 60 minutes version in the  [session description](/sessions/2025/extreme_vibe_coding.html). We briefly discussed it while coming up with the session, and prefer more hands-on. The workaround I came up with while thinking about the committees' message was doinge a Birds of a Feather session in the evening to go more in-depth with those who are up for it. So here is hoping it gets scheduled for the first day. 

We made the learning objectives several months ago. Incremental progress is hard to see day by day, but coming back to our tools and code after being away for weeks, the progress is noticeable. Both in what we have learned over time, e.g. guard rails and engineered prompts, small tools etc. as in the progress that models and tools are making.

From the learning objectives, *Strategic Refactoring and Re-prompting* is still much a work in progress. I was reflecting on this with Stephan Eggermont earlier today. Stephan and I are bootstrapping in stealth mode on what can be described as a MMOMCG (Massive Online Multiplayer Collaborative Game). Last week we have iterated on changes made by our coding assistant, having a close look at what works and what doesn't. We have made progress in additional checks and balances (for future post: test everything that could possibly break, means test more when using coding assistants, because they break in different ways than us), well engineered prompts, made "agents" out of some of our prompts etc. However...

While we are at a point where we can have the assistant churn through a larger plan with a number of refactoring steps (e.g. migrating a javascript front-end to typescript) and having all the unit and end-to end tests pass, there are still surprises. For instance, the assistent added several thousand lines of additional validation code that was not only unneccessary, but often wrong. 

We also find that "Going fast with value delivery while staying in control of complexity" is non-trivial. Drafting some blogposts today, one of the things that emerged is that the cost-of-change curve is still a thing. We can now go to the hockeystick part of the curve much faster. Our current hypothesis is that progress in models and coding tools ability to evaluate and remediate code is outstripped by the models increasing capability to produce large amounts of code in one go. We are working on ways to counter-act this, but this is an active area of research.

It is not yet clear if [Going down the waterfall iteratively - molding a view on our vibes](sessions/2025/iterative_waterfall_molding.html) with Stephan Eggermont has made it. I hope it will, because these are quite complimentary. In AI terms, having good "evals" is essential, and visualisations are a key part to effectively and efficiently judge larger changes.

If you made it this far, I would appreciate your feedback, either privately or in the linkedin comments for this post, once it goes up there.
