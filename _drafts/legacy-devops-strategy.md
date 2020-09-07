---
layout: post
title: Cargo cults and angry chaos monkeys
tags:
  - strategy
  - DevOps
author: Willem van den Ende
image:
---

A couple of days ago, Jamie Dobson and Simon Wardley did a back to back presentation on [Cargo Cults and mapping DevOps and serverless](https://www.youtube.com/watch?v=hlPEeDWHy34&feature=youtu.be). Great athmosphere in the virtual room. My son made a cameo apperance near the end. One can't strategists young enough.

This is a rich vein, it trigges a lot. So in the spirit of glorious [Dirt Roads](http://localhost:8082/2020/09/02/dimensional-planning.html), I'm going to limit myself to writing the things that resonated with me, amended with a few triggers.

Jamie prepared the presentation with a [blog post about Cargo Cults and Coconut Headphones](https://blog.container-solutions.com/cloud-native-transformation-and-wishful-thinking).

I was wondering if Jamie had seen the photos - he had, and put them in the presentation. I was also wondering how not to fall into Cargo Cults. I'm temped by 'the shiny' as much as the next person. I have learnt to try out 'the shiny' on my own first, and then only later contaminate others with it, but still, I don't mind failure but would rather do less of it sometimes.

After doing a short introduction on Wardley Maps, Simon talked about "No one size fits all" - choose specific methods (XP, agile, lean, ...) for specific contexts. Agile is becoming process over people. Then we made the case that DevOps will be the new legacy.

## Cargo cults

[Brittanica starts its' definition of a Cargo Cult as such:](https://www.britannica.com/topic/cargo-cult)
> Cargo cult, any of the religious movements chiefly, but not solely, in Melanesia that exhibit belief in the imminence of a new age of blessing, to be initiated by the arrival of a special “cargo” of goods from supernatural sources—based on the observation by local residents of the delivery of supplies to colonial officials

Richard Feynman translated this to science in 1974
>In the South Seas there is a cargo cult of people. During the war they saw airplanes with lots of good materials, and they want the same thing to happen now. So they’ve arranged to make things like runways, to put fires along the sides of the runways, to make a wooden hut for a man to sit in, with two wooden pieces on his head for headphones and bars of bamboo sticking out like antennas—he’s the controller—and they wait for the airplanes to land. They’re doing everything right. The form is perfect. It looks exactly the way it looked before. But it doesn’t work. No airplanes land. So I call these things cargo cult science, because they follow all the apparent precepts and forms of scientific investigation, but they’re missing something essential, because the planes don’t land.
— Richard Feynman

Societies with Cargo Cults are run by a Big Men, who perform impressive ceremonies to underline their greatness. Jamie gave several examples from Big Men going to a conference and coming back with advice that was only partially actionable. "Test all the things!" (asserts / expectations? what are those?)

## Cargo cult antidotes:

Practices are an emergent property of how you work, so blindly copying the practices might not be productive. You are probably familiar with companies copying the 'Spotify model'. It's worth watching Jamie explain the 'Netflix of the Netherlands'.

When going to a conference, don't blindly apply what you've seen, your context is different. Patterns put context first for a reason. Jamie mentioned the first Software Circus, and people adopting netflix practices like Chaos Monkeys without understanding or user need. I saw Kelsey Hightowers' brilliant Kubernetes demo, both highly entertaining, technically risque and solid content. I didn't adopt Kubernetes... After a successful launch, in which I spent far too much time creating a chain of Docker builds, I went cold turkey and forbade myself to use Docker for a year. That is how I 'missed' Kubernetes.

## How does one get sucked into a Cargo Cult

### Ad Men & Vendors

> For all our secular rationalism and technological advances, potential for surrender to the charms of magical thinking remains embedded in the human psyche, awaiting only the advertiser to awaken it.
Tim Wu, The Attention Merchants

This made me think about the ultimate Ad Men from the 80s - Amazing Discoveries. And lo and behold, there is video evidence of it. This is so over the top, no-one I knew bought anything from it, but one level away there were people who had gotten things from it.

The episode I found on youtube is about car polish. It is magical, and makes your car shiny! It's amaazing Mike! Note the comments of people who bought it and found it lacking. When I'd apply a Wardley map to polishing a car, not owning one would be an option, so you don't have to think about it. We delegate it to people who are specialists and do a much better job than we ever could. If you do it yourself, getting the basics right comes first. Then you maybe can do experiments. And basic can be very basic, as in use a soft spunge. I once had a (software) client who polished his brand new car with a metal scrubber. It had to be repainted. (He is extremely capable otherwise, everyone has their lapses).

### Intellectual gaps

I was about to write about Cargo Cult Marketing before this, and then Jamie said he fell for it when he started Container Solutions and overspent on marketing. I originally went to work for a consultancy, because I wanted my own company, but I knew nothing about marketing and sales.

I now know a bit about sales, and I don't think I can ever stop learning about marketing. Our current approach is do what we love, and deliberately cargo-cult small parts from companies that we like, keeping an eye on how well (or not) they work in our context. Then we share what we learn with our colleagues - we believe higher tides float all boats.

### Desperation

Choose life, choose a career. Choose XP, SAFE, Rational Rose, Kubernetes, AWS Lambda. I'm trying not to choose, and make conscious trade-offs instead, but there is always temptation and Fear of Missing Out (FOMO).

Or, as Jamie puts it further down in his Quick Checklist against magical thinking: "Am I moving too quickly? Only fools rush in".

Am I insecure, hero worshipping something?

### The Antidote

There are several antidotes, this one resonated most with me: **trusted advisers**. Talk to people who don't have an upside. Speak to people who you trust. We learnt the reverse from [Solution Selling](https://www.amazon.com/Solution-Selling-Creating-Difficult-Markets/dp/0786303158) - good clients listen to their peers, not to vendors.

We are all prone to wishful thinking, advertisers, soothsayers and translators. Move in small steps.

## On to Simon

Simon had another talk prepared, but switched to something else based on what Jamie presented - "carefully crafted presentation straight out of the window."

**No one size fits all**. Simon uses agile for reducing cost of change (XP), Lean/
off the shelf, focus on learning and reducing waste, focus on reducing
deviation.

Talking about specific methods for specific contexts caused Simon to be seen as a heretic at some (agile) conferences. Fact check: I haven't seen Simon burnt at the stake at the few agile
conferences I was - curious which ones these were. I've done back to back presentations with an early Prince II practitioner and worked with people who have been successful with Waterfall. So I'm all in on using appropriate methods. It is my inertia in having had my second and later successes with XP. The first one was flying by the seat of our pants and working closely with customers and users. Ah - "focus on user needs".

Doctrine: **Use Appropriate Methods**, **Think Small** (which links to Jamie's small steps and
Extreme Programming's baby steps), **Challenge Assumptions** (may have to drink poison if you do this too much), **Focus on User Needs**.

When a method is applied in the wrong context and it does not give the expected outcome, the default reaction tends to be "you are using the wrong parts of the process". This leads to process over people.

Simon also talked about DevOps being the New Legacy. We'll cover that in a follow up post.

## Further reading

In the run-up to this, Steve Freeman shared a few great resources. I'm still mulling over [Communities of Need versus Communities of Practice](https://theitriskmanager.com/2015/04/19/communities-of-need-community-of-solutions/). Chris Matts' talk is based around Geoffry Moore's Chrossing the Chasm. Food for follow up posts.

Jamie prepared the presentation with a [blog post about Cargo Cults and Coconut Headphones](https://blog.container-solutions.com/cloud-native-transformation-and-wishful-thinking). Inspiration for Jamies talk came from a presentation at the SPA Conference in 2006 by Dave Thomas that we both attended, included in Jamies post.

[Cargo Cult Science by Richard P. Feynman, 1974 - pdf](http://calteches.library.caltech.edu/51/02/CargoCult.pdf)

[Steve McConnell applied Cargo Cults to Software Engineering in 2000.](https://stevemcconnell.com/articles/cargo-cult-software-engineering/)
