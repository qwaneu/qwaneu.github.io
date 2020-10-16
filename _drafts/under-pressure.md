---
layout: post
title: Under pressure - why overtime is such a bad idea and working harder won't save you
tags:
  - agile fluency
  - continuous delivery
  - systems thinking
  - complexity
author: Marc Evers
image: /attachments/blogposts/2020/working-harder.jpg
---

We have been doing a number of Agile Fluency diagnostic workshops with several teams this year. Together with development teams, we discover how they can deliver better software products sooner, in a sustainable way. Occasionally we encounter teams that feel they are doing quite ok and although they try to do retrospectives, there is not much coming out of these. When we look closely at their way of working however, we see there is quite some room for further improving their productivity. In this post we will zoom in on what seems to be going on here and what an organization can do to get the team in a virtuous cycle of continuous improvement.

## Team fluency

An Agile Fluency diagnostic workshop is a kind of team retrospective, in which we discover together with a team how fluent they are in the different fluency zones. The 3 most interesting zones in the [Agile Fluency® Model](https://www.agilefluency.org/) are:
- **Focusing** - focusing teams produce business value; it is about transparency and teamwork
- **Delivering** - delivering teams deliver on the market cadence; it is about sustainable delivery, productive, low defects
- **Optimizing** - optimizing teams lead their market; 'business agility', teams organized for good product decisions

You could see a diagnostic workshop as a kind of retrospective. We sometimes
encounter teams that are not doing that many retrospectives.
Everything seems to be going well enough, they say, and there is not so much to
discuss in their retrospectives, or the retrospectives become a bit of a drag.

Our observation is that the team _are_ doing quite well, and we also see sufficient room to further improve 'productivity'.

Looking at Agile Fluency zone benefits, the model mentions increased ROI (Return
On Investment). If we make better product decisions, clarify priorities and
steer based on feedback from actual users, more value can be delivered sooner. A
_product decision_ is about what goes in the product, and which [level of
perfection](/2020/09/02/dimensional-planning.html) we aim for. A _priority
decision_ determines what work needs to be done first.

The model also mentions increased productivity. Now productivity is a
dangerous, overloaded term within software development. Does anyone remember
counting lines of code as a measure of productivity?.

## Productivity

Let's define productivity loosely as the share of a team's time that they spend
on doing valuable stuff. Valuable stuff is not only working on features and
changes that are valuable to users and customers, it also time spent on
learning, on doing structural fixes in the build pipeline, etc. Productivity is about being valuable in the short term and in the
long term.

Fixing defects, context switching because of late feedback, monitoring builds
and restarting because of flaky tests are all activities that keep productivity
down. Illustrated by the picture below.

![late feedback creates waste](/attachments/blogposts/2020/productivity-waste.jpg)

Context switching is wasted (non-value-adding) time, fixing stuff without learning & improving is wasted time.

So what can a team do to improve productivity? Regular reflection is key here:
reflect on your way of working, trying to find better ways of organizing your
work and creating more flow.

Hand-offs cause waiting and misunderstanding. We can reduce hand-offs by collaborating more closely. Closer collaboration leads to better communication, which helps us save time and be more productive.

Teams that get fluent in the Delivering zone work on their technical excellence.
This increases productivity by having low defect rates and little rework.
Delivering quality work and having low defect rates also changes the dynamics in
the team. This makes the context more joyful to work in. This affects retention
positively and helps productivity in the long term.

Part of getting fluent in Delivering means finding ways of shortening your feedback loops. If we can find ways to get the pipeline feedback from the picture above in a local, fast test, we change the whole dynamic of our work. Furthermore, we create an opportunity for ourselves to learn, because the feedback directly follows on our actions.

![fast feedback causes less waste and more learning](/attachments/blogposts/2020/productivity-less-waste.jpg)

## Creating a sense of urgency

We think teams benefit from a little pressure, and some sense of urgency, to trigger a quest for higher productivity.

We noticed that 'pressure' often has a negative connotation. In more stressful
times or when the stakes are high, some managers put pressure on development
teams to deliver more stuff faster, urging them to 'work harder'. Team members
feel the pressure and think the only option is to work overtime (often unpaid)
to deliver to the high demands.

## Enabling constraints help a team grow

There is a different way to create a moderate amount of pressure and a sense of
urgency. If we take a complex systems perspective, we can play with _enabling
constraints_. Enabling constraints are constraints on a system (e.g. a team)
that do not prescribe the system's behaviour, but help the system to
self-organize within those constraints. Enabling constraints provide sufficient
freedom for interesting behaviour to emerge.

> There are two types of constraints, **governing constraints** and **enabling constraints**.  
> As an example, say we'd organize an [Open Space](https://www.agilealliance.org/glossary/open-space) conference: a code of conduct would be a governing constraint; it defines the boundaries of acceptable behaviour and when a participant would cross those boundaries, they will get kicked out.  
> The Open Space rules and principles on the contrary, are enabling constraints. Rules like _Whoever comes is the right people_ and the _Law of mobility_ do not prescribe what should happen, but they provide a context in which useful conversations start taking place and where people take responsibility for their own learning

Enabling constraints create a container that encourages a team
to continuously reflect, look for improvements, innovate, but also to
optimize for flow of work, speed & quality of decisions, questioning what to
build, finding Dirt Roads.

Clear objectives and constraints on time and effort - pick a date, work with the
team as it is, mind the 32 / 40 weekly hours but also breaks, etc.

Then challenge the team to find their way of achieving the goal.

This is what we mean with 'pressure' - just enough pressure for a team to have a
sense of urgency, to trigger a bit of creativity but also invite push back -
"help me reach this goal; help me find a simpler way; if it is impossible, say
so, and then find something that is ambitious but achievable together".

What we see in practice is that teams get more fluent in particular in Focusing
and Delivering capabilities, because of demands of their organization, their
context, the market the organization is operating in. After some time the teams
plateau and what they do is good enough. Urge to grow further fades.

Having a set of enabling constraints like a goal, a target date, limits on work hours can help a team to feel that urge again.

## Under pressure, work harder?

Overtime acts as a buffer that absorbs any high demands. It is magic extra time,
by which the 60 hour job suddenly fits into 40 hours. This is **not** being
productive. On the contrary, overtime acts as a buffer that absorbing the high demand. It also hides inefficiencies in your process, dampening the effect of impediments.

When overtime is used as a buffer, there is no urge to stop, reflect, and find smarter ways of working. Neither is there an incentive
to call into question whether the demanded features are really necessary to
achieve value. Even worse, if a team manages to deliver something with substantial overtime, there is no feedback loop to management and customers, and they will think the team is being productive and well running. This sets expectations for the next time, making it harder to escape the overtime trap.

And it is even worse than that: research has shown that overtime quickly becomes counterproductive. Within weeks of working overtime, you actually become less productive than if you would not have worked overtime at all, see e.g. [The Research Is Clear: Long Hours Backfire for People and for Companies](https://hbr.org/2015/08/the-research-is-clear-long-hours-backfire-for-people-and-for-companies) or
[Working Over 40 Hours a Week Makes You Less Productive, Not More](https://lifehacker.com/working-over-40-hours-a-week-makes-you-less-productive-1725646811). And it quickly burns out people. In summary, overtime is inhumane and achieves the opposite of what people intend: lower instead of higher productivity.

@@DOE overtime

We also have an issue with stating that people should "work harder". This
assumes they are currently not doing their best. It is a reasonable assumption
that everyone is doing their best given what they know, their skills,the
resources available to them and the situation at hand (cf. the [prime directive
for
retrospectives](http://www.retrospectivewiki.org/index.php?title=The_Prime_Directive)).
Once in a while you might have to deal with a low performing contributor, but it
is management's job to act on this. In a team based context, productivity is a
systemic property - it emerges from the system of work, and how the team works
as a system in relation to its environment.

So demanding or allowing overtime and urging a team to "work harder!" is not going to work. This is not the way to a more productive team. Using pressure in this way will have the opposite effect of what management tries to achieve.

## Discover better ways, maximize the work not done

Instead, a team can use the constraints as enabling constraints and start reflecting on how they organize their work, how they can do their work better and whether the work really needs to be done to achieve the goal.

- **(re)organize for shorter feedback loops and better flow** - find/try
  different ways of how you organize, like more pair/mob programming instead of
  waiting for code reviews, playing with WIP (work in progress) limits,
  reconsidering your team's dependencies on other teams
- **learning better ways** - take ample time to reflect, adjust the way of
  working and try out stuff; this might feel a bit counter-intuitive because you
  are limited in time; this could result in all kinds of process improvements,
  like writing scripts for repeated work, taking time to thoroughly refactor
  that piece of code that is continuously slowing you down
- **maximizing the amount of work not done**: as a team start questioning what
  is really needed to achieve the objectives; when there is some pressure,
  usually you find you can do with less. Dimensional planning is a technique
  that can help here, see our previous posts: [Good enough
  software, early & often](/2020/09/02/dimensional-planning.html) and
  [Dimensional Planning - a
  story](/2020/09/30/dimensional-planning-a-story.html).

A sense of direction and a sense of urgency will make retrospectives valuable again. If a team knows where they are heading and know how fast (or how slow) they will start finding impediments and opportunities for improvement.

With some pressure on the system, great things can start to develop. But we need to keep a sustainable system of work, for people to thrive. We need to  balance focused work and focused improvement with slack and rest.

## Sustainable pace

Working with enabling constraints does not mean creating a stressful environment
for a team! Some teams might need a bit of help or coaching in how to discover
better ways. 

Helping a team to build in slack in the way of working is crucial here. Teams might need a bit of support here, because of the paradox: allowing slack in your schedule reduces the time available for work, so teams tend to skip on this (just working through the lunch instead of talking a walk or enjoying a good foosball match). In the end having slack (being off focus for work frequently) will lead to better solutions and will save time.

Some other ideas of keeping things sustainable are: learning by walking around,  e.g. attend other teams' ceremonies or go 'on loan' for a while in another part of the organisation (job rotation); [gold cards](https://leadingagileteams.com/2015/09/01/making-time-for-personal-development-gold-cards/), [20% time](https://en.wikipedia.org/wiki/20%25_Project), product dev-free weeks, training courses, conferences. 

> "Software development is a game of insight, and insight comes to the prepared, rested, relaxed mind." -- Kent Beck, Extreme Programming Explained

## References

The concept of Governing vs Enabling Constraints originates from [Alicia Juarrero](https://mitpress.mit.edu/contributors/alicia-juarrero) and has been elaborated in the [Cynefin sensemaking framework](https://en.wikipedia.org/wiki/Cynefin_framework). To learn more:

- Chris Corrigan, [Constraints that enable emergence](http://www.chriscorrigan.com/parkinglot/constraints-that-enable-emergence/)
- Dave Snowden, [Freedom through Constraints](https://www.cognitive-edge.com/freedom-through-constraints/)
- Chris Matts, [Constraints that Enable](https://theitriskmanager.com/2018/12/09/constraints-that-enable/)
- Maciej Kaszubowski, [Enabling constraints in software development](https://mkaszubowski.com/2020/05/11/enabling-constraints-in-software-development.html)

"Maximizing the amount of work not done" is one of the [twelve principles of the Agile Manifesto](https://agilemanifesto.org/principles.html).

If you'd like to learn more about the Agile Fluency model and how it can help you in getting more from agile working, we recommend reading the [eBook](https://www.agilefluency.org/ebook.php).

Regarding slack and sustainable pace, I can recommend the book by
Jon Fitch & Max Frenzel, [Time Off - A Practical Guide to Building Your Rest Ethic and Finding Success Without the Stress](https://maxfrenzel.com/time-off) (2020)

<aside>
  <h3>From good enough to team greatness</h3>
  <p>
    Would you like your teams to grow further even though they're doing ok? Do feel you are not getting the benefits from your 'agile transformation'? Drop us a line and we can work with you.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our agile fluency service</a>
  </div></p>
</aside>
