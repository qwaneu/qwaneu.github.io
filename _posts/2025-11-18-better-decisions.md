---
layout: post
title: What do you need to see to make better decisions?
tags:
- short
- community
- LLM
- legacy code
- moldable development
author: Willem van den Ende
image: /attachments/blogposts/2025/moving-bunnies-microprint-node-modules.png 
---

I am running a session at the Swindon Developers meetup this Thurdsday at 6:30PM 
 *. There are still some places available, so join me and [register now](https://www.meetup.com/swindon-software/events/311751879/). 
In this session I will demonstrate how we make better decisions by making results of work visible through tools that we built for the questions we have. The title evolved from a discussion with the organiser, [Sean Moir](https://www.linkedin.com/in/seanmoir/). 

What are we looking at, and what decisions do we make?
----

I showed some of these visuals to [Wouter Lagerweij](https://www.lagerweij.com/about/) on friday, and he asked what are you using these for? *Making better decisions of course* ;-) 

An example of a decision we made was to go slower. At first based on feedback from relatively standard 'tools' like tests, code coverage and linters, as well as roughly tracking how long it took us to make a change. We wanted to be able to detect earlier when our code goes the rails, so we can intervene in time. 


Below is a view we made last week, that I'll also discuss on Thursday in more detail. This *Microprint* shows all of the source files that we made in a fresh web frontend. 

![Thumbnails of files, longer chunks indicate longer files](/attachments/blogposts/2025/moving-bunnies-microprint-src.png)

What I like about this view, is that it shows the forest *and* the trees. Or some of it. I can click on a square and jump straight through to the source. I showed this view to Wouter, and we looked at one of the larger test files, the refactorings were quite obvious - introduce some builders, and see the tests become more glanceable.

This is at a point where the codebase is still relatively small, but when development is fast, you may easily miss things.

As thumbnail for this post, I used the same codebase, but now including `node_modules`, where the external dependencies and some of the development tooling live. 

![Thumbnails of files in src and node_modules, longer chunks indicate longer files](/attachments/blogposts/2025/moving-bunnies-microprint-node-modules.png)

Stephan and I saw quite a few large files. We read through the main production dependency, and accepted it for now. It is not big enough to be a worry. The other parts are probably in the developer tooling. Not ideal, but the interface with those is not that big. So something to keep an eye on, but nothing we need to act on now.

I have run this on some other codebases since I started writing this post on Friday. There are subtle differences that pop up from the microprints, inspecting the files with them and the discussion in a pair. Every week has some new insights. 

For Thursday's session we also made some dependency views - both what you'd expect with boxes and arrows, and others that I will go through. Hopefully we can get some participants up and running with glamorous toolkit, and they can code along. 

I love places like Swindon Developers Meetup and XP Days that make space for experimental sessions. So I hope you join me this thursday at 6:30PM in Swindon, or next week at [XP Days Benelux](/2025/09/01/extreme-vibe-coding.html).

What's next
-----
 
[Register for the session of course](https://www.meetup.com/swindon-software/events/311751879/). 
 Or if you can't make it, leave me a message here or on LinkedIn and I'll record a video separately.



