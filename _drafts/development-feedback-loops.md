---
layout: post
title: Three feedback loops in software product development
tags:
  - productivity
  - agile fluency
  - feedback
  - product development
  - systems thinking
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2023/3-loops.jpg
excerpt: Where to focus improvement efforts in an organisation is difficult, especially with software and multiple stakeholders. Should we bet the house on technical excellence? Let's look at it through three different feedback loops, to see if we are focusing on the 'right' stuff.
---

# Introduction

We are seeing 'agile transformations' and other improvement initiatives that deliver some improvement, but not as much as initially hoped for.
Groups work somewhat iteratively, but delivering valuable product with software inside still takes too long and costs too much. All the while, technical debt continues to mount.

Organizations do huge investments in Scrum, SAFe, agile transformations but
reap limited benefits. At the same time, we notice little investment in
technical excellence. Developers usually do get some training and/or some
learning budget, but they are primarily expected to focus on delivering
software. Often they are expected to do the learning in their free time, which
is an unreasonable thing to expect.

# Should we bet the house on technical excellence?

Jason Gorman has a video on [Why Your Agile Transformation Failed](https://www.youtube.com/watch?v=-wNH6YgZQtw) where he states that doing improvements in technical practices have a much larger impact on the whole development process than for example improvements in the Scrum process. Because the development loop gets executed many more times (hours and minutes) than sprint and daily standup loops (days and weeks) and the roadmap loop (quarters or even years), the effects of any improvements will be multiplied. So there is a huge leverage effect of improvements in technical excellence.

Does this mean that we should only focus on technical excellence? No, although we do see underinvestment in a lot of organizations and although technical excellence is an enabler for getting anything out of the door, we think it is important to take a systemic stance and invest in all parts of a software development system. 

In this post, we introduce a systemic perspective on software development, based on different feedback loops that are at play. 

> **Software development is an interplay between three feedback loops.**  
> **All three need love and care.**

# Three interdependent feedback loops - a systemic perspective

This is a work in progress. It is informed by Jason Gorman's talk, as well as 
the [Agile Fluency® Model](/blog-by-tag#tag-agile-fluency) that we have used to
generate conversations with clients. The feedback loops we will describe are close to the three Agile Fluency zones, but we focus more on the effects of feedback and how the loops interact instead of specific capabilities.

In software development, we see three feedback loops at play:

- Technical Excellence
- Working Together, Getting Things Done
- Product

![three loops partially overlapping](/attachments/blogposts/2023/3-loops.jpg)

> Note: there are different perspectives on software development and there are other feedback loops as well, for example at the strategy level. The perspective we are introducing here is not intended to be a complete model of software development, but rather a partial and useful one.

## Technical Excellence loop

The Technical Excellence loop is about the development work, about programming,
writing tests, running tests. It is the day-by-day, hour-by-hour,
minute-by-minute work of making working software.

Stuff that can happen here:
- Programming
- Test Driven Development
- Relentless refactoring
- CI/CD - continuous integration & continuous delivery
- CI/CD pipelines
- Pull requests, code reviews, code walkthroughs
- Working in baby steps, like Mike Hill's [Many More Much Smaller Steps](https://www.geepawhill.org/series/many-more-much-smaller-steps)

## Working Together, Getting Things Done

The Working Together, Getting Things Done loop is about how we work together, as
a team and with other people like product owners, architects, stakeholders, and
our way of working. Scrum for instance is a framework for this feedback loop,
being all about how we work together in a focused way to deliver the most
valuable thing first.

Stuff that can happen here:
- Sprints, iterations, daily stand-ups, weekly plannings
- Team dynamics & team coaching
- Retrospectives
- Kanban, continuous flow, work-in-progress limits
- Planning, velocity
- Impediments & impediment resolving
- Working in pairs or ensemble, mobbing
- Multidisciplinary teams

## Product

The Product loops is about building the right product and finding what's valuable for which stakeholders and users. It is about value and iterative discovery. 

Stuff that can happen here:
- (Small) releases, MVPs (minimum viable product)
- Business value
- [Roadmapping](/2022/03/29/product-hurricane-map.html) 
- Steering on value
- [Dimensional planning](/2020/09/02/dimensional-planning.html)
- [User story mapping](https://blog.piecemealgrowth.net/working-with-user-story-mapping)
- Outcomes & impact
- Weighted Shortest Job First (WSJF)

How the product loop functions, and what kinds of things are discovered to be valuable depends on various things, most notably the organisation, it's products, and the context it operates in. Contexts that hardly change for many years, can change overnight, like a stock exchange, a bank before the computer, or an energy company before home solar and recent geopolitical changes.

# Leverage effects

The technical excellence loop goes through more, and quicker cycles than the
other loops. This means that improvements made here have a faster pay off, as
well as a higher return on investment - this loop has the highest leverage. 

> As the [Agile Manifesto](http://agilemanifesto.org/principles.html) states:  
> *Continuous attention to technical excellence and good design enhances agility.*

Small improvements that affect the speed of the Technical Excellence loop or the
length of the feedback loops can have a big impact, because it gets multiplied
the most. Shaving off a few seconds of your unit test run for example will
benefit you every time you run the tests, many, many times a day. This all adds
up, for every line of code you change, many times for every user story you work
on.

It pays to invest time in improving build times, fixing flaky tests, getting
quicker pull request feedback, doing pair programming instead of pull requests.

Improvements in this loop have even more benefits, as Rob says:
> if you go very fast, you will get much faster feedback on whether things are going the right way. 

So technical excellence enables a speedup in the Working Together, Getting Things Done loop - getting small slices of high quality software running and tested earlier - and in the Product loop - faster discovery, earlier market
testing. The Technical Excellence loop also puts a bound on how fast you can discover and how fast you can deliver value.

Leverage in the Working Together, Getting Things Done loop can also be
substantial, for example in a chaotic organisation were developers work
individually instead of in teams. Learning to work as a team, structuring the
work, managing flow, focusing on value, maximizing the amount of
work not done, and frequently reflecting will make a
huge initial difference in getting more things done sooner.

The loops reinforce each other in more ways: by reflecting regularly and
improving on Working Together, we set ourselves up for discovering better ways
of developing software - improving the Technical Excellence loop.

> Programming is a leverage game.  
> Making the lever longer is *way* better than pushing the lever harder.  
> -- Kent Beck

# We need a whole systems approach

Should focus mostly or exclusively on the technical excellence loop? No, it is
not just about writing better code faster. It is not only about increasing
velocity, it's about acceleration in the right direction, like Jessica Kerr's
describes in her post on
[Velocity defeats itself. Get acceleration instead](https://jessitron.com/2022/12/22/velocity-defeats-itself-get-acceleration-instead/).
The direction has to come from the interplay with the other loops.

Let's have a look at some counter examples:

- Developers invest in technical solutions while ignoring the voice of the
  stakeholders. This makes us go faster on a road to nowhere.
- Sales sell too many things that don't exist yet or aren't feasible yet. There
  is always a tension, but improving in the sales capacity with a lack of
  capability to deliver is likely to lead to disappointed stakeholders and
  developers.
- Only improve the Working Together, Getting Things Done loop: we find better
  ways of moving post-its or JIRA issues and reflecting on them, but when
  developers aren't able to move the tickets, we might be going somewhere, but
  very slowly with lots of 'clever' fixing to make our solution work for
  customers.
- Improving Product through better vision - for example through good strategy,
  Event Storms, UX studies - without a solid organisation of teams and
  communication with developers will once again lead to disappointment.

# How is this perspective helpful?

The three loops perspective offers a different way of looking at a software development organization. It helps to take a couple of steps back. Take a good hard look at improvement initiatives that are ongoing, what they are delivering (or not), and identify gaps, if any.

Our clients often find it difficult to justify developer training or developer mentoring. If you want to move your organisation towards a more agile way of working and actually get the promised benefits, you need to invest not only in something like Scrum, but also in the Technical Excellence and Product loops. 

The perspective also helps to see why most agile transformations miss out the huge leverage of investing in Technical Excellence.

We find that just the act of stepping away from the keyboard and reflecting with
a group of developers leads to improved productivity, almost regardless of
content. Some of the effects of stepping away are permanent like faster builds,
others are temporary - practicing working in small steps, refactoring general
skills, but they tend to atrophy under pressure.

The three loops perspective also helps to show development teams that improving their work alone is not enough.

> The magic often happens in the gaps - things that could be done, but are actually picked up by no one.

<aside>
<h3>Feedback coffee</h3>
<p>We'd love to hear about how feedback loops (don't) work in your organisation. We would also love to hear if this perspective works for you, things that are missing or that we got wrong.</p>
<p></p>
<div>
<a href="/contact">Talk to us</a>
</div>
</aside>
