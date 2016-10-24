---
layout: post
title:  Delete pending tests
tags:
  - code
  - refactoring
  - tests
  - polyglot
author: Willem van den Ende
image: /attachments/blogposts/2016/pending.svg
---

Do you have pending tests left over from yesterday? Better delete them before they grow stale.

This struck me while Rob and I were reviewing a code base recently. An effort was made to write tests, and lots of tests were brainstormed, in the form of ‘pending’ tests. Some tests were implemented, some weren’t. We looked in the git history, and tens of tests had been pending for months.

Now this is easy to see in someone else’s code base. To be honest, I’m working on a code base that has that pattern too… I had about twenty pending tests. I deleted all of them today. Several had already been built as tests, but with a description that better matched my current understanding. I spent half an hour or so deleting them, and learning a thing or two about my tests.

Pending tests are a form of Work In Process, and quite often it is better to have a limited quantity of that. The twenty tests I had were not all in one place. It was one here, three there etc. Having only green tests carries less bagage. If the tool you use lists the number of pending tests separately, you can let your build tools check the number of peniding tests, and let the build fail when there are too many.

A pattern I sometimes use, and I think will use more often, is, instead of writing a pending test, write one that fails with a string comparison, and the left hand and right hand side together are a message telling me what idea I had for the inside of the test, e.g. this is what my test runner is showing me now:

```bash
An events' session descriptions
✗ are all visible to reviewers by default:

  "small list of fresh sessionDescriptions" ≠ "could be filtered"
```
   I can’t stand much more than one failing test, three at a pinch, so this helps keep me on track (getting rid of some ideas that float in my mind while writing tests) while still writing actual tests. Builds also fail without any additional tooling. Simplicity for the win.

![Traffic sign - 'Pending' with red border and red strike through](
image: /attachments/blogposts/2016/pending.svg)


