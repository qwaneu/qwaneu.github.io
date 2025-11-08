---
layout: post
title: Four types of knowledge in development
tags:
  - patterns
  - complexity
  - design
  - systems thinking
author: Marc Evers
image: TODO - create image representing 4 types (with some people figures in it)
---

Software delivery is "knowledge work". Developing software means knowledge creation - knowledge about solving customer problems and balancing trade-offs, knowledge about operating the software well, knowledge to be able to continue developing the software in the future.

In this post we want to zoom in on some specific forms of knowledge that play a role in software development. Knowing these types of knowledge enables you to make effective use of them but also to recognize the effects. It can help you to recognize when you are working "against the system" or where it's beneficial to direct your efforts.

Knowledge is a broad concept, there is a whole field of knowledge management, there's a body of knowledge about learning and training. For know, we use a working definition based on [Wikipedia's page on knowledge](https://en.wikipedia.org/wiki/Knowledge) (as of 24 October 2025):
> "Knowledge is an awareness of facts, a familiarity with individuals and situations, or a practical skill. (...)  
> It often involves the possession of information learned through experience and can be understood as a cognitive success or an epistemic contact with reality, like making a discovery. (...)  
> Knowledge is often understood as a state of an individual person, but it can also refer to a characteristic of a group of people as group knowledge, social knowledge, or collective knowledge. Some social sciences understand knowledge as a broad social phenomenon that is similar to culture."

We take a pragmatic perspective: **knowledge informs/steers behaviour**; in software development, developers use knowledge to make decisions about architecture, design, code structure, tests, etc.

Software development from a socio-technical perspective: it's not just the software that we are developing and maintaining, but also the teams and organisation structures around it, with their know-how (knowledge).

That sounds great but it is still quite broad and vague. Let's make it more concrete and practical.

Combining ideas from knowledge management, biology and systemic thinking, we distinguish these four types of knowledge that play an important role in software development:

1. **Explicit knowledge** - things that we can express and codify
2. **Tacit knowledge** - implicit, embodied, personal know-how
3. **Systemic knowledge** - embedded in the human systems we are part of, "culture"
4. **Stigmergic knowledge** - being part of the environment we work in

## Explicit knowledge - what we can express and codify 

Explicit knowledge has been codified, in documents, procedures, manuals, instructions, tutorials, etc. It resides explicitly in artifacts. Explicit knowledge is externalized (not confined in someone's head) and transferable.

Note: we're using 'codify' here in the sense of expressing something explicitly in some (natural, formal, or semi-formal) language. This can include source code, e.g. representing domain concepts and domain language explicitly in classes and names in the code. There is however more to code, as we will show below.

## Tacit - embodied knowledge

Tacit knowledge is know-how, skills, experience, intuition possessed by people, which are not codified and are hard to express or codify. Often this is embodied knowledge, e.g. riding a bicycle, playing a music instrument. Because tacit knowledge is hardly codifiable, it needs a different approach for transferring it. Transferring these kind of skills requires social and experiential learning. E.g. apprenticeships, learning by doing guided by an expert.

Because we cannot codify tacit knowledge, we cannot document everything that a developer needs to know. To share tacit knowledge, we need forms of social and experiential learning within the team. For example: if a team works with pull requests, a pull request review using written text is an unsuitable form to convey know-how from a more senior developer to a less skilled developer. For effective knowledge transfer, they need to sit and work together.

Earlier on, the idea was that tacit knowledge could be transformed into explicit knowledge through socialization and externalization, but more recent insights are that tacit knowledge is mostly uncodifiable and literally embodied - part of a person's body.

> **What about heuristics?**  
> A [heuristic](/2021/10/13/what-is-a-heuristic) is an explicit form that refers to some tacit knowledge. It is not a codification of the knowledge itself, but it can help transfer the knowledge (by having a name or short description for it) and enable a conversation about it.  
> Heuristics are a bit between explicit and tacit; a part is codified in a few words or sentences, and this is related to tacit knowledge. You still need social & experiential learning to transfer the whole thing, but heuristics help make tacit knowledge visible and discussable.

## Systemic knowledge

Taking a systemic perspective, a team forms a system, and is part of a larger system (department, business unit, organization, society). Team members themselves are also part of multiple systems, at work, at home, in their families.

These human systems are uniquely determined by their histories - by everything that has happened. So systems have a history and a memory, and in that way they have knowledge that influences their members' behaviour. This knowledge usually survives individual members, who might come and go. 

People often refer to this as "culture" (team culture, organisation culture), but we don't find the term "culture" very helpful. What we call culture is actually an emergent property, formed by all interactions and events over time [het is een resultante?]. This means that you cannot "change culture", you can only influence the events and interactions that will take place, and you'll have to deal with the history that's already there.

What does this mean for a software team? 

A team has a history (which starts forming the day the team starts forming), and something you could call a "team culture". It's "the way we do things in this team", often unspoken rules, norms and values. It's not written in documents or on the wiki, but you pick it up / feel it soon enough when you join the team. It is also about systemic order - who comes before who - and power. High impact events (often negative) are highly influential in forming "team culture". It is not always and not fully a conscious thing; it also plays at the subconscious level.

This plays a role in how a team makes decisions, also on technical things.

For example, a team member might dismiss a proposal for change saying "we tried this (a very long time ago) and it did not work", from a strong belief (even if all assumptions are outdated by now). Even worse, team members have this belief subconsciously but are unable to state it explicitly; instead, they will show all kinds of behaviour that look like "resisting" the proposed change.

Systemic knowledge is powerful, keeps e.g. a team together and can help a team to "survive" high pressure and setbacks. This stability also means that this is harder to bring change.

@@TBD: needs a few concrete examples!

Example: developing a habit of continuously doing small improvements, in code, tests, way of working, etc is very beneficial. We wrote about this earlier, in [Simple Acts of Kindness and Love](/2021/07/07/simple-acts-of-kindness-and-love).
If this is an individual developer's habit, the effect for the whole team might be limited. Or worse, if the team norm is a focus on just creating features fast and the rest works this way, it will cost a lot of energy for that individual to stick to the habit - rowing against the stream. When that individual leaves, nothing changes. Developing such a habit as a team is more difficult, but once the habit is there, it's much more powerful. The habit is not dependent on a single individual any more.

How can you influence this? (given that you cannot change history) You can learn about a team's history and the pivotal events that formed the team. Story telling and doing simulations/games can help to create shared experiences (see also ASHEN reference).

## Stigmergic knowledge

[Stigmergy](https://en.wikipedia.org/wiki/Stigmergy) is a concept originally from biology. It is a mechanism of indirect coordination where actors modify their local environment. They leave traces for others to follow. The
trace left by an individual action stimulates the performance of a next action
by the same or different agent.

We believe that the concept of stigmergy is also useful within a software development context. If we see the code and other artifacts as (parts of) the environment the team works in, we can also observe signs left behind in those artifacts that influence developers' behaviour.

This is not about having explicit agreements in a team on how to solve specific things in code or what to put where. It is about the shape of code (and other artifacts) influence the behaviour, for bad or good.

If we work in a code base riddled with null checks, the path of least resistance is keep on doing null checks in new code. We tend to follow the desire paths that are already there. This is not a bad thing nor a lack of discipline. It is actually our brain's nature to preserve energy as much as possible. Instead of spending/wasting brain power on rethinking everything, it takes less energy to follow the paths that are already there.

This can lead to undesirable behaviour. If we have an entangled code base with anemic data objects, lots of null checks, lots of procedural code, it will nudge developers to do more of it. If we want to move away to more maintainable code, we will have to go against the flow (which costs a lot of energy).

We can also apply this intentionally, realizing that every line of code we write will serve as an example for others, whether we like it or not. We can work on creating desire paths, nudging our future colleagues (and future self) towards something better.

@@TBD example from workshop: async org, team starts with ADRs, spreads across teams

Not everything in code is stigmergy? code can also contain codified knowledge (e.g. domain concepts) as mentioned before, it can contain comments about what (not) to do, a wiki/docs with some rules and guidelines, ... code is also a form of explicit knowledge - it is a codified interpretation of the problem and a solution deemed appropriate (usually without having codified the rationale) 

## Consequences / how does this help?

**Conflicting sources of knowledge** - we could agree as a team on specific rules on how we do stuff in the code (explicit knowledge). This could however conflict with the existing stigmergic knowledge. There might even be a conflict with how some team members have learned how to do things (tacit knowledge). This can make it more challenging to bring change than you'd expect. Especially under pressure, when the tacit and stigmergic knowledge will be the path of least resistance. Being aware of the different types of knowledge at play is helpful.

**Resistance to change** - when wanting to change/improve something. be aware of the types of knowledge at play and how these e.g. keep the system as it is ("resisting change"). ... [Resistance as a Resource](https://dhemery.com/articles/resistance_as_a_resource/)

**An extra reason to invest in code quality** - ... for the stigmergic effects

**Investing in teams** - need to invest in team skills and development skills, give proper attention to team forming and other team dynamics; contributing to tacit and systemic knowledge. Don't over-focusing on "documentation" (although it is important for what can be codified!)

## Related work & further reading

- [Principles for managing knowledge
](https://cynefin.io/wiki/Principles_for_managing_knowledge)
- Ikujiro Nonaka & Hirotaka Takeuchi, The Knowledge Creating Company (1995); note: Takeuchi & Nonaka also authored the [New New Product Development Game](https://hbr.org/1986/01/the-new-new-product-development-game) article (in 1986) which was an important source for Scrum as we know it.
- The [ASHEN framework](https://cynefin.io/wiki/ASHEN) is a method for mapping knowledge in an organisation. It has parallels: Artifacts = explicit knowledge, Skills = tacit knowledge; Heuristics = tacit/explicit; Experience = systemic knowledge
- There is a nice book called [Learning Histories](https://www.learninghistories.nl/post/nieuw-boek-learning-histories-vat-krijgen-op-je-organisatiecultuur) by Rik Peters which focuses on organisational culture basically being the resultant of its history (all the events that happened). This book is currently only available in Dutch. 
- We have run some exploratory workshops on stigmergy within a software context, at [Agile Cambridge 2023](/2023/11/25/stigmergy-agile-cambridge) and [Lean Agile Scotland 2023](/2023/09/20/stigmergy-lean-agile-scotland).

++++++++++++++++++++++++++++++++++++

- software development = creating knowledge (& encoding/capturing)
  - learning - about customers, needs, technology, dev skills, working together
  - building software + building team & org 
  - generate knowledge from feedback loops
  - feedback

- diff(what we expect it to be / what it is at the end)

- how are teams generating knowledge?

- old code base -> frustrated -> need to relearn
  - relearning ('spelunking') -> distribution of knowledge & capturing/embedding knowledge

knowledge -> different lenses, different stages of product (3X)
- captured knowledge vs knowledge to capture

capturing/distribution
- explicit: 
  - codify domain model in docs & code
  - codify software design in docs & code
  - codify rationale
- tacit
  - riding a bike
  - heuristics & principles
  - jr devs need sr mentoring/training!
  - microskills (when to do refact)
  - tacit domain knowledge
  - write down: what things are tacit

- stigmeric 
  - make it easy to do
  - people look at code and assume it is right
    - there's thing - I need to fit it in vs do simplest thing that works & refactoring (judgement/skills)
    - set up things - patterns of doing things right
    - vs micro level
  - outside code: room setup to facilitate collaboration

- systemic 
  - starts forming the moment a group of people gets together to do/achieve sth together
  - is persistent / durable / self-sustaining (good or bad)
  - social & experiential learning
  - mob/ensemble
  - simulations - shared experiences
  - telling stories
    - success stories - powerful if told by peers (teams, also mgt)
    - failure stories - actual learning
  - vgl. Snowden "collective knowledge" https://thecynefin.co/its-information-to-data-we-need-not-dikw/


[ ] elaborate on knowledge creation
[ ] link naar evidence based training



does it matter in the large? crappy skills but still making money?

we're ok at generating knowledge; how to use it? how to keep knowledge alive? how to keep it available?
- or is it intrinsic?


<aside>
  <p>
Something
  </p>
  <p><div>
    <a href="/contact">Contact us when you're interested!</a>
  </div></p>
</aside>
