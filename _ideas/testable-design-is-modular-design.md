---
layout: post
title: A testable design is a modular design
tags:
  - continuous delivery
  - test driven development
author: 
image:
---

What does 'testable' mean?

trying to test something in isolation implies isolating the thing (well, duh)

the effort and pain caused by isolating the thing provides us feedback about dependencies

when we do test driven development, we take this challenge upfront; because we are writing a test, we get immediate feedback on dependencies; if the dependencies start to hurt, we take action and change the design 

TDD and (unit) tests will provide feedback about the degree of isolation, i.e.
dependencies, or modularity (decoupling) in other words. The decision to act on
this feedback and reduce dependencies/improve modularity is still an explicit,
conscious one - TDD does not automatically fix it for you. TDD does make the
decision easier to take (because of the rich, direct feedback, we can take
better design decisions) and helps to make it modular sooner rather than later.
