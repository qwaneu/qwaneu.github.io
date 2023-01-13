---
layout: post
title: How do you communicate when pair programming?
tags:
- eXtreme Programming
- programming
- test driven development

author: Willem van den Ende
image: /attachments/blogposts/2023/do-you-draw-when-pair-programming.png)

Sally Ann Freudenberg once asked how developers communicate during pair
programming. Do you talk, draw, or let the code or tests talk?

we often say: 

> pair programming is a conversation that has working code as a side-effect.

Willems' preferred style seems to be a short conversation at the start of
a pairing session, figuring out what needs to be done, and roughly
outline how to proceed. Writing tests together 
will flesh out the real design. That design usually differs
slightly from the initial discussion, and sometimes significantly. The
fun here is in moulding the design together and finding the minimal way
to address the users' needs. That also may include rethinking features.
Like code, the best features are no features, so if we can find a way to
address a users' need while minimizing the number of features, even
better.

When the path ahead is clear, the flow of test-fail-run-refactor is smooth.
We pair relentlessly.

When it is clear what needs to be done for the user, but not how to
implement it, we do a small experiment. Also known as an architectural
spike @@reference. Sometimes it works to do it in a pair,
sometimes not. Different preferences for approaching a problem seem to
be most pronounced here. 

Experimenting in a pair can then feel like a [Three legged
race](http://fun.familyeducation.com/outdoor-games/activity/36835.html) and
might not be the fastest and most fun way to proceed. Even something seemingly
trivial like browsing the web together can be frustrating. Willem reads fast and
wide, having 10 plus tabs open is not an exception. Others read narrow and in
detail, trying to understand everything in one go. Going off alone for a set
amount of time, and coming back with conclusions from the experiment is more
fruitful in those circumstancees. That gives two perspectives on the same
problem that are more independent.

We do sketch out designs, but to that rarely. We do it at the beginning of
a significant chunk of work. We sketch design during pair programming when we wonder how
to wire things up.  Sometimes when we are stuck we do a spontaneous
design session with the rest of the team. When we have a wider team, otherwise we [step away from the keyboard](https://www.nationalgeographic.co.uk/history-and-civilisation/2022/08/the-science-of-why-you-have-great-ideas-in-the-shower "National Geographic on the science of having great ideas in the shower").

We talk continuously, preferably with code or a sketch in hand.
Without code it is just idle speculation.

![One drawing with several different styles, a doodle with a brickwork pattern
in the background, some arrows back and forth and circles and arrows. Also some
abstract people and sketch for a dialog.](/attachments/blogposts/2023/do-you-draw-when-pair-programming.png)

How do you communicate during programming, and when do you choose which
option?

@@CallToAction

If you want to experiment with pair programming, join our pair
programming course on <date>
