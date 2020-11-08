---
layout: post
title: Dimensions of Features - an Example
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/cobblestoneroad.jpg
---


## Dirt Road Products & Features

Let's see how we applied this when developing our online Agile Fluency Diagnostic tool. We had imposed time constraints on ourselves for delivering a first usable version: we had scheduled diagnostic workshops with two teams and we had limited time available because of other projects.

We defined our Dirt Road version of the tool as consisting of the following features:
- Authentication - because it was deployed to AWS
- Diagnostic session management
- Questionnaires
- Workshop rollup views
- Operability - deployed at AWS 

We left out the following features:
- Facilitator/user management (we hard-coded ourselves in the backend)
- Sending out workshop invitations (we started with manually copy-pasting & emailing joining links)
- Branding
- UX flow & stuff (crude error messages; leaving edge cases and dead ends in the application)

For the features that we did include, we also tried to scale down the dimensions:
- Authentication: Cobble - login with username and password; password reset functionality (required for security); to enable password resets, we decided to build email integration as well (looking back, there was an option to keep this simpler and postpone some of the effort, but hey, test-driving SMTP integration is fun!)
- Diagnostic session management: Dirt - create a session, list sessions, get joining links for participants (the minimal we need to be able to run multiple workshops)
- Questionnaires: Highway - we wanted to give workshop participants a good questionnaire experience, scaling down to Dirt Road would bear the risk of confusing or even putting off participants (who are very occasional users of the application) 
- Workshop rollup views: Dirt - we visualize the aggregated results from the workshop, but we don't store any changes, need to record that by hand (or take a screenshot)
- Operability: Cobble - running the application on our local machines was not an option, so we needed to deploy it to AWS, in a secure way; we coded our infrastructure in Terraform (will pay off anyway in time and stress reduction later on), we deploy Docker containers using a script, we applied HTTPS/SSL for secure access

This resulted in an application that was just in time good enough to run two diagnostic workshops.


## @@Bla

We thought of many more possible features and more shiny versions of features,
we parked them on our Miro board under 'Cobblestone' and 'Highway'.

@@Some features we removed from Dirt Road scope turned out to be unnecessary
(when discussing the next steps for evolving with the Agile Fluency Project). If
we would have 'just built it all' we would have wasted time.

And you cannot foresee everything; you need to put software in the hands of
users, sooner rather than later, and then observe how they use it. This will
provide information on what is 'good enough' / where your product is not yet
good enough. 

## On to the Cobblestone Road

What about the next one, the Cobblestone Road version?

@@TODO

## And the Highway? 

Once we got the Dirt Road out and we started working on Cobblestone features,
more and more possible features are popping up. While defining the Dirt Road
version and cutting off (do we really really need this?) to the bare essentials
(mostly) is doable (takes discipline, but having tight constraints really helps
in making decisions). Once your on the Cobblestone Road, the criteria tend to
become less clear. 

So one of the benefits of having a Highway version somewhere on the horizon, is
that we can park our shiny features there; some of them turn out to be
Cobblestone after all, or well worth the extra investment. Most of them will
stay there parked - but they are out of our heads so we can focus on more
valuable work!
