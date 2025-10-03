---
layout: post
title: Practices are Patterns
tags:
  - architecture
  - patterns
  - systems thinking
author: Marc Evers
image: /attachments/blogposts/2025/forces.png
---

In this post, we'd like to offer a different perspective on practices.

People try something in their team, it works great, then they go out in the
world trying to sell everyone on that practice (yes, we did that too when we
started out with eXtreme Programming in the early 2000s). When such a "best practice" goes out in the wild, it will work for some, but less so for others. We end up with "Why you should do Test Driven Development (TDD)" vs "TDD does not work" posts, which do not help advancing our field.

A practice fits in a context. It resolves specific forces in a specific context. So it is actually a pattern. 

![Depiction of set of forces interacting in a context](/attachments/blogposts/2025/forces.png)

## Introduction

Our trade and this year's "methodologies" (agile, scrum, DevOps, SAFe, cloud native, ...) are full of "best practices"; vendors, consultants, coaches push these on the organisations and teams they work with; 

we saw this with agile; teams were coached (often actually more coerced) into adopting scrum practices like sprints, daily standups, backlog refinements, sprint retrospectives, roles like product owners and scrum masters (under promises of delivering faster, doing more work in less time, being agile)

sometimes this works, teams become more productive
other teams complain about all those meetings, talk about 'rituals', going through the motions, eagerly waiting to get back at "work"; even though the agile coach, scrum consultant, or scrum master explained why the team is doing these, the developers; "this practice worked for me (so it should also good for you!)"


working in short cycles is a good thing right? just like daily checking in with the team on progress and impediments so we can help each other out, or reflecting frequently and adjusting how we work? so what are we missing? is this a matter of the team is not doing the practices well enough? do we need more explanation on why these "best practices" are good?

## A different perspective on practices

We think part of the problem is how we think about/regard practices. Often people regard a practice in isolation, as something that is (generally) a good thing to do; as things that have proven themselves in the field, so we should be able to apply them; often it's used as a kind of recipe that we can follow to achieve 'goodness' (the practice has already proven itself so we don't need to)

We use a different perspective on practices; see practices not as isolated good or proven things you can do, but as patterns:


<div class="shout-out">
  <div>
    <img src="/attachments/blogposts/2025/forces.png" alt="forces">
  </div>
  <div>
    <p style="text-align: left;"><strong>What is a pattern?</strong></p>
    <p style="text-align: left;">'Pattern' has different related definitions, we like to use the one by Christopher Alexander from he 1970s (which has also been a source for software design patterns):</p>
    <p style="text-align: left;"><em>"Each pattern describes a problem which occurs over and over again in our environment, and then describes the core of the solution to that problem, in such a way that you can use this solution a million times over, without ever doing it the same way twice.”</em> (A Pattern Language, p.x)</p>
    <p style="text-align: left;">A pattern describes the context (which includes the larger patterns it completes), the problem, and the solution as a field of relationships required to solve the stated problem in that context.</p>
  </div>
</div>

The original Extreme Programming book already hinted at this by presenting practices being part of a web of practices which support each other; a practice works in the context of other practices.

![Extreme Programming web of practices (partial)](/attachments/blogposts/2025/xp-web-partial.png)

So a practice resolves forces in a specific context. That means that whenever we are talking about a practice, or recommending one, or trying to implement one, we need to be aware of the applicable context for this practice and how it fits the current context.

TBD: examples + counter example

It also means that when we are enthusiastic about a practice or think it is a very good idea, we should present not only the practice itself but also share something about the forces it intends to resolve, the possible consequences, the trade-offs behind it.

TBD: example

## From best to good fit

This also helps getting rid of calling something a "*best* practice", which we are so eager to do in our trade. A "best practices" implies that there is nothing better and detaches a practice from context - 'best' often implies 'universally applicable'. It takes away opportunity to discuss actual fit to the situation at hand ('best' leaves little room for arguing) or considering trade-offs ('best' implies all trade-offs are in favor of this practice).

So no 'best practice', but rather 'good practice' (leaving room for situation fitness and finding even better practices) or - even more appropriate - a practice that is a good fit for this situation.

If we seek 'best' i.e. universally applicable things,
these tend to be at a different level, more like principles. [Simon Wardley's
doctrine principles](https://learnwardleymapping.com/doctrine/) - standard ways
of operating and techniques that you almost always should apply - is a good
example. These principles are at a higher abstraction level than something concrete like a Definition of Done. This enables generativity for the principles - fitting/applying it to your specific context.


TBD (of aparte post?): unintended consequences; eg story points; bad or good!
(-> you might learn sth new about context/applicability; unintended consequences could also be beneficial!); example: mocks (well-defined, bounded applicability, widely used outside, people hate mocks)

## Discovering context

So how do you learn what context a practice is a good fit for? Practices are usually discovered:
1. Someone tries something or observes specific behaviour, for example: when there is a serious & urgent production issue, teams tend to work closely together, sync'ing frequently so that they can steer their efforts and incorporate new insights effectively; together with the observation that when people do a meeting standing up, the meeting tends to be short & focused; this gave rise to trying daily standups, not just for emergency work but also for normal work (broadening the applicability).
2. Having discovered such a behaviour, they start sharing it, e.g. at conferences or meetups, in blog posts. Their message is basically "this worked well for me, I think it is useful for others as well".
3. More people start "selling" the practice. They advice to teams to start do it or coach/mentor/guide/force them into doing it.
4. As more and more teams are trying it, there will be success and failure stories. This often follows a kind of hype cycle, first people are overly enthusiastic, then the "it does not work" critics come along. Both the success and failure stories are actually useful, because they provide information about the boundaries of bounded applicability and the consequences.

Although a lot of evidence for practices remains anecdotally (with calls to authority), there is also a slowly growing body of evidence coming from research. Initiatives like the annual [DORA research](https://dora.dev) and the [research done by Cat Hicks](https://www.drcathicks.com/research) provide more and more insights.

## Implications 

So what does this way of looking at practices bring us?

- Regarding a practice in isolation is not useful, and could even be harmful. To apply a practice properly, we need to know which forces it resolves, the underlying trade-offs and consequences, any counter-indications. 
- We don't find it useful to talk about why a practice works or does not work; writing an agitated blog post about "why Test Driven Development does not work" is not useful. Sharing how you tried TDD and how you found a specific situation where it was a lot of work and provided limited benefits does provide useful knowledge.
- Copying a practice that seems to be working for someone else without taking situation and history into account will probably not give the desired results. The value of studying the visible behaviour of successful teams or organisations do is limited without context knowledge.
- Don't impose or "install" a practice on someone or a system like team, group, or organisation. Focus on how it fits the situation at hand. Disregarding context can even backfire - people picking up a dislike for e.g. Test Driven Development because it has been pushed upon them with proper regard for the context they are in.
- Failure stories are as important as success stories, as long as these are beyond the "I tried this for 30 minutes and it didn't work". Failure stories help find boundaries and trade-offs. Furthermore, people learn more from failure stories than success stories (+Snowden reference?).
- A practice is pattern; it is not a recipe. It is not something you can follow blindly, to get a guaranteed result. Learning a practice often involves some (or substantial) skills and know-how. It also needs to be made fit it to the situation. Heuristics can help if these are available. Stories from others can also help.
- It can still be useful to experiment with a practice - "let's try this and see what happens". Make this an informed "try"; look for success or failure indicators, and for unintended consequences. You might learn something new about context or applicability; unintended consequences can also be beneficial!


> **Nothing new?**  
> This is not a new perspective by the way. <a href="http://www.extremeprogramming.org/">Extreme Programming</a> with its 12 practices and underlying principles and values was born from in the 1990s from the patterns community. This has been an important source for us on how to look at practices.  
> Another source has been the Cynefin sensemaking framework, e.g. for the concept of <a href="https://cynefin.io/wiki/Bounded_Applicability">bounded applicability</a> of practices.

## References

- Christopher Alexander, [The Timeless Way of Building](https://www.patternlanguage.com/bookstore/timeless-way-of-building.html) &  [A Pattern Language](https://www.patternlanguage.com/bookstore/pattern-language.html)
- [Cynefin framework](https://cynefin.io/wiki/Cynefin)
- Kent Beck, [Extreme Programming Explained (1st edition)](https://openlibrary.org/books/OL18104604M/Extreme_programming_explained)
- Cat Hicks' [Research on software teams](https://www.drcathicks.com/research)


<aside>
  <h3>TBD</h3>
  <p>TBD</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
