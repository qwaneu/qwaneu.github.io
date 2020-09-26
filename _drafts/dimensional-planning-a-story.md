---
layout: post
title: Dimensional Planning - a story
tags:
  - continuous delivery
  - planning
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/dirtroad.jpg
---

We will explain how Dimensional Planning can work by telling a story of how we
applied Dimensional Planning in a project we were involved in and how it helped
us to steer the project towards delivering its desired outcomes in time.

## The story

In 2018, we joined a project to develop a new product for one of our customers. In true [agile fluency 'optimizing' style](https://martinfowler.com/articles/agileFluency.html), the team included business, marketing, UX, product vision, and development. We had a simple goal: enter the market with this new product. We had some new insights on dimensional planning and estimating and achieving goals.

For obvious reasons, we have to apply some discretion here. We cannot share all the project details, but add some concrete examples from the product we're currently working on, the online Agile fluency Diagnostic application.

Let's introduce some of the people involved (not their real names): Sarah was our ambitious business owner; Rob, Magnus, and Wilbert were the developers, Jelle was our UX designer, Diana our marketeer and Anton was our product owner.

We got involved in the project in February when some of the work had already been done. Anton, Diana, Sara and Jelle had created a [user story map](https://www.jpattonassociates.com/the-new-backlog/). And like often happens, the goals were set: launch an initial (beta) market release by June, launch a full release in September.

### The estimate and dimensions

We took a week or two to get acquainted with the technology involved (some would call that sprint 0). But then it started to itch. We had set dates, and the ambition were sky high, but I had this uncomfortable feeling that the plan might not be feasible.

Rather than to live with the scope and date, Magnus, Wilbert and I decided to to a quick estimation session. I wrote the stories on index cards,threw them on the table and did an initial rough [relative estimate](https://medium.com/comparethemarket/my-relative-estimation-guide-742e247bb63b).

![dim-plan-story-estimate](/attachments/blogposts/2020/dim-plan-story-estimate-2.jpg) 
{: class="post-image" }

We compared a few of the stories with what we have done in the past two weeks, extrapolated the numbers and concluded: June is definitely not doable. August is more likely. Then I proposed to add [dimensions](http://localhost:8082/2020/09/02/dimensional-planning.html) to the story. Although, quite some interaction designs where already done by Jelle, I proposed to set a goal, to have the functionality barely work at the end of June. We could get some feedback from some beta customers and use their feedback for planning the second release. 

> This company mentioned in the introduction, we created their own variant of the metaphor: __Paper Cup__, __Coffee Mug__, __Silver Chalice__. So the exact metaphor does not matter, as long as it helps the common understanding between development, business, customers.

We split all stories in _Paper Cup_ and _Coffee Mug_ stories and took about half of the estimate for the Paper Cup version. This again was a very rough estimate, but it seemed a good idea because firstly we thought we'd see along the way how we where doing. And secondly, we realised, we lacked knowledge, hence analysing the work in too much detail, would be useless. 

### The first sprints 

We used Jira for keeping track of the stories but maintained ad physical board as well. As I did not trust Jira to print the burn downs correctly, I used an excel sheet to generate the burn down charts. The drawings in this post are traced from those. Here's the first picture, after three sprints:

![dim-plan-story-burndown-1](/attachments/blogposts/2020/dim-plan-story-burndown-1.png) 
{: class="post-image" }

We tracked the estimated work still to be done (blue bars) and extrapolated the estimated release date from that data (the green line). Nothing fancy, that's is what a release burndown should show. 

The graphs looked too good to be true actually. The prognosed release was almost exactly end of june. It made me worry more than anything else. There's always something unexpected to happen. I'd rather see that sooner than later.

### Coping with slowing down

Then we started to see some slow down in our work. Some of the work took somewhat more time than expected. There are several ways of dealing with the situation. 
One way would be, to just move on and hope for the better. Another option is to assume that this was a hick-up, assume that our real velocity wouldn't change as shown in the picture below (dark green line). 

![dim-plan-story-burndown-3](/attachments/blogposts/2020/dim-plan-story-burndown-3.png) 
{: class="post-image" }


This hick-up scenario is not really honest. Extrapolating should be about taking the trend in work that is finished (or rather, a progressing estimate on the work still to be done). The light green line is more honest, and in fact more pessimistic. We would be looking at, the end of July rather than the end of June.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/dirtroad-sketch.png" alt="dirt road">
  </div>
  <div>
    <p>Remember from <a href="/2020/09/02/dimensional-planning.html">our dimensional planning post</a></p>
    <p>Dirt Road guiding question:<br>
    <strong>What can we leave out?</strong></p>
  </div>
</div>

So we started to look critically at the paper cup stories, what can we leave out. The backlog was sorted in order of priority, so together with Anton, we moved some of the lower paper cup stories out of scope. 

It would be tempting to lower the last bar with that, and so lower the green line. However, doing so would obfuscate the decisions we just made. It would look just like we where going faster. A better option is to visualise the work removed by removing the work from the bottom of the bar. Just like the green trend line of the work being done, we now could visualize a trend line about the scope being reduced as well, as shown by the red line in the picture below.

![dim-plan-story-burndown-4](/attachments/blogposts/2020/dim-plan-story-burndown-4.png) 
{: class="post-image" }

I like to call that effect _lifting the horizon_. The idea is that when the green line crosses the red line, we would be done with the first release. 

### A change of mind(-set)

You may argue that there's a limit to what you can do with reducing the scope of the project. So, like the green trend being to pessimistic, the red line may be to optimistic. We were well aware of that possibility. But here's what really happened.

At first I still wasn't happy with the fact that the end date was around the end of june. We didn't seem to have any slack. It would be just a matter of time, before something unexpected would happen. So the next sprint, we would have the same discussion of leaving something out from the bottom of the paper cup backlog. The effect was something like the picture below.

![dim-plan-story-burndown-5](/attachments/blogposts/2020/dim-plan-story-burndown-5.png) 
{: class="post-image" }

I really liked the effect of reducing the scope and its visualisation. The way I had used burn down graphs before was to visualize team's speed towards a goal only. But now I realized that, if we wanted we could play with the end date by _lifting the horizon_ if we wanted. It became a bit of an addiction, to repeatedly look at the current scope critically and look at ways to get something valueable quicker, and so postponing decisions on what value to bring next to later.

### Fractal dimensional planning

During the project we kept looking at the scope in this way. Dimensional planning, in its original inception of the idea talks about three dimensions:

* Dirt road (or paper cup)
* Cobble stone road (or coffee mug)
* Asphalt road (or silver chalice)

What the actual projection of these dimensions are on a product is somewhat subjective. You can have lively discussions on product quality. What is a _coffee mug_ to one can be unnecessary polishing of the _silver chalice_ to the other. The silver chalice to me became sort of a metaphor of something unnecessary, much like the [_YAGNI_](http://c2.com/xp/YouArentGonnaNeedIt.html) principle in eXtreme Programming.

After achieving a release I thought of the rest of the project as a new one. A fresh start, new chances, new estimates, new end dates. 

> To be totally honest, the dates remained quite, eh... fixed.

Yes the backlog was filled with everything we postponed during the former release, but in the mean time, so much had happened. We gathered feedback; we visited clients, we learned so much that the backlog was revisited. 

And yes we started again, with the same discussions on _paper cups_ for now and _coffee mugs_ for later and _silver chalices_ for the far, far future. 

In this way, dimensional planning is fractal.

## Summary

We have walked you through a stotry using dimensional planning in practice. We have shown what we did with _lifting the horizon_ and how that became somewhat addictive.

Separating the _'work done over time'_ from the _'scope reduced over time'_ visually really changed my thinking about burn downs. If you want you can play around with the _horizon_. 

Resetting a project after a release, changed my way of looking at dimensional planning as well; _Dirt roads_ and _cobblestones_ befome the interesting dimensions _asphalt roads_ are similar to _YAGNI_

<aside>
  <h3>Dimensional planning and release burn downs</h3>
  <p>We rarely see people use release burn downs (or burn ups) and dimensional planning, the way described in this article. People often use sprint burn down and/or do not look further than something generated by some tool. Teams often seem to have cold feed to start with their own visualisations to manage deadlines, scope and show progress. It not that hard, requires a bit of discipline.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>





