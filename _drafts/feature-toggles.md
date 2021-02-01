---
layout: post
title: When (not) to use feature toggles
tags:
  - feedback
  - continuous delivery
  - DevOps
author: Marc Evers, Willem van den Ende
image: /attachments/blogposts/2021/justus-menke-Uwecr7Su3dU-unsplash-cropped.jpg
---

In this post, we will reflect on the practice of using _feature toggles_. As
more and more development organizations are moving towards continuous delivery,
we see them using feature toggles more and more. It is, once again, not a best
practice, but one that comes with trade-offs. We are not implying feature
toggles are bad, but we urge you to be aware of the trade-offs and risks
involved, and to take a critical look at how you are using them.

![switch picture](/attachments/blogposts/2021/justus-menke-Uwecr7Su3dU-unsplash-cropped.jpg)
{: class="post-image post-image-70" }

## Feature toggles defined

Feature toggles are a separate mechanism to give access to a feature, e.g.
enabled in a specific environment, or enabled for specific users or
organizations.

Usually it works through some configuration flag, sometimes via a special
administrator UI where you can toggle a feature on or off in a specific
environment - test/production/acceptance...

## Feature toggles facilitate continuous delivery

As developers we want to ship small pieces and get early feedback. Users do not
always want this - "where did that button move?' - even when they are agile
developers or UX people. 

Feature toggles can help decouple delivery (moving changes to production) from
release (enabling it for users), for example because what is meaningful for a
user or customer comprises a bigger set of features. Another example is rolling
out gradually.

Feature toggles enable you to deliver at will, and removing releasing to
users/customers as a bottleneck. 

As a result of decoupling, releasing something to specific users/stakeholders
becomes a separate, independent business decision.

Feature toggles can also help reduce the risk of 'bad' changes and reduce fear
of releasing. If you can reduce the impact of releasing a feature to just one or
a few users, it becomes less risky. It even allows a kind of rollback (switching
off the feature toggle) when necessary.

## Feature toggles hinder continuous integration

Feature toggles come with trade-offs. They delay integration, so they tend to
move us away from continuous integration. A risk of this is late feedback - you
don't catch issues fast, because the issue is hidden behind the toggle.

Creating automated tests for the system with and without the feature toggle
enabled can help a lot. This does increase system complexity however, as it is
more difficult to juggle two variations of a system in your mind.

## Other consequences

Feature toggles introduce extra complexity in the code, either by adding some
extra conditionals and variations of behaviour or by having some extra routing
rules and configuration logic.

Feature toggles that span more than one component sharply increase cognitive
load. It is much harder to reason over two components and how their different
configurations interact than it is to reason about one component.

## Combinatorial explosion

Once teams start using feature toggles, sooner or later there will be many. Some
feature toggle management is highly recommended, so that you know when to remove
specific toggles and the corresponding code and tests.

Another nasty effect of multiple feature toggles occurs when they start
interacting. You could get into a situation of a combinatorial explosion of
toggle states. Effectively, you are creating a multitude of system
configurations. Having automated tests for each individual configuration becomes
much harder.

![combinatorial explosion of feature toggles](/attachments/blogposts/2021/ft-explosion.jpg)
{: class="post-image post-image-70" }

## Tech toggles

Once you have a toggle mechanism in place, it becomes your hammer and everything
starts looking like a nail - or a thumb. We also see teams using toggles to
switch off parts of the code that are not yet fully working or still messy. Such
toggles are not feature driven, but driven by technical motives, so we tend to
call these _tech toggles_.

Tech toggles can be useful in your journey towards continuous delivery, for
example to get rid of long release cycles and code freezes.

Once you are able to deliver at will, introducing tech toggles is a slippery
slope. It risks moving away from having continuously integrated software,
because you start increasing your batch size. Tech toggles can hide deeper
issues in your software development process. We recommend looking at your way of
working and finding a way of deliver code that is tested and works first, and building capability to quickly deploy and rollback changes,  before
resorting to tech toggles. We want to respond to change, not live in fear of additional if's and buts we added. 

## Considerations

Reduce the 'scope' of a toggle; if a toggle changes behaviour in many places in
the code, it becomes much harder to test both configurations of the system.

Prefer using your existing authorisation mechanism to enable/disable access to
features; having a single well understood mechanism reduces the risk of
mistakes. The feature toggle might need permissions to be finer grained. Remember to refactor and clean up when the feature toggle related permissions are not needed anymore.

![splitting permissions for toggling features](/attachments/blogposts/2021/ft-split-permissions.jpg)

If a toggle is affecting multiple components, let one component lead, while the
rest follows; i.e. one component uses the toggle to show different behaviour,
the others just react correctly on what this component does/tells/says (@@needs
small example)

Feature toggles will only work well when one can separate all the functionality
under the toggle. One can also fool oneself easily.

## Conclusion

Feature toggles is a practice that facilitates continuous delivery, but it comes
with trade-offs. We find it useful to take a critical stance and see feature
toggles more as a symptom than a solution. This can help us find better ways of
delivering continuously without postponing integration or getting stuck in
complexity.

## Further reading

- [Twitter thread](https://twitter.com/ph1/status/1263186192951939072) by [Pete Hodgsson](http://twitter.com/@ph1) on [Piranha: an open Source tool to automatically delete stale code](https://eng.uber.com/piranha/). Academic paper: https://manu.sridharan.net/files/ICSE20-SEIP-Piranha.pdf. The Twitter thread contains a more detailed categorisation beyond 'tech toggles' and 'other'.
- [Categories of Feature Toggles](https://www.martinfowler.com/articles/feature-toggles.html#CategoriesOfToggles) on martinfowler.com.
- [LaunchDarkly](https://launchdarkly.com/), a service to manage flags at various states in a products lifecycle, for various audiences.

_Credits:_ 
- _<span>Switch photo (cropped) by <a href="https://unsplash.com/@justusmenke?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Justus Menke</a> on <a href="https://unsplash.com/s/photos/switch?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>_

<aside>
  <h3>Delivering software at will</h3>
  <p>
    Would you like your teams to grow towards continuous delivery and delivering at will? Drop us a line and we can work with you.
  </p>
  <p><div>
    <a href="/consulting">Learn more about our consulting and mentoring services</a>
  </div></p>
</aside>
