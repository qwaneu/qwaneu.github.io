---
layout: post
title: Under pressure - why overtime is such a bad idea and working harder won't save you
tags:
  - agile fluency
  - continuous delivery
  - systems thinking
author: Marc Evers
image:
---

We have been doing a number of Agile Fluency diagnostic workshops with several teams this year. In such a workshop, we discover together with a software team how fluent they are in the different fluency zones. The 3 most interesting zones in the [Agile Fluency® Model](https://www.agilefluency.org/) are:

- Focusing - focusing teams produce business value; it is about transparency and teamwork
- Delivering - delivering teams deliver on the market cadence; it is about sustainable delivery, productive, low defects
- Optimizing - optimizing teams lead their market; 'business agility', teams organized for good product decisions

You could see a diagnostic workshop as a kind of retrospective. We sometimes
encounter teams that are not doing that many retrospectives.
Everything seems to be going well enough, they say, and there is not so much to
discuss in their retrospectives, or the retrospectives become a bit of a drag.
Our observation is that the team _are_ doing quite well, and we also see sufficient
room to further improve 'productivity'.

## Productivity

Looking at Agile Fluency zone benefits, the model mentions increased ROI (Return
On Investment). If we make better product
decisions, and clarify priorities, more value can be delivered sooner.
A _product decision_ is about what goes in the product, and which [level of perfection](@TODO link to dimensional planning) we aim for. A _priority decision_ determines what work needs to be done first.

The model also mentions
increased productivity/efficiency. Now productivity is a dangerous, overloaded
term within software development. Does anyone remember counting lines of code as a
measure of productivity?.

Let's define productivity loosely as the share of a team's time that they spend
on doing valuable stuff. Valuable stuff is not only working on features and
changes that are valuable to users and customers, it also time spent on
learning, on doing structural fixes in the [CI/CD pipeline](@TODO Link for acronym), etc.
Productivity is about being valuable in the short term and in the long term.

Fixing defects, context switching because of late feedback, monitoring builds and
restarting because of flaky tests are all activities that
keep productivity down.

![taartgrafiekje of zo van werkzaamheden ter illustratie?]()

So what can a team do to improve productivity? Regular reflection is key here:
reflect on your way of working, trying to find better ways of organizing your
work and creating more flow.

Hand-offs cause waiting and misunderstaning. We can reduce hand-offs by collaborating more closely. Closer collaboration leads to better communication, which helps us save time and be more productive.

Teams that get fluent in the Delivering zone work on their technical excellence.
This increases productivity by having low defect rates and little rework.
Delivering quality work and having low defect rates also changes the dynamics in
the team. This makes the context more joyful to work in. This affects retention
positively and helps productivity in the long term.

## A little pressure

We think teams benefit from a little pressure, and some sense of urgency, to trigger a quest for higher productivity.

We noticed that 'pressure' often has a negative connotation. In more stressful
times or when the stakes are high, some managers put pressure on development
teams to deliver more stuff faster, urging them to 'work harder'. Team members
feel the pressure and think the only option is to work overtime (often unpaid)
to deliver to the high demands.

## Working harder

Overtime acts as a buffer that absorbs any high demands. It is magic extra time,
by which the 60 hour job suddenly fits into 40 hours. This is not being
productive. On the contrary, by absorbing the high demand, there is no urge to
stop, reflect, and find smarter ways of working. Neither is there an incentive to
call into question whether the demanded features are really necessary to achieve
value and find a simpler way to your goals. Worse, it reinforces the idea that
the team can actually do 60 hour jobs in 40 hours.

And it is even worse: research has shown that overtime quickly becomes counterproductive. Within weeks of working overtime, you actually become less productive than if you would not have worked overtime at all.
[bron??](https://lifehacker.com/working-over-40-hours-a-week-makes-you-less-productive-1725646811). And it quickly burns out people. In summary, overtime is inhumane and achieves the opposite of what people intend: lower instead of higher productivity.

We have another issue with saying people should "work harder", namely the
assumption that they are currently not doing their best. It is a reasonable
assumption that everyone is doing their best given what they know, their
skills,the resources available to them and the situation at hand (cf. the [prime
directive for
retrospectives](http://www.retrospectivewiki.org/index.php?title=The_Prime_Directive)).

Yes occasionally we have to deal with a low performing contributor, but this is
management's job to act on this. Most of the time getting better outcomes and
being more productive is a systemic issue - it follows from the system of work,
and how the team works as a system in relation to its environment.

So overtime and shouting "work harder!" is not going to work. This is not the way to a more productive team. Using pressure in this way will have the opposite effect of what management tries to achieve.

## Enabling constraints help teams grow

There is a different way to use a moderate amount of pressure. Taking a complex
systems perspective, we can look at enabling constraints. Enabling constraints
are constraints on a system (e.g. a team) that do not prescribe the system's
behaviour, but help the system to self-organize within those constraints.
Enabling constraints provide sufficient freedom for interesting behaviour to
emerge.

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

## Discovering better ways & maximizing the amount of work not done

Putting a little pressure on a team in the form of the enabling constraints
mentioned above will help them in discovering better ways. Specifically:

- **learning better ways** - take ample time to reflect, adjust the way of
  working and try out stuff; this might feel a bit counter-intuitive because you
  are limited in time; this could result in all kinds of process improvements,
  like writing scripts for repeated work, taking time to thoroughly refactor
  that piece of code that is continuously slowing you down
- **(re)organize for shorter feedback loops and better flow** - find/try
  different ways of how you organize, like more pair/mob programming instead of
  waiting for code reviews, playing with WIP (work in progress) limits,
  reconsidering your team's dependencies on other teams
- **maximizing the amount of work not done**: as a team start questioning what
  is really needed to achieve the objectives; when there is some pressure,
  usually you find you can do with less. Dimensional planning is a technique
  that can help here, see our previous posts: [Good enough
  software, early & often](/2020/09/02/dimensional-planning.html) and
  [Dimensional Planning - a
  story](/2020/09/30/dimensional-planning-a-story.html).

![DoE over sense of urgency -> retro focus -> etc]()

## Sustainable pace

Working with enabling constraints does not mean creating a stressful environment for a team! Some teams might need a bit of help or coaching in how to discover better ways.

And remember, as a manager, you're in it together.
(ways to keep things sustainablle: learning by walking around (e.g. attend other teams ceremonies, or go 'on loan' for a while in another part of the organisation (job rotation). Gold cards, 20% time, product dev-free weeks, training courses, conferences ). I should find that kent beck quote from xp explained soon...).

## Conclusion

TBD

## References

The concept of Governing vs Enabling Constraints originates from Alicia Juarrero and has been elaborated in the Cynefin sensemaking framework. For more information, see e.g.:

- Chris Corrigan, [Constraints that enable emergence](http://www.chriscorrigan.com/parkinglot/constraints-that-enable-emergence/)
- Dave Snowden, [Freedom through Constraints](https://www.cognitive-edge.com/freedom-through-constraints/)
- Chris Matts, [Constraints that Enable](https://theitriskmanager.com/2018/12/09/constraints-that-enable/)
- Maciej Kaszubowski, [Enabling constraints in software development](https://mkaszubowski.com/2020/05/11/enabling-constraints-in-software-development.html)

If you'd like to learn more about the Agile Fluency model and how it can help you in getting more from agile working, we recommend reading the [eBook](https://www.agilefluency.org/ebook.php)

<aside>
  <h3>From good enough to team greatness</h3>
  <p>
    Would you like your teams to grow further even though they're doing ok? Do feel you are not getting the benefits from your 'agile transformation'? Drop us a line and we can work with you.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our agile fluency service</a>
  </div></p>
</aside>
