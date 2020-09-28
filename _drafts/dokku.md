---
layout: post
title: Deploy a blank page with Dokku
tags:
  - continuous delivery
  - devops
  - architecture
author: Willem van den Ende
image: /attachments/blogposts/2020/caleb-russell-intimidating-containers.jpg
---

So you want to quickly deploy a small experiment to production. How do you do
that? [Dokku](http://dokku.viewdocs.io/dokku/) is one way of doing that. Here
are my first impressions of it. Dokku lets you deploy an application with a simple `git push`, requiring only one or two lines of configuration in the application's git repository. Dokku was a lot easier to set up than I hoped, and it was kind of fun!

The pattern we apply here is:

<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2020/deploy-empty-page.png" alt="deploy an empty page">
  </div>
  <div>
    <p><strong><a href="/2020/09/03/deploy-a-blank-page.html">Deploy a blank page to production</a></strong>, so that you know all the steps
necessary to deploy the next time. This way you can start iterating on
features together with actual users from day one, and speed up the way you
deploy with each iteration.
    </p>
  </div>
</div>

Deploying blank pages serves a dual purpose. It is useful to quickly share early development. It is also a good way to experiment with ways of deploying.

## Why Dokku
What is the user need here? I started developing a flash card application to help me remember programing constructs and library functions. This worked well enough on my laptop, but I wanted to use it on my phone to quickly review questions on the go as well.

I didn't want to lose quick local development, and I didn't want to write elaborate Terrorform scripts either. I also didn't want a fully manual deployment that I would forget the working of in due time. Options discarded:

* BAAS (Backend As A Service). I've used one extensively. They seem to come without SQL, and fast iteration after initial development is still something that requires a fair amount of work.
* Elaborate cloud deployment with e.g. Terraform. More complicated than needed
* Manual deployment on a VPS. It would work at this scale, but I would forget what I did, and is not that repeatable.

It turns out that Dokku is not only more repeatable, but also faster than manual
deployment. It boils down to useful primitives, good documentation and choices that are pre-made.

For development I settled on a glorious little monolith. Inspired by
Marc and Rob, I chose [SQLite instead of](https://www.sqlite.org/whentouse.html)
`fopen()`. As a development language I chose Haskell. Because I missed it, and there are some interesting takes on backend development that originat from it. Based on the feedback I got from deploying with Dokku, I switched frameworks. More about that later.

For a first deployment I would like to protect details with https (Lets Encrypt)
and quickly hide it behind a username/password (HTTP Basic Authentication)
while I figure out how I want authentication and authentorization to work properly.

If you need at most one (virtual) server, then Dokku appears to be a great fit.
I've deployed a few experiments with it it now, and was very pleasantly surprised about
Dokku's lack of complexity.

## Why does it matter

It is easy to get lured into complex setups recommended by cloud providers (link
to wordpress on AWS). I found even a simple looking BAAS can have its' own
complexities when e.g. trying to have a test environment, or quickly iterating
on my laptop. Dokku uses by now established technology: git, docker and nginx,
and does a good job of hiding the complexities of the latter two from you
without introducing unnecessary risks.

It also comes with nice surprises like zero-downtime deployments with very little work.

## How does it work
Dokku lets you deploy with a `git push` of your experiment to a (virtual) server
of your choosing. I chose Hetzner for this experiment, they have used 100% green
energy long before the big cloud providers, their service has always been swift
(when necessary, which isn't often). And their VPS's are priced well below other offerings.

The basic flow, as illustrated by the animation below is, to tell dokku to
create an app, tell Dokku what components it consists of in a `Procfile` (mine is
just one line) and optionally a `.buildpack` if the application is non-standard
(mine was haskell, so I needed one). push the repository to Dokku and wait for
it to build. I learned after the basic tutorial that providing an FQDN in this
step helps to add Lets Encrypt in the next step.

Let's encrypt can be added after that (Not before), it is one command, you only
need to provide an e-mail address. Basic Authentication is also one command.

I recommend going through the tutorial that lets' you set up an example Rails
application, even if you don't care about rails. I was pleasantly surprised how
easy it was to add PostgreSQL to an application. I chose to start
with sqlite, because I thought that would make deployment easier, but Dokku
makes postgresql so easy that I may be wrong about that. Creating a database and adding it to an application is just two Dokku commands away. It also includes a facility to
back up the database to an S3 compatible bucket regularly.

## Bonus: Cheap zero-downtime deployments

I was pleasantly surprised to find that with adding yet another text file -
CHECKS - dokku can do fast zero downtime deployments. You need to tell dokku how
long to wait before running a health check, how many retries to do and how long
,and what the health check (a GET request to an http endpoint in my case) should
be, and what should be in the result.

A checks file for a haskell application I deployed looks like:

@@ Checks

While haskell build times can be long, application startup is well under a
second, so we don't have to wait long for the health check.

## Storage took a bit longer to figure out

For my test app, I needed to change two things:

- read the PORT environment variable
- check if there is a /storage directory

The Dokku storage plugin @@link allows you to specify a directory on the host
that will be mounted in the docker container. An Sqlite database is just a file (SQLite i compeetes with `openn`).

A bit would be: an hour or so, as opposed to lets encrypt and basic auth that took minutes. Not bad at all.

the port and storage were also good feedback about the two sets I based my
experiment on. Yesod is batteries included, but figuring out how to specify a
Port and storage was a pain - the scaffold has a lot of code to go through.
Servant doesn't do much configuration out of the box, so a directory check and
environment variable read were quickly added (after searching for the
appropriate API calls).

## Conclusion: Dokku is a keeper

Dokku makes it easy to deploy with a single `git push` with a provider of your choosing. VPSes are cheap and plentiful. Dokku abstracts docker containers away without introducing unnecessary risks. If you need more than a build on git push can provide, you can always add an external continuous delivery pipeline that builds a Docker container, and push that to a Dokku host later.

![Man looks up at large stacks of shipping containers, he is almost surrounded by them.](/attachments/blogposts/2020/caleb-russell-intimidating-containers.jpg)
Docker containers can be intimidating. <span>Photo by <a href="https://unsplash.com/@calebrussell?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Caleb Russell</a> on <a href="https://unsplash.com/s/photos/shipping-containers?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>

# Further reading:

- [Terrorform was a red dwarf episode](https://en.wikipedia.org/wiki/Terrorform)

-- ad blurb:
Want to improve your deliveries, make them flow more continuosly? We deliver software large and small, and help other people do it. (talk to us | service link)
