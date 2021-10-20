---
layout: post
title: Under pressure
tags:
  - productivity
  - agile fluency
  - continuous delivery
  - systems thinking
  - complexity
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/working-harder.jpg
---

Are you regularly holding retrospectives, but they do not result in
improvements? In this post we will highlight how a team can move to a virtuous
cycle of continuous improvement. 

- [Background](#background)
- [Team fluency](#team-fluency)
- [Productivity](#productivity)
- [Under pressure](#under-pressure)
- [Why overtime is such a bad idea and working harder won't save you](#why-overtime-is-such-a-bad-idea-and-working-harder-wont-save-you)
- [Enabling constraints help a team grow](#enabling-constraints-help-a-team-grow)
- [Discover better ways, maximize the work not done](#discover-better-ways-maximize-the-work-not-done)
- [Sustainable pace](#sustainable-pace)
- [Conclusions](#conclusions)
- [References](#references)

## Background 

In our consulting practice this year we have run [Agile
Fluency](https://www.agilefluency.org/) diagnostic workshops with several
development teams. Our aim is to let the team discover how they can sustainably
deliver better software products faster. We do this by learning together with
them about what is going on, using a set questionnaire as a guide. 

Occasionally we work with a team that feels they are doing
quite ok. They do retrospectives, but not much is coming out of these.
However, when we look closely at how they work, we see quite a bit of room for
further improvement. 

## Team fluency

An Agile Fluency diagnostic workshop is a kind of team retrospective, in which
we discover together with a team how fluent they are in the different zones that
the [Agile Fluency® Model](https://www.agilefluency.org/) distinguishes:

| **Focusing** | Teams that are fluent in the Focusing zone produce business value; this zone is about transparency and teamwork. |
| **Delivering**  | Teams that are fluent in the Delivering zone, deliver on the market cadence; this zone is about sustainable delivery, about being productive with low defects. |
| **Optimizing** | Teams that are fluent in the Optimizing zone lead their market; this zone is about 'business agility', where teams are organized for making good product decisions. |
| **Strengthening** | Teams that are fluent in the Strengthening zone make their organizations stronger; this zone is about teams understanding their role in the larger organization and helping the organization to become more successful. |

We sometimes work with teams that are not doing that many retrospectives.
Everything is going well enough, they say, and they have not much to
discuss in their retrospectives. Their retrospectives become a bit of a drag.

Our observation is that, while such a team is performing reasonably
well, they tend to have blind spots for improvement opportunities, often in the
area of _productivity_. Now productivity in software development is an
overloaded and somewhat dangerous term. Does anyone remember counting lines of
code as a measure of productivity? So let's elaborate a bit on what we mean with productivity.

> Higher productivity is only one of the benefits of becoming fluent in the
> different Agile Fluency zones. Others are increased Return On Investment
> (ROI), reduced risk and increased team member satisfaction.

## Productivity

Let's define productivity as the share of a team's time that they spend
on doing valuable stuff. Valuable stuff is not only working on features and
other changes directly valuable to users and customers. It also includes time
spent on learning, on doing structural fixes in the build pipeline, etc.
Productivity is about being valuable in the short term and in the long term.

Fixing defects, context switching because of late feedback, keeping an eye on
running builds and restarting them a few times because of flaky tests are all
activities that lower productivity, illustrated by the picture below.

![late feedback creates waste](/attachments/blogposts/2020/productivity-waste.jpg)

> Productivity and ROI are not independent. Productivity is an enabler
for increasing ROI: by becoming more productive, a team can deliver value
earlier, for lower costs. Becoming more productive means delivering software
more smoothly, and smoothness of delivery makes it possible to steer software
products.

**In a team based context, productivity is a systemic property** - it emerges
from the interactions between the team members and between the team and it
organizational context. So what can a team do to improve productivity? 

**Regular reflection is key**: reflect on your way of working, look for better
ways of organizing your work, create more flow. Hand-offs between team members
for instance cause waiting and misunderstanding. You can reduce hand-offs by
collaborating more closely. Closer collaboration leads to better communication,
which helps us save time and be more productive.

To get fluent in the _Delivering_ zone, a team works on their **technical
excellence**. Technical excellence increases productivity by having low defect
rates and little rework. Delivering quality work with low defect rates
changes the atmosphere in the team, making it more joyful to work.
This affects retention positively and helps long term productivity.

Getting fluent in Delivering means finding ways of **shortening your feedback
loops**. If you can find ways to get feedback from local, fast tests, instead of
waiting for the feedback from your build pipeline, the dynamic of your
work changes. This also creates **opportunities to learn**, because the feedback
directly follows your actions.

![fast feedback causes less waste and more learning](/attachments/blogposts/2020/productivity-less-waste.jpg)

## Under pressure

So how to proceed when a team thinks it is doing ok, but observe they have blind
spots? What can we do to get them to further improve their productivity? We
think a sense of urgency can help to help them move to a virtuous cycle of
continuous improvement and so, higher productivity. A sense of urgency can be
developed from a bit of pressure. 

We notice that 'pressure' often has a negative connotation. In stressful times,
when the stakes are high, some managers will pressure teams to deliver more
stuff faster, urging them to "work harder". Team members get stressed and fall
in the trap of thinking the only option is to work overtime.  

**This is not what we mean here and we think that such an approach is
counterproductive!**

## Why overtime is such a bad idea and working harder won't save you

So why is working harder and putting in overtime so unproductive? Let's
visualize this using a diagram of effects: if there is too much work to do, we
experience pressure and we decide to work overtime, which results in more
valuable output, reducing the work left. This is a balancing loop, illustrated by the see-saw icon.

![diagram of effects #work -> overtime -> valuable output](/attachments/blogposts/2020/under-pressure-overtime.jpg)

Overtime acts as a buffer that absorbs high demands. It is like magic extra
time, by which a 60 hour job suddenly fits into 40 hours. Putting in extra
time is **not** being productive, it is hiding the effort and any inefficiencies
in your way of working. The extra time facilitates working around impediments,
instead of tackling these structurally.

With overtime as a buffer, there is less urge to stop, reflect, and find smarter
ways of working. Neither is there an incentive to call into question if all
planned features are necessary to achieve the goal. Even worse, if a team
manages to deliver with substantial overtime, there is no feedback
loop to management and customers about the real effort, and they will believe
the team is productive. This sets expectations for the next time, making it
harder to escape the overtime trap.

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

The diagram of effects below illustrates this: when feeling the pressure to
deliver, we tend to skip reflection and process improvement, which means we are
not becoming more productive. A side effect of overtime is fatigue and
more mistakes, making us less productive. This reduces the valuable output
we produce, increasing pressure even more. There are multiple self-reinforcing
loops at play here (see the snowballs rolling downhill) which are much stronger
than the balancing effect mentioned earlier.

![diagram of effects #pressure -> less reflection; overtime -> fatigue & mistakes -> less productive -> less valuable output](/attachments/blogposts/2020/under-pressure-overtime-effects.jpg)

We also have an issue with stating that teams should "work harder". This assumes
they are currently not doing their best. It is a reasonable assumption that
everyone _is_ doing their best given what they know, their skills, the resources
available to them and the situation at hand - see the [prime directive for
retrospectives](http://www.retrospectivewiki.org/index.php?title=The_Prime_Directive) for inspiration.

So demanding (or allowing) overtime and urging a team to "work harder!" is not
going to work and will not lead to a more productive team. 

## Enabling constraints help a team grow

There is a different way to create a moderate amount of pressure and a sense of
urgency, turning to the field of complex systems for inspiration. We regard a
team within its organizational context as a complex system. Complexity theory
provides us with the idea of **Enabling Constraints**. Enabling constraints are
constraints on a system (e.g. a team) that do not prescribe the system's
behaviour, but help the system to self-organize. Enabling constraints are not
strict rules and obligations that state what you should do and what you are not
allowed to do, but they are boundaries (sometimes strict, sometimes more
elastic) within which a team can self-organize.

Providing a team with clear objectives and a target date, and challenging them
to find their way to that goal with limited time and effort, is a way of
providing a team with enabling constraints. Deciding together to mind the 40 /
36 / ... working hours per week is another enabling constraint. Using these
constraints will create a container within which a team can self-organize by
continuously reflecting, looking for improvements, innovating, but also
optimizing the flow of their work, optimizing the speed & quality of their
decisions, questioning what to build, finding [Dirt
Roads](/2020/09/30/dimensional-planning-a-story.html).

The diagram of effects below shows how the enabling constraints of having a
goal, a deadline and no overtime change the system. When we feel the pressure,
we can decide to take time for reflection and continuous improvement, so that we
become increasingly more productive, delivering more valuable output in less
time.

![enabling constraints changing the system](/attachments/blogposts/2020/under-pressure-pressure-constraints.jpg)

This is what we mean when we talk about 'pressure'. The goal and the constraints
provide just enough pressure for a team to have a sense of urgency, to trigger a
bit of creativity, but also invite some push back from the team.

> There are two types of constraints, **governing constraints** and **enabling constraints**.  
> To illustrate the difference, let's look at organizing an [Open
> Space](https://www.agilealliance.org/glossary/open-space) conference: a _code
> of conduct_ is a governing constraint, because it defines boundaries of
> acceptable behaviour. If a participant crosses those boundaries, they
> will be kicked out.  
> The Open Space rules and principles are enabling constraints.
> Rules like _Whoever comes is the right people_ and the _Law of mobility_ do
> not prescribe what should happen, but provide a context in which useful
> conversations start taking place and people take responsibility for
> their own learning.

## Discover better ways, maximize work not done

If we use things like an ambitious goal, time boxes, and reasonable work hours as enabling constraints, the team can start reflecting on how they organize their work, how they can do their work better and whether the work really needs to be done to achieve the goal:

- **(re)organize for shorter feedback loops and better flow** - try different
  ways of how you organize your flow of work, look for ways of getting feedback
  earlier in your process. Some examples: do more pair/mob/ensemble programming
  instead of waiting for code reviews; play with WIP limits (work in progress);
  work in a different way with teams you depend on.
- **learn better ways** - take time to adjust the way of working; try out
  stuff, run small experiments. This might feel counter-intuitive because you
  have a big goal to achieve and limited time. Running many experiments however
  is the way to find process improvements, like scripts for repeated work, or
  simplifying some code that is continuously slowing you down. In the end it
  will make you go faster.
- **maximize the amount of work not done**: following [this principle of the
  Agile Manifesto](https://agilemanifesto.org/principles.html), start
  questioning what is really needed to achieve the goal. With pressure and
  limited resources, you often find you can do with less. Dimensional planning
  can help here, see our previous posts: [Good enough software, early &
  often](/2020/09/02/dimensional-planning.html) and [Dimensional Planning - a
  story](/2020/09/30/dimensional-planning-a-story.html).

Having a sense of direction and a sense of urgency will make retrospectives
valuable again. If a team knows where they are heading and know how fast (or
slow) they are going, they will start seeing impediments and opportunities for
improvement.

With some pressure on the system, great things can develop. But we need to keep
the work sustainable, for people to thrive. We need to balance focused work and
focused improvement with slack and rest.

## Sustainable pace

Working with enabling constraints like we described above does not mean creating
a stressful environment for a team! This is a pitfall however and some teams
could use a bit of help or coaching, to find a [sustainable pace](https://sustainablepace.net/what-is-sustainable-pace).

Helping a team to build in slack in the way of working is crucial, because of
the paradox: allowing slack in your schedule reduces the time available for
work, so teams tend to skip on this, for instance working throughout the lunch
instead of taking a walk or enjoying a good foosball match. But slack in your
schedule will in the end save time and lead to better solutions.

Some ideas for keeping things sustainable are: learn by walking around, e.g.
attend other teams' ceremonies or go 'on loan' for a while in another part of
the organisation (job rotation); [gold
cards](https://leadingagileteams.com/2015/09/01/making-time-for-personal-development-gold-cards/),
[20% time](https://en.wikipedia.org/wiki/20%25_Project), product dev-free weeks,
training courses, conferences. 

> "Software development is a game of insight, and insight comes to the prepared,
> rested, relaxed mind." -- Kent Beck, Extreme Programming Explained

## Conclusions

What we see in practice is that teams get more fluent in particular in Focusing
and Delivering proficiencies, because of organizational or market demands. After
some time the teams plateau and what they do is good enough. Urge to grow
further fades. Having a set of enabling constraints like a goal, a target date,
and limits on work hours can help a team to feel that urge again.

Let's conclude with a quote from the [Time Off](https://maxfrenzel.com/time-off) book by John Fitch & Max Frenzel, where the authors quote Stephan Aarstol, CEO of a successful business, where during summer time everyone has 5 hour workdays: 

> The shorter work time requires focus and clarity. You have to develop what
> Aarstol calls a "production mindset," asking yourself what's essential and
> putting better processes in place. He believes most people don't spend enough
> of their work time thinking about how to work, instead of just working: "A
> five-hour workday offers baked-in time management by forcing workers to
> prioritize high-value activities." By creating artificial time constraints,
> you actually help unlock productivity enhancements because it forces you to
> reevaluate the way in which you do things.

## References

The concept of Governing vs Enabling Constraints originates from [Alicia Juarrero](https://mitpress.mit.edu/contributors/alicia-juarrero) and has been elaborated in the [Cynefin sensemaking framework](https://en.wikipedia.org/wiki/Cynefin_framework). To learn more, you can read:

- Chris Corrigan, [Constraints that enable emergence](http://www.chriscorrigan.com/parkinglot/constraints-that-enable-emergence/)
- Dave Snowden, [Freedom through Constraints](https://www.cognitive-edge.com/freedom-through-constraints/)
- Chris Matts, [Constraints that Enable](https://theitriskmanager.com/2018/12/09/constraints-that-enable/)
- Maciej Kaszubowski, [Enabling constraints in software development](https://mkaszubowski.com/2020/05/11/enabling-constraints-in-software-development.html)

A Diagram of Effects is a powerful technique to make sense of what is going on in a team or an organization. We recommend Gerald M. Weinberg's [Quality Software Management series](http://geraldmweinberg.com/Site/QSM_vol_1.html) if you'd like to learn more, or read our whitepaper [Promise is Debt](/attachments/ebooks/qwan-systems-book.pdf) (PDF).

_Maximizing the amount of work not done_ is one of the [twelve principles of the Agile Manifesto](https://agilemanifesto.org/principles.html).

If you'd like to learn more about the Agile Fluency model and how it can help your teams grow, we recommend reading [the article by Jim and Diana](https://www.martinfowler.com/articles/agileFluency.html).

On the topic of slack and sustainable pace, I recommend the book by
Jon Fitch & Max Frenzel, [Time Off - A Practical Guide to Building Your Rest Ethic and Finding Success Without the Stress](https://maxfrenzel.com/time-off) (2020)

Find more great quotes from Kent Beck at [Goodreads](https://www.goodreads.com/author/quotes/25211.Kent_Beck).

_Credits: reviewed by Willem_

<aside>
  <h3>From good enough to team greatness</h3>
  <p>
    Would you like your teams to grow further even though they're doing ok? Do feel you are not getting the benefits from your agile transformation? Drop us a line and we can work with you.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our agile fluency service</a>
  </div></p>
</aside>
