---
layout: post
title: The case against feature toggles
tags:
  - feedback
  - continuous delivery
  - DevOps
author: 
image:
---

As more and more development organizations are moving towards continuous
delivery, we see them using feature toggles more and more. In this post, we'd
like to reflect on this practice. It is (again) not a best practice, but one
that comes with trade-offs. We are not implying feature toggles are bad, but we
urge you to be aware of the trade-offs and risks involved, and to take a
critical look at how you are using them.

## Feature toggles defined

Feature toggles: a separate mechanism to give access to a feature, e.g. enabled in a specific environment, or enabled for specific users or organizations.

Usually it works through some configuration flag, sometimes via a special administrator UI where you can toggle a feature on or off in a specific environment (test/production/...).

## Feature toggles facilitate continuous delivery

Feature toggles can help decouple delivery (moving changes to production) from
release (enabling it for users). E.g. because what is meaningful for a user or
customer comprises a bigger set of features. Or you want to roll out gradually.

Feature toggles enable you to deliver at will, and removing releasing to
users/customers as a bottleneck. 

As a result of decoupling, releasing something to specific users/stakeholders
becomes a separate, independent business decision.

## Feature toggles hinder continuous integration

Feature toggles come with trade-offs. They delay integration, so they tend to
move away from continuous integration. A risk of this is late feedback - you
don't catch issues fast, because the issue is hidden behind the toggle.

Creating automated tests for the system with and without the feature toggle
enabled can help a lot. This does increase system complexity however, as it is
more difficult to juggle two variations of a system in your head.

## Other consequences

Feature toggles introduce extra complexity in the code, either by adding some
extra conditionals and variations of behaviour or by having some extra routing
rules and configuration logic.

Feature toggles that span more than one component sharply increase the cognitive
load. It is much harder to reason over two components and how their different
configurations interact.

## Combinatorial explosion

Once teams start using feature toggles, sooner or later there will be many. Some feature toggle management is highly recommended, so that you know when to remove specific toggles and the corresponding code and tests.

Another nasty effect of multiple feature toggles occurs when they start
interacting. You could get into a situation of a combinatorial explosion of
toggle states. Effectively, you are creating a multitude of system
configurations. Having automated tests for each individual configuration becomes
much harder.

![@@ some sort of 'tree' diagram visualizing explosion of configurations]()

## Tech toggles

Once you have a toggle mechanism in place, it become your hammer and everything
starts looking like a nail. We also see teams using the toggles to switch off
parts of the code that are not working or still messy. As you are not toggling
features, we tend to call these 'tech toggles' instead.

Feature toggles come with trade-offs, but tech toggles are a big no for us. In
our opinion, tech toggles can be prevented. Instead, look at your way of working
and find a way of deliver code that is tested and works. Tech toggles only hide
deeper issues in your software development approach.

## Some good practices and considerations

Reduce the 'scope' of a toggle; if a toggle changes behaviour in many places in
the code, it becomes much harder to test both configurations of the system.

Prefer using your existing authorisation mechanism to enable/disable access to
features; having a single well understood mechanism reduces the risk of
mistakes. @@+example

If a toggle is affecting multiple components, let one component lead, while the
rest follows; i.e. one component uses the toggle to show different behaviour,
the other juts react correctly on what this component does/tells/says (@@needs
small example)

## Conclusion

Feature toggles is a practice that facilitates continuous delivery, but it comes
with trade-offs. 

We find it useful to take a critical stance and see feature toggles as a symptom
instead of a solution. This can help us find better ways of delivering
continuously without postponing integration or getting stuck in complexity.
