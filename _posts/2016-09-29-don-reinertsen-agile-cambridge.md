---
layout: post
title:  Software engineering in a digitized world
author: Willem
image: /attachments/blogposts/2016/DReinertsen2007a_400x400.jpg
---

A liveblog of Don Reinertsens' Agile Cambridge keynote

## Summary

* Don't fear variability
* Buffer with care
* Focus on payoff functions, not probablities
* Buy information in small batches
* Think like a smart gambler
* Create options to recover from bad outcomes quickly and create good ones
* Value good economic choices over conformance

## Liveblog continues

"Have you received messages telling you that variabilty is bad?"

There is a tendency in software development to think in binary - either hate variability of love it.

If I have high variabilty going into the black box, I have low projects coming out.

There is a long war on variability:

* Zero defects
* repeatability in CMMI
* Lean Manufacturing
* estimating methods of Scrum
* Lean Kanbans' interest in Statiscal Process Control

"But as we know, not all wars are based on sound reasoning"

## Today we like to minimize variability

under commit, pad buffers to reduce variability.

Six Sigma - make choices that have low variability. Innovation introduces uncertainty in outcomes, uncertainty raises variability. It was introduced in 3M. 3M tracked which products were generating revenue. After Six Sigma, annual reports showed a drop from 60 to 40 to 30 percent, and then they stopped reporting, until ... (McErnie?) left.

### Hiding variability with a buffer

Don't commit to the expected return, make a different commitment. What currency did you use to pay for that reduction in variability? Ask what it is worth buying the reduction, what did you pay for it? You paid for it with cycle time. There really is an advantage in having a product in the market that nobody else has.

## Aysmmetric Payoffs and Option Pricing

Expected price / Payoff vs price / Expected payoff.

"Everything in manufacturing applies anywhere else in the world" (not Don's opinion, paraphrasing some consultants who favor manufacturing practices for everything).

## The economic view

* Variability is not good or evil.
* Has different effects depending on economic payoff function.

## Are other approaches possible

## Nassim Taleb

Most relevanti book of his for product development: Anti-fragility, not a terribly well organised read, but has some important ideas.

A fragile system produces worse outcomes when you perturb it. The more you perturb it, the worse it gets.

If you looked at Microsoft products in the 90s, they would have 20 revlevels of dlls that had dependencies on all other dlls. it was intrinsically an untestable system. What they evented decided to do was realise that most of the cases would never happen in the real world, so they shipped a few million beta copies and see what feedback came back.

Anti-fragility behaves like options: increase value by more perturbation.

### How do we create Anti-Fragility

Taleb suggests it is useful, but does not give much guidance on how to get there. You are already doing some things in some form. The ingredients are in the kitchen, you are just not using them yet.

#### Can we change payoff functions?

Fast feedback reduces loss from bad outcomes, fast feedback enables exploitation of good outcomes. Venture capitalists exploit this. How do I end up amplifying the payoffs on the positive tail, while reducing the costs on the negative tail?

### Creating asymmetries

* Create fast feedback
* Enable fast decision-making
* Engineer payoff functions

Payoff as asymmetries are not accidental, they are the result of deliberate management choices.

### Create fast feedback

Accelerating the feedback loop allows you to exercise options much sooner.

* Buy information in small batches
  * Enable small batches with low transaction costs
  * Deploy in small batches (automate deployment flow - deployment in large batches, because cost of 'deploy' transaction is high)
* Reduce queueus
  * Queues delay feedback
  * Control the invisible WIP in the process - our queues in product development are invisible.
  * Make queues visible, then reduce them
* Acccelerate the flow of time-critical information
  * non-homogenous flows. Not all flows have equivalent economic significance ('Move the ambulance faster down the road')
  * Prioritize flow of certain information
  * Escalate high-value decisions quickly. Unfortunately most people miss the econmic information/models to make good decisions on this.

### Use batch size to create options

You don't know which paths are unproductive at beginning. Lean Startup with MVPS is an anti-fragile behaviour. Do MVP, shut down unproductive paths quickly.

### Payload management

Everything we did was more valuable than everything we chose not to do. We exploited all the new information we received during the development process. Throw things under the bus, and put new things on it. Make good economic choices

### Fast decision making

* Decentralize control
  * Authority
  * Information
  * Resources

* Favor decision speed over accuracy
  * Making it safe to use initiative

* Control exposure by managing consequences instead of frequency of occurence.

Marine corps give guidance: if you have 80% of the information and not made a decision, you have wasted an opportunity.

Facebook focus on consequences: why make it live for a billion users? why make it live for a 1000?

### Engineer payoff your functions

At HP every division was self-funding, they did not subsidize unsucessful business units. Unsuccesful paths were automatically shut down.

## A few takeaways

* Don't fear variability
* Buffer with care
* Focus on payoff functions not probablities
* Buy information in small batches
* Think like a smart gambler
* Create options
* Value good economic choices over conformance

## epilogue - question asked about speaking beforehand

The way you become a comfortable speaker is by speaking. Take a subject you are comfortable with, that you believe is important and you believe people want to know. Start with small batches, small audiences, lightning talks.
