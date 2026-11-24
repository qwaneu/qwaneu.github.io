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
We reinforce and entrain patterns by doing - patterns of thought, patterns of movement. 
This always happens, whether we are conscious about it or not, whether we want it or not.
**So, everything we do is a form of practice.**

This perspective opens up opportunities and exposes risks. 
Seeing every activity as practice means we have a lot of learning opportunities. 
We can practice our skills and accelerate growth all the time, everywhere!
It also means for example that woftware developers are practising their skills on production software, whether we 
like it or not.

![picture showing the legs of a person wearing orange and gray Nike shoes walking on gray concrete stairs](/attachments/blogposts/2026/bruno-nascimento-PHIgYUGQPvU-unsplash.jpg)
{: class="post-image post-image-50" }

## Reflective practice

learning does not only take place in formal classroom settings, but also (even more!) in our daily activities.
Work (and all other activities!) provides us ample learning materials.
Adding reflection to our daily activities will help us learn and grow continuously.
It enables situated, experiential, embodied learning, linking practice and theory together.  

We can reflect individually, together with peers, and supervised.
A lot of learning, in particular [skills, tacit knowledge and collective 
knowledge](/2025/11/25/types-of-knowledge-in-development) is social and experiential.

## From blame and shame to compassion

As we are learning, we will make mistakes. 
Things turn out differently from what we expect. 
We tend to feel bad about this: "we're professionals, we should not make mistakes!".
So we put blame and shame on ourselves and others. 
This prevents learning, and we get stuck in making the same mistakes over and over again.

By seeing all activities as practice, we take a much more compassionate stance:
- making mistakes is an important part of learning; 
- an essential part of learning takes places outside the classroom, we can account for that in our daily work;
- we facilitate learning in our daily work, by putting fast feedback loops and safeguards in place. 

## Facilitate learning in daily work

Fast feedback loops are essential for learning. 
We need the feedback on how we are doing our work to be close enough to the work itself to enable learning. 
Think seconds to minutes, not hours, days or longer: 
automated tests running locally in seconds, immediate feedback from my pair programming partner, CI build 
results coming back within minutes.
Feedback that arrives weeks later in the form of a production incident provides stress instead of learning. 
Having a solid, fast automated test suite for example enables us to experiment safely with refactorings.

Embedding reflection in our activities is essential for getting feedback, both as part of the activity and shortly 
after the activity.
In his book *The Reflective Practitioner*, Donald Schön described this as *reflection-on-action* and 
*reflection-in-action* 

[Unintended consequences](/2025/11/08/unintended-consequences) of our activities are another source of 
learning.
We tend to ignore them or push them away as undesired. 
Instead, see them as rich learning material - *prepare to be surprised!* 

## Consequences

Once we realise that everything we do is practice, there are some consequences to take into account.

**We have so much material at our hands to learn from.** 
When all our activities are practice, we are opening up a huge amount of learning material.
We are not confined to classroom training or dedicated practice sessions, but we can reflect on whatever 
we did and what happened.

**Practise where you want to go.** 
You become good at what you practise.
If people always find you for solving tricky bugs or fixing their printer, and you say yes everytime, you will become 
the tricky bug solver or the printer fixer. 
If you find yourself becoming the expert in something you don't like, then do less of that and more of what you do like.

This holds for individuals and also for teams. 
You can't expect a team to become proficient at e.g. delivering good software with just a short, isolated training 
course.
They will need to practice in their daily work, explicitly, reflectively, and safely!
Otherwise, they will just become better at what they have always been doing.

**Practise on production code.**
Developers will practise on production code - you cannot prevent that. 
Usually this happens unconsciously and the impact can be high. 
This leads to production incidents and increased rework on the short term nand technical debt and hard-to-maintain 
software in the long term.

Recognising developer activity explicitly as practice is useful. 
Add moments of reflection to the activities - don't wait for the bi-weekly retrospective!
Optimise for learning through pair-programming, collective code-walkthroughs, collaborative design sessions.
Run coding dojos to practise on real problems in a safe space.

Pull Request reviews can also focus more on learning, although they are not well suited this.
They have been separated in time from the actual practice and focus mostly on explicit reading and writing rather dan 
social and experiential learning.

**Shorten feedback loops.**
We need short, high quality feedback loops that are fast enough.
Feedback enables learning and can provide a safety net, which creates a safe space for experimenting.
Feedback loops can be e.g. automated tests, feedback from team members, the continuous conversation in pair 
programming, heuristics that evaluate quality. 

One of the [principles of the Agile Manifesto](https://agilemanifesto.org/principles.html) is: *at regular 
intervals, the team reflects on how to become more effective, then tunes and adjusts its behavior accordingly.*
In the early days of eXtreme Programming (early 2000s), there was a small company who took this principle to the 
extreme.
They added a reflection moment to *every* activity they did, planning sessions, daily standups, pair programming 
sessions. This is a huge boost for learning.

**Falling in the trap of pattern entrainment.**
Once we have learned something, and we reinforce it by doing it over and over again, it becomes harder and harder to 
break free from it. 
This becomes problematic when our environment changes and different behaviour is needed.
We get caught in *pattern entrainment*. 
As Chris Corrigan writes in [Pattern entrainment is one of our biggest 
problems](https://www.chriscorrigan.com/parkinglot/pattern-entrainment-is-one-of-our-biggest-problems/):

> “pattern entrainment” is probably our achilles heel as a species.  Pattern entrainment is the idea that once our brains learn something, it is very difficult to break that knowledge.  And while we may be able to change our knowledge of facts fairly easily – such as admitting a mistake of a factual nature “you’re right, there is no 7:30 ferry after all!” – changing the way we make sense of facts is surprisingly hard.

**You need other forms of learning too.**
@@In software development, we see limited investment in classroom learning and other learning activities. 
Developers go to conferences or meetups (often in their spare time) and pick up new ideas there.
Occasionally they attend a course if budget and time allow. 
Most of their actual learning will take place in their daily activities, on production code. 

This is a good thing, especially if we take the "everything is practice" stance and appropriate measures. 

Most organisations we see do not address learning in practice well.

There is still a place for classroom learning. 
A classroom setting provides a safe, low-distraction environment where people can be introduced to new 
concepts and experiment with them.
A classroom training will need proper guidance afterwards, otherwise it will have limited impact. 

So you need both:
- classroom setting to introduce new ideas, build a shared perspective, and practice safely;
- learning, by doing, in daily activities, with proper guidance and support.

## Further reading 

- "Software development is a cooperative game of invention and communication" (from [Alistair Cockburn's book Agile 
  Software Development](https://alistaircockburn.com/)). In software delivery, we are continuously creating knowledge, 
  skills and know-how.
- Donald Schön, [The Reflective Practitioner](https://openlibrary.org/books/OL3511128M/The_reflective_practitioner) (1983) - about [reflective practice](https://en.wikipedia.org/wiki/Reflective_practice)
- Johanna Rothman, [A Management Minute: Train People on Skills They Need. 
  Period.](https://www.jrothman.com/mpd/management/2026/10/a-management-minute-train-people-on-skills-they-need-period/). Johanna makes the case for continuous learning and training people on the skills they need for their work.
- We have developed a [hands-on workshop to map different types of knowledge and skills within your 
  organisation](/specials/knowledge-workshop). 
  This 
  workshop will give you insight into the knowledge and skills you have and what you can do to manage this effectively.

_This blog post has been waiting as a draft for a long time. 
- [Paula Kolthoff, Embodied Learning](https://embodiedlearning.nl/) @@ say something_

<em>Photo "person wearing orange and gray Nike shoes walking on gray concrete stairs" © 2016 by <a href="https://unsplash.com/@bruno_nascimento">Bruno Nascimento</a> on <a href="https://unsplash.com/photos/person-wearing-orange-and-gray-nike-shoes-walking-on-gray-concrete-stairs-PHIgYUGQPvU">Unsplash</a></em>

<aside>
<h3>Get some practice</h3>
<p>Are you wondering how you can steer learning in your organisation? 
Let's have a chat about the skills and knowledge your organisation needs and what forms of learning will 
supprot that.
</p>
<div>
<a href="/contact">Contact us</a>
</div>
</aside>
