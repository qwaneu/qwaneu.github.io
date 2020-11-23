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
this post, we will go more in depth and show how you can use the roads metaphor
not only for releases of a product, but for individual features as well. This
provides a fine-grained mechanism for planning and delivering small, valuable
increments.

- [Product level dimensions](#product-level-dimensions)
- [Feature level dimensions](#feature-level-dimensions)
- [Fine grained planning & steering](#fine-grained-planning--steering)
- [Summary](#summary)
- [References](#references)

## Product level dimensions

We can apply dimensional planning for a software product at two levels: product
level and feature level. In the previous posts, we focused mainly on product
level dimensions - the Dirt Road / Cobblestone Road / Highway versions of a
product. 

The Dirt Road version is a minimal set of functionality, where the guiding
question is **what can we leave out?** A Dirt Road web shop could have a
product catalogue and a shopping basket, while we keep supply management,
payment and order processing as manual processes. The Cobblestone Road version
does the job, but not more than that. The guiding questions is **is it good
enough?** The Highway version is a full blown implementation, where the guiding
question is **what do we still want to pay for?**

![dimensions of a product](/attachments/blogposts/2020/dimensions-releases.jpg)
{: class="post-image post-image-50" }

## Feature level dimensions

We can also look at a single feature and define Dirt Road, Cobblestone
Road & Highway dimensions for that feature. Let's look at features of a web shop. The dimensions of the _Search_ feature could be: 
- _Dirt Road_ - just show list of all products and let the user use the browser search functionality;
- _Cobblestone Road_ - offer keyword search with exact matching;
- _Highway_ - provide smart search using word similarity and a list of synonyms.

We can define dimensions for instance based on quality requirements: the Dirt
Road for the Product Catalogue could be a limited catalogue of say 30 products,
which is shown fully. The Cobblestone Road version supports way more products
with pagination and possibly lazy loading. 

Having defined dimensions of features, you can base your product releases on this, as illustrated below.

![dimensions of features, fine-grained planning](/attachments/blogposts/2020/dimensions-features.jpg)

You could call the dimensions of a feature or user story **alternate depths** of
this feature. We elaborate the feature in several iterations, going from a
shallow implementation or manual workaround to a full blown version with all
bells and whistles. So feature dimensions embody **true iterative working**.
This means that a feature or user story can repeatedly show up in the backlog,
for different dimensions.

There are no hard rules for what a Dirt Road version and what a Cobblestone Road
version of a feature is. Feature dimensions result from negotiation of the development team and their business or customer, guided by _what can we leave out_ and _what is good enough_ to achieve intended outcomes.

## An example of feature dimensions

Having feature level dimensions provides a more fine-grained way of planning and
negotiation. It provides more options to scale down a planned feature, e.g. from
Highway to Cobblestone or Dirt Road when we want to deliver something valuable
sooner.

The picture below shows part of a user story map for a web shop, with features
like Search, Browse, Compare, Check out, and Pay.

![example story map](/attachments/blogposts/2020/dp-story-map-1.jpg)

We can define dimensions for the features. The Search Dirt Road is a simple list
of products, while the Compare Dirt Road is a manual workaround: buyers can
compare product details themselves, for instance by opening two products in
separate browser tabs. The Pay Dirt Road is payment by bank transfer: the web
shop shows just bank account details, the rest is manually processed.
Integrating with a payment provider is Cobblestone Road, gift cards are the
Highway for now.

For Inspect Product, the minimal version is showing the details, because
otherwise buyers do not have sufficient information to decide to buy. The
Cobblestone Road includes images.

Dirt Road Order Processing is mostly manual: the system shows information for
the warehouse employee who will search & package the products. We first want to
test the market before investing in order processing automation.

![example story map with dimensions for features](/attachments/blogposts/2020/dp-story-map-2.jpg)

Having different dimensions of the Pay feature enables team negotiation about
how well do we want to do the Pay feature, what is good enough and what more are
we willing to invest in.

## Fine grained planning & steering

Based on the dimensions of features, we can decide on Dirt Road and Cobblestone
Road releases for the web shop. We decide to include product images and save
details for later for now in the Dirt Road release, although they are probably
the first thing to be moved out when we need to reduce scope for the first
release.

![example story map with releases](/attachments/blogposts/2020/dp-story-map-3.jpg)

After we have delivered the Dirt Road release, we can again look at the rest of
the story map, asking ourselves what we can leave out and when is it good
enough.

## Summary

We can apply the Dirt Road - Cobblestone Road - Highway metaphor of Dimensional
Planning not only to whole releases, but also to individual features. We can
define Dirt Road, Cobblestone Road, and Highway versions of a feature, for
instance based on different quality requirements.

This facilitates iterative development of features and user stories. A user
story can occur multiple times in the backlog, in different versions. By
defining the Dirt Road story and starting with that, this reduces the risk of
story perfectionism and analysis paralysis. 

Feature dimensions also facilitate finer grained planning, tracking and
steering. Instead of all-or-nothing decisions for reducing scope - _should we
remove or include this story?_ - we can decide to keep a story but reduce its depth.

User story dimensions provide an extra way of splitting large user stories, in a
true iterative way. In this way, dimensions enable the _Negotiable_ property of
Bill Wake's [INVEST heuristic for good user
stories](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

## References

The idea of applying dimensions to both releases and features originates from
Koen Van Exem, the inventor of Dimensional Planning. He calls them _Alternate
Futures_ and _Alternate Depths_. See also [Koen's original
slides](https://www.slideshare.net/inxin/dimensional-planning-30790935)

To learn more about User Story Mapping, we recommend going back to the source - [Jeff Patton's original article](https://www.jpattonassociates.com/the-new-backlog/) or [his book User Story Mapping](https://www.amazon.com/User-Story-Mapping-Discover-Product/dp/1491904909/ref=as_sl_pc_qf_sp_asin_til?tag=jefpatass-20&linkCode=w00&linkId=NX2UXYQEFAANOFPO&creativeASIN=1491904909).

This post is part of a series on Dimensional Planning:

- [Dimensional Planning - good enough software, early & often](/2020/09/02/dimensional-planning.html)
- [Dimensional Planning - a story](/2020/09/30/dimensional-planning-a-story.html)
- Dimensions of Dimensional Planning
- [Dimensions of Features - an example](/2020/11/23/dimensions-of-afp.html)
