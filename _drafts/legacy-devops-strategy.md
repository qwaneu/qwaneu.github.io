---
layout: post
title: Cargo cults and angry chaos monkeys
tags:
  - strategy
  - DevOps
author: Willem van den Ende
image:
---

A couple of days ago, Jamie Dobson and Simon Wardley did a back to back presentation on Cargo Cults and mapping DevOps and serverless. Great athmosphere in the virtual room. My son made a cameo apperance near the end. One can't strategists young enough.

This is a rich vein, it trigges a lot. So in the spirit of glorious Dirt Roads, I'm going to limit myself to writing the things that resonated with me, amended with a few triggers.

Simon: No one size fits all methods. Agile is becoming process over people.

Jamie prepared the presentation with a blog post about Cargo Cults.

[Brittanica starts its' definition of a Cargo Cult as such:](https://www.britannica.com/topic/cargo-cult)
> Cargo cult, any of the religious movements chiefly, but not solely, in Melanesia that exhibit belief in the imminence of a new age of blessing, to be initiated by the arrival of a special “cargo” of goods from supernatural sources—based on the observation by local residents of the delivery of supplies to colonial officials

I was wondering if Jamie had seen the photos - he had, and put them in the presentation. I was also wondering how not to fall into Cargo Cults. I'm temped by 'the shiny' as much as the next person. I have learnt to try out 'the shiny' on my own first, and then only later contaminate others with it, but still, I don't mind failure but would rather do less of it sometimes.



# Cargo cult antidotes:

Societies with Cargo Cults are run by a Big Men, who perform impressive ceremonies to underline their greatness.

Practices are an emergent property of how you work, so blindly copying the practices might not be productive. You are probably familiar with companies copying the 'Spotify model'. It's worth watching Jamie explain the 'Netflix of the Netherlands'.

When going to a conference, don't blindly apply what you've seen, your context is different. Patterns put context first for a reason. Jamie mentioned the first Software Circus, and people adopting netflix practices like Chaos Monkeys without understanding or user need. I saw Kelsey Hightowers' brilliant Kubernetes demo, both highley entertaining.  After

# How does one get sucked into a Cargo Cult

## Ad men

> For all our secular rationalism and technological advances, potential for surrender to the charms of magical thinking remains embedded in the human psyche, awaiting only the advertiser to awaken it.
Tim Wu, The Attention Merchants

This made me think about the ultimate Ad Men from the 80s - Amazing Discoveries. And lo and behold, there is video evidence of it. This is so over the top, no-one I knew bought anything from it, but one level away there were people who had gotten things from it.

The episode I found on youtube is about car polish. It is magical, and makes your car shiny! It's amaazing Mike! Note the comments of people who bought it and found it lacking. When I'd apply a Wardley map to polishing a car, not owning one would be an option, so you don't have to think about it. We delegate it to people who specialize in it and could do a much better job than we ever could. If you do it yourself, getting the basics right comes first. Then you maybe can do experiments. And basic can be very basic, as in use a soft spunge. I once had a (software) client who polished his brand new car with a metal scrubber. It had to be repainted. (He is extremely capable otherwise, everyone has their lapses).

## Intellectual gaps

I was about to write about Cargo Cult Marketing before this, and then Jamie said he fell for it when he started Container Solutions and overspent on marketing. I originally went to work for a consultancy, because I wanted my own company, but knew I knew nothing about marketing and sales. I know a bit about sales, and I don't think I can ever stop learning about marketing. Our current approach is do what we love, and deliberately cargo-cult small parts from companies that we like, keep an eye on how well (or not) they work in our context, and share what we learn with our colleagues - we believe higher tides float all boats.


## Desperation

Choose life, choose a career. Choose XP, SAFE, Rational Rose, Kubernetes, AWS Lambda. I'm trying not to choose, and make conscious trade-offs instead but there is always temptation and Fear of Missing Out (FOMO).

Or, as Jamie puts it further down in his Quick Checklist against magical thinking: "Am I moving too quickly? Only fools rush in".

Am I insecure, hero worshipping something.

## The Antidote

There are more, this one resonated most with me: trusted advisers, talk to people who don't have an upside. Speak to people who you trust. (we learnt the reverse from Solution Selling - good clients listen to their peers, not vendors.).

We are all prone to wishful thinking, advertisers, soothsayers and translators. Move in small steps.

# Simon had another talk prepared

But switched to something else based on what Jamie said. "Carefully crafted presentation straight out of the window.".

No one size fits all. Simon uses agile for reducing cost of change (XP), Lean/
off the shelf, focus on learning and reducing waste, focus on reducing
deviation. Fact check: I haven't seen Simon burnt at the stake at a few agile
conferences I was - curious which ones these were. (I've done back to back presentations with an early Prince II practitioner, and worked with people who have been successful with Waterfall. So I'm all in on use appropriate methods, it is my inertia in having had my second and later successes with XP. The first one was flying by the seat of our pants and working closely with customers and users. Ah - "focus on user needs").

# Further study:

In the run-up to this, Steve Freeman shared a few great resources. I'm still mulling over Communities of Need versus Communities of Practice. Chris's talk is based around Geoffry Moore's Chrossing the Chasm.

From the same time period, Dave Snowden was recalling his Cynefin presentation at XP2004.

"you are using the wrong parts of the process" leads to process over people.

Doctrine: use appropriate methods, think small (links to Jamies' small steps and
xp's baby steps), challenge assumptions (may have to drink poison if you do this
too much.). Focus on user needs.

Simon switches to DevOps the new legacy after next intro.

A utility: change something from exiting to boring.

"I don't tell them they're wrong, I just let them look at the map". Collectively visualizing things is powerful.

Compute from product to utility causes co-evolution.

Inertia ('traditional' -> Next generation)

Past stuff not thrown out of the window, but co-opted (as devops and now cloud native do with agile).

"Refactoring has financial value". Observability of financial flows is slowly growing.

Emerging architectural value of serverless is expected by the map, but isn't there yet.

Serverless and cloud don't save money, they allow you to do more, because you
are in competition. If you don't move, you are going to have to spend more and
more just to keep up.. 10-15 year transitions. Evolution is made of thousands of
diffusion curves. 2024 to 2029 serverless is becoming the new norm. "Digital
transformation is saying you've discovered the internet."

climatic pattern: no choice on evolution. No custom-built everything, we depend
on lots of components, otherwise it would not be possible.

Red Queen effect: the need to keep moving, just to stand still.

1. execs have no situational awareness
2. if you're starting a cloud journey now, wait a couple of years and do
   serverless then.
3. "they think they are busy people."
4. Do you see any companies anticipate serverless (I built the world first
serverless environment in 2005). Big consultants killed it. You need to get the
timing right. Amazon, like the chinese government are good at finding the right
time to industrialize.
5. Jamie: who is going to change serverless into a racket. Who is going to
   benefit? Boring serverless. How are providers of the functions going to make
   money.

Existential threat / forcing function. The only pattern we have seen in every
cloud native transformation.

Maps get discussions going. Whiteboards take the person(al) out of the
discussion, they move the discussion from the subject to the object. Simon /
doctrine: Have a common language / challenge assumptions. The people doing the
work know the problems, but narrative doesn't let the assumptions be challenged.
pre-mortem / post-mortem blameless.

Andy Nordgren -

Everett Rogers - diffusion. Moore uses the non-cumulative form . Each evolution
goes through hundreds or thousands of chasms.

[Cargo Cult Science by Richard P. Feynman, 1974](http://calteches.library.caltech.edu/51/02/CargoCult.pdf)
