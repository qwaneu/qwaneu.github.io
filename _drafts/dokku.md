# How to quickly deploy an experiment with Dokku

or Dokku - great for deploying blank pages, and then some
or Dokku - first impressions

00 Why Dokku
Say you have a web aplication that you want to quickly show to someone, or use
on multiple devices, and maybe keep around and show to a few more people, but
you don't know yet. You would like to protect details with https (Lets Encrypt)
and maybe quickly hide it behind a username/password (Basic Authentication)
while you figure out how to authenticate more users.

If you need at most one (virtual) server, then Dokku appears to be a great fit.
I've deployed a few experiments with it, and was very pleasantly surprised about
Dokku's lack of complexity.

00 Why does it matter

It is easy to get lured into complex setups recommended by cloud providers (link
to wordpress on AWS). I found even a simple looking BAAS can have its' own
complexities when e.g. trying to have a test environment, or quickly iterating
on my laptop. Dokku uses by now established technology: git, docker and nginx,
and does a good job of hiding the complexities of the latter two from you
without introducing unnecessary risks.

It also comes with nice surprises like zero-downtime deployments with very little work.

00 How does it work
Dokku lets you deploy with a `git push` of your experiment to a (virtual) server
of your choosing. I chose Hetzner for this experiment, they have used 100% green
energy long before the big cloud providers, their service has always been swift
(when necessary, which isn't often). And their VPS's are priced well below other offerings.

The basic flow, as illustrated by the animation below is, to tell dokku to
create an app, tell Dokku what components it ocnsists of in a Procfile (mine is
just one line) and optionally a .buildpack if the application is non-standard
(mine was haskell, so I needed one). push the repository to Dokku and wait for
it to build. I learned after the basic tutorial that providing an FQDN in this
step helps to add Lets Encrypt in the next step.

Let's encrypt can be added after that (Not before), it is one command, you only
need to provide an e-mail address. Basic Authentication is also one command.

I recommend going through the tutorial that lets' you set up an example Rails
application, even if you don't care about rails. I was pleasantly surprised how
easy it was to add PostgresQL to an application. My experimental application was
with sqlite, because I thought that would make deployment easier, but Dokku
makes postgresql so easy that I may be wrong about that (including a facility to
back up the database to an S3 or compatible bucket regularly).

00 Bonus: Cheap zero-downtime deployments

I was pleasantly surprised to find that with adding yet another text file -
CHECKS - dokku can do fast zero downtime deployments. You need to tell dokku how
long to wait before running a health check, how many retries to do and how long
,and what the health check (a GET request to an http endpoint in my case) should
be, and what should be in the result.

A checks file for a haskell application I deployed looks like:

@@ Checks

While haskell build times can be long, application startup is well under a
second, so we don't have to wait long for the health check.

00 Storage took a bit longer to figure out

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

0 Conclusion: Dokku is a keeper
