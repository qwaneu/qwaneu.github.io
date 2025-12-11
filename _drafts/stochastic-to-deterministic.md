---
layout: post
title: 
tags:
- moldable development
- LLM
author: Willem van den Ende
image: 
---

I went on a little road trip the last couple of weeks, running three new sessions and our classic TDD and legacy code course at a long term client. So I have been able to dump some of my brain on people and come out with more rules of thumb and catch phrases that might help to explain how I work at the moment.

One of them is **Stochastic To Deterministic**. As someone said "I have always been doing this with software development. You always turn a messy question into code.". Now with a coding agent in the 'DevLoop', we are adding a different kind of non-determinism to it.

A coding agent, for the purpose of this discussion, is a program that uses a large language model to generate code, and to **select tools** to run. Using tools is important, as many people use coding assistants in an IDE (Integrated Development Environment) that only produce snippets of code. I adopted the term _spicy autocomplete_ for that. I use that sometimes for small bits of utility code, but did not find it very interesting for larger codebases. 

Working with tools allows us to iterate on the way we use the coding agent, and extend it by creating tools that make the coding agent more deterministic. This means a couple of things:

More predictable results
---

Prompt adherence, the extent to which a large language model executes what was asked, is improving. But the larger and more complicated the prompt, the lower the chance that what you intend actually happens. Reducing the size of prompts by using tools, and only letting the language model deal with summaries of tools' output makes for smaller, faster and more efficient contexts. This leads to more predictable results.

This comes at the cost of a lot of trial and error. [QWAN Tracker](https://qtracker.apps.sustainabledelivery.com/) feels like the first application where this works. But I carefully chose a solution that I guessed was in the training data (a task board) and a stack that I know could work well (Phoenix Liveview with Elixir). And then it felt like 90% process improvement, 5% Product and 5% Development.

Fitter, happier, more productive
---

'Tools' may sound fancy, but it can be a one line shell script. It can also be more. The main thing for me to start with, is that the script always does the same thing predictably, and I can review it if I want. It also runs faster, and uses fewer tokens - so it is also the environmentally sounder option.


We are less dependent on the coding agent
---

As we extract more of our knowledge and ways of working into executable scripts, we can replace the coding agent and/or the large language model it uses, and get similar results. This may allow us to do more with less powerful and power hungry models that run on our laptops, instead of cloud-based models.

In a way I feel like using the power of the Claude / cloud against it. But also with it. Coding Agents run tools well, and giving them focused tools yields better results, while also giving us options.

Programming as theory building
---

As we create the tools, we are building a theory, in code, of what our way of working looks like. If it is too rigid, and we need to go back to a prompt instead of a tool, this is feedback to us that our process is not exactly what we think it is. And this is ok. I like fluid ways of working. I also like software that works reliably, and am used to building things that 'just work' after they ship. So I don't have to look back, guess and debug, but can focus on the next thing.

Now what?
===

I wanted to write a longer blog post, about how I work this week, but [Stephan](www.domeinmodel.nl) suggested it demanded too much of the reader. This is my attempt at surfacing some of the trial and error. I intend to write more about *meta prompting* - how I use prompts to generate stored prompts and tools, and about the specific workflow for QWAN Tracker. As Stephan said,

We weten vanuit besturingstheorie, dat hoe groter de stappen die we nemen, en groter de cycle, des te beter iedere individuele beslissing moet zijn. Als we hele kleine stapjes kunnen zetten, maakt de kwaliteit van iedere individuele beslissing veel minder uit, zolang we snel kunnen toetsen of het de goede was en de beslissing terug te draaien is

translate the above into english



Further reading
===

Programming as Theory building, by Peter Naur, original 1985 paper is available as PDF: https://pages.cs.wisc.edu/~remzi/Naur.pdf, hosted by Remzi Arpaci-Dusseau at UW-Madison. There's also a copy at gwern.net (https://gwern.net/doc/cs/algorithm/1985-naur.pdf) which includes it alongside related writings.
The original publication was in Microprocessing and Microprogramming, Volume 15, Issue 5, May 1985 — but that's behind a paywall on ScienceDirect.
