---
layout: post
title: Software coherence
tags:
  - architecture
  - coupling
  - design
  - knowledge management
author: Marc Evers
image: 
---

Coupling and cohesion are two fundamental, closely related concept of software design. We have covered these 
extensively in our series on connascence. They play a big role in our work, the quality of what we 
deliver and the confidence we have in our changes.

Coupling and cohesion are both about change: if we make a change, what other parts need to change as well? What parts 
do we need to bring closely together because they always change together?

There is another important concept that affects our ability and confidence in changing software: coherence. In this 
post we'd like to explore what coherence in software design is and how we can use it. 

## Defining coherence

Kristen Maevyn has recently written an [insightful essay](https://maevyn.codes/decoherence) on the concept of decoherence in software and how AI use can
impact this. She defines decoherence as:

> **decoherence**: the accumulation of locally valid but mutually incompatible or redundant models within a system, such
> that the cost of change is dominated by translating among those models and preventing unintended side-effects.

So let's turn this around into a (working) definition of coherence:

> **coherence**: @@ the absence of locally valid but mutually incompatible or redundant models within a system, such
> that the cost of change is dominated by translating among those models and preventing unintended side-effects.

Coherence is not a thing yet in software design. A few people like Kristen have written about it. There is e.g. 
a post by Thomas Vilhena about [system design coherence](https://thomasvilhena.com/2019/11/system-design-coherence) and 
a recent post by Alberto Brandolini about [Code is still a side 
effect](https://blog.avanscoperta.it/2026/08/27/code-is-still-a-side-effect/). Alberto gives the following definition 
of coherence:

> How much the different artifacts support the same vision.

So it is about different parts of the design being based on (or supporting) the same model, idea, vision. It does allow 
multiple models for different concerns in the design. For most of our domains, we cannot force the whole design to 
conform to a single model. 

provide working definition of what we mean with 'model'

can be technical like frameworks and libraries used as well as functional/domain

Examples:
- Web frameworks come and go over time; in a 15 year old code base, we encountered at least 4 different 
  client side frameworks in use, including Prototype.js, jQuery and React. This means 4 ways of solving the same 
  problem, putting quite a knowledge burden on developers. Especially for older frameworks.

## Related concepts

### coupling/cohesion vs coherence

Coupling/cohesion and coherence are different properties. Coupling is about what needs to change together for the 
codebase to remain consistent. Cohesion is things that change together that have been put closely together. 

Coherence is related to coupling: coherent design means different parts use the same model or ideas, which means that 
when the model/idea is changed for one part, coherence decreases (you now have two parts based on different models) or 
you need to change the other parts as well to conform to the new model. 

### coherence vs consistency

consistency = "agreement or harmony of parts or features to one another or a whole" (Merriam-Webster dictionary)
coherence goes further, it is not just about agreement or harmony but also about using not more different models than 
necessary and using models that are compatible. It is about conforming to models (theory, idea, approach).

So just having different parts of a code base consistent with each other helps, but it does not make it coherent. The 
lack of a model increases the cognitive burden. It puts the burden of discovering an underlying model on the developers 
that need to change the code. 

### Coherence vs stigmery



### Coherence vs AI

Both Kristen and Alberto discuss this.

AI can generate code that is in line with the patterns present; the more consistent the patterns, the better the result 
is in line with them? claim: more 'patterned' is also easier to review/check

Humans need to guard and steer coherence, in particular domain coherence.

relate to stigmergy

## Measuring coherence



## Implications

Low coherence means:
- higher cognitive load of dealing with multiple (redundant) models; increases the risk of errors
- more about impact of coherence on defects and rework?
- knowledge/skills risk: you need to keep/guard knowledge about these different models; keeping the knowledge 'warm'
  costs effort & time; risk: old knowledge left the building
- less structure to fit new code/ideas in; less clarity on what belongs where; will increase coupling and decrease 
  cohesion (so coherence also provides direction for managing coupling, in the sense that using models helps in what 
  belongs where)

Investing in keeping coherence high is important. Otherwise, the maintenance effort and risks will increase.
"It works right now, doesn't it?" is not a good argument.

Keeping coherence high makes the code base more predictable and maybe even a bit boring. But this frees up headspace 
e.g. for focusing more on product and user impact.

## References

* https://blog.avanscoperta.it/2026/08/27/code-is-still-a-side-effect/
* https://maevyn.codes/decoherence
* https://thomasvilhena.com/2019/11/system-design-coherence
* Coherence is a thing in e.g. UX design? https://uxmag.com/articles/design-for-coherence-not-consistency

<aside>
<h3>coherent</h3>
<p>bla </p>
<div>
<a href="/contact">Let's have a chat</a>
</div>
</aside>
