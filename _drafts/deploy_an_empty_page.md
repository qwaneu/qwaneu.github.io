---
layout: post
title: Deploy a blank page to production
tags:
  - continuous delivery
author: Willem van den Ende
---

Continuous delivery is valuable, but where do you start? At the start of
a greenfield development you have no software, and if you had any
software, you would not know how to put it into production.

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/deploy-empty-page.png" alt="deploy an empty page">
  </div>
  <div>
    <p><strong>Deploy a blank page to production</strong>, so that you know all the steps
necessary to deploy the next time. This way you can start iterating on
features together with actual users from day one, and speed up the way you
deploy with each iteration.
    </p>
  </div>
</div>

## Context

Either you or your organisation are afraid to ship, and you don't know where to
start. On the one hand you have no software to deploy, on the other hand, you
don't know how to deploy it.

### When deployment is done by someone else

Even though continuous delivery pipelines are becoming more common, this still
happens.

Deployment of websites and applications is outsourced to a
different department or company. Deployments happen by handing over a
packaged version of the application (e.g. a virtual machine, a .jar
file, or a zip file with sources and other assets) together with a document for ops detailing the steps needed to deploy the software.

Releases happen infrequently and are error prone. This often leads to pressure to deploy less frequently. This leads to development teams that are out of sync
with delivery - e.g. a team can deliver changes only once a week or once every two weeks.

### When you start from scratch

Prefer a technology stack that comes with simple, scripted deployment out of the
box, or one that makes deployment extremely straightforward. Create that blank page or the 'Hello world!' API and deploy it.

Examples would be Heroku, AWS Amplify, Google Firebase, or if you want to self-host, Dokku.

## Resulting Context

Your team, your stakeholders, and operations people, testers and anyone
else know what is involved in a release, so there is less fear
of doing it again. Everyone can improve something for the next
release. 

Since you start small - with nothing - you can ship as often as
you want. Do the next release quickly after the first one, to get into a rythm, to reduce the risk of errors, and to speed up
rollback or recovery in case it is needed.

When you ship a small change, it's easy to find the ones who know how to handle
anything that might go wrong. Errors that are made are likely to be smaller,
with less impact.

## History

This is a (proto-)pattern we've used in various contexts since at least 2001, when we started doing continuous integration. We probably stole this from
somewhere else, probably from [eXtreme Programming explained 1st edition](https://www.amazon.com/Extreme-Programming-Explained-Embrace-Change/dp/0201616416) by
Kent Beck, the
[c2 wiki](http://wiki.c2.org) or the XP mailing list.

<aside>
  <h3>Learning how to get software to production often & early is hard.</h3>
  <p>Get your software flowing! We have made all the mistakes for you.</p>
  <p><div>
    <a href="/consulting">Learn more about our mentoring & consultancy services</a>
  </div></p>
</aside>
