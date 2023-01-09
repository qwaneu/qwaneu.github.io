---
layout: post
title: The three feedback loops in software product development
tags:
  - productivity
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

Continuous attention to investing in techical excellence is essential. Why? 
Looking at software product development, we can distinguish 3 important feedback loops: the *product loop*, the *getting valuable work done loop* and the *technical excellence loop*. The faster the technical excellence loop on the inside goes, the faster the outside loops can go.


![Three loops drawn inside out - technical excellence loop, getting valuable things done loop and product loop](/attachments/blogposts/2022/three-loops-intro.svg)

Improvements in the inner loop have the most impact, because the loop is
iterated over most. Any effects, good or bad,  get multiplied. This means
that _continuous attention to investment in technical excellence_ is essential.

Many 'agile transformations' tend to focus on the middle and outer loops only,
which is necessary but not sufficient. According to Jason Gorman, [this is the
reason most agile transformations fail](https://www.youtube.com/watch?v=-wNH6YgZQtw).

For effective, sustainable development, we need to work on all three feedback
loops eventually. Focusing on the middle and outer loops is not sufficient, but
focusing mostly on the inner loop isn't sufficient either. Productivity and ROI
come from the interplay between the loops. You still can decide to focus on a
specific loop at specific points in time, but over time you need to tend to all
three.

The three feedback loops is a model and a model is a simplification. We think it
provides a useful lens on the systemic effects in software product development
and helps to find more effective and efficient interventions.

Looking through the frame of the 3 loops allows us to investigate: 

- length of the feedback loops, 
- delays, 
- handovers , 
- waiting for decision making, 
- and "rework" 

A bit more on why we put "rework" in scare quotes. We love iteration. Iteration is often a necesary condition for iteration. What we don't like to see is work going through the loop again because it is not good enough. 

The three loops are about
- decision making
- getting feedback & information
- to steer & improve


![initial whiteboard sketch](/attachments/blogposts/2022/3-feedback-loops-sketch.jpg)

# Outer loop - product loop


Stuff that happens here:
- (small) releases
- roadmaps (+link roadmapping post Paul Dyson)
- steering on value
- dimensional planning
- user story mapping

# Middle loop - getting valuable work done loop

Middle loop: "Simplicity--the art of maximizing the amount of work not done--is
essential." (Agile Manifesto principle 10, although this applies to the other 2
loops as well)

Leverage in the middle loop can be substantial, e.g. in 'chaotic' organizations
mostly based on individual contributors rather than teams. Structuring work,
managing flow, focusing on value, and continuous improvement can make a huge
initial difference. This is what the Scrum idea of "Doing Twice the Work in Half
the Time" albeit a bit misleading is about. A bit of focus and maximizing the
amount of work not done can be shockingly effective.

Stuff that happens here:
- sprints / kanban
- velocity
- work-in-progress limits
- impediments

# Inner loop - technical excellence loop

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
> "if you go very fast, you will get much faster feedback on whether things are going the right way"
. 

So technical excellence enables a speedup in the middle loop
("becoming better faster") and in the outer loop - faster discovery, market
testing, etc.

Stuff that happens here:
- pair programming
- TDD, relentless refactoring
- smoothness of delivery
- pull requests + reviews
- working in baby steps / MMMST (Mike Hill)
- tiny deltas of value
- frontend <-> backend 

# Why most agile transformations fail, according to Jason...

Most agile initiatives tend to focus on this loop (and often the outer loop as
well). The inner loop is not paid attention to. Investing in the middle and
outer loops only will bring some benefits for most organizations, but they won't
realize their potential.

Most agile transformations miss out the huge leverage of investing in the inner loop.

# ...but you need to work on all three - the loops interact

The 3 loops interact. The inner loop is a big enabler for the other two loops.
The middle loop ensures flow and can create a urgency for e.g. investing in
inner loop improvements.

In the end, you need to work on all three loops: without investment in the outer
loop you are unable to deliver to your users'/stakeholders' needs. Without
investing in the middle loop, not much will come out of development. Without
investing in the inner loop, delivery will be slow and defect-rich.

You need to work on all 3 loops for effective product delivery. 

+ plaatje met loops die elkaar beinvloeden

# Big gains, need investment

Inner loop improvements can have a huge impact, they also require investment.
Becoming highly skilled at software development takes practice, training,
mentoring. Learning how do deliver running, tested software on shorter and
shorter loops is a hard skill.

Many organizations tend to underinvest, urging developers to focus on 'writing
software'. Or they see training mostly as an individual employment benefit with
limited training budgets. 

Training often seen as something for the individual, and as a fringe benefit (? "secundaire arbeidsvoorwaarde"). This misses the point of structurally improving the inner loop in a teams based environment. 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">
Too many companies think “coaching” is a benefit they might offer under the learning &amp; development budget, when actually it is an existential concern for any technical team. 
<a href="https://t.co/Z3Ih1CRZJr">https://t.co/Z3Ih1CRZJr</a></p>&mdash; Beth (@bethcodes) <a href="https://twitter.com/bethcodes/status/1437153928362160131?ref_src=twsrc%5Etfw">September 12, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


Another important aspect is in a team based context (and you basically need team
based work for any serious development effort) it is about *team* capabilities.
You need to train & coach teams. This is another bit point of leverage. It also
requires a different frame of thinking, not software development = many hands
programming.

# Stuff

Power of tiny gains graph: https://twitter.com/AlexAndBooks_/status/1497956168949448708

# Sources

Ref: Jason Gorman, [Why agile transformations fail](https://www.youtube.com/watch?v=-wNH6YgZQtw) July 2021
- Most Agile transformations tend to focus mostly on optimising the outer feedback loops of the development process, which produces disappointing results. To speed up delivery cycle times, focus on the innermost loop - build & test 
- The kernel of agility in software development - and the business models that rely on that software - is how long it takes to build and test your software. I can pretty accurately predict the future of a software-dependent business with that one metric.
- If your build + test times are slow, the cost of changing your systems will be high, and - no matter how successful you are now - you're just doing market research for a more agile competitor.
- The key point in my video on why Agile transformations tend to fail is they try to speed up nested feedback loops by focusing on the outer loops. As any programmer of performance-critical code will tell you, optimising the innermost loop usually produces much faster cycle times

The other source for the 3 loops is: Agile Fluency model with its Focusing, Delivering & Optimizing zone capabilities correspond to the 3 feedback loops.

# Related work

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Programming is a leverage game. Making the lever longer is *way* better than pushing the lever harder.</p>&mdash; Kent Beck (@KentBeck) <a href="https://twitter.com/KentBeck/status/1489301473380864000?ref_src=twsrc%5Etfw">February 3, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

XP loops; the "2 parts" of XP (the Scrum-like part and the 'technical' part)

Related to XP: BDD has inner and outer loop - https://twitter.com/AntonyMarcano/status/1450394615304044546?t=fQX1saqyXxU9o-WTf8dVQw - the TDD loop, one failing test at a time concerns the inner dev loop; the BDD or 'acceptance test loop' concerns the getting things done loop  

Martin Fowler, [Is High Quality Software Worth the Cost?](https://www.martinfowler.com/articles/is-quality-worth-cost.html)

Willem-Jan Ageling, [Scrum Has Three Learning Cycles — Are These Devaluing Your Learning Through Empiricism?](https://medium.com/serious-scrum/scrum-has-three-learning-cycles-are-these-devaluating-your-learning-through-empiricism-d8090c94f44e)

# Follow up posts:

## Improving the inner loop?

- what does improving the inner loop means? e.g. "smoothness of delivery", no more flakey tests, shift left

## Team capabilities investment - a different perspective


Focusing on training as employment benefit & training/learning for individuals:
the *conflict* of getting more skilled vs delivering something now lands on the
developer's desk! This conflict shouldn't be there.

## 3 feedback loops seen from complex systems perspective

safe-to-fail probes; being able to dampen negative effects
