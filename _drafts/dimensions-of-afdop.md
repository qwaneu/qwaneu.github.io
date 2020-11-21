---
layout: post
title: Dimensions of Features - an Example
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/diagnostic-tool.png
---

In this next post in our series on [Dimensional Planning](/2020/09/02/dimensional-planning.html), we will share how we
applied Dimensional Planning to the Online Agile Fluency® Diagnostic application
we have been working on since spring.

- [Going remote](#going-remote)
- [Dirt Road Products & Features](#dirt-road-products--features)
- [Simple is hard](#simple-is-hard)
- [On to the Cobblestone Road](#on-to-the-cobblestone-road)
- [And the Highway?](#and-the-highway)
- [Reflecting on what we did](#reflecting-on-what-we-did)
- [References](#references)

## Going remote

[Agile Fluency diagnostic
workshops](https://www.agilefluency.org/diagnostic.php) were originally designed
as face to face workshops where participants fill in a questionnaire and then
create a shared, aggregated view of their answers.

In March, about a week after the lock down started, we had to run our first
diagnostic workshop remotely. We build something quickly with Google Forms and
Sheets, which worked ok-ish. Because we were to run many more workshops over the
months to come and because we thought "hey we are software developers, we can
build something cool ourselves!", we embarked on a journey to develop a web
based application to support these workshops.

## Dirt Road Products & Features

We had imposed time constraints on ourselves for delivering a first usable
version: we had scheduled diagnostic workshops with two teams and we had about 6
weeks, with limited time available because of other projects.

The application needed at least something for filling in a questionnaire
and visualizing aggregated results. After Rob had made a start with the
questionnaire, we defined our Dirt Road version of the tool, consisting of the
following key features:

| *Questionnaires* | accessible through unique links so that participants do not need to create an account and can remain anonymous |
| *Rollup views* | the aggregated questionnaire results that we share with the participants |
  
But we also needed:

| _Authentication_ | the application should be publicly accessible for participants, some security measurements should be in place |
| _Operability_ | deploy the application to AWS |

We left out the following features:

| _User management_ | we decided on the Dirt Road of hard-coding ourselves in the backend, being the only users for now |
| _Send workshop invitations_ | we started with manually copying & emailing the links |
| _Styling & branding_ | we did some styling but kept it as simple as possible |
| _User experience_ | we put some effort in the questionnaire, but as the rest of the application was only used by us expert users, we kept error handling  simple with some rough edges, and we tolerated some edge cases and dead ends in the application |

For the features that we did include, we also tried to scale down the dimensions:

| _Authentication_ | **Cobblestone** | login with username and password, and  provide password reset functionality for better security. To enable password resets, we decided to build email integration as well. Looking back, we could have postponed some effort here by keeping it simpler, but hey, test-driving SMTP integration is actually quite fun! |
| _Diagnostic session management_ | **Dirt Road** | the minimum we required for running workshops: create a session, list all sessions, get joining links for participants. We did not add access control: all users (well, Rob & Marc)  could see all session details. |
| _Questionnaires_ | **Cobblestone** | we wanted to give workshop participants a good questionnaire experience, scaling down to Dirt Road would probably confuse or even put off participants, because they are very occasional users of the application. |
| _Rollup views - visualization_ | **Cobblestone** | we visualized the aggregated results from the workshop in a nice table with coloured dots, because the visualization needs to be clear for participants. |
| _Rollup views - gathering consensus_ | **Dirt Road** | we can mark answers visually,which was a CSS no-brainer, but we don't record the results. Instead we record results by hand or by screenshot. |
| _Operability_ | **Cobblestone** | running the application on our local machines was not an option, so we needed to deploy it somewhere. We chose to deploy to AWS and operate it in a secure way. Instead of manual configuration, we coded our infrastructure in Terraform. We expect this will pay off in time and reduced stress later on. For deploying our Docker containers we could largely reuse an existing deployment tool we developed for a different project. |

We did not build an automated CI/CD pipeline. We did create build scripts that
do the heavy lifting like running tests and creating Docker images, but the
release process and versioning is still manual, which is good enough up to
now. Continuous Integration and Delivery is an activity, not a tool.

Based on these decisions, we managed to deliver just in time an application that
was good enough to run the two scheduled diagnostic workshops. The facilitator's dashboard looked like shown below. The joining links are quite primitive (relative urls):

![AFP facilitator's dashboard April 2020](/attachments/blogposts/2020/afdop-april-2020.jpg)

The questionnaire and rollup view looked like this, (with bogus test questions from our fake backend server):

![AFP facilitator's dashboard April 2020](/attachments/blogposts/2020/afdop-2-april-2020.jpg)

## Simple is hard

Developing a Dirt Road is harder than it seems: playing the _what can we leave
out_ is quite difficult. We might have left more things out for the first
workshops. There is often a plausible reason for "just doing this feature as
well". It is a matter of trade-offs and judgment.

The questionnaire and rollup view needed to be good enough for workshop
participants to use, so that they'd focus on the content and not on the
application's rough edges. For some things we thought "how hard can it be! Let's
just build it", which sometimes turned out to be more work than assumed. And
then you're suffering from the sunk cost fallacy and you decide to finish it
anyway.

## When your software touches reality

As we were not in contact with any real users apart from ourselves, we made a
lot of assumptions in our decisions. You cannot foresee everything; you need to
put software in the hands of users, sooner rather than later, and then observe
how they use it. This will provide better information on what is 'good enough'
and where your product is not yet good enough.

In the course of the 6 weeks, we thought of many more possible features and some
nice bells and whistles. We parked these on our Miro board under the
'Cobblestone' and 'Highway' releases.

Some features we moved to Cobblestone Road or Highway scope turned out to be
unnecessary later on. After the first release, we discussed the application and
possible next steps with Jim and Diana from the Agile Fluency Project, which was
again useful feedback on our assumptions. It made some features disappear from
the board. If we would have 'just built it all' at the start, we would have
wasted time.

## On to the Cobblestone Road

Together with the Agile Fluency Project we decided to develop the application
further and make it available for the community of facilitators. We defined a
few different releases.

This meant more features and less Dirt Road-ness, to make the application good
enough for administration by the Agile Fluency Project and for a wider audience
of facilitators. We decided on the following features:

| _Facilitator management_ | ability to add new facilitators and see all who have access to the application; introduce an 'administrator' role |
| _Access control_ | facilitators can only see their own sessions |
| _Recording rollup results_ | |
| _Automated backups_ | |
| _Agile Fluency Project branding_ | to make it an integrated experience for facilitators |

We decided to postpone the following things:

| _Update facilitators_ | Getting facilitators on board was the first priority, updating can be added later. |
| _Facilitator license expiry_ | We assumed that in the short term not many licenses would expire, so everyone keeps having access to the application. |
| _Questionnaire internationalization_ | Although we picked this one up pretty soon; we knew some had translated the questionnaire and we found multi language support an interesting challenge (how hard can it be! well, not that hard, but it took more effort than we initially assumed ;) |

Currently, the application looks like this:

![diagnostic tool current view](/attachments/blogposts/2020/diagnostic-tool.png)

## And the Highway?

Once we got the Dirt Road out and we started working on Cobblestone features,
more and more possible features are popping up. The Dirt Road version was about
reducing to the bare essentials - _do we really really need this?_ It takes
discipline, and having tight constraints helps in making better decisions, [like
we wrote earlier](/2020/10/26/under-pressure.html). Once you are on the
Cobblestone Road, the game tends to change. Now we get more and more user
feedback.

A benefit of having a Highway version somewhere on the horizon, is that we can
park our shiny features and wild ideas there; some of them will turn out to be
Cobblestone (being part of good enough), other will be worth the extra
investment. Quite a few will stay parked. They are out of our heads so we can
focus on valuable work.

It is a bit like in the days when we put our user stories on index cards taped
to the wall. We'd create a place for the shiny stories that are customers found
very important. Some of those never got prioritized and kept hanging there until
they'd fall of the wall like falling leaves during autumn. We'd put the fallen
cards in a box but no one ever asked about them. By putting those things on a
card on the wall, even though we suspected we would never do them, our customers
felt heard and knew it was a matter of trade-offs whether these stories would
get priority or not. In one of our early XP projects, we had a nice round
wall where we put the story cards on, giving the impression of future stories
disappearing:

![story wall](/attachments/blogposts/2020/niwi-story-wall.jpg)

## Reflecting on what we did

We used the principles of Dimensional Planning and its guiding questions _'what
can we leave out'_ and _'what is good enough'_ to deliver working software for a
fixed deadline with limited available time. We made trade-offs using the
metaphor.

We did not strictly follow the Dirt Road, Cobblestone Road, Highway dimensions.
So did we apply Dimensional Planning wrong then? No, Dimensional Planning is not
a method, it is not a recipe you follow to get a good result. **It is a metaphor
with some guiding questions that helps you in making decisions and communicating
the why of your decisions.**

Taking a complex systems perspective, Dimensional Planning is a form of
**scaffolding**. It creates a context for making better product decisions, where
you can decide to keep the scaffolding in place - keep using the metaphor - or
leave it after having done the first releases, like we have done after the doing the first release and discussing new release objectives with the Agile Fluency Project.

> Scaffolding is a novel concept from the field of complex systems and
> sense-making. In organizations, we often focus on rigid things like
> procedures, processes, methods. Scaffolding provides a more flexible
> concept for making good stuff emerge.  
> As Toby Sinclair puts it in his post on [12 Organisational Design Principles that Embrace Complexity](https://www.tobysinclair.com/post/organisational-design-principles-that-embrace-complexity): _"Organisational Scaffolding is a structure, often temporary that can be used to help the emergence of desired outcomes. Scaffolding helps create the right conditions."_  
> Many agile practices like daily standups or Scrum sprints, turn out to
> beneficial, within a context!. They are not rigid methods that guarantee
> success, but they are also forms of scaffolding. They help desired behaviour
> to emerge.

## References

This post is part of a series on Dimensional Planning:

- [Dimensional Planning - good enough software, early & often](/2020/09/02/dimensional-planning.html)
- [Dimensions of Dimensional Planning](/2020/11/13/dimensions-of-dimensional-planning.html)
- [Dimensional Planning - a story](/2020/09/30/dimensional-planning-a-story.html)
- @@this post

More on scaffolding: Sonja Blignaut, [Learnings from Whistler: Scaffolding emergence](https://www.morebeyond.co.za/learnings-from-whistler-scaffolding-emergence/)

We have started to make some of the Python backend code we developed available
as the Quiltz Open Source libraries. It includes our test driven implementation
of [an SMTP based email sending library -
quiltz-messaging](https://github.com/qwaneu/quiltz-messaging).
