---
layout: post
title: Working with User Story Mapping
tags:
  - agile
  - planning
  - product development
author: Marc Evers
image: /attachments/blogposts/2025/storymapping_illustratie_1.jpg
---

<a title="Jeff Patton: User Story Mapping" href="http://www.agileproductdesign.com/the_new_backlog.html" target="_blank">User Story Mapping</a> is one of our favourite practices that we often use with clients and in courses. User Story Mapping is an agile product planning practice, with its roots in user centered design. It has been popularized by <a title="Jeff Patton" href="http://www.agileproductdesign.com/blog" target="_blank">Jeff Patton</a>.

## Mapping user stories in two dimensions

User story mapping offers an alternative for more traditional agile planning approaches like the Scrum product backlog. Instead of a simple list, stories are laid out in a two dimensional map. The map provides a high level overview of the system under development, insight in the value it adds to the users (the horizontal axis), and a way to organize detailed stories into releases according to importance and priority (the vertical axis). The map shows how every user story fits in the full scope.

Releases are defined by creating horizontal slices of user stories, each slice being a release. For the first release, it is recommended to build a *walking skeleton* - a minimal set of user stories covering all user goals, so that you build a minimal but complete system to validate functionality and architecture early.

An important contribution of user story mapping is its focus on the users, the user goals, and the (system independent) activities/processes that the system should support. This helps the team to focus on why they are building the software - business value instead of feature details.

## We love small user stories

We prefer small user stories that can be build in 1 or 2 days. Small stories are easier to estimate, you deliver working software in small steps (working software daily), you get early feedback and a continuous feeling of accomplishment. We don't need to do extensive task planning, because making a quick list of tasks just in time on an index card is sufficient.

## Limitations of traditional agile planning approaches

We ran into a number of limitations of small stories. It becomes increasingly more difficult to understand the system as a whole through all the small stories. Some of our customers had trouble seeing the forest for the trees. We were also lacking a way to manage coherent sets of dependent stories. These start off as epics or themes, but once they are split up, it becomes hard to keep track of what belongs to what and how far each theme or epic has been done.

!['Where to Go' by Jeff Hitchcock - depicting a long, empty, winding road in a landscape with mountains](/attachments/blogposts/2025/where_to_go.jpg) 
{: class="post-image post-image-50" }  
<small>[Where to Go](http://www.flickr.com/photos/91281489@N00/319180335) by 
[Jeff Hitchcock](http://www.flickr.com/people/91281489@N00)</small>  
{: class="post-image" }

We also ran into limitations of linear backlogs for managing and prioritizing user stories. With lots of small stories and a lack of a good overview, it becomes difficult to prioritize. You spend more and more time on rearranging and refining the backlog instead of delivering working, valuable software.

Release planning - determining what value to deliver when - is a complex problem with multiple dimensions. Reducing it to a one dimensional backlog can work for simple systems, but for most systems we work with, essential details are lost.

The traditional way of agile planning supports working *incrementally* well. It provides little support for *iterative* development - building a story by fleshing it out in a number of deliveries. The risk here is that customers expect a user story to be finished in one go, while it might need two or more iterations. Lack of support of iterative development also bears the risk of customers requesting complete, bloated features (because it should be done right the first time), where simpler features would be sufficient (but the customer cannot know that until he/she sees the working features).

Last but not least, we frequently encounter developers and customers talking primarily in terms of software features. Teams get lost in solution details without a thorough understanding of the actual problems the software will solve. It's not only developers failing to speak the customer's language! We have also encountered customers and users talking databases, fields, screens, instead of focusing on what they actually want to achieve.

## User story mapping to the rescue

User story mapping focuses on the different users of the system and their goals. To achieve their goals, users perform <em>activities</em>, consisting of <em>tasks</em>. These are all user-centric - focusing on what the user does, not on features of the software. Features should support the user in doing tasks and achieving goals.

![a sketch of a user story map with time and necessity dimensions](/attachments/blogposts/2025/storymapping_illustratie_1.jpg)
{: class="post-image post-image-70" }

Instead of a linear backlog, you create a map of user activities and tasks. This defines the system at a high level and gives a complete overview of the scope. You put activities and tasks along the horizontal axis. The map then tells the story of the system: the activities describe the bird's eye view of the scope, the tasks tell how a user actually uses the system. Note that activities and tasks are closely related to business processes. Adapt the terms to your own context.

You define releases based on tasks. You iteratively build the system, fleshing out the different tasks by defining detailed user stories (which are software oriented). The vertical axis of your story map indicates importance: higher up means more important.

![a sketch of a user story map with time and necessity dimensions, and four sliced releases](/attachments/blogposts/2025/storymapping_illustratie_2.jpg)
{: class="post-image post-image-70" }

You define releases by drawing horizontal <em>slices</em> and moving stories up and down between slices. For the first release you define a <em>walking skeleton</em> - the bare bones of the system, minimal functionality that covers all activities. You defer splitting out the task level stories into concrete, detailed stories until the last responsible moment.

Detailed stories will become 'done', activities en tasks are never 'done' as a story. You can always put in more features, make it better.

> There are no hard and fast rules for story mapping. There are guidelines, but no strict boundaries of what activities, tasks, and stories are. The boundary between user oriented stories and software oriented stories is not strictly defined either.

## Benefits

User story mapping brings a number of benefits:

* It helps to keep an overview of the whole system and makes visible what value the system adds, what goals and activities or processes it supports, and how all the small, detailed user stories fit in.
* It facilitates release planning and enables a better conversation about defining delivering value early and managing risks. Building a walking skeleton can give early feedback on market and technical risks.
* By introducing the user's perspective and the rationale behind the system, user story mapping shifts the dialogue to the actual business value of the software. We only build features when the story map shows a rationale for that feature. A story map helps focus on the essential parts of the system. We have also used story maps to make teams aware that you don't need to build all those features. A subset is often sufficient to help users achieve their goals.
* By focusing on user goals, activities, and tasks first instead of software features, you keep more options open regarding ways of realizing / supporting those goals and activities. Manual workarounds can be a good alternative more often than you'd think.
* It augments rather than replaces practices from e.g. Scrum or eXtreme Programming and it plays well with techniques like [Event Storming](https://www.eventstorming.com/), which provides input for activities and tasks, [Dimensional Planning](/2020/09/02/dimensional-planning) to slice releases, and [Example Mapping](https://cucumber.io/blog/bdd/example-mapping-introduction/) to carve out user stories and tests.

Would you like to know more? Jeff Patton has [written useful materials on story mapping](https://www.agileproductdesign.com).

> This is an updated version of a [blog post](https://blog.piecemealgrowth.net/working-with-user-story-mapping) that we published earlier in 2009.

<aside>
  <p><strong>Would you like to learn more?</strong></p>
  <p>We can guide you in applying user story mapping for your products, e.g. by facilitating a user story mapping workshop for your product or by running a our [User Story Mapping & Dimensional Planning workshop](/training/user-story-mapping-dimensional-planning) to experiment hands-on with story mapping.</p>

  <p><div>
    <a href="/contact">Contact us when you're interested!</a>
  </div></p>
</aside>
