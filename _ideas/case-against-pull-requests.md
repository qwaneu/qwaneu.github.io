---
layout: post
title: The case against pull requests
tags:
  - agile
  - patterns
  - complexity
  - systems thinking
  - eXtreme Programming
author: Marc Evers
image:
---


(Almost) everybody is doing pull requests + reviews (because everybody is doing it and tools support it); 

this is a practice from a low-trust context!

Reviewing is good; but there are alternative ways

What concerns are addresses by a process with PRs and reviews?
- reviewing code / 4 eyes principle
- find quality issues
- traceability of changes? (PR as a unit of meaningful change, less fine granular than commits)

**Practice outside its context**: Applying a low-trust practice does not help building high trust; 

**Patterns shape the interactions that take place there**
PRs+reviews as a practice might be influencing team work negatively:
- focus on individual contributions & working individually
- waiting to ask for feedback until it is good/right
- decreasing trust, review anxiety, seniors overloaded with checking contributions

**Late feedback / long feedback loops**: 
link to review anxiety/Cat Hicks
increases failure demand / waste: context switching, getting in the flow again;
no/limited learning effect (dev is already working on something else, wants to finish it asap) because the feedback is too far from the point where the behaviour took place (for learning you need feedback in/close to the moment)

**Unfit for skills transfer**
Design and development skills are for a large part tacit knowledge (or at least there are important tacit parts to it)
Tacit knowledge is not codifiable, so PR reviews can only address a limited part of knowledge/skills transfer

Reference to the Principles for managing knowledge:
- *We only know what we know when we need to know it* - that knowledge is situational and devs need to learn it in the moment (works less well if the feedback comes afterwards/much later)
- *We always know more than we can say, and we will always say more than we can write down.* 
- *The way we know things is not the way we report we know things* - which means that the (well-intended) things you write in the review is not the actual thing that the junior needs to learn.

For tacit knowledge transfer, you need social & experiential learning; working together, learning by doing/trying/making mistakes with some feedback and supervision
You also need mentoring/training "in-the-moment"


## References

[Principles for managing knowledge](https://cynefin.io/wiki/Principles_for_managing_knowledge)

+ some references about skills learning research
