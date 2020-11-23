---
layout: post
title: Dimensions of Features - An Example
tags:
  - continuous delivery
  - planning
author: Marc Evers
image: /attachments/blogposts/2020/diagnostic-tool.png
---

In this next post in our series on [Dimensional Planning](/2020/09/02/dimensional-planning.html), we will share how we
applied Dimensional Planning to the Online Agile Fluency® Diagnostic application
we have been working on since spring.

- [Going remote](#going-remote)
- [Dirt Road Products & Features](#dirt-road-products--features)
- [Simple is hard](#simple-is-hard)
- [When your software touches reality](#when-your-software-touches-reality)
- [On to the Cobblestone Road](#on-to-the-cobblestone-road)
- [And the Highway?](#and-the-highway)
- [Reflecting on what we did](#reflecting-on-what-we-did)
- [References](#references)

## Going remote

[Agile Fluency diagnostic
workshops](https://www.agilefluency.org/diagnostic.php) were originally designed
as face to face workshops where participants individually fill in a
questionnaire and then create a shared, aggregated view of their answers.

In March, about a week after the lock down started, we had to run our first
diagnostic workshop remotely. We build something quickly with Google Forms and
Sheets, which worked ok-ish. Because we were to run many more workshops over the
months to come and because we thought "hey we are software developers, we can
build something cool ourselves!", we embarked on a journey to develop a web
based application to support these workshops.

## Dirt Road Products & Features

We had quite tight time constraints for delivering a first usable version. We
had scheduled two diagnostic workshops by the end of April, which
meant we had about 6 weeks, with limited time available because of other
projects.

The application needed at least something for filling in the questionnaire and
visualizing aggregated results. After Rob had made a start with the
questionnaire, we defined our Dirt Road version of the tool, with the following
key features:

| *Questionnaires* | accessible through unique links so that participants can remain anonymous and do not need to create an account |
| *Rollup views* | the aggregated questionnaire results that we share with the participants |
  
But we also needed:

| _Authentication_ | The application should be publicly accessible for participants, so some security measurements should be in place. |
| _Operability_ | We wanted to deploy the application to AWS. |

We left out the following features:

| _User management_ | Being the only users for now, we decided on the Dirt Road solution of hard-coding ourselves in the back-end. |
| _Send workshop invitations_ | We started with manually copying & emailing joining links. |
| _Styling & branding_ | We applied some styling but kept it as simple as possible. |
| _User experience_ | We put some effort in the questionnaire, but as the rest of the application was only used by us (expert users), we kept error handling  simple with some rough edges. We tolerated some edge cases and dead ends in the application. |

For the features that we did include, we also tried to scale down the dimensions:

| _Authentication_ | **Cobblestone** | Login with username and password,  provide password reset functionality for better security. To enable password resets, we decided to build email integration as well. Looking back, we could have reduced some effort here, but hey, test-driving [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) integration is quite fun! |
| _Diagnostic session management_ | **Dirt Road** | We built the minimum required for running workshops: create a session, list all sessions, get joining links for participants. We did not add access control, so all users could see all sessions. |
| _Questionnaires_ | **Cobblestone** | We wanted to give workshop participants a good questionnaire experience, so scaling down to Dirt Road would risk confusing or even putting off participants. |
| _Rollup views - visualization_ | **Cobblestone** | We decided to put in some effort in visualizing aggregated workshop results in a nice table with coloured dots, because this visualization needs to be clear for participants. |
| _Rollup views - gathering consensus_ | **Dirt Road** | Marking consensus visually was a CSS no-brainer, but we don't record it. Instead we record results by hand or by screenshot. |
| _Operability_ | **Cobblestone** | Running the application on our local machines was not an option. We chose to deploy to AWS and operate it in a secure way. Instead of configuring everything manually, we coded our infrastructure in Terraform. We expect this will pay off in time and reduced stress later on. For deploying our Docker containers we could largely reuse an existing deployment tool we had developed for a different project. |

We did not build an automated CI/CD pipeline. We did create build scripts that
do the heavy lifting like running tests and creating Docker images, but the
release process and versioning is still manual, which is still good enough today. Continuous Integration and Delivery is an activity, not a tool.

Based on these product decisions, we managed to deliver just in time an
application that was good enough to run the two scheduled diagnostic workshops.
The facilitator's dashboard looked like shown below. The joining links are very primitive relative URLs:

![AFP facilitator's dashboard April 2020](/attachments/blogposts/2020/afdop-april-2020.jpg)

The questionnaire and rollup view looked like this, showing bogus test questions from our fake back-end server:

![AFP facilitator's dashboard April 2020](/attachments/blogposts/2020/afdop-2-april-2020.jpg)

## Simple is hard

Developing a Dirt Road is harder than it seems: playing the _what can we leave
out_ game is quite difficult. We could have left more things out while still being able to run the two workshops, but there is often a plausible reason to "just do this feature as well". It is a matter of trade-offs and judgment.

The questionnaire and rollup view needed to be good enough for workshop
participants to focus on the content and not to be distracted by the
application's rough edges. For some things we thought "how hard can it be! Let's
just build it", which sometimes turned out to harder than we assumed. And then
we'd suffer from the [sunk cost
fallacy](https://time.com/5347133/sunk-cost-fallacy-decisions/) and decide to
finish it anyway.

## When your software touches reality

Initially we were not in contact with any real other users apart from ourselves,
so we made a lot of assumptions. We cannot foresee everything, so we need to put
software in the hands of users, sooner rather than later, and then observe how
they use it. This will provide way better information on what is 'good enough' and where your product is still lacking.

In the course of those 6 weeks, we thought of many more possible features, some
necessary, some quite cool. We parked them on our Miro board under 'Cobblestone
Road' and 'Highway'. After the first release, we discussed the application with
Jim Shore and Diana Larsen from the Agile Fluency Project. This provided again
useful feedback on our assumptions and made some features disappear from the
board. If we would have 'just built it all' at the start, we would have wasted
time.

## On to the Cobblestone Road

We decided to develop the application further and make it available for the
community of facilitators. This meant more features and less Dirt Road-ness. We
needed to make the application good enough to hand over user management to the
Agile Fluency Project and to serve  a wider audience of facilitators. We decided
on the following features:

| _Facilitator management_ | ability to add new facilitators and see all who have access to the application; introduce an 'administrator' role |
| _Access control_ | facilitators can only see their own sessions |
| _Recording rollup results_ | the current Dirt Road solution was too error prone for use by others, so we needed to implement proper storing/retrieving of results |
| _Automated backups_ | necessary for disaster recovery, because there will be more and more valuable data in the system  |
| _Agile Fluency Project branding_ | to make it an integrated experience for facilitators |

We decided to postpone the following things:

| _Update facilitators_ | Getting facilitators on board was the first priority, we can add updating later. |
| _Facilitator license expiry_ | We assumed that in the short term not many licenses would expire. |
| _Questionnaire internationalization_ | I18N would be pretty cool, but we regarded it initially as a nice to have. We did pick it up quite soon however. We knew some facilitators had translated the questionnaire and we found multi language support an interesting challenge - "how hard can it be?" Well, not that hard, but it took more effort than we initially assumed ;) |

Currently, the application looks like this:

![diagnostic tool current view](/attachments/blogposts/2020/diagnostic-tool.png)

## And the Highway?

Once we got the Dirt Road out and we started working on Cobblestone features,
more and more possible features were popping up. The Dirt Road version was about
reducing to the bare essentials - _do we really really need this?_ This takes
some discipline, having tight time constraints helps in making better decisions,
[like we wrote earlier](/2020/10/26/under-pressure.html). Once you are on the
Cobblestone Road, you get more and more user feedback and the game tends to
change. 

A benefit of having a Highway version somewhere on the horizon, is that we can
park our shiny features and wild ideas there. Some will turn out to be
Cobblestone, others will be worth the extra investment. Quite a few will stay
parked there. Because they are now out of our heads, we can focus on valuable
work.

It is a bit like in the old days when we put our user stories on index cards
taped to the wall. We'd create a place for the shiny stories that our customers
found "very important". Some of those never got prioritized and kept hanging
there until they'd fall of the wall like leaves in autumn. We'd put the fallen
cards in a box but no one ever asked about them. By putting those things on  the
wall, even though we suspected they'd never get prioritized, our customers felt
heard and understood it was a matter of trade-offs whether these stories would
get priority or not. In one of our early XP projects, we had a nice round wall
for the story cards, giving the impression of future stories disappearing:

![story wall](/attachments/blogposts/2020/niwi-story-wall.jpg)

## Reflecting on what we did

We used the principles of Dimensional Planning and its guiding questions _'what
can we leave out'_ and _'what is good enough'_ to deliver working software for a
fixed deadline with a limited time budget. We made our product trade-offs using
the metaphor.

We did not strictly follow the Dirt Road, Cobblestone Road, Highway dimensions.
So did we apply Dimensional Planning wrong then? No, Dimensional Planning is not
a method, it is not a recipe you follow to get a good result. **It is a metaphor
with some guiding questions that helps you in making decisions and communicating
the why of your decisions.**

Taking a complex systems perspective, Dimensional Planning is a form of
**scaffolding**. It creates a context for making better product decisions, where
you can decide to keep the scaffolding in place - i.e. keep using the metaphor -
or stop using it after the first releases, like we have done after the doing the
first release and discussing new release objectives with the Agile Fluency
Project.

> Scaffolding is a novel concept from the field of complex systems and
> sense-making. In organizations, we often focus on rigid things like
> procedures, processes, methods. Scaffolding provides a more flexible
> concept for making good stuff emerge.  
> As Toby Sinclair puts it in his post on [12 Organisational Design Principles that Embrace Complexity](https://www.tobysinclair.com/post/organisational-design-principles-that-embrace-complexity): _"Organisational Scaffolding is a structure, often temporary that can be used to help the emergence of desired outcomes. Scaffolding helps create the right conditions."_  
> Many agile practices like daily stand-ups and Scrum sprints, turn out to
> beneficial within a context!. They are not rigid methods that guarantee
> success, but they are also forms of scaffolding. They help desired behaviour
> emerge.

## References

More on scaffolding: Sonja Blignaut, [Learnings from Whistler: Scaffolding emergence](https://www.morebeyond.co.za/learnings-from-whistler-scaffolding-emergence/)

We have started to make some of the Python backend code we developed available
as the Quiltz Open Source libraries. It includes our test driven implementation
of [an SMTP based email sending library -
quiltz-messaging](https://github.com/qwaneu/quiltz-messaging). It is still in an early stage, but feel free to [contact us](/contact) if you're interested!

_Credits: thanks to Willem for editing and helping improve this post._

This post is part of a series on Dimensional Planning:

- [Dimensional Planning - good enough software, early & often](/2020/09/02/dimensional-planning.html)
- [Dimensional Planning - a story](/2020/09/30/dimensional-planning-a-story.html)
- [Dimensions of Dimensional Planning](/2020/11/13/dimensions-of-dimensional-planning.html)
- Dimensions of Features - an example

<aside>
  <h3>Want to apply dimensional planning?</h3>
  <p>These practices are simple and elegant, but not always easy to put into practice. We offer workshops on agile planning techniques and we can mentor your team in applying them successfully.</p>
  <p><div>
    <a href="/training">Learn more about our workshops</a>
  </div></p>
</aside>
