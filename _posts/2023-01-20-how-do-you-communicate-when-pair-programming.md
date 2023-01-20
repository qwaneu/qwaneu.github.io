---
layout: post
title: How do you communicate when pair programming?
tags:
- eXtreme Programming
- programming
- test driven development

author: Willem van den Ende
image: /attachments/blogposts/2023/do-you-draw-when-pair-programming.png
--- 

[Sally Ann Freudenberg](https://salfreudenberg.wordpress.com) once asked how do developers communicate during pair
programming. Do you talk, draw, or let the code or tests talk?

we often say: 

> pair programming is a conversation that has working code as a side-effect.

My preferred style seems to be a short conversation at the start of
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
spike (Mike Hill has a great [introduction to spikes](https://www.geepawhill.org/2020/06/02/an-intro-to-spikes/)]) Sometimes it works to do it in a pair,
sometimes not. Different preferences for approaching a problem seem to
be most pronounced here. 

Experimenting in a pair can then feel like a [Three legged
race](http://fun.familyeducation.com/outdoor-games/activity/36835.html) and
might not be the fastest and most fun way to proceed. Going off alone for a set
amount of time, and coming back with conclusions from the experiment is more
fruitful in those circumstancees. That gives two perspectives on the same
problem that are more independent. To sketch or not to sketch is up to each, on their own then. Sketches can be a good aid to discuss the outcomes.

One way to see what communication mode you miss most, is to try 'Silent pairing' - pair work without speaking. Rob and I once tried this remotely, programming with only a shared terminal and a text editor between us. The only thing we were allowed to say was 'ding!' to indicate whose turn it was. We used ping-poing pair programming, writing tests and code in turn. It was fascinating to only let the tests do the talking. We were both going in different directions, but figuring out what direction the other had in mind was challenging, and fun.

![One drawing with several different styles, a doodle with a brickwork pattern
in the background, some arrows back and forth and circles and arrows. Also some
abstract people and sketch for a dialog.](/attachments/blogposts/2023/do-you-draw-when-pair-programming.png)

We do sketch out designs, but do rarely go into great detail. We sketch at the beginning of
a significant chunk of work. We sketch design during pair programming when we wonder how
to wire things up.  Sometimes when we are stuck we do a spontaneous
design session with the rest of the team. If there is a team, otherwise we [step away from the keyboard](https://www.nationalgeographic.co.uk/history-and-civilisation/2022/08/the-science-of-why-you-have-great-ideas-in-the-shower "National Geographic on the science of having great ideas in the shower"), and a sketch will likely come to us when we get back. I have done some of my best work this way.

We talk continuously, preferably with code or a sketch in hand. Often we use boxes and arrows, sometimes loose UML diagrams, e.g. sequence diagrams when we are designing services or have an interaction between objects that we don't understand well enough just yet. But always loosely,
and keeping our minds open to change, because without tests and code we are only speculating.

How do you communicate during programming, and when do you choose which
option? Is it different from when you work solo?

<aside>
<h3>Do you want to experiment with pair programming?</h3>
<p>Whether you are doing it and want to improve, wish to have more people in your organisation practice pair programming, or want to reflect on your way of working by doing deliberate practice, pair programming is embedded as the default way of learning in all of our courses. We also have a dedicated day on pair programming, but that is currently only available off-menu. Feel free to ask us about it!
</p>
<div>
<a href="/training">Book a course</a>
</div>
</aside>

