---
layout: post
title: "TDD Heuristics: 0, 1, N"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/0-1-N.jpg
---

Where do I start when writing a test? Start with a negative case for the
behaviour, then add one positive, one more, and maybe that is enough. 
You are likely to find more cases after you start, 
getting over that 'blank piece of paper' feeling is often the biggest hurdle.

![0-1-N.jpg](/attachments/blogposts/2021/tdd/0-1-N.jpg)
{: class="post-image post-image-50" }

Starting with a negative case prevents you from only writing tests for
happy paths. It is also often the smallest step you can take. 
Completing a step feels good and prepares you to take the next.
Before you know it you may have a whole suite of these things.

## An example

If we would test-drive a vending machine, we would start
with the ```deliversNothingWhenEmpty``` test,
then do ```deliversColaWhenChoosingCola``` - a single choice. 

Finally, we do ```deliversCanOfChoice```, which allows us to generalize.
