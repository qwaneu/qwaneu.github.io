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

"Practice makes perfect" - you become good at things you repeatedly do - . In fact, everything what we do is a form of practice. By doing, we reinforce and entrain patterns - patterns of thought, patterns of movement. This happens always, whether we are conscious about it or not, whether we want it or not.

Why is this relevant? We think this perspective opens up opportunities and exposes some risks, for instance in software delivery. Seeing every activity as a practice and learning opportunity can accelerate skills growth. On the other hand, if every activity is a form of practice, it also means that developers are practising their skills on production software whether we like it or not - we'd better provide direction and safeguards. 

![picture showing the legs of a person wearing orange and gray Nike shoes walking on gray concrete stairs](/attachments/blogposts/2026/bruno-nascimento-PHIgYUGQPvU-unsplash.jpg)
{: class="post-image post-image-50" }

## Reflective practice

If everything is practice, then work (and all other activities) provides us ample materials for learning. Adding reflection (individually, together, supervised) to our daily activities will help us learn and grow. Everything we do can become learning material.

This enables reflective practice and will move us to continuously learning in practice. It enables situated, experiential, embodied learning, linking practice and theory together. It recognises that learning does not only take place in formal, classroom based settings, but also (and even more) in our daily activities.

It fits with the idea that a lot of learning, especially regarding [skills, tacit knowledge and collective/systemic knowledge](/2025/11/25/types-of-knowledge-in-development) needs to be social & experiential.  helps building.

## From blame and shame to compassion

As we are learning, we will make mistakes. Things will turn out differently from what we expected. We tend to feel bad about this ("we're professionals, we should not make mistakes") and put blame and shame on ourselves and others. Blame and shame prevent learning, and can lead to making the same mistakes over and over again.

Seeing all activities as practice provides a much more compassionate stance:
- We recognise we're learning and making mistakes is an important part of that. 
- Learning cannot be confined to a classroom setting, we need to account for that in our daily work.
- We can organize our work to facilitate the learning, putting fast feedback loops and safeguards in place. Having a solid, fast automated test suite for example enables us to experiment with refactoring.

Fast feedback loops are essential. We need feedback on the quality of our work closely enough to the work itself, to enable learning. This is about seconds (local automated test, pair feedback) to minutes (CI build time). Feedback that comes a few weeks later from a production incident provides a stressful situation with hardly any learning. 

Having reflection as part of the activity and taking place directly after activities is also essential. This is what Donald Schön described as *reflection-on-action* and *reflection-in-action* in his book *The Reflective Practitioner*.

Another good source for learning are the [unintended consequences](/2025/11/08/unintended-consequences) of our activities. Instead of pushing these away and trying to forget quickly, these provide rich learning.

## Consequences / what does this mean

What are the consequences if we see everything we do a practice?

### We have so much material at our hands to learn from

If we see all our activities as practice, we open up a huge amount of material we can use to reflect on and learn from. We don't need to restrict this to classroom training, but we can reflect on whatever we did and what happened.

### Practice where you want to go

You become good at what you practice - if you find yourself becoming the expert in something you don't like (people always find you for solving a tricky bug or fixing their printer), then practise that less and shift your efforts to what you do like.

This holds at a personal level but also for delivery teams. You can't expect them to become good at different ways of working with just a short training and hardly any practice afterwards. They will just become better at the old ways of working.

### Practising on production code

Developers practice on production code - you cannot prevent that. Usually this happens unconsciously and the impact can be high. Short term effects can be production incidents, increased rework; longer term effects are technical debt and software that is hard to maintain.

Recognising developer activity as practice can help; add moments of reflection to the activities (don't wait for the bi-weekly retrospective), optimize for learning through pair-programming, collective code-walkthroughs, collaborative design sessions.

PR reviews can also focus more on learning. However, PR reviews are not well suited for learning, being separated in time from the actual practice and focusing mostly on writing instead of social learning).

### Short, fast feedback loops

We need short, high quality feedback loops that are fast enough. We need feedback to enable learning. We also need feedback as a safety net. Having a good safety net creates a safe space for experimenting.

Feedback loops can be anything: e.g. automated tests, feedback from team members, the continuous conversation in pair programming, heuristics to evaluate quality. 

In the early days of agile and eXtreme Programming (early 2000s), there was a small company who took the [agile principle](https://agilemanifesto.org/principles.html) of *At regular intervals, the team reflects on how to become more effective, then tunes and adjusts its behavior accordingly.* to the extreme, by adding a reflection moment to every activity they did, planning sessions, daily standups, pair programming session. This helps a lot in amplifying learning.

### You need other forms of learning too

In software development, we see limited investment in classroom learning and other specific learning activities. Developers go to conferences and pick up new ideas there, and occasionally do a course if budget and time allows. This means that most of the learning will take place through their daily activities.

This is a good thing, especially if we take the "everything is practice" stance and appropriate measures. There is still a place for classroom learning however. Especially to introduce people to new concepts and to let them learn by doing and experimenting in a safe environment with less distractions. 

Doing a classroom training, without proper guidance afterwards will also limit the learning effects. Most organisations we see do not address learning in practice well enough.

So you need both:
- classroom formats to introduce new ideas, build a shared perspective, and practice safely
- learning in daily activities, with proper guidance and support

## Further reading 

- "Software development is a cooperative game of invention and communication" (from [Alistair Cockburn's book Agile Software Development](https://alistaircockburn.com/)); we are continuously creating knowledge (including skills/know-how).
- Donald Schön, [The Reflective Practitioner](https://openlibrary.org/books/OL3511128M/The_reflective_practitioner) (1983) - about [reflective practice](https://en.wikipedia.org/wiki/Reflective_practice)
- [Paula Kolthoff, Embodied Learning](https://embodiedlearning.nl/)

<em>Photo "person wearing orange and gray Nike shoes walking on gray concrete stairs" © 2016 by <a href="https://unsplash.com/@bruno_nascimento">Bruno Nascimento</a> on <a href="https://unsplash.com/photos/person-wearing-orange-and-gray-nike-shoes-walking-on-gray-concrete-stairs-PHIgYUGQPvU">Unsplash</a></em>
