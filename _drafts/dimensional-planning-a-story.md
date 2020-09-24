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

We took a week or two to get acquainted with the technology involved (some would call that sprint 0). But then it started to itch. We had set dates the ambition were sky high, but I had this uncomfortable feeling that the plan might not be feasible.

Rather than to live with the scope and date, Magnus, Wilbert and I decided to to a quick estimation session. I wrote the stories on index cards,threw them on the table and did an initial rough [relative estimate](https://medium.com/comparethemarket/my-relative-estimation-guide-742e247bb63b).

![dim-plan-story-estimate](/attachments/blogposts/2020/dim-plan-story-estimate-2.jpg) 
{: class="post-image" }

We compared a few of the stories with what we have done in the past two weeks, extrapolated the numbers and concluded: June is definitely not doable. August is more likely. Then I proposed to add [dimensions](http://localhost:8082/2020/09/02/dimensional-planning.html) to the story. Although, quite some interaction designs where already done by Jelle, I proposed to set a goal, to have the functionality barely work at the end of June. We could get some feedback from some beta customers and use their feedback for planning the second release. 

> This company mentioned in the introduction, we created their own variant of the metaphor: __Paper Cup__, __Coffee Mug__, __Silver Chalice__. So the exact metaphor does not matter, as long as it helps the common understanding between development, business, customers.

We split all stories in _Paper Cup_ and _Coffee Mug_ stories and took about half of the estimate for the Paper Cup version. This again was a very rough estimate, but it seemed a good idea because firstly we thought we'd see along the way how we where doing. And secondly, we realised, we lacked knowledge, hence analysing the work in too much detail, would be useless. We used Jira for keeping track of the stories but maintained ad physical board as well. As I did not trust Jira to print the burn downs correctly, I used an excel sheet to generate the burn down charts. The drawings in this post are traced from those.

The first few sprints, seemed to be going well. The graphs looked too good to be true actually. The prognosed release was almost exactly end of june. It made me worry more than anything else. There's always something unexpected to happen. I'd rather see that sooner than later.

Then we started to see some slow down in our work. Some of the work took somewhat more time than expected. One way of dealing with this is, to stick to the plan for wa while and hope for the better. We directly had a chat with Anton and discussed on what to leave out. 

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

The discussion was not on leaving out stories alone, we also discussed the _papercupness_ of stories, re-estimated and came to the following burn down graph.

This burn down needs some explanation. The green line on top shows our velocity extrapolated in the future. After re-estimating, we could have reduced the amount of work still to be done on the top of the graph, but that would obfuscate the constructive discussion we just had. We decided therefore to indicate the reduced work in lifting up the horizon. 

Just like the way we indicate velocity in the burn down in the green line, we indicated that there may well be a similar reducing scope 'velocity'. 





We maintained a 

