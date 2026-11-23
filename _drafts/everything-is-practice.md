---
layout: post
title: Everything is practice
tags:
  - systems thinking
  - productivity
  - learning
  - knowledge management
author: Marc Evers
image: /attachments/blogposts/2026/bruno-nascimento-PHIgYUGQPvU-unsplash.jpg
---

"Practice makes perfect" - you become good at things you repeatedly do.
By doing, we reinforce and entrain patterns - patterns of thought, patterns of movement. 
This always happens, whether we are consciously practicing or not, whether we want it or not.
So, everything we do is a form of practice.

This perspective opens up opportunities and exposes risks, for instance in software delivery. 
Seeing every activity as a practice means we have a lot of learning opportunities. 
This can accelerate skills growth. 
On the other hand, it also means that developers are practising their skills 
on production software daily, whether we like it or not - we'd better provide direction and safeguards. 

![picture showing the legs of a person wearing orange and gray Nike shoes walking on gray concrete stairs](/attachments/blogposts/2026/bruno-nascimento-PHIgYUGQPvU-unsplash.jpg)
{: class="post-image post-image-50" }

## Reflective practice

If everything is practice, then work (and all other activities) provides us ample learning materials. 
Adding reflection (individually, together, supervised) to our daily activities will help us learn and grow.
We can reflect individually, together with peers, and supervised.

Reflective practice will shift us to learning continuously. 
It enables situated, experiential, embodied learning, linking practice and theory together. 
learning does not only take place in formal classroom settings, but also (even more!) in our daily activities.

A lot of learning, in particular [skills, tacit knowledge and collective 
knowledge](/2025/11/25/types-of-knowledge-in-development) is social & experiential

## From blame and shame to compassion

As we are learning, we will make mistakes. 
Things turn out differently from what we expect. 
We tend to feel bad about this - "we're professionals, we should not make mistakes!".
So we put blame and shame on ourselves and others. 
This prevents learning and can lead to making the same mistakes over and over again.

By seeing all activities as practice we take a much more compassionate stance:
- making mistakes is an important part of learning; 
- an essential part of learning takes places outside the classroom, we can account for that in our daily work;
- we facilitate learning in our daily work, by putting fast feedback loops and safeguards in place. 

@@ add some reference to Paula

## Facilitating learning in daily work

Fast feedback loops are essential. 
We need the feedback on the quality of our work to be close enough to the work itself to enable learning. 
Often this is seconds to minutes, not hours, days or longer. 
Think locally running automated tests, feedback from my pair, CI build results.
Feedback that arrives weeks later in the form of a production incident provides stress instead of learning. 

Having a solid, fast automated test suite for example enables us to experiment with refactoring.

Embedding reflection in our activities is essential, both as part of the activity and shortly after the activity.
In his book *The Reflective Practitioner*, Donald Schön described this as *reflection-on-action* and 
*reflection-in-action* 

[Unintended consequences](/2025/11/08/unintended-consequences) of our activities are another good source of learning.
We tend to ignore them or push them away as undesired. 
Instead, see them as rich learning material - *prepare to be surprised!* 

## Consequences

Once we realize that everything we do is practice, we also start noticing some consequences.

**We have so much material at our hands to learn from.** 
When all our activities are practice, we are opening up a huge amount of learning material.
We don't need to restrict this to classroom training, but we can reflect on whatever we did and what happened.

**Practise where you want to go.** 
You become good at what you practice.
If you find yourself becoming the expert in something you don't like (people 
always find you for solving a tricky bug or fixing their printer), then practise that less and shift your efforts to what you do like.

This holds at a personal level but also for delivery teams. 
You can't expect a team to become good at different ways of working with just a short isolated training.
They will need to practice in their daily work, explicitly, reflectively, and safely!
Otherwise, they will just become better at what they have always been doing.

**Practise on production code**
Developers will practise on production code - you cannot prevent that. 
Usually this happens unconsciously and the impact can be high. 
Short term effects can be production incidents and increased rework.
Longer term effects are technical debt and software that is hard to maintain.

Recognising developer activity explicitly as practice is useful. 
Add moments of reflection to the activities (don't wait for the bi-weekly retrospective!), optimize for learning 
through 
pair-programming, collective code-walkthroughs, collaborative design sessions.

Pull Request reviews can also focus more on learning. 
However, such reviews are not well suited for learning.
They have been separated in time from the actual practice and focus mostly on explicit reading and writing rather dan 
social and experiential learn learning.

**Shorten feedback loops**
We need short, high quality feedback loops that are fast enough.
We need feedback to enable learning. 
We also need feedback as a safety net. 
Having a good safety net creates a safe space for experimenting.

Feedback loops can be e.g. automated tests, feedback from team members, the continuous conversation in pair 
programming, heuristics that evaluate quality. 

One of the [principles of the Agile Manifesto](https://agilemanifesto.org/principles.html) is: *at regular 
intervals, the team reflects on how to become more effective, then tunes and adjusts its behavior accordingly.*
In the early days of agile and eXtreme Programming (early 2000s), there was a small company who took this principle  
to the extreme.
They added a reflection moment to *every* activity they did, planning sessions, daily standups, pair programming 
sessions. This is a huge boost for learning.

**You need other forms of learning too.**
In software development, we see limited investment in classroom learning and other specific learning activities. 
Developers go to conferences and pick up new ideas there.
Occasionally they can attend a course if budget and time allows. 
As a consequence, most of the learning will take place in their daily activities.

This is a good thing, especially if we take the "everything is practice" stance and appropriate measures. 
There is still a place for classroom learning, however. 
A classroom setting provides a safe, low-distraction environment where people can be introduced to new 
concepts and experiment with them.

A classroom training without proper guidance afterward, will have limited impact. 
Most organisations we see do not address learning in practice well.

You need both:
- classroom setting to introduce new ideas, build a shared perspective, and practice safely;
- learning, by doing, in daily activities, with proper guidance and support.

## Further reading 

- "Software development is a cooperative game of invention and communication" (from [Alistair Cockburn's book Agile Software Development](https://alistaircockburn.com/)); we are continuously creating knowledge (including skills/know-how).
- Donald Schön, [The Reflective Practitioner](https://openlibrary.org/books/OL3511128M/The_reflective_practitioner) (1983) - about [reflective practice](https://en.wikipedia.org/wiki/Reflective_practice)
- [Paula Kolthoff, Embodied Learning](https://embodiedlearning.nl/)
- Johanna Rothman, [A Management Minute: Train People on Skills They Need. Period.](https://www.jrothman.com/mpd/management/2026/10/a-management-minute-train-people-on-skills-they-need-period/)

@@ add plug for knowledge workshop

<em>Photo "person wearing orange and gray Nike shoes walking on gray concrete stairs" © 2016 by <a href="https://unsplash.com/@bruno_nascimento">Bruno Nascimento</a> on <a href="https://unsplash.com/photos/person-wearing-orange-and-gray-nike-shoes-walking-on-gray-concrete-stairs-PHIgYUGQPvU">Unsplash</a></em>

<aside>
<h3>something with learning and skills</h3>
<p>
something about learning path, skills development strategy
</p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
