---
layout: post
title: Dimensions of Dimensional Planning
tags:
  - continuous delivery
  - planning
author: Marc Evers
image: /attachments/blogposts/2020/dimensions-features.jpg
---

In a previous post, we [introduced the Dimensional Planning
technique](/2020/09/02/dimensional-planning.html), and shared [how we used this
for a product we worked on](/2020/09/30/dimensional-planning-a-story.html). In
this post, we will go more in depth with this technique and show how you can use
the roads metaphor not only for releases of a product, but for individual
features as well. This provides a fine-grained mechanism for planning and
realizing small, valuable increments.

- [Product level dimensions](#product-level-dimensions)
- [Feature level dimensions](#feature-level-dimensions)
- [Fine grained planning & steering](#fine-grained-planning--steering)
- [Summary](#summary)
- [References](#references)

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
Road/Highway dimensions for that feature. Let's look at features of a web shop. The dimensions of the _Search_ feature could be: 
- _Dirt Road_: just show list of all products, and lets the user use the browser search in page functionality;
- _Cobblestone Road_: offer keyword search with exact matching;
- _Highway_: provide smart search using word similarity and a list of synonyms

We can define dimensions for other features as well, for instance for order
processing, or define dimensions based on quality requirements. An example of
the latter for the Product Catalogue is a Dirt Road version for a limited
catalogue of say max 30 products, which is shown fully. The Cobblestone Road
version supports way more products with pagination (and possibly lazy loading). 

![dimensions of features, fine-grained planning](/attachments/blogposts/2020/dimensions-features.jpg)

You could call the dimensions of a feature (or story) this **alternate depths**
of this feature. We elaborate the feature in several iterations, going from a
shallow implementation (sometimes a manual workaround) to a full blown version
with all bells and whistles. So dimensions of a feature embody **true iterative
working** and a feature or user story can repeatedly show up in the backlog,
with different dimensions.

There are no hard rules for what is Dirt Road and what is Cobblestone Road.
Instead, the feature dimensions are the result of negotiation, based on the
guiding questions _what can we leave out_ and _what is good enough_, with
respect to the intended product outcomes.

## An example of feature dimensions

This gives us a more fine-grained way of planning and negotiation. It provides
more options to scale down a planned feature, e.g. from Highway to Cobble or to
Dirt when we want to deliver at a specific date. 

The picture below shows part of a user story map for a web shop, which has
features like Search, Browse, Compare, Check out, and Pay.

![example story map](/attachments/blogposts/2020/dp-story-map-1.jpg)

We can define on dimensions for the features. The Search Dirt Road is the list
of products, while the Compare feature the Dirt Road is a manual workaround:
buyers can compare product details themselves, for instance by opening the two
products in separate browser tabs. The Dirt Road Pay feature is pay by bank
transfer: the web shop shows bank account details (so also a manual version).
Payment provider integration is Cobblestone Road, offering & redeeming gift
cards is the Highway for now. 

![example story map with dimensions for features](/attachments/blogposts/2020/dp-story-map-2.jpg)

For Inspect Product, the minimal version is showing the details, because
otherwise buyers do not have sufficient information to decide to buy. The
Cobblestone Road includes images.

Dirt Road Order Processing is mostly a manual process: the system shows
information for the warehouse employee who will search & package the order. We
first want to test the market before investing in order processing automation.

## Fine grained planning & steering

Based on the dimensions of features, we can decide on Dirt Road and Cobblestone
Road releases. We decide to include product images and save details for later
for now in the Dirt Road release, although they are probably the first to move
out when we have to reduce scope for the first release.

![example story map with releases](/attachments/blogposts/2020/dp-story-map-3.jpg)

After we have delivered the Dirt Road release, we can again look at the rest of
the story map, asking ourselves what we can leave out and when is it good
enough.

## Summary

We can apply the Dirt Road-Cobblestone Road-Highway metaphor of Dimensional
Planning not only to whole releases, but also to individual features. We can
define Dirt Road, Cobblestone Road, and Highway versions of a feature.

This facilitates iterative development of features and user stories. A story can
occur multiple times in the backlog, in different versions. By defining the Dirt
Road story and starting with that, this reduces the risk of story perfectionism
and analysis paralysis. 

Dimensions of features also facilitates fine grained planning, tracking and
steering. Instead of all-or-nothing decision when reducing scope - should we
remove or include this story? - we can decide to reduce the 'depth' of a story.

User story dimensions provide an extra way of splitting large user stories, in a
true iterative way. In this way, dimensions enable the _Negotiable_ property of
Bill Wake's [INVEST heuristic for good user
stories](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

## References

The idea of applying dimensions to both releases and features originates from
Koen Van Exem (inventor of Dimensional Planning. He calls them _Alternate
Futures_ and _Alternate Depths_. See also [Koen's original
slides](https://www.slideshare.net/inxin/dimensional-planning-30790935)

To learn more about User Story Mapping, we recommend going back to the source - [Jeff Patton's original article](https://www.jpattonassociates.com/the-new-backlog/) or [his book User Story Mapping](https://www.amazon.com/User-Story-Mapping-Discover-Product/dp/1491904909/ref=as_sl_pc_qf_sp_asin_til?tag=jefpatass-20&linkCode=w00&linkId=NX2UXYQEFAANOFPO&creativeASIN=1491904909).
