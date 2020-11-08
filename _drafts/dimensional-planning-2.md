---
layout: post
title: Dimensions of Dimensional Planning
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/cobblestoneroad.jpg
---

In a previous post, we [introduced the Dimensional Planning technique](), and shared [how we used this for a product we worked on]() - the 'dimensions' of the product.

In this post, we will dive a bit more into details, and show how you can use the
roads metaphor not only for releases of a product, but for features within a
product as well. This provides a fine-grained mechanism for planning and
realizing small, valuable increments.

## Product level dimensions

We can apply dimensional planning for a software product at two levels: at the
product level and at the feature level. In the previous posts, we focused mainly
on Dirt Road/Cobblestone Road/Highway dimensions of a product. 

The Dirt Road version is a minimal set of functionality, where the guiding
question is **what can we leave out?**. A Dirt Road web shop could have a
product catalogue and a shopping basket, but supply management, payment and
order processing are still manual processes.

The Cobblestone Road version of a product is a **good enough** version, it does
the job, but no more than that. The Highway version is a full blown
implementation, where the guiding question is **what do we still want to pay
for?**

![dimensions of a product](/attachments/blogposts/2020/dimensions-releases.jpg)
{: class="post-image post-image-50" }

## Feature level dimensions

We can also look at a single feature and define Dirt Road/Cobblestone
Road/Highway dimensions for that feature. 

An example of what dimensions of the _Search Product_ feature in a web shop could be: 
- the Dirt Road version just show list of all products, and lets the user use the browser search in page functionality;
- the Cobblestone Road version offers keyword search with exact matching;
- the Highway version provides smart search using word similarity and a list of synonyms

We can define dimensions for other features as well, for instance for order
processing, or define dimensions based on quality requirements. An example of
the latter for the Product Catalogue is a Dirt Road version for a limited
catalogue of say max 30 products, which is shown fully. The Cobblestone Road
version supports way more products with pagination (and possibly lazy loading). 

![dimensions of features, fine-grained planning](/attachments/blogposts/2020/dimensions-features.jpg)

You could call the dimensions of a feature (or story) this _alternate depths_ of
this feature. The dimensions embody iterative working. So a feature or story can
repeatedly show up in the backlog, with different dimensions.

## Fine grained planning & steering

This gives us a more fine-grained way of planning and negotiation. It provides
more options to scale down a planned feature, e.g. from Highway to Cobble or to
Dirt when we want to deliver at a specific date. 

The picture below shows part of a possible story map for a web shop, which has features like search, browse, compare, select product, check out.

![example story map](/attachments/blogposts/2020/dp-story-map-1.jpg)

In release planning (user story mapping) we can plan the different dimensions of
features. For the web shop, the Search Dirt Road is the list of products, while the Compare feature the Dirt Road is a manual workaround: buyers can compare product details themselves, e.g. by opening the two products in separate tabs. In the same way, the Dirt Road Pay feature is pay by bank transfer: the web shop shows bank account details (so also a manual version). Payment provider integration is Cobblestone Road, offering & redeeming gift cards is the Highway for now. 

For Inspect Product, the minimal version is showing the details (otherwise, buyers do not have sufficient information to decide to buy), while the Cobblestone Road includes e.g. images.

Dirt Road Order Processing is also a mostly manual process: the system can show details for the warehouse employee who will search & package the order. We
first want to test the market before investing into order processing automation.

![example story map with dimensions for features](/attachments/blogposts/2020/dp-story-map-2.jpg)

Based on the dimensions of features, we can decide on Dirt Road and Cobblestone Road releases. We decide to include product images and save details for later for now in the Dirt Road release, although they are probably the first to move out when we have to reduce scope for the first release.

![example story map with releases](/attachments/blogposts/2020/dp-story-map-3.jpg)

After we have delivered the Dirt Road release, we can again look at the rest of
the story map, asking ourselves what we can leave out and when is it good
enough.

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

And you cannot foresee everything; you need to put software in the hands of users, sooner rather than later, and then observe how they use it. This will provide information on what is 'good enough' / where your product is not yet good enough. 

## On to the Cobblestone Road

What about the next one, the Cobblestone Road version?

@@TODO

## And the Highway? 

Once we got the Dirt Road out and we started working on Cobblestone features, more and more possible features are popping up. While defining the Dirt Road version and cutting off (do we really really need this?) to the bare essentials (mostly) is doable (takes discipline, but having tight constraints really helps in making decisions). Once your on the Cobblestone Road, the criteria tend to become less clear. 

So one of the benefits of having a Highway version somewhere on the horizon, is that we can park our shiny features there; some of them turn out to be Cobbelstone after all, or well worth the extra investment. Most of them will stay there parked - but they are out of our heads so we can focus on more valuable work!

## Summary

We can apply the Dirt Road/Cobblestone Road/Highway metaphor of Dimensional Planning to whole releases,


## References

- [Koen's original slides](https://www.slideshare.net/inxin/dimensional-planning-30790935)

