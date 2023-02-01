---
layout: post
title: Three feedback loops in software product development
tags:
  - productivity
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

# introduction

We are seeing 'agile transformations' and other improvement initiatives that deliver some improvement, but not as much as initially hoped for.
Groups work somewhat iteratively, but delivering valuable product with software inside still takes too long and costs too much. All the while, technical debt continues to mount.

Organizations do huge investments in Scrum, SAFe, 'agile transformations' but
reap limited benefits. At the same time, we notice little investment in
technical excellence. Developers usually do get some training and/or some
learning budget, but they are primarily expected to focus on delivering
software. Often they are expected to do the learning in their free time, which
is an unreasonable thing to expect.

# So now what? Should we bet the house on technical excellence?

Jason Gorman has a video on [Why Your Agile Transformation Failed](https://www.youtube.com/watch?v=-wNH6YgZQtw) where he states that doing improvements in technical practices have a much larger impact on the whole development process than for example improvements in the Scrum process. Because the 'development loop' gets executed many more times (in terms of hours or minutes) than the 1 or 2 weekly sprint loop or a quarterly roadmap loop, the effects of any improvements will be multiplied. So there is a huge leverage effect of improvements in technical excellence.

Does this mean that we should only focus on technical excellence? No, although we do see underinvestment in a lot of organizations and although technical excellence is a crucial enabler for getting anything out of the door, we state that you need do take a systemic stance and invest in all part of the software development system. 

In this post we introduce a part of our systemic perspective on software development. We will describe a perspective on software development based on different feedback loops that are in play: **software development is an interplay between three feedback loops. All three need love and care.**

# A systemic perspective: three interdependent feedback loops

This is a work in progress. It is informed by a Jason Gorman demonstrating the
influence of technical excellence on speed. Another source is the
[Agile Fluency® Model](https://www.agilefluency.org/) that we have used to
generate conversations with clients. The Agile Fluency Model focuses on team
skill and distinguishes 3 zones representing different capabilities: Focusing,
Delivering and Optimizing. The feedback loops we will describe are close to the
three Agile Fluency zones, but we focus more on the effects of feedback and how
the loops interact instead of skills. We are using a slightly different
terminology here, as we are exploring the space, we focus more on how the
feedback loops function and interact with each other, less on specific
capabilities.

In software development, we see three feedback loops at play. These loops are,
from inside to outside:

- "Technical Excellence" loop
- "Working Together, Getting Things Done" loop
- "Product" loop

![three loops partially overlapping](/attachments/blogposts/2023/3-loops.jpg)

> Note: you can take different perspectives on software development and see other feedback loops as well, e.g. at the strategy level. The perspective we are introducing here is not intended to be a complete model of software development, but rather a partial but useful one.

## Technical Excellence loop

The Technical Excellence loop is about the development work, about programming, writing tests, running tests. It is the day-by-day, hour-by-hour, minute-by-minute work of making working software.

Stuff that happens here:
- Programming
- Test Driven Development
- Relentless refactoring
- CI/CD (continuous integration & continuous delivery)
- Pair programming
- Pull requests, code reviews, code walkthroughs
- Working in baby steps, like Mike Hill's [Many More Much Smaller Steps](https://www.geepawhill.org/series/many-more-much-smaller-steps)

## Working Together, Getting Things Done

The Working Together, Getting Things Done loop is about how we work together, as a team and with other people like product owners, architects, stakeholders, and our way of working. Scrum for instance is a framework for this feedback loop, being all about how we work together in a focused way to deliver the most valuable thing first.

Stuff that happens here:
- Sprints, iterations, daily stand-ups, weekly plannings
- Team dynamics & team coaching
- Retrospectives
- Kanban, continuous flow, work-in-progress limits
- Planning, velocity
- Impediments & impediment resolving
- Working in pairs or ensemble, mobbing

## Product

Stuff that happens here:
- (Small) releases, MVPs (minimum valuable product)
- Roadmapping (+link roadmapping post Paul Dyson)
- Steering on value
- Dimensional planning
- User story mapping
- Outcomes & impact

# Leverage effects

At our clients, the technical excellence loop goes through more, and quicker cycles than the other loops. This means that improvements made here have a faster pay off, as well as a higher return on investment.



Inner loop has most leverage: "Continuous attention to technical excellence and good design enhances agility." (Agile Manifesto principle 9)

Small improvements that affect the speed of the inner loop or the length of the
feedback loops can have a big impact, because it gets multiplied the most. As an
example, shaving off a few seconds of your unit test run will benefit you every
time you run the tests, many, many times a day. This all adds up, for every line
of code you change, many times for every user story you work on.

Small improvements in the inner development loop have the biggest effect because
of multiplication effects. So it pays to invest time in improving build times,
fixing flaky tests, getting quicker pull request feedback, doing pair
programming instead of pull requests.

Another way in which the inner loop has a big leverage. As Rob says 
> "if you go very fast, you will get much faster feedback on whether things are going the right way". 

Leverage in the middle loop can be substantial, e.g. in 'chaotic' organizations
mostly based on individual contributors rather than teams. Structuring work,
managing flow, focusing on value, and continuous improvement can make a huge
initial difference. This is what the Scrum idea of "Doing Twice the Work in Half
the Time" albeit a bit misleading is about. A bit of focus and maximizing the
amount of work not done can be shockingly effective.



So technical excellence enables a speedup in the middle loop
("becoming better faster") and in the outer loop - faster discovery, market
testing, etc.


(thinking of a fake chart where the area below the tech excellence improvement grows faster, sort of like a CFD for the three loops)

# We need a whole systems approach (holistic approach?)

Doest hat mean we should focus exclusively on the technical excellence loop? No, Velocity is a vector, it has a quantity and a direction (ref @jessitron on velocity / accelleration). We can improve the quantity in the technical excellence loop, but direction has to come from the interplay with the other loops. 

Lets' have a look at some counter examples:

- Developers invest in technical solutions while ignoring the voice of the stakeholders. This makes us go faster on a road to nowhere.
- Sales sell too many things that don't exist yet, or aren't feasible yet. There is always a tension, but improving in the sales capacity with a lack of capability to deliver is likely to lead to disappointed stakeholders and developers. 
- Only improve the getting things done loop: We find better ways of moving post-its, and reflecting on them (or JIRA tickets), but when development can't actually move the tickets, we might be going somewhere, but very slowly with lots of 'clever' fixing to make our solution work for customers.
- Product: better vision (e.g. good strategy, great event storms, UX studies) without a solid organisation of teams and communication with developers will once again lead to disappointment.
- Product ignores liability leading to multi-billion dollar lawsuits.

# how is this perspective helpful?

Clients often find it difficult to justify e.g. developer training. We find that just the act of stepping away from the keyboard and reflecting with a group of developers (almost regardless of content) leads to improved productivity. Some of the effects of stepping away are permanent (e.g. better builds), but others are temporary (practicing working in small steps, refactoring are general skills, but they tend to atrophy under pressure).

# closing notes

3 loops perspectief is niet allesomvattend maar biedt een nuttig perspectief (er zijn meer nuttige perspectieven)

# References


Michel Grootjans video, cross-training / upskilling can reduce the need for communication / waiting.

+ how is this perspective helpful to you?

