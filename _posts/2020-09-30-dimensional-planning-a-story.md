---
layout: post
title: Dimensional Planning - a story
tags:
  - continuous delivery
  - planning
author: Rob Westgeest
image: /attachments/blogposts/2020/dirtroad.jpg
---

In this post, we will explain how [Dimensional Planning](/2020/09/02/dimensional-planning.html) can work by sharing a story of how we
applied it in a project and how it helped
us to steer the project towards delivering its desired outcomes in time.

## The story

In 2018, we joined a project to develop a new product for one of our customers. In true [agile fluency 'optimizing' style](https://martinfowler.com/articles/agileFluency.html), the team included business, marketing, UX, product vision, and development. We had a clear goal: enter the market with this new product. We had some new insights on using dimensional planning to estimate and achieve goals.

For obvious reasons, we have to apply some discretion here. We cannot share all the project details. Instead we will add some concrete examples from the product we're currently working on, the online Agile fluency Diagnostic application.

Let's introduce some of the people involved (not their real names): Sarah was our ambitious business owner; Rob, Magnus, and Wilbert were the developers, Jelle was our UX designer, Diana our marketeer and Anton was our product owner.

We got involved in the project in February when some of the work had already been done. Anton, Diana, Sara and Jelle had created a [user story map](https://www.jpattonassociates.com/the-new-backlog/). And like often happens, the goals were set: launch an initial (beta) market release by June, launch a full release in September.

### The estimate and dimensions

We took a week or two to get acquainted with the technology involved. But then it started to itch. We had set dates, and the ambitions were sky high, but I had this uncomfortable feeling that the plan might not be feasible.

Rather than to live with the scope and date, Magnus, Wilbert and I decided to to a quick estimation session. I wrote the stories on index cards,threw them on the table and did an initial rough [relative estimate](https://medium.com/comparethemarket/my-relative-estimation-guide-742e247bb63b).

![dim-plan-story-estimate](/attachments/blogposts/2020/dim-plan-story-estimate-2.jpg) 
{: class="post-image" }

We compared a few of the stories with what we had done in the past two weeks, extrapolated the numbers and concluded: June is definitely not feasible. August is more likely. Then I proposed to add [dimensions](/2020/09/02/dimensional-planning.html) to the story. Although quite some interaction designs where already done by Jelle, I proposed to set a goal: have the functionality barely working at the end of June. We could get feedback from some beta customers and use their feedback for planning the second release. 

> For this company, we co-created their own version of the Dirt Road/Cobblestone Road/Highway metaphor: __Paper Cup__, __Coffee Mug__, __Silver Chalice__. So the exact metaphor does not matter, as long as it aids shared understanding between development, business and customers.

We split the stories in _Paper Cup_ and _Coffee Mug_ stories and took about half of the estimate for the Paper Cup version. This again was a very rough estimate, but it seemed like a good idea. Firstly, we thought we would see along the way how well we where doing. And secondly, we realised that we lacked knowledge, hence analysing the work in too much detail would be useless. 

### The first sprints 

The company used Jira to keep track of stories, but we maintained a physical board as well. As I did not trust Jira to print burn downs charts correctly, I used an Excel sheet to generate the charts. The drawings in this post are based on those. Here is the first burn down chart, after three sprints:

![paper cup version burn down chart after 3 sprints](/attachments/blogposts/2020/dim-plan-story-burndown-1.png) 
{: class="post-image" }

We tracked the estimated work still to be done, depicted by blue bars, and extrapolated the estimated release date from that data - the green line. Nothing fancy, that's is what a release burn down chart should show. 

The graphs looked too good to be true actually. The forecast release date was almost exactly end of June. It made me worry more than anything else. Something unexpected is always bound to happen. I'd rather see that sooner than later.

### Coping with slowing down

Then we started to see some slow down in our work. Some of the work took a bit more time than expected. 

There are several ways of dealing with this situation. One way is to just move on and hope for the better. Another option is to assume that this was just a hiccup, and our real velocity wouldn't change, as shown in the picture below (dark green line).

![paper cup release burn down with slow down](/attachments/blogposts/2020/dim-plan-story-burndown-3.png) 
{: class="post-image" }


This hiccup scenario is not really honest. Extrapolating should be about taking the trend in work that is finished, or rather a progressing estimate of the work still to be done. The light green line is more honest, and in fact more pessimistic. We would be looking at the end of July rather than the end of June.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/dirtroad-sketch.png" alt="dirt road">
  </div>
  <div>
    <p>Remember the Dirt Road guiding question from <a href="/2020/09/02/dimensional-planning.html">our dimensional planning post</a>:</p>
    <p>
    <strong>What can we leave out?</strong></p>
  </div>
</div>

So we started to look critically at the paper cup stories, to see what we can leave out. The backlog was sorted in order of priority, so together with Anton, we moved some lower priority paper cup stories out of scope. 

It would be tempting to lower the last bar with that, and so lower the green line. However, doing so would obfuscate the decisions we just made. It would wrongly suggest we were going faster. A better option is to visualise the work removed by removing the work from the bottom of the bar. Just like the green trend line of the work being done, we now could visualize a trend line about the scope being reduced as well, as shown by the red line in the picture below.

![paper cup version burn down chart with work removed](/attachments/blogposts/2020/dim-plan-story-burndown-4.png) 
{: class="post-image" }

I like to call that effect _lifting the horizon_. When the green line crosses the red line, we would be done with the first release. 

### A change of mind(-set)

You could argue that there is a limit to what you can do with reducing the scope of the project. Like the green trend being too pessimistic, the red line may be too optimistic. We were well aware of that possibility. But here's what actually happened.

At first I still wasn't happy with the fact that the end date was around the end of June. We didn't seem to have any slack. It would just be a matter of time before something unexpected would happen. So in the next sprint, we would have the same discussion of leaving something out from the bottom of the paper cup backlog. The effect was something like the picture below.

![paper cup version burn down chart, leaving out even more](/attachments/blogposts/2020/dim-plan-story-burndown-5.png) 
{: class="post-image" }

I really liked the effect of reducing the scope and its visualisation. The way I had used burn down graphs before was to visualize a team's speed towards a goal only. But now I realized that if we wanted, we could play with the end date by _lifting the horizon_. It became a bit of an addiction to repeatedly look at the current scope critically, and identify ways to get something valuable sooner. In that way we could postpone decisions on what value to bring next.

### Fractal dimensional planning

During the project we kept looking at the scope in this way. Dimensional planning, in its original inception of the idea, talks about three dimensions:

* Dirt road (or paper cup)
* Cobblestone road (or coffee mug)
* Highway (or silver chalice)

How you project these dimensions on a software product you are developing is somewhat subjective. You can have lively discussions on product quality. What is a _coffee mug_ to one person can be unnecessary polishing of the _silver chalice_ to the other. For me, the silver chalice became a metaphor of something unnecessary, much like the [YAGNI - You Aren't Gonna Need It](http://c2.com/xp/YouArentGonnaNeedIt.html) principle in eXtreme Programming.

After delivering a release, I thought of the rest of the project as a new release: a fresh start, new chances, new estimates, new end dates. 

> To be totally honest, the dates remained quite, eh... fixed.

Yes, the backlog was filled with everything we postponed during the former release, but in the mean time so much had happened. We had gathered feedback, we visited clients, we learned so much that we revisited the whole backlog.

And yes, we started again, with the same discussions on _paper cups_ for now and _coffee mugs_ for later and _silver chalices_ for the far, far future. 
In this way, dimensional planning is fractal.

## Summary

We have walked you through a story of using dimensional planning in practice. We have shown what we did with _lifting the horizon_ and how that became somewhat addictive.

Visualizing the _work done over time_ separately from the _scope reduced over time_ really changed my thinking about burn down charts. If you want, you can play around with the _horizon_. 

'Resetting' a project after a release changed my way of looking at dimensional planning as well: _Dirt roads_ and _Cobblestone roads_ become the interesting dimensions, while _Highways_ are much more _YAGNI - you aren't gonna need it_.

_Credits: I really am not much of a writer, and 'speeling error' are my middle names. There is no way I could write anything really, without Willem and Marc, cleaning up the mess. Thanks guys._

This post is part of a series on Dimensional Planning:

- [Dimensional Planning - good enough software, early & often](/2020/09/02/dimensional-planning.html)
- Dimensional Planning - a story
- [Dimensions of Dimensional Planning](/2020/11/13/dimensions-of-dimensional-planning.html)
- [Dimensions of Features - an example](/2020/11/23/dimensions-of-afp.html)

<aside>
  <h3>Dimensional Planning and Release burn down charts</h3>
  <p>We rarely see teams use release burn downs/burn ups and dimensional planning in the way described in this article. Teams use <em>sprint</em> burn down charts only, often generated by some tool.</p>
  <p>Creating your own visualisations to manage deadlines and scope, and to show progress towards your goals provides much more value. Wondering how to start? Feel free to contact us.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
