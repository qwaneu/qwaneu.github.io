---
layout: post
title:  Software Circus conference report
author: Willem
---

Last week Rob, Marc and I went to [Software Circus](http://softwarecircus.eu/), a
new conference on programmable infrastructure.

Here's a brief summary of the sessions I particularly enjoyed. Photos
don't seem to be up yet, but this one sums up at least part of my
experience: great coffee and fresh mint tea, sunshine and a beach at a
canal in Amsterdam (the beach, unfortunately is just off to the right of
the picture).

![View on a canal in Amsterdam over some fresh mint tea](/attachments/blogposts/2015/software-circus-canal.jpg)

And some interesting sessions, in chronological order.

### Prometheues - metrics that scale down and up

I've used or tried to use several metrics solutions, most of them seem
fine if you scale up (i.e. you can have someone maintain them), and most
were not very easy to set up (Riemann, Statsd / Graphite). Probably
because of many moving parts. E.g. storing your data is separate from
showing it, which is separate from collecting it. That is great once you
know what you're doing, but for getting started, not so much.
 
[Robert Jacob](http://softwarecircus.io/robert-jacob/) ran a workshop on
wednesday introducing [Prometheus](https://github.com/prometheus). That (wonder!) worked out of the box,
I had it set up monitoring my freshly baked haskell web service in an
hour or so. Prometheus has support for efficiently pushing data from a
server or service when there is a lot of it, but also supports getting
started by just publishing a simple web page on '/metrics' with some
text explaining the metrics provided. There are a number of exporters,
e.g. for getting [statistics from
nginx](https://github.com/discordianfish/nginx_exporter) or a host
machine.

If you want to have a look, [this
prometheus review](http://rancher.com/docker-monitoring-continued-prometheus-and-sysdig/)
looks like a reasonable introduction.

### No slides, no process, no projects, no premises.

[Adrian Cockroft](http://softwarecircus.io/adrian-cockcroft/) was gutsy
enough to deliver an off the cuff speech, mostly based on audience
questions. This gave us some insights on how Netflix designed work and
systems to support a particular culture. Not exactly sure what to do
with it yet.

### How to automate your infrastructure

[Arnoud Vermeer](http://softwarecircus.io/arnoud-vermeer/) gave some
brutally honest insights in what goes on in running, and trying to
automate, dispersed data centres with a varied infrastructure. Not directly
appliccable to what we do on a day-to-day basis, but interesting to see
what goes in the kind of infrastructure that all of us use on a daily
basis. 

Some takeaways from this: 

- There is a computer in your computer in your
computer, and everything else is a computer too. The power supplies have
a (hard to interface with) computer, there is a computer inside your
server to provide it with firmware updates.
- The distinction between Dev and Ops is as it's ever been. Yes,
  there are people building servers in to racks, everything else is much
more enjoyable as a script. I still occasionally run in to people who
want to 'own' the hardware of their server in a data centre somewhere,
so they can go there at night to troubleshoot. I don't, and it looks
like data centre operators also like sleep. Hence, script all the
things.

### Unikernels for fast and secure immutable infrastructure

[Anil Madhavapeddy](http://softwarecircus.io/anil-madhavapeddy/) gave an
introduction to unikernels that was both hands-on and mindblowing. This
talk had a very high information density. At least for me, I had vaguely
heard about unikernels before, this made it a lot more concrete. 

Unikernels allow you to build tiny virtual machines that only contain
the minimal kernel and OS support that an application needs. This means
you can e.g. build a VM in just 24MB, I don't expect to find a linux distribution
of that size. If your service doesn't require a file system, let it use
a kernel without file system support, and an OS without the 'ls' command
etc.

The second half of the talk showed a distributed storage layer based on
git (the storage format, not necessarily the tooling because of
performance). The example was a distributed log that could be merged
back to a single git repository, e.g. on a developers' laptop. 
 
### Rediscovering the command line

The more I use unix, the more I appreciate its' tools and how they fit
together. Unix allows you to treat the internet (or github) as a giant
scrapheap, and assemble solutions made from what ever programming
language the developers who made the tool feel like. Think about it:  [Command-line tools can be 235x
faster than your Hadoop
cluster](http://aadrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html).

[Steve Freeman](http://softwarecircus.io/steve-freeman/) ranted
enthusiastically about how they built a system to index and filter a
large set of PDF documents from unix pipes and filters instead of e.g.
hadoop, and how the resulting solution was much smaller and simpler than
what they had planned initially.

I find that Docker encourages command line tools even more. If you want
to use your favorite programming language or tool, you have to make the
conscious decision to include it in a Dockerfile. Using `bash`, `cut`,
`jq` or `make`
is then a lot easier, because those are often already present, and don't
require a separate dependency management solution (looking at you,
Python and Ruby).

Steve also made the argument, that a lot of unix tools were written at a
time when computers had significantly fewer resources, and are therefore
much more highly optimized than e.g. hadoop. 

Sometimes I think spinning up virtual machines is just too easy these days. If money isn't an object, at least take into consideration the amount of power and water (for cooling) data centres consume. Then look at `xargs` and friends, and consider how satisfying it can be to get a result quickly.

### Barbeque and nibbles

Not a session per se, but deserves a mention. Catering for 200+ people
is not easy, and my expectations for food at conferences is sufficiently
low. I was pleasantly surprised. The food was very good, the meat not
scorched, and [Roest](http://www.amsterdamroest.nl/), which means Rust
in English, provided very nice nibbles between the main meals. Food for
thought. 

### Inspiring the Next Generation to Runaway and join the circus

I thoroughly enjoyed [Diane Mueller](http://softwarecircus.io/diane-mueller/) 's talk on encouraging more people of all ages to tinker with technology. This  includes, but is not limited to, programming. 

I saw some chatter about if kids need role models to start programming.
I didn't have any, and I don't know many of my colleagues who did. Diane
suggested a few things. The one that stuck with me most: [provide a
magical experience](http://www.getmakered.com/). The idea that you can
understand, and modify, how everyday devices work is foreign to many
people. Often to me it is as well, although I'm tempted to [build a
better rat trap](http://makezine.com/projects/make-43/smart-rat-trap/).

Making a caravan as a maker space was another interesting one, as going
into a makerspace can be daunting for a first time. They combine it with
arts and crafts caravans to form... a circus!

Have a look at [Get Makered](http://www.getmakered.com/) to get an
impression of their setup. 

### From Theory to Production: Managing Applications at Scale

[Kelsey Hightower](http://softwarecircus.io/kelsey-hightower/) mixed
a hands-on demonstration of Kubernetes with rounds of tetris to show the effects of naive resource management in clusters. This talk managed to get across what I didn't understand from other sources - in what circumstances distributed configuration management, service discovery and application scheduling makes sense. The demo clearly showed how it works in practice.

### Build pipelines as code

[Florian Sellmayr](http://softwarecircus.io/florian-sellmayr/) demonstrated [LambdaCD](https://github.com/flosell/lambdacd) a Continuous Integration solution build with and configured (i.e. programmed) through Clojure. I liked how a build pipeline can be succinctly expressed in code. 

What I'm not convinced about, is that the CI server now becomes another stack to manage. Getting started looks innocent enough "just start Leiningen and it will take care of the rest", but over time you'll need to update Leiningen on your CI server(s), make sure the right versions of everything are present etc. And whenever you make a modification, the build server has to restart. I found reloading in Clojure to not be very reliable. Yes, it works a few times, and then either fails for mysterious reasons or you find yourself calling a function that is deleted in source, but of course still present in the VM. 

And if the shiny new function you just wrote breaks, it breaks CI for
everyone. So maybe the CI should be CI'd? Meta Meta. 

The other thing I found in production, is that source code can be a good deal less discoverable than a UI. After some experience with [Bake](http://neilmitchell.blogspot.co.uk/2014/10/bake-continuous-integration-system.html), in Haskell, I found that it always took us some time to understand what it is we wanted to do, even with things I can do with Jenkins (which has its own problems, but at least a UI and plugins to browse through) in a heartbeat.

With Bake I found myself deploying a 'beta' CI in a blank VM. Which was
easy enough to do, but doesn't feel very fluid.

Sometimes I think CI is not nearly as simple as it could be. [Hilverd
Reker](http://softwarecircus.io/hilverd-reker/) and [Steve
Freeman](http://softwarecircus.io/steve-freeman/) described their
_meta-pipeline for generating continuous delivery pipelines for
microservices_. Having 'just' 4 people maintaining a CD system for a
hundred developers is not that much, but still, a whole team just to be
able to build software continuously. I don't have answers here, but it
does make me wonder.

So there you have it. Software Circus. New answers, new questions. Not
too shabby for a conference that was put together in a few summer months. Thanks Jamie, Mark and everybody else for making it quite
enjoyable!
 

<a href="/feed.xml" class="feed">Subscribe to QWAN's feed - Systemic Thinking for Sustainable Development</a>

<div id="disqus_thread"></div>
<script type="text/javascript">
  var disqus_shortname = 'qwanblog'; // required: replace example with your forum shortname

  /* * * DON'T EDIT BELOW THIS LINE * * */
  (function() {
   var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
   dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
   (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
   })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
