---
layout: post
title: Dimensional Planning
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/Tree-Dirt-Road-Grass-Road-Landscapes-Green-House-2423162.jpg
---

In 2018, we joined a project to develop a new product for one of our customers. In true [agile fluency 'optimizing' style](https://martinfowler.com/articles/agileFluency.html), the team included business, marketing, UX, product vision, and development. We had a simple goal: enter the market with this new product. We had some new insights on @@dimensional planning and estimating and achieving goals. 

> For obvious reasons, we have to apply some discretion here. We cannot share all the project details, but add some concrete examples from the product we're currently working on, the online Agile fluency Diagnostic application.

Let's introduce some of the people involved (not their real names): Sarah was our ambitious business owner; Rob, Magnus, and Wilbert were the developers, Jelle was our UX designer, Diana our marketeer and Anton was our product owner.

We got involved in the project in February when some of the work had already been done. Anton, Diana, Sara and Jelle had created a [user story map](https://www.jpattonassociates.com/the-new-backlog/). And like often happens, the goals were set: launch an initial (beta) market release by June, launch a full release in September.

We took a week or two to get acquainted with the technology involved (some would call that sprint 0). But then it started to itch. We had set dates the ambition were sky high, but I had this uncomfortable feeling that the plan might not be feasible. 

@@more


## Dimensional Planning

We learned Dimensional planning around 2008 from our colleague Koen Van Exem. Dimensional Planning introduces the metaphor of different kinds of roads. This metaphor enables teams to talk about different 'levels' of the software they are building and how well the software meets customer goals. It creates a common language to discuss what's needed and what the customer thinks is worth paying for.

The metaphor defines three types of roads to represent three versions of your software: Dirt Road, Cobblestone Road, and Highway.

### Dirt Road

A Dirt Road version is a basic, simple, bare minimal solution. It does the job, but nothing more. It can be quick & dirty from a functional point of view and it can include manual workarounds. If you launch for example a new web store for an uncertain market, you can build only the user facing part, while processing incoming orders manually. If it is successful, you can decide to automate order processing, if it fails, you have greatly limited your losses by only investing in the bare minimum.

![dirt road, by Kristine Pethick, "Dirt Road to Playa Sucia"](/attachments/blogposts/2020/dirtroad.jpg)
{: class="post-image post-image-50" }

So how do we determine what needs to be in a Dirt Road solution? It should be **good enough to get feedback**.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/dirtroad-sketch.png" alt="dirt road">
  </div>
  <div>
    <p>Dirt Road guiding question:<br>
    <strong>What can we leave out?</strong></p>
  </div>
</div>

For a Dirt Road version, we set a release goal and a deadline. Then we drive development with a release burn down, shaving off work so that we deliver to our goal. We continuously ask ourselves: _do we really need this to get the feedback we seek?_

### Cobblestone Road

A Cobblestone Road version is a complete, usable implementation. It does the job like it should, but without extras, without fancy things.

![cobblestone road, by zebulon.walton, "A narrow street in France"](/attachments/blogposts/2020/cobblestoneroad.jpg)
{: class="post-image post-image-50" }

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/cobblestoneroad-sketch.png" alt="cobblestone road">
  </div>
  <div>
    <p>Cobblestone Road guiding question:<br>
    <strong>What is good enough?</strong></p>
  </div>
</div>

For a Cobblestone Road version, we set a release goal and deadline and then we drive development with a release burn down. To steer towards the goal and the deadline, we practice "Iceberg change management" - @@

### Highway

A Highway version is a full implementation, with bells & whistles.

![highway by USDA NRCS Montana](/attachments/blogposts/2020/highway.jpg)
{: class="post-image post-image-50" }

How great should it be? How far do you want/need to go? 

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/highway-sketch.png" alt="highway">
  </div>
  <div>
    <p>Cobblestone Road guiding question:<br>
    <strong>What do we still want to pay for?</strong></p>
  </div>
</div>

For the Highway version, we set a release goal and deadline and then we drive development with a release burn down. Like for the Cobblestone Road version, we practice Iceberg change management.

## Dimensional Planning in practice

In practice, we usually create a story map and assign different stories to the different dimensions. We end up with Dirt Road, Cobblestone Road and Highway slices. This implies we will have at least three releases.

We can split up large stories up in different dimensions.

## Variations on a theme

In the company mentioned in the introduction, they created their own variant of the metaphor: paper cup, coffee mug, silver chalice. So the exact metaphor does not matter, as long as it helps the common understanding between development, business, customers.

You could even use 4 levels if that suits your context better. More than 4 levels would make it complicated and would reduce the power of the metaphor.

## Value of dimensional planning

Cobblestone: customer realization: "we don't need the Highway"

Looking at Value delivered/return on investment: realize value ealier 

![plaatje van Yves](/attachments/blogposts/2020/yves-hanoulle-roi-dimensional-planning.png)
{: class="post-image post-image-50" }

**The metaphor provides customer and developers with a language to discuss smaller valuable 'shippables'. It also makes the idea of 'good enough software product' more concrete.**

- Earlier ROI
- Reduce new product development risk
- Realize value/reach goals with less effort

## Origins

Our colleague Koen Van Exem invented the metaphor and used it to sell fixed scope, fixed budget, fixed time projects - those dreaded "fixed everything" projects.

The customer wants it all and wants the best; you try to convince them that they will not need all the bells and whistles but the customer won't buy that. And you know only when the customer gets their hands on the software, they will understand what they really need. 

Delivering the Dirt Road and Cobblestone Road versions will largely satisfy the customer's real needs already. This facilitates a conversation about with Highway aspects the customer still finds valuable enough to pay for. Dimensional Planning can help to create space for negotiation even when everything seems to be fixed.

## Related techniques

We already mentioned [User Story Mapping](https://jpattonassociates.com/the-new-backlog/). Dimensional Planning works well with user story mapping, as it helps slicing releases and finding release goals.
User story mapping proposes to start with a ‘walking skeleton’ - a minimal version of the software that spans everything to get architectural feedback. A walking skeleton is not a Dirt Road version: they seek different kinds of feedback. You can still do both, start with a walking skeleton, then do a Dirt Road version.

![user story mapping + dimensional planning](/attachments/blogposts/2020/storymapping-slices.jpg)
{: class="post-image" }

Real Options: 
- using Dirt Road to test assumptions quickly; price of 'failure' is low (instead of putting all your bets on the most expensive one, the Highway) 

## Reading more

- [Dimensional Planning](http://www.hanoulle.be/2015/07/dimensional-planning/)
- [Koen's original slides](https://www.slideshare.net/inxin/dimensional-planning-30790935)
- [Real options by Yves Hanoulle & Geike Hanoulle](https://www.youtube.com/watch?v=YAxUwZzlMJE&feature=youtu.be)
- [Impact Mapping](https://www.impactmapping.org/) by Gojko Adzic, another useful technique that helps you plan for value

Picture credits:
- [Kristine Pethick, "Dirt Road to Playa Sucia"](https://www.flickr.com/photos/159897164@N04/40783372452/in/photolist-258TrL1-Afe78x-2e5fABY-wK1zvu-AAw3gg-FaS4A9-wCH4Hy-HjyqV2-22WokAY-QwHpso-2cvycxd-24wYVLC-AAsydZ-fy1URA-28SRmsL-kyENwx-AAw8XM-gueM6v-nsTvQM-219Whd6-51FcWq-frzDGo-2ecogf6-26KpEaE-5S3U2x-21JB2Pq-ow8ULT-ha2Cr8-2bBiKtr-jjogDL-GmGbtt-AqZPJp-2df496k-TmLvuy-ouhRge-4C37VL-21JEYwC-2e5f6bJ-2c41qqq-2a4XmCv-cU9djQ-2ax4mX7-ha2Fqy-2cL1ERB-219Wh48-tB1sne-2196PmW-21JAZo3-XUYaP8-ow9dTY)
- [zebulon.walton, "A narrow street in France"](https://www.flickr.com/photos/129869996@N05/16815586995/in/photolist-rBWhaH-5qgr2g-e8wECB-aShcAZ-aekRjc-LXAN49-cCZkkj-9292a5-6j7NA7-f1Wbih-91Q72X-24SCcRY-od5Tk9-5JTGzY-yd8wKp-g6AF97-Ay9rBE-YMnEsM-cCZjBu-arEaAi-2aA7LLB-owu81r-sHyPto-sHyND7-215rrXQ-yJ7KXG-HtZtYD-NjKGD-ySQjM3-xNd7Wa-oyeT6r-yGM23b-oeq3PJ-ysuTmh-yK6vxD-qrPQEU-2fqyUjN-LmZVfy-5GANxN-amymNE-aRPN1i-5JNsFP-5rZobf-8XQ1u1-bLLknX-5uxt8X-5JNrYp-68mpfT-ouGyT3-tnMHPu)
- [USDA NRCS Montana
Roads10.tif](https://www.flickr.com/photos/160831427@N06/24195960627/in/photolist-CS7C7X-JKmsWE-4vgo5-pu9JtG-Bwko6v-AKAiop-WcDfnj-atAVun-nvQZPY-x9pXL-28vzsLu-MtbseE-A7JWbG-AJvZpQ-orukdd-5k7aMq-eZpV1-JVcMs-pihYiS-uQ5Tfk-PEpYHo-GyLPDT-6BpjPj-5DSQ5G-8ZNkh-frzDGo-xTL8u2-q9h6Ea-vbRjRF-vRefE8-aiB7mr-ogoG4R-vYpdL-ehUpXY-8RDsQg-gGNuS1-eApn8j-dNTbn4-HDpFNM-dAexNJ-2fBMt7v-5hnrJy-ZnjRne-GHLchu-HAsM7L-8DoSXS-Lqnud2-xDeVre-5Avufr-2SaQ5a)
