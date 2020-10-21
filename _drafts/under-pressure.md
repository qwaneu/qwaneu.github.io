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

We have run [Agile Fluency](https://www.agilefluency.org/) diagnostic workshops
with several development teams this year. In these workshops, we discover
together with a team how they can deliver better software products faster, in a
sustainable way. Occasionally we work with a team that feels they are doing
quite ok. They try to do retrospectives, but not much is coming out of these.
When we look closely at how they work however, we see quite some room for
further improvement of their productivity. 

In this post, we will zoom in on what is going on here and what an organization
can do to help a team to move towards a virtuous cycle of continuous
improvement.

## Team fluency

An Agile Fluency diagnostic workshop is a kind of team retrospective, in which
we discover together with a team how fluent they are in the different zones that
the [Agile Fluency® Model](https://www.agilefluency.org/) distinguishes. The
three most interesting zones are:

| **Focusing** | Teams that are fluent in Focusing produce business value; this zone is about transparency and teamwork. |
| **Delivering**  | Teams that are fluent in Delivering deliver on the market cadence; this zone is about sustainable delivery, about being productive with low defects. |
| **Optimizing** | Teams that are fluent in Optimizing lead their market; this zone is about 'business agility', where teams are organized for making good product decisions. |

We sometimes work with teams that are not doing that many retrospectives.
Everything seems to be going well enough, they say, and there is not much to
discuss in their retrospectives. The retrospectives become a bit of a drag.

Our observation is that usually such a team is actually performing reasonably
well, but there is also room to further improve _productivity_. Now
productivity in software development is a overloaded term. Does anyone
remember counting lines of code as a measure of productivity? So let's
elaborate a bit on our working definition of productivity.

> Higher productivity is one of the benefits of becoming fluent in the different
Agile Fluency zones. The model also mentions increased Return On Investment as a
benefit: if we make better product decisions, clarify priorities and steer based
on feedback from actual users, we can deliver more value sooner. A _product
decision_ is about what goes in the product and which [level of
perfection](/2020/09/02/dimensional-planning.html) we aim for, while a _priority
decision_ determines what work needs to be done first.

## Productivity

Let's define productivity loosely as the share of a team's time that they spend
on doing valuable stuff. Valuable stuff is not only working on features and
other changes directly valuable to users and customers. It also includes time
spent on learning, on doing structural fixes in the build pipeline, etc.
Productivity is about being valuable in the short term and in the long term.

Fixing defects, context switching because of late feedback, keeping an eye on
running builds and restarting them a few times because of flaky tests are all
activities that lower productivity, like illustrated by the picture below.

![late feedback creates waste](/attachments/blogposts/2020/productivity-waste.jpg)

So what can a team do to improve productivity? **Regular reflection is key**:
reflect on your way of working, look for better ways of organizing your work,
create more flow. Hand-offs between team members for instance cause waiting and
misunderstanding. We can reduce hand-offs by collaborating more closely. Closer
collaboration leads to better communication, which helps us save time and be
more productive.

To get fluent in the Delivering zone, a team works on their **technical
excellence**. Technical excellence increases productivity by having low defect
rates and little rework. Delivering quality work and having low defect rates
also changes the dynamics in the team, making it a more joyful space to work in.
This affects retention positively and helps long term productivity.

Getting fluent in Delivering means finding ways of **shortening your feedback
loops**. If you can find ways to get feedback from local, fast tests, instead of
waiting for the feedback from your build pipeline, the whole dynamic of your
work changes. This also creates **opportunities to learn**, because the feedback
directly follows on our actions.

![fast feedback causes less waste and more learning](/attachments/blogposts/2020/productivity-less-waste.jpg)

We think a team can benefit from a little pressure and some sense of urgency, to
help them move to a virtuous cycle of continuous improvement and higher
productivity.

> We notice that 'pressure' often has a negative connotation. In stressful
times, when the stakes are high, some managers will pressure teams to deliver
more stuff faster, urging them to 'work harder'. Team members get stressed and
fall in the trap of thinking the only option is to work overtime.  
**This is not what we mean here and we think that such an approach is counterproductive!**

## Under pressure, work harder?

So why is working harder and putting in overtime so unproductive?

Overtime acts as a buffer that absorbs any high demands. It is like magic extra
time, by which a 60 hour job suddenly fits into 40 hours. So putting in extra
time is **not** being productive, it is hiding the effort and any inefficiencies
in your way of working. The extra time facilitates working around impediments,
instead of tackling them structurally.

With overtime as a buffer, there is less urge to stop, reflect, and find smarter
ways of working. Neither is there an incentive to call into question if all
planned features are necessary to achieve value. Even worse, if a team manages
to deliver something based on substantial overtime, there is no feedback loop to
management and customers about the real effort, and they will believe the team
is productive. This sets expectations for the next time, making it harder to
escape the overtime trap.

And it is even worse than that: research has shown that overtime quickly turns
counterproductive. Within weeks of working overtime, the net result is that you
are actually less productive than if you would not have worked overtime at all,
see e.g. [The Research Is Clear: Long Hours Backfire for People and for
Companies](https://hbr.org/2015/08/the-research-is-clear-long-hours-backfire-for-people-and-for-companies)
and [Working Over 40 Hours a Week Makes You Less Productive, Not
More](https://lifehacker.com/working-over-40-hours-a-week-makes-you-less-productive-1725646811).
Furthermore, overtime quickly burns out people. In summary, overtime is inhumane
and achieves the opposite of what people intend: lower instead of higher
productivity.

@@DOE overtime

We also have an issue with stating that teams should "work harder". This assumes
they are currently not doing their best. It is a reasonable assumption that
everyone _is_ doing their best given what they know, their skills, the resources
available to them and the situation at hand - see e.g. the [prime directive for
retrospectives](http://www.retrospectivewiki.org/index.php?title=The_Prime_Directive)).
Once in a while you might have a low performing contributor, but then it is
management's job to act on this. **In a team based context, productivity is a
systemic property** - it emerges from the interactions between the team members
from how the organizational context interacts with the team.

So demanding (or allowing) overtime and urging a team to "work harder!" is not
going to work and will not lead to a more productive team. 

## Enabling constraints help a team grow

There is a different way to create a moderate amount of pressure and a sense of
urgency, turning to the field of complex systems for inspiration. We can regard a team within its organization context as a complex system. 

Complexity theory provides us with the idea of _Enabling Constraints_. Enabling
constraints are constraints on a system (e.g. a team) that do not prescribe the
system's behaviour, but help the system to self-organize. They are not strict
rules and obligations that state what you should do and what you are not allowed
to do, but they are boundaries (sometimes strict, sometimes more elastic) within
which a team can self-organize.

Providing a team with clear objectives and challenging them to find their way to
that goal with limited time and effort can be seen as relevant enabling
constraints here. Together with a team, you can e.g. pick a date mind and agree
that you will mind the 32 / 40 working hours per week. This will create a
container that can encourage a team to continuously reflect, look for
improvements, innovate, but also to optimize the flow of their work, to optimize
the speed & quality of decisions, to question what to build, to find [Dirt Roads](/2020/09/30/dimensional-planning-a-story.html).

This is what we mean when we are talking about 'pressure'. The goal and the
constraints provide just enough pressure for a team to have a sense of urgency,
to trigger a bit of creativity, but also invite some push back from the team.

> There are two types of constraints, **governing constraints** and **enabling constraints**.  
> To illustrate the difference, let's look at organizing an [Open
> Space](https://www.agilealliance.org/glossary/open-space) conference: a code
> of conduct is a governing constraint; it defines boundaries of
> acceptable behaviour. If a participant would cross those boundaries, they
> will be kicked out.  
> The Open Space rules and principles are enabling constraints.
> Rules like _Whoever comes is the right people_ and the _Law of mobility_ do
> not prescribe what should happen, but they provide a context in which useful
> conversations start taking place and where people take responsibility for
> their own learning.

## Discover better ways, maximize the work not done

If we use things like an ambitious goal, time boxes, and reasonable work hours as enabling constraints, the team can start reflecting on how they organize their work, how they can do their work better and whether the work really needs to be done to achieve the goal:

- **(re)organize for shorter feedback loops and better flow** - try
  different ways of how you organize your flow of work, look for ways of getting feedback earlier in your process; for example: do more pair/mob/ensemble programming instead of waiting for code reviews; play with WIP limits (work in progress); work in a different way with teams you depend on.
- **learning better ways** - take sufficient time to reflect and adjust the way
  of; try out stuff, run small experiments; this might feel counter-intuitive
  because you have a big goal to achieve and limited time; running many experiments however is the way to find all kinds of process improvements, like scripts for repeated work, or simplifying some code that is continuously
  slowing you down. It will help you to go faster.
- **maximizing the amount of work not done**: as a team start questioning what
  is really needed to achieve the goal; when there is some pressure and your
  resources are limited, you often find you can do with less. Dimensional
  planning is a technique that can help here, see our previous posts: [Good
  enough software, early & often](/2020/09/02/dimensional-planning.html) and
  [Dimensional Planning - a
  story](/2020/09/30/dimensional-planning-a-story.html).

Having a sense of direction and a sense of urgency will make retrospectives valuable again. If a team knows where they are heading and know how fast (or slow) they are going, they will start seeing impediments and opportunities for improvement.

With some pressure on the system, great things can develop. But we need to keep the work sustainable, for people to thrive. We need to balance focused work and focused improvement with slack and rest.

## Sustainable pace

Working with enabling constraints like we described above does not mean creating
a stressful environment for a team! This is a pitfall however and some teams
could use a bit of help or coaching, to find a [sustainable pace](https://sustainablepace.net/what-is-sustainable-pace).

Helping a team to build in slack in the way of working is crucial, because of
the paradox: allowing slack in your schedule reduces the time available for
work, so teams tend to skip on this, for instance working throughout the lunch
instead of taking a walk or enjoying a good foosball match. In the end having
slack will lead to better solutions and will save time.

Some ideas for keeping things sustainable are: learning by walking around, e.g.
attend other teams' ceremonies or go 'on loan' for a while in another part of
the organisation (job rotation); [gold
cards](https://leadingagileteams.com/2015/09/01/making-time-for-personal-development-gold-cards/),
[20% time](https://en.wikipedia.org/wiki/20%25_Project), product dev-free weeks,
training courses, conferences. 

> "Software development is a game of insight, and insight comes to the prepared,
> rested, relaxed mind." -- Kent Beck, Extreme Programming Explained

## Conclusions

What we see in practice is that teams get more fluent in particular in Focusing
and Delivering capabilities, because of demands of their organization, their
context, the market the organization is operating in. After some time the teams
plateau and what they do is good enough. Urge to grow further fades. Having a
set of enabling constraints like a goal, a target date, limits on work hours can
help a team to feel that urge again.

## References

The concept of Governing vs Enabling Constraints originates from [Alicia Juarrero](https://mitpress.mit.edu/contributors/alicia-juarrero) and has been elaborated in the [Cynefin sensemaking framework](https://en.wikipedia.org/wiki/Cynefin_framework). To learn more:

- Chris Corrigan, [Constraints that enable emergence](http://www.chriscorrigan.com/parkinglot/constraints-that-enable-emergence/)
- Dave Snowden, [Freedom through Constraints](https://www.cognitive-edge.com/freedom-through-constraints/)
- Chris Matts, [Constraints that Enable](https://theitriskmanager.com/2018/12/09/constraints-that-enable/)
- Maciej Kaszubowski, [Enabling constraints in software development](https://mkaszubowski.com/2020/05/11/enabling-constraints-in-software-development.html)

_Maximizing the amount of work not done_ is one of the [twelve principles of the Agile Manifesto](https://agilemanifesto.org/principles.html).

If you'd like to learn more about the Agile Fluency model and how it can help you in getting more from agile working, we recommend reading the [eBook](https://www.agilefluency.org/ebook.php).

Regarding slack and sustainable pace, I can recommend the book by
Jon Fitch & Max Frenzel, [Time Off - A Practical Guide to Building Your Rest Ethic and Finding Success Without the Stress](https://maxfrenzel.com/time-off) (2020)

Find more great quotes from Kent Beck at [Goodreads](https://www.goodreads.com/author/quotes/25211.Kent_Beck).

<aside>
  <h3>From good enough to team greatness</h3>
  <p>
    Would you like your teams to grow further even though they're doing ok? Do feel you are not getting the benefits from your 'agile transformation'? Drop us a line and we can work with you.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our agile fluency service</a>
  </div></p>
</aside>
