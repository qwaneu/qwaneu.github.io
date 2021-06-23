---
layout: post
title: Test Driven Development Recap
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: 
---

This is the first in a series of posts on **heuristics and guidelines for unit tests
and test driven development**. 

Before we dive into heuristics, let's first do a quick recap of Test Driven
Development (TDD). We notice that more and more people have heard of it, but
also that few know what TDD actually is.

## The 5-minute-to-the-coffee-machine explanation of TDD

We can explain TDD while walking to the coffee machine. The Test
Driven Developent cycle consists of 4 steps:

![TDD cycle](/attachments/blogposts/2020/tdd-cycle.png)

1. write a test
2. see it fail
3. make it pass
4. refactor
 
Practicing TDD is _slightly_ more difficult than explaining it, and takes a bit
of deliberate practice.

### Write a test

The first thing we do is: **write a test**. We write **one** test, which forces
us to isolate the problem and make it concrete. We express it in code the
details of the interface we design and the behaviour we expect.

### See it fail

We run the test and watch the new test fail. As we did not write any code yet,
we expect missing definitions and missing behaviour. 

Only the new test should fail. Are there any other failures? Fix them first. We
also check if the feedback from the failure is helpful.

**A red bar is progress!**

### Make it pass

Step by step we add code, run the test and see less (or different) failures. We
strive for simplicity: we write just enough code just to make this test pass.
Cheating and faking (like returning a constant value instead of a proper
implementation) is allowed, or even recommended - it reminds us of the next test
to write

**Hurray! – green bar! – let's party...**

### Refactor

...wait a minute with the party, there is a fourth step left: refactor. 

Now that our tests are all green, we can safely clean up code, remove
duplication, improve naming This is called
[refactoring](https://refactoring.com) - small, well-defined steps that improve
the design of the code, without changing its behaviour.

**Now we're done, let's party!**

## That's it?

The TDD cycle describes the basics of TDD in a nutshell. It is a cycle of 4
steps that usually takes seconds rather than minutes to go through. it's simple,
but not easy. It is a skill that needs practice to master. We suspect some
developers get put off by this when trying out TDD: it takes some practice to
become sufficiently fluent at it, so it you're new to it and try it only for a
short time, it is hard to judge its value.

## But what _is_ it, really?

Some think TDD is mainly about going overboard writing unit tests; others think
it is primarly about first writing tests; others think it is an all-or-nothing
approach and get put off by fanatics stating it is the only true and
professional way to write code.

TDD is a discipline of working - a way in which we approach our development
work. It is a set of habits that help to keep on taking small steps towards our
goals

It reminds us that we continously take care of the code and refactor while
everything is still fresh in our minds. 

It forces us to think about the next step we are going to take, about how things
should work; it forces us to express our intent precisely in code. Jim Shore
call this a "series of validated hypothesis" - a test is a hypothesis, the code
(in)validates it.

> "I'm not a great programmer; I'm just a good programmer with great habits." -- Kent Beck

## Practice

The TDD cycle looks deceptively simple. TDD is however not a recipe, it's not a
step-by-step method you can blindly follow that results in guaranteed high
quality software.

Instead, it is a way of working that helps us to make better design decisions;
it provides a structure that enables us to take small steps, to continuously
take care of our code (even if part of us can't wait to start the next story),
to grow a suite of fast, meaningful automated tests. 

It is our default way of writing good code, doing incremental design and growing
a suite of fast tests, because we've found that we hugely benefit from it in
getting to results quickly, while writing code that works. It is not the only
useful practice, but we see it as the basis for quality work, the foundation for
doing CI/CD (continuous integration, continuous delivery) properly. It is a key
practice in promoting small software changes to production quickly and with
confidence in a sustainable, repeatable way

For us software developers, TDD is a good way to be continuously in touch with
our 'material', like an artist making a painting who gets immediate feedback
from the brush and the canvas. 

> A story from Rob:  
> _When helping my father doing carpentry, I was struggling to cut
a plank in half with a saw. My father made it look so easy. His saw went
through wood like a knife cutting through butter. His cuts
where clean and straight. I was sweating to get the saw through. Half
way through, I was getting fatigue in my arm and my cuts where ugly, uneven. It
was frustrating._  
> _I remember my father kept saying: "Just let the saw do
the work and it helps if you go back and forth in a straight line."
When cutting a plank, his words still resonate in my head._  
> _"Let the saw do the work", really means "don't put too much pressure on
the saw". It will make for cleaner cuts and will prevent fatigue in
your arm. Similarly, "Going back and forth in a straight line" helps the
saw cut easier though the wood, prevent fatigue, and makes for cleaner cuts as well. The things he said were not practices, but rather principles and
heuristics that make the process smoother and the end result better."_

Like cutting a plank, TDD is deceptively simple to explain but hard to do well.
Over the years of training and mentoring people we have collected quite a few
heuristics and guidelines that help us to write, _and explain how to write_,
tests that are clean, maintainable, and helpful. We will be publishing a series
of these heuristics and guidelines, so keep an eye on this blog!
## Effects

In [TDD as Change
Stragey](https://www.geepawhill.org/2021/02/02/tdd-as-change-strategy/) states
"Microtest TDD is an effective change strategy because it dramatically improves
our performance at comprehension, confirmation, and regression detection, all
critical factors in handling change quickly & safely."

When doing TDD we find ourselves hardly using the debugger any more. The tests
help us to pinpoint issues quite well. And we tend to start with writing a test
first to reproduce a bug.

Working test driven does feel slow sometimes; sometimes we have a solution in
our head, and writing test first, step by step feels like driving with your foot
on the brake. We still find that working in this way forces us to think about
our design and it provide very early feedback about the brilliant solution in
our head (which often turns out to be less brilliant than we thought). In the
end it makes us go faster, because our code just works. With each green test, we
are a tiny step closer to our goal.

## Some more quotes

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Someone is wrong about TDD on the internet, claiming it to be &quot;backwards&quot;.<br><br>It&#39;s actually just very very deliberately forward, but in tiny steps.<br><br>TDD done well might best be described as:<br>Clarify Intent Before Acting.</p>&mdash; Tobbe Gyllebring (@drunkcod) <a href="https://twitter.com/drunkcod/status/1397152190347816972?ref_src=twsrc%5Etfw">May 25, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I think it’s fashionable to hate on unit testing because, like anything in software, many are bad at it and only do it via cargo culting. Good TDD promotes loose coupling and is a productivity hack. Other testing is needed, too. “Simplest test that could possibly fail.”</p>&mdash; Jon Stewart (@codeslack) <a href="https://twitter.com/codeslack/status/1392312280570793988?ref_src=twsrc%5Etfw">May 12, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">In unit testing, what&#39;s a unit? Is it a method? Is it a class? Is it a module? No. Let&#39;s clarify this once and for all.<br><br>In unit testing, a unit isn&#39;t an element of structure. In unit testing, a unit is an individually observable element of BEHAVIOR.<a href="https://twitter.com/hashtag/TDD?src=hash&amp;ref_src=twsrc%5Etfw">#TDD</a> <a href="https://twitter.com/hashtag/BDD?src=hash&amp;ref_src=twsrc%5Etfw">#BDD</a> <a href="https://twitter.com/hashtag/ATDD?src=hash&amp;ref_src=twsrc%5Etfw">#ATDD</a> <a href="https://twitter.com/hashtag/UnitTesting?src=hash&amp;ref_src=twsrc%5Etfw">#UnitTesting</a></p>&mdash; Christian Hujer #BLM 🏴‍☠️🖦🧙🏻‍♂️🕊💉 (@christianhujer) <a href="https://twitter.com/christianhujer/status/1391301843683139585?ref_src=twsrc%5Etfw">May 9, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 


## I want to learn more!

Go to the source. Kent Beck's book [Test Driven Development, By
Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/)
from 2002 is a good source to learn more.

Another book we often recommend is [Growing Object Oriented Software, Guided by
Tests](http://www.growing-object-oriented-software.com/), by Steve Freeman and
Nat Pryce (2008). This book applies TDD in a broader way, not just unit testing
but also acceptance testing.

Jim Shore did a series of [Lunch & Learn sessions on TDD](https://www.jamesshore.com/v2/projects/lunch-and-learn) last year, which is a series of 21 videos where he shows all aspects of TDD - also highly recommended!

GeePaw Hill has written a lot of thoughtful posts on TDD: https://www.geepawhill.org/category/tdd/. See for instance his video on [Five Underplayed Premises Of TDD](https://www.geepawhill.org/2018/01/18/five-underplayed-premises-of-tdd-2/)

Or join one of our [Test Driven Development courses](/training/test-driven-development). Our courses focus on deliberate practice and learning by doing.
