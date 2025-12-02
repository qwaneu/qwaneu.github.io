---
layout: post
title: TDD in relation to generative AI 
tags:
- Last week in GenAI, LLM
author: Willem van den Ende
image: 
---

While I am writing less code by hand, paradoxically, the value of being able to do TDD and the practice of warmups increases drastically.

- Know what good looks like, in a visceral way
- Keep contact with the code
- Being able to decide the size of your steps
- Going where no LLM has gone before

Because you can do tiny, controlled steps you can always fall back on.

This is a somewhat handwavey post. Someone asked me last week about what I think about TDD in the light of coding agents and large language models. And this week, Rob and I are running a TDD course at one of our regular clients, who, according to a job ad, now use generative AI for code. So the goal of writing this out is for me to get to a one paragraph pitch on my position, and a link for details and literature.

This is this weeks' opinion, next weeks' may be different. Three weeks ago, I was about to throw my computer and my Claude Code subscription out of the window. But in the moment of giving up, thanks to a nudge from Stephan Eggermont (who uses these tools in a more limited way than I do), I made a wish, and got the code I needed (not the code I asked for - make it work, make it right) to breathe life into our bootstrapped startup.

Since April, I've been diving deep into working with coding agents for larger prototypes, at and beyond the edge of their capability, as well using local Large Language Models for lean startup chats and making small tools for myself, inside my current editor of choice. 

There are many reasons for this. I am always looking for better ways to deliver value through software (or without software). And in training courses over the last two years we have been getting questions about the use of AI coding assistants more and more regularly.


One of the reasons I started experimenting in depth with coding agents and local LLMs was that in the last two years, 

Teams with good practices are being accelerated by applying large language models to code. Teams with less than stellar practices are also sped up, generating problems faster.

I'm writing this while a coding agent is making a Kanban board (working title: QWAN Tracker) more accessible, following accessibility guidelines.


Conversational programming
Rob Bowleys' post from august, confirmed by DORA: AI accellerates teams with good practices
Be mindful of 'going faster' (let alone 'generating more code') as a measure of productivity. As with scrum, it is easy to forget that the price of software is paid long after the first lines have been written.

Small tools

Further reading

cat hicks

# The similarity: wishful thinking

One of our rules of thumb for TDD is [Wishful thinking](/2021-07-01-tdd-wishful-thinking.md):

> Write a test based on how you wish the object under test could be used. Then
make it work. Don't let yourself be limited by constraints and implementation
details... nothing is holding you back! Just write it as you'd wish it to be.

The scale can be different, and it translate to prompting roughly as

> Write a prompt, based on what you wish the computer would do for you. Don't worry about implementation details. Just write it as you'd wish it to be.

It may be a bit strange if you have been to one of our events to hear me say that. I normally don't even use auto complete, and now I've gone all in on coding assistants?

Rob, Marc and I are not very keen on autocomplete. It gets in the way of wishful thinking. When we are writing a test, we do not want to be disturbed by things that are already there. That constrains us to thinking about what already exists in the codebase - and what the tool digs up: what we want may be there, but not under the name we are using. Looking for what exists comes after that. We want to think about could be. This is a place of imagination.

And so is the prompt. Especially the initial one. Developing the initial seed of a game, based on an idea of my son, and seeing it run: pure magic. Especially with hardly any game development experience on my part. But that is only the first 80%. The other 80% of the work is in the remaining 20% of the functionality. Which brings us to details.


# A difference: the devil is in the details

For me, bootstrapping, it goes in all directions at once, on the one hand
Colleteral Edits, on the other hand, more thorough testing Bugmagnet and I make property based tests daily now. Formal methods are coming into reach of average people, so the number of phd hours per 1000 lines of code is probably decreasing as well.
