---
layout: post
title: Dimensions of Dimensional Planning
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/Tree-Dirt-Road-Grass-Road-Landscapes-Green-House-2423162.jpg
---

In the previous post, we introduced the Dimensional Planning technique, and shared how we defined Dirt Road, Cobblestone Road and Asphalt Road versions of a product we worked on - the 'dimensions' of the product.

## Product level dimensions vs feature level dimensions

We can apply dimensional planning for a software product at two levels: at the product level and at the feature level.

We can define Dirt/Cobble/Highway dimensions for our product, e.g. by defining the Dirt Road version as a minimal set of functionality, leaving out whole features. A Dirt Road web shop could consist of a product catalogue and a shopping basket, but supply management, payment and order processing are manual processes.

@@plaatje van 3x product dimension als sets features

We can also look at a single feature and define Dirt/Cobble/Highway dimensions for that feature: the Dirt Road version of catalogue would be just a list of products, without search or product details; the Highway Road version support keyword search, pagination and separate product detal pages.

@@plaatje van 3x feature dimensions

This gives us the possibility for more fine-grained planning and negotiation. It also gives us more room to 'scale down' a planned feature e.g. from Highway to Cobble or to Dirt when we want to deliver at a specific date.

In release planning (user story mapping) we can plan the different dimensions of features.

@@story map plaatje met wat dimensions?

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
- Questionnaires: Ashpalt - we wanted to give workshop participants a good questionnaire experience, scaling down to Dirt Road would bear the risk of confusing or even putting off participants (who are very occasional users of the application) 
- Workshop rollup views: Dirt - we visualize the aggregated results from the workshop, but we don't store any changes, need to record that by hand (or take a screenshot)
- Operability: Cobble - running the application on our local machines was not an option, so we needed to deploy it to AWS, in a secure way; we coded our infrastructure in Terraform (will pay off anyway in time and stress reduction later on), we deploy Docker containers using a script, we applied HTTPS/SSL for secure access

This resulted in an application that was just in time good enough to run two diagnostic workshops.


## @@Bla

We thought of many more possible features and more shiny versions of features, we parked them on our Miro board under 'Cobblestone' and 'Highway'.

@@Some features we removed from Dirt Road scope turned out to be unnecessary (when discussing the next steps for evolving with the Agile Fluency Project). If we would have 'just built it all' we would have wasted time.

## On to the Cobblestone Road

What about the next one, the Cobblestone Road version?

@@TODO

## References

- [Koen's original slides](https://www.slideshare.net/inxin/dimensional-planning-30790935)
- [Dirt Road Picture](https://www.maxpixel.net/Tree-Dirt-Road-Grass-Road-Landscapes-Green-House-2423162)

