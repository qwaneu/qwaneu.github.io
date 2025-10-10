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

> This is a slightly polished repost of a blog post that we published in 2009

<p><a title="Jeff Patton: User Story Mapping" href="http://www.agileproductdesign.com/the_new_backlog.html" target="_blank">User Story Mapping</a> is one of our favourite practice, we used it with clients and in our courses. User Story Mapping is an agile product planning practice, with its roots in user centered design. It has been popularized by <a title="Jeff Patton" href="http://www.agileproductdesign.com/blog" target="_blank">Jeff Patton</a>.</p>

<p>User story mapping offers an alternative for traditional agile planning approaches like the Scrum product backlog. Instead of a simple list, stories are laid out as a two dimensional map. The map provides both a high level overview of the system under development and of the value it adds to the users (the horizontal axis), and a way to organize detailed stories into releases according to importance, priority, etc. (the vertical axis). The map shows how every user story fits in the full scope.</p>

<p>Releases are defined by creating horizontal slices of user stories, each slice is a release. For the first release, it is recommended to build a minimal set of user stories covering all user goals, so that you build a minimal but complete system to validate functionality and architecture early.</p>

<p>An important contribution of user story mapping is its focus on the users, the user goals, and the (system independent) activities/processes that the system should support. This helps the team to focus on why they are building the software &#8211; business value instead of feature details.</p>

<p>Story mapping was a natural fit for us, after working with agile for a number of  years. It augments existing agile processes and solves a number of issues we have run into.</p>

<h3>We love small user stories</h3>

<p>We came to prefer small user stories that can be build in 1 or 2 days. Small stories have all kinds of advantages. They are easier to estimate, you deliver working software in small steps (working software daily), you get early feedback and a continuous feeling of accomplishment. We don&#8217;t need to do extensive task planning, because making a quick list of tasks just in time on an index card is sufficient.</p>

<h3>Limitations of traditional agile planning approaches</h3>

<p>We ran into a number of limitations of small stories. It becomes increasingly more difficult to understand the system as a whole through all the small stories. Some of our customers had trouble seeing the forest for the trees. We were also lacking a way to manage coherent sets of dependent stories. These start off as epics or themes, but once they are split up, it becomes hard to keep track of what belongs to what and how far each theme or epic has been done.</p>

<p style="text-align: center;"><img class=" aligncenter" title="Where to Go  by Jeff Hitchcock" src="/attachments/blogposts/2025/where_to_go.jpg" alt="Where to Go  by Jeff Hitchcock" width="400" height="266" /></p>

<p style="text-align: center;"><small><a href="http://www.flickr.com/photos/91281489@N00/319180335">Where to Go</a> by 
<a href="http://www.flickr.com/people/91281489@N00">Jeff Hitchcock</a></small></p>

<p>We also ran into limitations of linear backlogs for managing and prioritizing user stories. With lots of small stories and a lack of a good overview, it becomes difficult to prioritize. You spend more and more time on rearranging and grooming the backlog grooming instead of delivering working, valuable software.</p>

<p>Release planning &#8211; determining what value to deliver when &#8211; is a complex problem with multiple dimensions. Reducing it to a one dimensional backlog can work for simple systems, but for most systems we work with, essential details are lost.</p>

<p>The traditional way of agile planning supports working incrementally well. It provides little support for iterative development (i.e. building a story by fleshing it out in a number of deliveries). The risk here is that customers expect a user story to be finished in one go, while it might need two or more iterations to be fleshed out well. Lack of support of iterative development also bears the risk of customers requesting complete, bloated features (because it should be done right the first time), where simpler features would be sufficient (but the customer cannot know that until he/she sees the working features).</p>

<p>Last but not least, we frequently encounter developers and customers discussing primarily in terms of software features. Teams get lost in the solution details without a thorough understanding of the actual problems the software will solve. It&#8217;s not only developers failing to speak the customer&#8217;s language! We have also encountered quite a number of customers and users talking databases, fields, screens, and other solution aspects, instead of focusing on what they actually want to achieve.</p>

<h3>User story mapping to the rescue</h3>

<p>User story mapping focuses on the different users of the system and their goals. To achieve their goals, users perform <em>activities</em>, consisting of <em>tasks</em>. These are all user-centric – focusing on what the user does, not on features of the software. Features should support the user in doing tasks and achieving goals.</p>

<p style="text-align: center;"><img class="aligncenter" title="User Story Map" src="/attachments/blogposts/2025/storymapping_illustratie_1.jpg" alt="" width="420" height="183" /></p>
<p>Instead of a linear backlog, you create a map of user&#8217;s activities and tasks. This defines the system at a high level and gives a complete overview of the scope. You put activities and tasks along the horizontal axis. The map then tells the story of the system: the activities describe the bird&#8217;s eye view of the scope, the tasks tell how a user actually uses the system. Note that activities and tasks are closely related to business processes. Adapt the terms to your own context.</p>

<p>You define releases based on tasks. You iteratively build the system, fleshing out the different tasks by defining detailed user stories (which are software oriented). The vertical axis of your story map indicates importance: higher up means more important.</p>

<p style="text-align: center;"><img class="aligncenter" title="Planning releases with a story map" src="/attachments/blogposts/2025/storymapping_illustratie_2.jpg" alt="" width="480" height="190" /></p>

<p>You define releases by drawing horizontal <em>slices </em>and moving stories up and down between slices. For the first release you define a <em>walking skeleton</em> – the bare bones of the system, minimal functionality that covers all activities. You defer splitting out the task level stories into concrete, detailed stories until the last responsible moment.</p>

<p>Detailed 	stories will become &#8216;done&#8217;; activities en tasks are never &#8216;done&#8217; as 	a story; you can always put in more features, make it better.</p>

<p>There 	are no hard and fast rules for story mapping. There are a number of useful 	guidelines, but no strict boundaries of what activities, tasks, and stories are. The boundary between user oriented stories and 	software oriented stories is not strictly defined either.</p>

<h3>Benefits</h3>

<p>User story mapping brings a number of benefits:</p>

<ul>
<li>It helps to keep an overview of the whole system and makes visible what value the system adds, what goals and activities or processes it supports, and how all the small, detailed user stories fit in.</li>
<li>It facilitates release planning and enables a better conversation about defining delivering value early and managing risks; building a walking skeleton can give early feedback on market and technical risks.</li>
<li>By introducing the users perspective and the rationale behind the system, User story mapping shifts the dialogue to the actual business value of the software. We only build features when the story map shows a rationale for that feature. A story map helps focus on the essential parts of the system. We have also used story maps to make teams aware that you don&#8217;t need to build all those features. A subset is often sufficient to help users achieve their goals.</li>
<li>By 	focusing on user goals, activities, and tasks first instead of software features, you keep more options open regarding ways of realizing / supporting those goals and activities. Manual workarounds can be a good alternative more often than you&#8217;d think (btw I prefer to call it <a title="Sapient Processes" href="http://www.satisfice.com/blog/archives/99" target="_blank">sapient processes</a> rather than manual workarounds)</li>
<li>It augments rather than replaces practices from e.g. Scrum or eXtreme Programming and it plays well with other techniques like <a title="Dimensional Planning" href="http://www.inxin.com/wiki/DimensionalPlanning" target="_blank">Dimensional Planning</a> and agile business process analysis.</li>
</ul>

<p>Would you like to know more? <a title="Jeff Patton" href="http://www.agileproductdesign.com/blog" target="_blank">Jeff Patton</a> has written very good material on story mapping. There&#8217;s however only so much theory, the beef is in doing it. We have developed a simulation called <a href="http://www.qwan.it/training/half-day-workshops/newproductdevelopment/">The New New NEW! Product Development Game</a> to experience release planning with user story mapping. We can also guide you in applying user story mapping in your projects. <a href="/contact">Let me know</a> if you&#8217;re interested.</p>
