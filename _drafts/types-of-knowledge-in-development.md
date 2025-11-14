---
layout: post
title: Four types of knowledge in development - introduction
tags:
  - patterns
  - complexity
  - design
  - systems thinking
author: Marc Evers
image: TODO - create image representing 4 types (with some people figures in it)
---

Software delivery is knowledge intensive work. We are continuously learning, about the problems we're solving, about our users and customers, about how we can work more productively. We are building up knowledge in all kind of areas, but we are not always good at keeping the knowledge or making most use of it. Take working with legacy code for example, which often feels like a process of archaeology, rediscovering long forgotten knowledge.

In this post, we will explore different forms of knowledge that play a role in software delivery. We don't intend this to be a comprehensive overview of everything around knowledge, but rather a new, practical and helpful perspective. A richer perspective of different forms of knowledge will enable us to develop and keep knowledge more effectively. Knowing which type of knowledge needs which approach will reduce the chances of working "against the system", but rather use it to get more done with higher quality.

## Knowledge

Knowledge is a broad concept with several definitions. There is a whole field of knowledge management. We are using this working definition based on [Wikipedia's page on knowledge](https://en.wikipedia.org/wiki/Knowledge) (as of 24 October 2025):
> "Knowledge is an awareness of facts, a familiarity with individuals and situations, or a practical skill. (...)  
> It often involves the possession of information learned through experience and can be understood as a cognitive success or an epistemic contact with reality, like making a discovery. (...)  
> Knowledge is often understood as a state of an individual person, but it can also refer to a characteristic of a group of people as group knowledge, social knowledge, or collective knowledge. Some social sciences understand knowledge as a broad social phenomenon that is similar to culture."

As practitioners, we focus on what knowledge brings us: **knowledge influences behaviour**. Knowledge includes both factual knowledge and know-how (skills). In software development, we use knowledge to make decisions about architecture, design, code structure, tests, etc. Whenever we use the term 'knowledge', it also includes skills and know-how.

## Software development as knowledge creation

Developing, delivering and operating software products is not just highly knowledge intensive, it is also a process of continuously creating knowledge (learning). We are learning:
- about the market, about our users, stakeholders and what is value for them
- new technologies, frameworks, libraries, algorithms, and other solution components
- how to model our domains properly and get a deep, shared understanding
- how to create designs and solutions that fit the trade-offs we are dealing with
- how to work effectively with each other
- new practices that make us more effective
- how our software products behave in the real world with unforeseen interactions

We create knowledge through creating a product *together* &mdash; the result of our learning is not just code but a socio-technical system: the code, how it is deployed, documentation, manuals, the development team and its way of working, the organization around the development team that includes product managers, UX, support, management, the community of users. The knowledge we create gets embedded in our heads, our code, our organization, in the eco-system we are part of.

Feedback plays an important role in learning. From eXtreme Programming, agile development, DevOps & Lean Software Development, we already know about fast & early feedback (from the ways of DevOps) to amplify learning (one of the Lean Software Development principles).

Taking this perspective of seeing software development as a process of knowledge creation (rather that just creating software applications/services) allows us to manage explicitly for creating and keeping knowledge. This is key to becoming a highly productive software delivery organisation.

Knowledge plays such a pervasive role in our work. but it is also quite elusive. 

## 4 types of knowledge - a new perspective

We see four types of knowledge that play an important role in software development. This perspective is by no means comprehensive or complete, but it  aims at being useful for growing and keeping knowledge and skills in our organisations.

We distinguish these four types of knowledge that play an important role in software development:

1. **Explicit knowledge** - things that we can express and codify
2. **Tacit knowledge** - implicit, embodied, personal know-how that cannot be codified
3. **Systemic knowledge** - embedded in the human systems we are part of, groups, teams, departments; often referred to as "culture"
4. **Stigmergic knowledge** - embedded in the environments we work in

We are combining ideas from knowledge management, biology, Cynefin and systems thinking, as well as our experiences with software organisations.

Let's take a look at what these four types mean. We will dive deeper in follow-up posts, where we will elaborate on what the implications are, what works (and what doesn't) for growing and keeping that type of knowledge.

## Explicit knowledge - what we can express and codify 

Explicit knowledge has been codified, in documents, procedures, manuals, instructions, tutorials, etc. It resides explicitly in artifacts. Explicit knowledge is externalized (not confined in someone's head) and transferable.

'Codify' means expressing something explicitly in some (natural, formal, or semi-formal) language and is a broader concept than expressing something in source code.

Code contains explicitly codified knowledge about the domain, about how we solve the problems for our users. It is called 'code' for a reason. Domain concepts are for example reflected in classes and functions, comments are telling us what (not) to do. What has often not been made explicit is the rationale of solutions and decisions.

## Tacit - embodied knowledge

Tacit knowledge is know-how, skills, experience, intuition possessed by people, which are not codified and are hard to express or codify. Often this is embodied knowledge, e.g. riding a bicycle, playing a music instrument. Because tacit knowledge is hardly codifiable, it needs a different approach for transferring it. Transferring these kind of skills requires social and experiential learning. E.g. apprenticeships, learning by doing guided by an expert.

Because we cannot codify tacit knowledge, we cannot document everything that a developer needs to know. To share tacit knowledge, we need forms of social and experiential learning within the team. For example: if a team works with pull requests, a pull request review using written text is an unsuitable form to convey know-how from a more senior developer to a less skilled developer. For effective knowledge transfer, they need to sit and work together.

Earlier on, the idea was that tacit knowledge could be transformed into explicit knowledge through socialization and externalization, but more recent insights are that tacit knowledge is mostly uncodifiable and literally embodied - part of a person's body.


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

TBD: ref naar Snowden ("collective knowledge") die hier terloops iets over roept

## Stigmergic knowledge

[Stigmergy](https://en.wikipedia.org/wiki/Stigmergy) is a concept originally from biology. It is a mechanism of indirect coordination where actors modify their local environment. They leave traces for others to follow. The
trace left by an individual action stimulates the performance of a next action
by the same or different agent.

We believe that this concept is also useful within a software development context. So what is the 'environment' there? The code and other artifacts are (parts of) the environment a team works in. 

Artifacts like code contain all kinds of signs that influence developers' behaviour. In a code base riddled with null checks, the path of least resistance is doing more null checks. These are like desire paths. This is not a bad thing nor a matter of lack of discipline. It is actually our brain's nature to preserve energy as much as possible. Instead of spending/wasting brain power on rethinking everything, it takes less energy to follow the paths that are already there.

The (physical) office space also influences behaviour. Having everyone together facilitates communication and collaboration. A single wall or door in between can already have a big impact. What does this mean for working remotely?

Stigmergic knowledge is not about explicit team agreements on how to solve specific things in code or what to put where. It is about the shape of code and other artifacts that influence the behaviour, for bad or good.

Not everything in code is stigmergy. Code also contains explicitly codified knowledge like domain concepts reflected in classes and names or comments telling what (not) to do. It is also codified (by definition) solution to the problems we are trying to solve. The rationale is usually not explicitly codified in our experience.

A wiki that lists rules and guidelines are explicit knowledge that tries to influence behaviour, although when the desire paths in the code run differently from what the rules on the wiki state, the desire paths usually win.

## Consequences / how does this help?

**Conflicting sources of knowledge** - we could agree as a team on specific rules on how we do stuff in the code (explicit knowledge). This could however conflict with the existing stigmergic knowledge. There might even be a conflict with how some team members have learned how to do things (tacit knowledge). This can make it more challenging to bring change than you'd expect. Especially under pressure, when the tacit and stigmergic knowledge will be the path of least resistance. Being aware of the different types of knowledge at play is helpful.

**Resistance to change** - when wanting to change/improve something. be aware of the types of knowledge at play and how these e.g. keep the system as it is ("resisting change"). ... [Resistance as a Resource](https://dhemery.com/articles/resistance_as_a_resource/)

**An extra reason to invest in code quality** - ... for the stigmergic effects

**Investing in teams** - need to invest in team skills and development skills, give proper attention to team forming and other team dynamics; contributing to tacit and systemic knowledge. Don't over-focusing on "documentation" (although it is important for what can be codified!)

## Related work & further reading

- [Principles for managing knowledge
](https://cynefin.io/wiki/Principles_for_managing_knowledge)
- Ikujiro Nonaka & Hirotaka Takeuchi, The Knowledge Creating Company (1995); note: Takeuchi & Nonaka also authored the [New New Product Development Game](https://hbr.org/1986/01/the-new-new-product-development-game) article (in 1986) which was an important source for Scrum as we know it. @@bit more
- The [Agile Fluency® Model](https://www.agilefluency.org/) is also knowledge focused; specifically it focuses on growing skills as a team and becoming fluent in these skills.
- The [ASHEN framework](https://cynefin.io/wiki/ASHEN) is a method for mapping knowledge in an organisation. It has parallels: Artifacts = explicit knowledge, Skills = tacit knowledge; Heuristics = tacit/explicit; Experience = systemic knowledge
- There is a nice book called [Learning Histories](https://www.learninghistories.nl/post/nieuw-boek-learning-histories-vat-krijgen-op-je-organisatiecultuur) by Rik Peters which focuses on organisational culture basically being the resultant of its history (all the events that happened). This book is currently only available in Dutch. 
- We have run some exploratory workshops on stigmergy within a software context, at [Agile Cambridge 2023](/2023/11/25/stigmergy-agile-cambridge) and [Lean Agile Scotland 2023](/2023/09/20/stigmergy-lean-agile-scotland).

## Credits

Thanks Willem, [Arien Kock](https://www.linkedin.com/in/arienkock), and [Patrick Vine](https://agilitymatters.wordpress.com/about/) for the conversations and sharing of ideas.



<aside>
  <p>
Something
  </p>
  <p><div>
    <a href="/contact">Contact us when you're interested!</a>
  </div></p>
</aside>
