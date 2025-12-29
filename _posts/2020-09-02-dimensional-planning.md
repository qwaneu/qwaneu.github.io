---
layout: post
title: Dimensional Planning - good enough software, early & often
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: /attachments/blogposts/2020/dirtroad.jpg
---

Starting new product development with the question 'What can we leave out?' may
seem paradoxical. We do this to start a conversation between customers and
developers. As we go we develop a shared language, so that value can be delivered
early and often. This is called Dimensional Planning.

Dimensional Planning was invented by our colleague Koen Van Exem around 2008. He used it to sell fixed scope, fixed budget, fixed time projects - those dreaded "fixed everything" projects.

## I want it all

The customer wants it all and wants the best; you try to convince them that they will not need all the bells and whistles but the customer often won't buy that. And you know only when the customer gets their hands on the software, they will understand what they really need.
Dimensional Planning is a way to manage such a catch-22 situation and to facilitate a constructive conversation about a goal, and how to get there.

Dimensional Planning is built around a metaphor of road building. Roads can be more or less luxurious. Luxury comes at a cost though. The customer asks for a 6 lane highway, but in our experience delivering a dirt road and maybe a few cobblestone road releases will largely satisfy the customer's real needs already. This facilitates a conversation about which Highway aspects the customer still finds valuable enough to pay for. Dimensional Planning can help to create space for negotiation even when everything seems to be fixed.

## Dirt Road

A Dirt Road version is a basic, simple, bare minimal solution. It does the job, but nothing more. It can be quick & dirty from a functional point of view and it can include manual workarounds. If you launch for example a new web store for an uncertain market, you can build only the user facing part, while processing incoming orders manually. If it is successful, you can decide to automate order processing, if it fails, you have greatly limited your losses by only investing in the bare minimum.

![dirt road, by Kristine Pethick, "Dirt Road to Playa Sucia"](/attachments/blogposts/2020/dirtroad.jpg)
{: class="post-image post-image-50" }

So how do we determine what needs to be in a Dirt Road solution? It should be **good enough to get feedback**.

To work towards a Dirt Road version, we can set a release goal and a deadline, and use a release burn down to drive development. We continuously ask ourselves: _do we really need this to get the feedback we seek?_, shaving off work so that we will deliver to our goal.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/dirtroad-sketch.png" alt="dirt road">
  </div>
  <div>
    <p>Dirt Road guiding question:<br>
    <strong>What can we leave out?</strong></p>
  </div>
</div>

## Cobblestone Road

A Cobblestone Road version is a complete, usable implementation. It does the job like it should, but without extras, without anything fancy. For the Cobblestone Road release of our web shop, we automate order processing. We keep the user interface simple however. It does the job, nothing more, so simple dropdown lists, no smart searches, no extensive sorting and filtering, no continuous scrolling.

![cobblestone road, by zebulon.walton, "A narrow street in France"](/attachments/blogposts/2020/cobblestoneroad.jpg)
{: class="post-image post-image-50" }

So how do we determine what needs to be in a Cobblestone Road solution? Or what does not need to be in there? You should be able to stop development after delivering the Cobblestone Road release: it does the job, it is functional, it gets you from A to B but no more. It does not excite, but no one makes a fuss about it either.

Just like with Dirt Road releases, it helps to set a release goal and a deadline, and use a release burn down to drive development. The decision criterion here is: if we would leave out this piece, would someone be hindered in doing their work? No? Then it is not part of your Cobblestone Road release.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/cobblestoneroad-sketch.png" alt="cobblestone road">
  </div>
  <div>
    <p>Cobblestone Road guiding question:<br>
    <strong>What is good enough?</strong></p>
  </div>
</div>

## Highway

A Highway release is a full blown implementation, with all the bells & whistles, luxuries, and nice-to-haves. Striving for perfection finds its place in the Highway release.

Chances are that by now, the customer has learned so much from tangible Dirt Road and Cobblestone Road results, that the current perspective on what comprises the Highway has changed dramatically from what the customer initially assumed. 

![highway by USDA NRCS Montana](/attachments/blogposts/2020/highway.jpg)
{: class="post-image post-image-50" }

How great should it be? How far do you want to go? What should be in the Highway release(s)? Well, anything can be in there, as long as someone is willing to pay for it. Just remember, kids, [code can be a liability, as well as an asset](http://wiki.c2.com/?SoftwareAsLiability).

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/highway-sketch.png" alt="highway">
  </div>
  <div>
    <p>Highway guiding question:<br>
    <strong>What do we still want to pay for?</strong></p>
  </div>
</div>

## Dimensional Planning in practice

We usually create a story map and assign different stories to the different dimensions. We end up with Dirt Road, Cobblestone Road and Highway slices. This implies we will have at least three releases. We can apply the metaphor also to large stories and split them up in different dimensions.

Dimensional Planning works well with [User Story Mapping](https://jpattonassociates.com/the-new-backlog/), as it helps slicing releases and finding release goals.
User story mapping proposes to start with a _walking skeleton_ - a minimal version of the software that spans everything to get architectural feedback. A walking skeleton is not a Dirt Road version: they seek different kinds of feedback. You can still do both, start with a walking skeleton, then do a Dirt Road version.

![user story mapping + dimensional planning](/attachments/blogposts/2020/storymapping-slices.jpg)
{: class="post-image" }

> In a story map, it is not always as simple as story 'X' is a Dirt Road story and story 'Y' a Cobblestone Road or Highway story. Stories in a story map are often of 'epical' size. They need to be split in smaller stories. The three roads metaphor can facilitate this splitting process as well.

Using the metaphor of the three road helps in negotiating an earlier release with customers who want it all: it allows them to agree on a bare minimum version, because they know the bells and whistles won't be forgotten. Along the way, the customer will realize they don't need the full highway.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/roi-dimensional-planning.png" alt="get value early with dimensional planning">
  </div>
  <div>
    <p>Dimensional Planning provides customers and developers a <strong>shared language</strong> to discuss <strong>smaller valuable deliveries</strong>. It is about <strong>good enough software</strong>.
    </p>
  </div>
</div>

## Read more

- [Dimensional Planning](http://www.hanoulle.be/2015/07/dimensional-planning/)
- [Koen's original slides](https://www.slideshare.net/inxin/dimensional-planning-30790935)
- [Real options by Yves Hanoulle & Geike Hanoulle](https://www.youtube.com/watch?v=YAxUwZzlMJE&feature=youtu.be)
- [Impact Mapping](https://www.impactmapping.org/) by Gojko Adzic, another useful technique that helps you plan for value

Picture credits:

- [Kristine Pethick, "Dirt Road to Playa Sucia"](https://www.flickr.com/photos/159897164@N04/40783372452/in/photolist-258TrL1-Afe78x-2e5fABY-wK1zvu-AAw3gg-FaS4A9-wCH4Hy-HjyqV2-22WokAY-QwHpso-2cvycxd-24wYVLC-AAsydZ-fy1URA-28SRmsL-kyENwx-AAw8XM-gueM6v-nsTvQM-219Whd6-51FcWq-frzDGo-2ecogf6-26KpEaE-5S3U2x-21JB2Pq-ow8ULT-ha2Cr8-2bBiKtr-jjogDL-GmGbtt-AqZPJp-2df496k-TmLvuy-ouhRge-4C37VL-21JEYwC-2e5f6bJ-2c41qqq-2a4XmCv-cU9djQ-2ax4mX7-ha2Fqy-2cL1ERB-219Wh48-tB1sne-2196PmW-21JAZo3-XUYaP8-ow9dTY)
- [Jeremy Keith, Cobblestones.](https://www.flickr.com/photos/adactio/21557546772/in/photolist-yQY4AU-284v4u3-e5AD2r-23yhTMU-48oKvf-PRwAmq-ZsbxcZ-23DtyTU-L4SLk5-oV9frt-Ay9JYH-27RrjEo-6Ycw9t-nUeGVP-rYBxha-6BBtBe-2T8zHS-29mGNJL-cZxTJA-SUNMGf-B7VPPE-ihoHWV-aaB4Lf-q5cjpV-2T8zQ9-9njqnT-xjb6yw-MGKTfE-KRh4L-GEdREg-dtNcAu-6ZsFyS-itNPDc-4JqniW-7fXmGy-pM6ppn-fAGHdV-EAMDZ3-GEdRnn-JnkRj8-iFhMAJ-26fu2MW-25efAq5-kKrQV8-LEddot-Yp96Aa-qiMxVy-21ZLnQK-iEVm8Q-ohJLSq)
- [USDA NRCS Montana
  Roads10.tif](https://www.flickr.com/photos/160831427@N06/24195960627/in/photolist-CS7C7X-JKmsWE-4vgo5-pu9JtG-Bwko6v-AKAiop-WcDfnj-atAVun-nvQZPY-x9pXL-28vzsLu-MtbseE-A7JWbG-AJvZpQ-orukdd-5k7aMq-eZpV1-JVcMs-pihYiS-uQ5Tfk-PEpYHo-GyLPDT-6BpjPj-5DSQ5G-8ZNkh-frzDGo-xTL8u2-q9h6Ea-vbRjRF-vRefE8-aiB7mr-ogoG4R-vYpdL-ehUpXY-8RDsQg-gGNuS1-eApn8j-dNTbn4-HDpFNM-dAexNJ-2fBMt7v-5hnrJy-ZnjRne-GHLchu-HAsM7L-8DoSXS-Lqnud2-xDeVre-5Avufr-2SaQ5a)

This post is part of a series on Dimensional Planning:

- Dimensional Planning - good enough software, early & often
- [Dimensional Planning - a story](/2020/09/30/dimensional-planning-a-story.html)
- [Dimensions of Dimensional Planning](/2020/11/13/dimensions-of-dimensional-planning.html)
- [Dimensions of Features - an example](/2020/11/23/dimensions-of-afp.html)

<aside>
  <h3>Want to apply story mapping and dimensional planning?</h3>
  <p>These practices are simple and elegant, but not always easy to put into practice. We offer workshops on agile planning techniques and we can mentor your team in applying them successfully.</p>
  <p><div>
    <a href="/training">Learn more about our workshops</a>
  </div></p>
</aside>
