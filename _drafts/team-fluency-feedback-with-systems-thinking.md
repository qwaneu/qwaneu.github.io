---
layout: post
title: Team Fluency Feedback with Systems Thinking
tags:
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2021/afd-techdebt-example.jpg
---

To get a better insight in how a team can grow and what support they need from
their organization, we use the Agile Fluency® model and associated tools. In
this post, we'll share how we run an Agile Fluency team diagnostic session and
how we arrive at specific recommendations both for the team and for their
management. 

The examples are based on an actual diagnostic session we have ran with a team,
but we have blurred any confidential information. We assume basic knowledge of
the [Agile Fluency model](https://www.agilefluency.org/model.php) and its zones.

- [Engaging with management and the teams](#engaging-with-management-and-the-teams)
- [Making sense of what's been said](#making-sense-of-whats-been-said)
- [An example pattern - handling technical debt](#an-example-pattern---handling-technical-debt)
- [Considerations](#considerations)
- [Next steps](#next-steps)

@@twee uitkomsten (fb Willem 28-03-2022):
- waar deelnemers zelf mee komen
- ons perspectief

# Engaging with management and the teams

We start out with a conversation with management, i.e. the people who have the
authority to decide on investments the team needs. Together with management, we
decide on objectives for the team and the appropriate fluency zone: focusing,
delivering or optimizing.

Then we schedule and run a diagnostic workshop with the whole team. This
workshop is an extended team retrospective. Each team member individually fills
in a survey, then we discuss the aggregated results together. The survey
consists of a number of method-agnostic statements about team behaviour. Each
team members indicate if the team shows that before on a scale from Never to
Always.

The aggregated results look like this:

![an example rollup chart showing the aggregated survey results for a team](/attachments/blogposts/2021/afd-rollups-example.jpg)

The dots represent the different team members, the answers marked green
represent the consensus we arrive at collaboratively. Consensus is not about
perfect agreement, it is about a good-enough answer for where the team currently
is.

> These results do not represent the team's maturity! It is not a race to the top! 

We provide a team feedback on how fluent they are in the different capabilities
required to get quality software out of the door now and in the future. We use
the information from the diagnostic session to indicate direction for growth.
Because we have co-created a detailed self-assessment, we can provide a much
more specific direction for growth than what usually comes out of a team
retrospective.

The fact that the team from the example is not fully fluent in everything does
not mean that they are a problematic team. On the contrary, this is a team that
is doing quite well, they are delivering changes to production almost every day
and have low defect rates. Even though they are doing well, they still have
opportunities to grow further.

So the exact survey answers are not so relevant, it is all about the
conversation that takes place in the workshop. The team has a conversation about
how they work. Sharing different perspectives and perceptions is already hugely
valuable. Many of the teams we meet do not get to such a depth in their sprint
retrospectives. 

The survey statements trigger deep conversations with and within the team. We
listen for signals - like someone saying "we have hardly any serious issues" -
and probe about what is really going on. In a time span of two hours we get a
huge amount of rich information of how the team works and how it interacts with
its context. Too much to keep in our heads, so we make many, many notes - and
process the notes immediately afterwords in some markdown document, like this: 

![impression of the written and typed notes we take during a diagnostic session](/attachments/blogposts/2021/afd-notes-example.jpg)

We do not directly provide advice or recommendations during the diagnostic
session. We have a good night of sleep and then try to make sense of it. We are
especially interested in any systemic effects at play, things that keep the
system the way it is and things that are self-reinforcing and could run out of
control. By taking a systemic perspective, we can find possible interventions
for the team and management that have more impact. It prevents from focusing on
symptoms alone.

Often, teams already get new insights and ideas for action from the diagnostic
workshop itself. This is to be expected in a complex system like a team, where
observing also means influencing - *diagnosis = intervention*.

# Making sense of what's been said

To make sense of all the details, we use a technique called Diagrams of Effects
(DoE), from the field of systems thinking. In a DoE, we try to map the system in
terms of variables and how these variables influence each other. 

We start out with writing down candidate variables on post-its. A variable is
something that can increase or decrease, something that you can measure or
observe in practice. Initially it is mostly brainstorming and diverging:

![initial brainstorm of variables with many post-its, in this case on a Miro board](/attachments/blogposts/2021/afd-many-postits.jpg)

Some examples of the variables we have found for this team: 
- Smoothness of delivery to production
- Size of business increments
- Defects in CI/CD pipeline
- Clearness of Why & Value of work
- Time between delivery to production and finding a production issue
- Slow down by technical debt

In this example, the darker post-its represents variables related to the
Delivering zone, and the lighter ones related to Focusing and Optimizing.

You may recognize a pattern in these variables. If your team has a similar
context, the patterns may match, and you can reuse them. We see similar patterns
recurring when working with different teams.

Then we get to the daunting task of finding relations between the variables. We
do this together as facilitators. We start drawing causal edges and challenge
each other if this causal relationship is really there, or is it an indirect
relation, i.e. some other variable should be in between. We merge duplicate
variables, and discard some that do not add much in this context:

![converging to a diagram of effects](/attachments/blogposts/2021/afd-converging.jpg)

Black edges mean a *same* effect: if one variable goes up, the other also tends
to go up. Red edges mean an *opposite* effect: if one variable goes up, the
other tends to go down.

We sometimes add some explanation or write down some themes we notice, like the
purple post-its in this case. Or we add some benefits that are relevant for
management and show how these relate to the system (green post-its in this
example).

The diagram we create is not the truth. It represents how we (as facilitators)
perceive the system, based on what we heard from management and from the team,
what we heard between the lines, and our own experience. We will not present the
complicated diagram shown above as 'the way things are'. Instead, we use the
diagram to illustrate how we see the system, and how we think the team can make
more effective steps for growth. We use diagrams of effects as a kind of
'intuition support system'.

If our efforts result in such a big, complicated diagram, we look for ways to
present it in a more manageable way. In this case, we noticed that there were
actually 3 systems in place. Of course, everything is connected, but splitting
it up in three smaller diagrams allows us to present our feedback in a more
focused way:

![split up the diagram into 3 smaller ones](/attachments/blogposts/2021/afd-splitting-up.jpg)

We have identified a number of self-reinforcing loops in the diagrams,
represented by the small snowballs. 

# An example pattern - handling technical debt

Let's have a look at one of the sub-diagrams. It is about handling technical
debt. When we present a diagram like this to a team, we build it up in steps, so
that we take the team along with our story. 

![example diagram of effects about handling technical debt](/attachments/blogposts/2021/afd-techdebt-example.jpg)

We noticed a self-reinforcing loop: over time, more *Technical debt* means
*Long term maintainability* goes down, reducing *Smoothness of Delivery*. Lower
*Smoothness of Delivery* reduces *Forecast reliability*, which reduces the
organization's *Ability to steer* development initiatives. This lowers the
organization's *Trust in the team*, which negatively impacts the *quality of
both functional and technical decisions*. This increases *Technical debt*, and
so on.

A way of tackling this is reducing technical debt as a project. This requires
more visibility of technical debt in terms of short term and long term business
impact. Tackling technical debt as a projects has all kinds of disadvantages,
like increasing the length of development feedback loops. A technical debt
project tends to be complex and unpredictable, which impacts *Forecast
reliability* negatively. This is why we put a big 'Beware!' in the diagram. This
way of tackling technical debt is not inherently bad, we do find it important to
be aware of the downsides of this approach.

An alternative way is the team tackling technical debt by refactoring in (many,
many) baby steps. By keeping the actual steps small, the team can get in a state
where they are continuously working on technical debt in a more predictable way,
while having sufficient time for other work as well. Tackling technical debt in
this way requires some skill however, as working in very small, highly
controlled steps sounds simple but is actually quite hard. A team needs practice
time and perhaps some training and mentoring to master these skills.

# Considerations

When we report back to management, we sometimes create specific diagrams of
effects from a management perspective. Sometimes we re-use the diagrams we
shared the team, if the team consents to that. 

Diagrams of effects help to go beyond symptoms and find more effective
interventions. In addition, diagrams of effects are non-personal and
blameless.They shift the focus away from an individual's behaviour, to the
systemic aspects, to how things are organized and how that affects behaviour.
This is in line with for instance Deming's statement that [90-95% of performance
is governed by the system](https://deming.org/dr-deming-called-for-the-elimination-of-the-annual-performance-appraisal/).

# Next steps

The feedback we provide to the team and to management is quite rich, so we let
them sleep on it. We meet up with the team to check up how it is going, to help
them identify experiments they could run. 

<aside>
  <h3>From good enough to team greatness</h3>
  <p>
    Would you like your teams to grow further even though they're doing ok? Do feel you are not getting the benefits from your agile transformation? Drop us a line and we can work with you.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our team fluency services</a>
  </div></p>
</aside>
