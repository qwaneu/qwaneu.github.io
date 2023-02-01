---
layout: post
title: Stabilization periods, a powerful incentive for improvement
tags:
- agile
author: Willem van den Ende
image: 
---

# introduction

Returning to our three loops, this means that at least part of QA is not part of the technical excellence loop, but part of the 'working together' loop. Things to watch for are 'stabilization periods'. We then ask how long the stabilization period is. And then sometimes find out there is more than one stabilization period, before and after the release, as well as ongoing fixes at clients' side.

When one produces machines for 24/7 production, and does SAFe, it can look like this:

4 month cycle

1 week inception
3 weeks stabilization from previous cycle
6 weeks development of new capabilities (1: these are often called features, but it might also be the ability to manufacture with increased precision or throughput)
2 weeks code freeze and 'QA' (another word for stabilization)
1 week reflection



# Can we fix this by sheer technical excellence?

Some of what we see is caused by people working in isolation, inside the teams. In the 6 weeks of development the developer, working heroically on their own, will be pulled away from 'their feature' when something goes wrong at a client side, and other support tiers can not fix the problem. The developer will put their work aside (if you are lucky in version control, but it also hapens that it stays on 'their machine', making this process largely invisible to the management chain outside the team, and even for direct colleagus, as the fish are the last to be aware of the water).

But I digress. The consequence of stepping away from the work, focusing on something else and coming back, is lost context. We can improve this, by getting better at baby steps, making small commits, doing branch by abstraction so the work can continue when we get back, and others can see what is going on. But we would still have a context switch. It would make our work more visible, it would help us go faster, but sitll others will be waiting for our hand-offs.

Michel Grootjans made a simulation and a video in which he uses it to demonstrate the effect of hand-offs within a team. 

Michel Grootjans has a video where he shows a model of a group of individuals, where when the individuals become multi-skilled (he calls this a full stack developer for the purpose of the video) the wait time reduces because of fewer handoffs. It is well worth watching, but requires focus.

Often what we see is worse. Michel has, in his video, the QA person as part of the team. Often we still see this happening outside of the team.

# can we fix this with un-interruptible sprints inside of a longer release cycle?

Maybe, if your sprints are short enough. If the sprints are longer than changes in your environment, you will loose goodwil with your external clients, at best. At worst, the organization can not perform as desired and will cease to exist.

So one or two week sprints might be a start. This forces communication between the team members and stakeholders on a regular basis, and will encourage to find smaller things to deliver (once again, see branch by abstraction). Maybe slightly less urgent work then can be turned into regular work, and there is a regular moment to reflect on the urgent work, and what can be done to prevent it from happening, if anything.

Write about firefighting groups, or separate post?

# The three loops are sometimes more separate than they need to be
