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
applied Dimensional Planning to the Online Agile Fluency Diagnostic application
we have been working on since spring.

- [Going remote](#going-remote)
- [Dirt Road Products & Features](#dirt-road-products--features)
- [Simple is hard](#simple-is-hard)
- [On to the Cobblestone Road](#on-to-the-cobblestone-road)
- [And the Highway?](#and-the-highway)
- [Reflecting on what we did](#reflecting-on-what-we-did)
- [References](#references)

## Going remote

The Agile Fluency diagnostic workshop was originally designed as a face to face
workshop where participants fill in a questionnaire and then build an aggregated
view of their answers together.

In March, about a week after the lock down started, we had to run our first
diagnostic workshop remotely. We build something quickly with Google Forms and
Sheets, which worked ok-ish. As we were to many more of these workshops over the
months to come, and because we thought "hey we are software developers, we can
build something cool ourselves!" we embarked on the journey to develop a web
based application to support these workshops.

The application needed to do something with filling in a questionnaire and
visualizing the aggregated results.

## Dirt Road Products & Features

We had imposed time constraints on ourselves for delivering a first usable
version: we had scheduled diagnostic workshops with two teams and we had about 6
weeks, with limited time available because of other projects.

After Rob had made a start with the questionnaire, we defined our Dirt Road version of the tool, consisting of the following key features:
- Questionnaires, accessible through unique links so that participants do not need to create accounts and can remain anonymous in the system
- Rollup views - the aggregated questionnaire results
  
But we also needed:
- Authentication - we needed to make the application publicly accessible for participants so we needed to have some security in place
- Operability - deploy the application at AWS 

We left out the following features:
- Facilitator/user management; we decided on the Dirt Road of hard-coding ourselves in the backend
- Sending out workshop invitations; we started with manual copy-pasting & emailing joining links
- Branding; we did some styling but kept it as simple as possible
- UX flow & stuff (crude error messages; leaving edge cases and dead ends in the application)

For the features that we did include, we also tried to scale down the dimensions:
- Authentication: Cobblestone - login with username and password; provide
  password reset functionality as well for better security; to enable password
  resets, we decided to build email integration as well. Looking back, maybe we
  could have postponed some effort by keeping this even simpler, but hey,
  test-driving SMTP integration is quite fun!
- Diagnostic session management: Dirt Road - the minimum we required for running
  workshops: create a session, list all sessions, and get joining links for
  participants; we did do any access control: all users (well, Rob & Marc) could
  see all session details
- Questionnaires: Highway - we wanted to give workshop participants a good
  questionnaire experience, scaling down to Dirt Road would bear the risk of
  confusing or even putting off participants, who are very occasional users of
  the application
- Workshop rollup views
  - visualization: Cobblestone - we visualize the aggregated results from the
    workshop with coloured dots
  - gathering consensus on answers: Dirt Road - we can mark answers (that was a
    CSS no-brainer) but we don't store results; recording of results needs to be
    done by hand or by screenshot
- Operability: Cobblestone - running the application on our local machines was
  not an option, so we needed to deploy it to AWS, in a secure way; instead of
  just doing some quick manual configuration, we coded our infrastructure in
  Terraform. From experience we know this will pay off anyway in time and stress
  reduction later on. For deploying our Docker containers we could largely reuse
  an existing script, we applied HTTPS/SSL for secure access

We did not build an automated CI/CD pipeline. We did create build scripts that
do the heavy lifting (running tests, creating Docker images), but the release
process and versioning is still manual, and good enough up to today.

This resulted just in time in an application that was good enough to run the two
scheduled diagnostic workshops. We managed to deliver the application within all time constraints, with a limited number of late hours.

## Simple is hard

Developing your Dirt Road is harder than it seems: playing the game of 'what can
we leave out' game' is quite hard. We might have left more things out for the
first workshops, but that is also a matter of trade-offs and judgment. The
questionnaire and rollup view needed to be good enough for our workshop
participants to use (so that they'd focus on the content and not on the
application's rough edges). For some things we thought "how hard can it be,
let's just build it", which sometimes turned out to be a bit more work. Once
you're in the sunk cost fallacy you decide to finish it anyway.

There are still a lot of assumptions in the decisions we made. And you cannot
foresee everything; you need to put software in the hands of users, sooner
rather than later, and then observe how they use it. This will provide
information on what is 'good enough' / where your product is not yet good
enough. 

In the course of the 6 weeks, we thought of many more possible features and more shiny versions of features. We parked these on our Miro board under 'Cobblestone' and 'Highway'. 

Some features we removed from Dirt Road scope turned out to be unnecessary later
on. After the first release, we discussed the application and possible next
steps with Jim and Diana from the Agile Fluency Project, which was again useful
feedback on our assumptions, making some features disappear from the board. If
we would have 'just built it all' at the start, we would have wasted time.

## On to the Cobblestone Road

With the Agile Fluency Project we decided to develop the application further and make it available for the community of facilitators. We defined a few different releases. 

This meant more features and less Dirt Road-ness, to make the application good enough for administration by the Agile Fluency Project and for a wider audience of facilitators
- Facilitator management, including an 'administrator' role
- Access control: facilitators can only see their own sessions
- storing rollup results
- automated backups
- applying the Agile Fluency Project styling to make it an integrated experience

Not for now:
- updating facilitators
- expiry of facilitator licenses
- I18N

## And the Highway? 

Once we got the Dirt Road out and we started working on Cobblestone features,
more and more possible features are popping up. While defining the Dirt Road
version and cutting off - _do we really really need this?_ - to the bare
essentials (mostly) is doable. It takes discipline, and having tight constraints
helps in making better decisions, [like we wrote
earlier](/2020/10/26/under-pressure.html). Once you are on the Cobblestone Road,
the game tends to change. Now we get more and more user feedback.

So one of the benefits of having a Highway version somewhere on the horizon, is
that we can park our shiny features there; some of them turn out to be
Cobblestone after all, or well worth the extra investment. Most of them will
stay there parked - but they are out of our heads so we can focus on more
valuable work!

## Reflecting on what we did

We use the principles of Dimensional Planning and its guiding questions 'what
can we leave out' and 'what is good enough' to deliver working software for a
fixed deadline with limited available time. We made trade-offs using the
metaphor.

We did not strictly follow the Dirt Road, Cobblestone Road, Highway dimensions. So did we apply Dimensional Planning wrong then? No, as Dimensional Planning is not a method, not a recipe you follow to get a good result. It is a metaphor with guiding questions that helps you in making decisions and communicating the why of your decisions.

Taking a complex systems perspective, Dimensional Planning acts as scaffolding. 
it provides support for making better decisions, where you can decide to keep
the scaffolding in place (keep using the metaphor) or leave it after having done
the first releases (like we have done after releasing and discussing new release
objectives with the Agile Fluency Project)

> Scaffolding is a novel concept from the field of complex systems and
> sense-making. In organizations, we often focus on rigid things like
> procedures, processes, methods. Scaffolding provides a more flexible
> concept for making good stuff happen in an organization.  
> As Toby Sinclair puts it in his post on [12 Organisational Design Principles that Embrace Complexity](https://www.tobysinclair.com/post/organisational-design-principles-that-embrace-complexity): _"Organisational Scaffolding is a structure, often temporary that can be used to help the emergence of desired outcomes. Scaffolding helps create the right conditions."_  
> Many agile practices turn out to beneficial (within a context!). These are not
> rigid methods that guarantee success, but they are scaffolding,
> like daily standups or Scrum sprints. They help desired behaviour
> to emerge.

## References

This post is part of a series on Dimensional Planning:

- [Dimensional Planning - good enough software, early & often](/2020/09/02/dimensional-planning.html)
- [Dimensions of Dimensional Planning](/2020/11/13/dimensions-of-dimensional-planning.html)
- [Dimensional Planning - a story](/2020/09/30/dimensional-planning-a-story.html)
- @@this post

More on scaffolding: Sonja Blignaut, [Learnings from Whistler: Scaffolding emergence](https://www.morebeyond.co.za/learnings-from-whistler-scaffolding-emergence/)
