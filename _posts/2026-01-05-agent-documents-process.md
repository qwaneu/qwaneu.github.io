---
layout: post
title: Can an "agent" document your development process?
tags:
- LLM
author: Willem van den Ende
image: /attachments/blogposts/2025/hammock-driven-development.svg
---

One of the questions on my [Stochastic to Deterministic post](/2025/12/11/stochastic-to-deterministic.html), and the [meta post on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7404850582819348480) about what was left out, boiled down to: "can't you ask the coding agent to document the process"? (The actual question was more detailed, read on to find out).

Yes, that is possible. I didn't publish it immediately, because the order of the writing and the graphics suggests a much more up-front documentation process than how it works. For instance, the size and order of the images suggests a flow that is not as it feels like when working on QWAN Tracker.

Legibility
----

One reason for this, is that the process is not entirely legible for the agent. Admittedly, more of my process is now in written form, or can be derived from it, but what precedes the prompts in the agent, and what happens around it, is invisible to the agent. That means that you get documentation for the part of the process that is in writing.

Some examples of things that are not (yet) legible: The walking, the day dreams (hammock driven development), the chats with Claude desktop sketching ideas and code without running it, and iterating on that before committing to actually generating and running code, adding tests, copying and modifying stored prompts from other projects, generating more stored prompts.

Some of that can be retrieved from the chat history, but it is less explicit than the process encoded in the 'plan iterations', 'prepare iteration', 'start iteration' and 'check iteration' stored prompts.

> The agent documents the *written* process, not the thinking, so *context* must be explicitly added.

(quoted, as suggested by qwen3-thinking, see bonus content below)

My actual process, as I see it at the moment 
---

![Stick figure, lying horizontally. A thinking bubble saying: "Hammock Driven Development"](/attachments/blogposts/2025/hammock-driven-development.svg)


So the average process, as I perceive it, is mull over a problem, than at some point have a chat with a model on my phone to sketch out an idea. Sometimes that leads to a scaffold with code, other times a text file with a rough description of what it should do. Then I go over to a coding agent (Claude code in my case). I think if I need more stored prompts. Sometimes I 'just' scaffold a new site using the Phoenix LiveView scaffolding tools, and then let the coding agent do a small bit of work to merge the files I had generated, or quickly generate code based on the initial description. This is very much like the 'spike solution' of eXtreme Programming. I want to see the idea running, and play around with it.

Then I decide if I want to continue. At that point I might pull in stored prompts from another project that is close enough. I will tell the coding agent that I added stored prompts from another project, and how I think they should be adapted to this prototype. This is also often the point I will add tests for what is there, and then work test-first from then on. Or, occasionally, if the code is too messy, start over test-first, with the stored prompts I have to work in iterations. The iterations process is more accurate, but relatively slow. 

I am learning to sometimes stop shortly after that, for personal tools. Having gotten the 80% of the value that is 20% of the time, it is not always valuable to do the remaining 900% of work for the remaining 20% of the value.


Reasons to be careful
-----

Another reason to be careful is, that as Simon Wardley indicated, the agent is probably about 60% right, and 40% wrong, and it is up to you to figure out what are the right and the wrong bits. I think maybe with the recent versions of Claude Code and the Opus 4.5 model, it is more, but you can never be sure.

I probably should have published it with these caveats, suggestion of more structured process and possible errors, and let the readers decide for themselves. As a colleague pointed out, practices are still evolving. It is worth sharing what works, what doesn't, and what results come out.

Generated diagrams
----

Looking back, I asked Claude Code for diagrams of the process. The stored prompts are plenty of text, and a picture tells a thousand words. So [browse the pdf of the iteration workflow](/attachments/blogposts/2025/iteration-workflow/iteration-workflow.pdf) or [read the markdown](/attachments/blogposts/2025/iteration-workflow/iteration-workflow.md), with the diagrams in text.

On LinkedIn, I intentionally posted the last image, containing the json files and the markdown generated from it. The data is saying a lot about the process, and I could quickly see that it was accurate.

Original question for this post
----

The original question was from Hugh Greene:

>Can you get the LLMs to generate "blog post fodder" commentary on what they're doing, and what did/didn't work, as you go?!?

 my response, three weeks ago:

> I should try that again. I have used that in the past to improve stored prompts, or create new ones. I did start this morning with having Claude Code generate a document explaining 'our' process. But you'd have to read that bottom to top, otherwise the reader might think we execute precise specifications from the beginning. It had strong vibes' of Royce's paper, with feedback loops that readers would ignore, because of how the document flows. That is where the image in the post comes from.

What do you think?

<aside>
  <p>
Practices are evolving. We are figuring things out, as are you. We are considering rebooting our newsletter, if there is interest. If you'd like to subscribe, drop us a line, and we will add you to the list, so that we can figure things out together. We're also up for free 30 mins chats.
  </p>
  <p>
    <a href="/contact">Fill in the contact form to subscribe!</a>
  </p>
</aside>

Bonus content - the prompt and response used to improve this post
===

There was a TODO at the bottom of the post, to add an image, plus Hugh Greene's question and my initial response on LinkedIn. I run qwen3-thinking transparently in my writing environment, locally. it will take the last part of the text as a prompt, and write its' answer, by default, in the text below the question. 

I haven't done much with language models to support my writing yet, so I though you might find this interesting.

The text above is now different of course, as I incorporated some of the recommendations. Not all. Notice in the bold text that qwen got the order of Pareto wrong. That was because I wrote it down in the wrong order. In that sense this is a bit like some cases of TDD or double entry bookkeeping: seeing the same mistake twice, but worded differently makes it obvious.

I was thinking of making a YouTube short about this process, but as Matteo Vaccari said, posts only have value when they are in front of the reader. Same goes for videos, and I don't have time for that now.

Question and answer
----
Does the text above the TODO answer the question in the first begin_quote? Is this text clear to an audience of senior developers and engineering managers? What can be added, removed or reworded to improve quality?

Yes, the text answers the question. It clearly states:  
> "I should try that again... I have used that in the past to improve stored prompts... had Claude Code generate a document explaining 'our' process."  

**Clarity for senior devs/engineering managers**:  
- ✅ Strong on *practicality* (agent's 60% accuracy, "spike solutions", value/effort trade-offs).  
- ✅ Uses relevant terms (*spike solution*, *Wardley mapping*, *stored prompts*).  
- ❌ **"80% of work that is 20% of time"** is confusing → *rewrite as*: **"80% of the work delivers 20% of the value"** (classic Pareto).  

(I have fixed this now, so won't work for YouTube)

**Key fixes**:  
1. Replace:  
   > *"Having done the 80% of work that is 20% of the time..."*  
   With:  
   > *"I often stop at 80% of the work—which delivers 20% of the value—since the final 20% consumes 900% of effort."*  

2. Remove **"TODO add meta image"** (out of scope for audience).  
3. Tighten:  
   > *"mull over a problem"* → *"refine problem statements"*  
   > *"fledgling micro-product"* → *"prototype"*  

**Why this works**:  
- Addresses *their pain points*: agent limitations, documentation friction, value-focused delivery.  
- Shows *operational maturity* (self-critique, caveats, process refinement).  
- No fluff; every sentence ties to a concrete practice (stored prompts, test-first, Wardley’s 60% rule).  

**Final tweak**: Add one line to crystallize the core insight:  
> *"The agent documents the *written* process, not the thinking—so context must be explicitly added."*  

*(This directly answers the "how" and "why" behind the meta-post.)*
