---
layout: post
title: Productivity is systemic
tags:
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers
image: 
---

Productivity of software development teams - difficult to get a grip on but everyone wants teams to be more productive. 

We talk to managers, who say they'd like their teams to be more productive (or 'go faster').

Freelance developers get hired to help out with a legacy migration project, get fired because they are too slow (struggling with the legacy and delayed feedback loops in the organization)


## Productivity (revisited)

Measuring productivity in software development is a hard topic. 
We have written about it before, and proposed a useable working definition.

What often happens in agile organizations is focusing on the effort spent, like
story points. Gojko Adzic writes about this in [The Play, the points, and the
biggest lie in
software](https://gojko.net/2021/01/11/the-play-the-points-the-lie.html)
(measuring productivity is hard, measuring value delivered is even harder)

## Productivity is (mostly) a property of the system

Productivity is mostly determined by the system of work, the way teams, their
dependencies and their interactions are organized. Deming stated it already many
years ago that [90-95% of performance is governed by the
system](https://deming.org/dr-deming-called-for-the-elimination-of-the-annual-performance-appraisal/).

We assume people are doing their best given the knowledge, skills and tools they
have at hand. Seeing the team as a (complex) system, it is safe to assume it is
performing at its optimal level of productivity. If you assume otherwise, you
are assuming the team members are just slacking off.

In [The Gardeners
Dilemma](https://www.linkedin.com/pulse/gardeners-dilemma-dirk-jan-swagerman/),
Dirk Jan Swagerman writes about the maintenance burden you build up when you
keep on delivering software. If you don't tend to it or if you assume
maintenance is free, it will drag down a team's performance more and more, while
it's not the team's fault - "No: your software team does not suck if they make
slow progress on a legacy code base."

## The 'system' is management's job

So if a team's productivity is not good enough, look at the system to learn what
is limiting their performance. This goes beyond reacting on the first symptoms
you notice, that will probably make this worse. It requires some deep,
collaborative reflection using intuition support techniques like Diagrams of
Effects, Cynefin, constraint mapping, value stream mapping.

A team is a complex system (@@Cynefin linkje). This means that improving
productivity is not a matter of meticulously analysing the current situation,
designing a desired state and planning actions to bridge that state. Instead,
the suitable approach is one of sense-making, gaining situational awareness in
the direction the system is inclined to move (dispositioned), and then thinking
up some experiments that are in line with what you have learned. Experiments
because you cannot be sure if will succeed so you'd rather keep a possible
negative effect small (but still run the experiment, because you never know what
more you'll discover).

This is management's job! This is where you can have true leverage in the organization's performance.

When I say management's job, this is not restricted to those who have 'manager' in their job title, although it should at least come from there (@@vgl. Geerts transformatie moet vanuit de lijn komen). If we succeed at having teams develop more reflective capability and systemic thinking skills of their own, they can can learn to do this on their own. So we mean 'management' here eventually in the sense like Gerald Weinberg uses it in his Quality Software Management series @@todo: uitwerken.

So you could find some things that is keeping productivity low:
- the team is missing skills - so they need to learn and train; this requires
  support and investment (training courses and time to practice; if you expect
  people to learn everything in their evening hours, you're not taking
  productivity seriously, and you're harming people with families, you're
  depriving people of their rest, an important pillar of high performance)
- the team needs to wait for others outside the team, e.g. for approvals,
  reviews, or they have to wait on long builds, nightly test run results, etc.
  Waiting is destructive for productivity. It is quite useless to urge people to
  fill the waiting time with other work, because waiting breaks focus, people
  lose time in task switching. This can be a tougher one to break; create
  collaborative awareness of where there is waiting in the process and how that
  is impacting end to end ("concept to cash") development performance, e.g. with
  value stream mapping. Reorganize to eliminate waiting; relentlessly improve
  builds and CI/CD pipelines so that they will give their feedback within 15
  minutes - see Charity Majors' post on [Why are my tests so slow?]
  (https://charity.wtf/2020/12/31/why-are-my-tests-so-slow-a-list-of-likely-suspects-anti-patterns-and-unresolved-personal-trauma)
- the team is working in a kind of 'good enough' mode, almost complacent, there
  seems to be no sense of urgency. So [create a sense of
  urgency](/2020/10/26/under-pressure.html), make sure they understand the why.
  In the light of a short term delivery date, a complacent team can suddenly become a focused, productive team.
- the team is working as a collection of individuals instead of a team, everyone
  does his/her own tasks, some are very busy, others finish early and don't know
  what to do next. Invest in team coaching, teach them about flow.

And don't focus on individual utilization! By optimizing everyone's utilization,
you are guaranteed to cause horrible development performance. Your goal is to
deliver better software sooner, your goal is not to keep people busy. If you
want to keep people busy, suggest them a hobby. 

## Sometimes it's the individual

One developer can drag down a team, by slacking off, or with a negative attitude
or by working on his own instead of collaborating (being a rock star instead of
a team player), or being a 'brilliant jerk'.

This sometimes happens and this will negatively impact the team's performance.
This is still management's job to handle this!

You can fix low performance by having a talk with someone who is dragging down
the team, or even removing him. This does not necessarily lead to a highly
productive team. The organizational context will quickly become the next
bottleneck.
