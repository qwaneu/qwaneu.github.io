---
layout: post
title: Product Hurricane Maps to take into account tech debt when roadmapping 
tags:
- technical debt, patterns, agile, product development, continuous delivery
author: Willem van den Ende
image: /attachments/blogposts/2022/2018-Steve-Freeman-Product-Hurricane-Map.png
---


Recently we got asked is "How do we (as a development team or larger group) 'sell' technical debt to stakeholders?".

Context
========

A team has a shared understanding of the importance of keeping quality
(in the broadest sense) high, and technical debt low. The team also has
a shared understanding of how much it would cost to bring components they use up to scratch.
Several of the components need extensive (re)work when used.  The team has difficulty communicating cost/benefits of improved quality to stakeholders when discussing
timelines for product roadmaps.


Solution
=========

Produce a product hurricane map, setting out features on the product
roadmap against the components needed for each feature, and the effort
needed to improve these components.

The team and stakeholders negotiate on which features are (not) in scope
and when. Stakeholders do not get the option to negotiate the extent to
which technical debt is adressed.

Resulting context
==================

Reducing number of defects, and code that is easier to work with leads
to smoother flow for subsequent features, and eventually faster
delivery, with fewer issues when the feature is delivered to the users. Stakeholders can make informed cost/value decisions.

Mechanics
==========

We learnt about product hurricane maps from a presentation by Steve Freeman. A hurricane map can look like this (with Steve on the left of it):

![Steve Freeman presenting a product hurricane map in 2018, the map is a table, which is reproduced in text further down in this post.](/attachments/blogposts/2022/2018-Steve-Freeman-Product-Hurricane-Map.png)

components horizontally, with number of days needed to remove technical
debt listed below each. Items for the roadmap (could be in the
granularity of stories, could also be epics). The color of each feature
indicates the amount of work. Steve
Freeman uses tick boxes for
each of the components - you could also copy the number of days for each
component in the cells, and add the number up at the end. (This does not
take order in the roadmap into account - that complicates things, maybe
hence the tickmarks - that just indicates \'needs this component\').

Steve uses days with rough granularity (20, 40 not 40 and 41). We are
always careful to not use days, because this may turn into a commitment
instead of an estimate. But it may make it easier to coordinate with
other groups\' roadmaps.

Let\'s put the example map in our own table,so we can have a play with
it:

<table>
<thead>
<tr class="header">
<th>Stories (Backlog)/ Component</th>
<th>Aldgate</th>
<th>Bank</th>
<th>Chesham</th>
<th>Debden</th>
<th>Farringdon</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Technical debt (days to remove)</td>
<td>20</td>
<td>500</td>
<td>2</td>
<td>100</td>
<td>10</td>
</tr>
<tr class="even">
<td>Fast input for frequent users</td>
<td></td>
<td></td>
<td>✔</td>
<td></td>
<td></td>
</tr>
<tr class="odd">
<td>Reconciliation for sales staff</td>
<td>✔</td>
<td></td>
<td></td>
<td></td>
<td>✔</td>
</tr>
<tr class="even">
<td>Easy input for infrequent users</td>
<td></td>
<td></td>
<td>✔</td>
<td></td>
<td></td>
</tr>
<tr class="odd">
<td>Scale to 100x customers</td>
<td>✔</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr class="even">
<td>Chinese version</td>
<td></td>
<td></td>
<td></td>
<td>✔</td>
<td></td>
</tr>
<tr class="odd">
<td>Separate hosting for USA</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>
<p>The only feature we can get without addtional work is "Separate hosting for USA". Everything else involves work. Luckily nobody needs the "Bank" component that would take 500 days to bring up to standard. "Bank" will be left alone, unless it needs e.g. security updates (leaving components 'alone', and deciding when to perform upgrades of its' dependencies is a separate topic).</p>
<p>If we replace the check marks by numbers, we can see the totals for each item in the backlog (could be stories, epics or whatever you want to call future features):</p>
<table>
<thead>
<tr class="header">
<th>Stories (Backlog)/ Component</th>
<th>Aldgate</th>
<th>Bank</th>
<th>Chesham</th>
<th>Debden</th>
<th>Farringdon</th>
<th>Total</th>
<th></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Technical debt (days to remove)</td>
<td>20</td>
<td>500</td>
<td>2</td>
<td>100</td>
<td>10</td>
<td>662</td>
<td></td>
</tr>
<tr class="even">
<td>Fast input for frequent users</td>
<td></td>
<td></td>
<td>2</td>
<td></td>
<td></td>
<td>2</td>
<td></td>
</tr>
<tr class="odd">
<td>Reconciliation for sales staff</td>
<td>20</td>
<td></td>
<td></td>
<td></td>
<td>10</td>
<td>30</td>
<td></td>
</tr>
<tr class="even">
<td>Easy input for infrequent users</td>
<td></td>
<td></td>
<td>2</td>
<td></td>
<td></td>
<td>2</td>
<td></td>
</tr>
<tr class="odd">
<td>Scale to 100x customers</td>
<td>20</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td>20</td>
<td></td>
</tr>
<tr class="even">
<td>Chinese version</td>
<td></td>
<td></td>
<td></td>
<td>100</td>
<td></td>
<td>100</td>
<td></td>
</tr>
<tr class="odd">
<td>Separate hosting for USA</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td>0</td>
<td></td>
</tr>
</tbody>
</table>

What we can see here, is there is a total of 662 guestimated days of
work to address technical debt, but since Bank is not needed in the near
future, if we were to schedule all of the features it is about 132 days
(if we adress Chesham and Aldgate once, we don\'t have to do that work
again.).

If you don\'t want to discuss days, you could also consider traffic
lights (or 1 to 3 in a spreadsheet) with small, medium, large to
correlate quality of the component and their size. Hat tip Lilian
Nijboer.

Why is it important
===================

Stakeholders should care about tech debt, not the details, but the costs
of having it, and the benefits of resolving it. Tech debt, defects and
other symptoms of poor quality lead to [failure
demand](https://beyondcommandandcontrol.com/failure-demand/). Focus on
delivering value is lost, lead times are longer than necessary,
schedules become unpredictable.

It may be hard to envision success. But it is possible. When we had a
chat with a long-term client, and they asked for advanced training, we
suggested a training on legacy code. Their response was: \"We don\'t
have legacy code anymore\". They worked for several years addressing
quality in their components, and got to a stage where work was
relatively smooth.

Exceptions
==========

Improving quality in a growing system is not optional. Otherwise (link
to gardeners\' dilemma by DJ), productivity will tend to zero. Maybe
perhaps, when you think really really hard, in exceptional circumstances
such as when a component is End-of-Life and soon to be replaced,
improvements can be left. But stakeholders have to take into account the
increased friction resulting from using such a component.

What to do when the team does not yet have consensus on tech debt for their components?
=======================================================================================

Spend some time reaching consensus. [Quality
Views]( https://blog.colinbreck.com/reflections-on-using-quality-views/#fn1) By Colin Breck can help - colour an
architecture diagram of components by tech debt, and track over time.
The hurricane map leaves out the relations between the components. Quality views leave out the relations between the features.

Further viewing and reading
===========================

The video we based this post on: [Steve Freeman: A Bluffer\'s Guide to
Technical Debt for other people - SCLConf 2018 -
YouTube](https://www.youtube.com/watch?v=jXpJVsv3Iec). This has a lot more
detail - we focused just on the visualization here. Steve discusses Skills Liquidity for instance, which can help smoothing out flow by being aware of skills the team has and can develop.

Thank you for reading all this far. This is just a quick post, because we find hurricane maps useful and wanted something in writing to share. Your feedback would be most welcome. 

Thanks to Rob Westgeest, Marc Evers and Lilian Nijboer for feedback on drafts (and Rob for referring to the video).
