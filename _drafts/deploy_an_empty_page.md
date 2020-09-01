---
layout: post
title:  Deploy a blank page to production
author: Willem
---

## Summary

Continuous delivery is valuable, but where do you start? At the start of
a greenfield development you have no software, and if you had any
software, you would not know how to put it into production.

Deploy a blank page to production, so that you know all the steps
necessary to deploy the next time. This way you can start iterating on
features together with actual users from day one, and speed up the way you
deploy with each deployment/iteration.

## Context

You are or your organisation is afraid to ship, and you don't know where to
start. On the one hand you have no software to deploy, on the other hand, you
don't know how to deploy it.

### When deployment is done by someone else

Even though continuous delivery pipelines are becoming more common, this still
happens.

Deployment of websites and applications is outsourced to a
different department or company. Deployments happen by handing over a
packaged version of the application (e.g. a virtual machine, a .jar
file, or a zip file with sources and other assets in case of an interpreted language like
php) together with a document detailing the steps needed to deploy the
software for operations personel.

Releases happen infrequently and are error prone. This often leads to requests
to deploy less frequently. This leads to development teams that are out of sync
with delivery - e.g. a team can deliver changes weekly or bi-weekly

### When you start from scratch

Prefer a technology stack that comes with simple, scripted deployment out of the
box, or that makes deploymen extremely straightforward. Create that blank page, or 'hello world' API and deploy.

Examples would be Heroku, AWS Amplify, Google Firebase, or if you want to self-host, Dokku.

## Resulting Context

Your team, your stakeholders, and operations people, testers and anyone
else involved know what is involved in a release, so there is less fear
of doing it again, and everyone can improve something for the next
release. Since you start small (with nothing), you can ship as often as
you want. Do the next release quickly after the first one, so you can
get into a rythm, reduce the chance of errors as well as speed up
rollback or recovery in case it is needed.

When you ship a small change, it's easy to find the ones who know how to handle
anything that might go wrong. Errors that are made are likely to be smaller,
with less impact.

### History

This is a (proto-)pattern we've used in various contexts since at least 2001, when we
started doing continuous integration. We probably stole this from
somewhere else (probably eXtreme Programming explained 1st edition by
Kent Beck, the
[c2 wiki](http://wiki.c2.org)  or the XP mailing list).
