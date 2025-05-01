---
layout: post
title: I accidentally made a shallow research tool 
tags:
- LLM, 
author: Willem van den Ende
image: 
---

I accidentally made a local shallow research tool, while learning about Large Language Models. As a small LLM put it: "This tool simplifies your research process, making it more effective and efficient for deep learning".



Summary
=====

This archtectural spike lets you use an LLM to search the web and get links and summaries as you wish. Where is the code? [on QWAN's freshly minted git server](https://gitea.apps.sustainabledelivery.com/mostalive/agentic-search/src/branch/main/) There are also [more detailed notes on some queries](https://gitea.apps.sustainabledelivery.com/mostalive/agentic-search/src/branch/main/notes)

It is fun to use, and gives me search queries and results I would not necessarily have come up with myself. I like serendipity.


What is it good for, in more words?
----

As the [tiny Local Language Model that could](https://huggingface.co/Qwen/Qwen3-0.6B) once said:

>  **Optimize Your Research with a Local, Efficient Tool**
>
>  Our local shallow research tool is now fully optimized for clarity and speed. By leveraging the most compelling URLs, we ensure your findings are not only accurate but also directly tied to your learning objectives.  
>  **Key Benefits:**
>    1. **Efficiency:** Rapid access to the most relevant resources, saving time and effort. 
>    2. **Clarity:** Direct and easy-to-understand interpretations of the data, ensuring your learning is focused. 
>    3. **Customization:** Tailored for your specific context, delivering the best possible outcomes.

I couldn't resist playing with it. I found my original intro a bit to dry and duplicated. If you want a differtent one, run this

``` bash
echo "I accidentally made a local shallow research tool, while learning about Large Language Models. Based on your prompt, it will search duck duck go and present the most compelling urls, with an interpretation guided by your prompt." \
  | llm -m qwen3:0.6B 'Remove duplication from this text, and make it more clear, touting the benefits of the tool'
```

Link to the `llm` tool further down.

Backstory
=====


I have been enjoying ChatGPT's deep research feature that came out recently. I'll tell you about that later. I also have been enjoying local Large Language Models (LLMs) for programming and sometimes summarizing sources or my own writing. For programming the qwen2-coder models 

Since I wrapped up two challenging projects last month, I finally have more than the hour here and there to dive further into it. I want to both get better at using LLMs for programming, and also understand how they work. Marc suggested earlier this year that I write a series of blogposts about my use of them, but I have been drinking from a firehose, and it is quite difficult to figure out a good place to start writing. This seems like a surprisingly good place, because it is not much code, and made clearer to me how large language models can use tools to do things like search the web, and fetch pages. I now have an intuition for how it works, you might get one too if you try it out. 

Yesterday I was looking at the new [Qwen 3 LLMs](https://github.com/QwenLM/Qwen3?tab=readme-ov-file) as I have been enjoying the qwen2 models for answering programming questions. LLMs are still very much trial and error, and they have some very small models now. So I downloaded a few sizes.

One of the more interesting new models is a larger model, that consists of a number of smaller models. It runs only one model at a time, and reports were that people managed to run this successfully on systems with limited GPU, but a fair amount of RAM. Rob, Marc and I have beefy laptops for development and running courses, but they don't necessarily have much in the way of GPU power.

I was also doing some _deep research_ with ChatGPT on doing searches and working with text from webpages. I have enjoyed the new 'deep research' functionality, and have been playing with googles' AI Studio and LM notebook, that also allow you to add links and documents, and let an LLM work on that. I wanted to have more of that locally. I have been piping my notes into [llm](https://github.com/simonw/llm) and played with doing that directly with `curl` like so:

``` bash
curl https://blog.logrocket.com/product-management/assumption-mapping-guide-examples \ 
  | llm prompt -m mistral7 'Summarize the previous, explain what assumption mapping is, and what the benefits are'
```

I needed to try a few models on that, as the javascript in the webpage confused some of them. So then it becomes more of an engineering problem than a whimsical query: how do I get the text out cleanly? Can I do this with multiple pages at a time?

ChatGPTs suggestions were interesting, and I learnt a bit about how LLMs were doing it. They were quite low level and hacky though, so  I put it aside for a bit. I would have gone ahead and done a spike with it, until I had a minor issue with getting  [this model](https://huggingface.co/Qwen/Qwen3-30B-A3B) running on my machine. I read the extensive Readme further, it had an example of [Agentic Use](https://huggingface.co/Qwen/Qwen3-30B-A3B#agentic-use) that already had a **fetch**' for fetching webpages. How hard could it be to add a search function?

Surprisingly hard. The devil is always in the details. But I can't complain about having a walking skeleton my own search and summarize tool that runs locally on my laptop after a days work, in much less than 100 lines of python code. Especially since until last week, I only used LLM tools out of the box, and did not do any programming with them. I'm quite happy with that!

Jargon buster
---

If you've been as baffled as I have by some terminology in this space, congratulations, you have now seen example of [Retrieval Augmented Generation (RAG)](https://blogs.nvidia.com/blog/what-is-retrieval-augmented-generation/). In this case, using search and urls to increase the knowledge availble to the model to reason about. 

And 'agentic' in our case means giving an LLM a description of some tools that it can use in textual form (well, actually, JSON),  a way for it to communicate back in text what tool it wants to use and how, and an interpreter with plugins that can transform that into an actual function call, or external tool invocation. It is text, functions and (random) numbers all the way down.


What's Next? {#whats-next}
========

Not sure. I think I will continue using my local search and summarize, mixed with just using small local models without search, as well as quick command line search without models. It is fun and kind of addictive to come up with these prompts and see what the llm comes up with, both in the outcomes as well as the search terms it uses and the 'thinking' it does.

I might make some improvements to the tool - have a proper CLI with the model and prompt as parameter. It would also be fun to have a chat interface, and I am wondering, since the LLM tool (see below) already provides that, if something like this could work as a plugin for that.

The tool is not very observable. For some things I have to look inside the `<think>` blocks the LLM provides, the search tool does provide some logging, and I let the jetbrains AI assistant with google gemini add some error handling and reporting. Progress is a long (depending on how many turns the model needs) list of dots, would be nice to have a spinner for instance. 

I started writing some [Rules of thumb](#heuristics), I've included them as bonus content in this post, as they also contain some learning from playing with the agentic search. These might turn into one or more separate posts. I got some feedback from Wouter Lagerweij, which already led to yet another heuristic. 


I am also thinking of making a video or blog post about refactoring this 'one python file' into separate responsibilities and adding the improvements above using Aider, an LLM based programming tool I have had good results with (when the random seeds are blowing my way ;-) ). As the LLMs would say: let me know if you want to know more about anything above !

Until next time, happy generating!


Further Reading
=======

- [Qwen 3 offers a case study in how to effectively release a model](https://simonwillison.net/2025/Apr/29/qwen-3/) By Simon Willison mentions the teamwork across organisations that went into releasing this model with broad support on day 1.
- [Qwen 3 0.6B Model announcement](https://huggingface.co/Qwen/Qwen3-0.6B) also has the agentic use sample, and suggested parameters. Plus an explanation of the thinking and non-thinking mode.
- [DDGR - Duck Duck Go command line](https://github.com/jarun/ddgr) ChatGPT suggested it, but it felt a bit hacky to integrate. Also ChatGPT missed a few parameters, to run it in non interactive mode, and get tue url out. `tldr ddgr` will tell you it is `--expand`. While I have not integrated it, I am using it, as it is fun and fast tu use (not to mention more exact than with an LLM).
- My detailed [Notes](https://gitea.apps.sustainabledelivery.com/mostalive/agentic-search/src/branch/main/notes/) with evaluation of some prompts, the process and duck duck qo queries used by the LLM and the results.
- The [Heuristics](#heuristics) section below has some rules of thumb, and some more observations from this experiment.


Bonus content: Heuristics, quick and dirty {#heuristics}
=====

I've collec:w
ted some Heuristics so far, and there are some next steps and further reading after that. I might split these out into separate posts later, but thought these rules of thumb might be of use if you consider working with LLMs. It was useful for me to write them out at least, and reflect on how I was working while putting this architectural spike together.

Heuristic - start small, increase power in models as needed {#start-small}
-------

When you are not looking for perfect results, but _good enough_ or _interesting_, smaller models often perform surprisingly well.
Smaller models are starting to perform better, month by month. Smaller models use less data and energy, and provide responses faster (in general).

Therefore:

Increase the power of the model as needed. Start with a small one, pick the next better one if needed.

Example:

**Search** For this post I accidentally started out with qwen 3 0.6B, a tiny model. The results were funny, but if and when it produced links, they were all to [example.com](example.com), although some of the paths after it looked plausble ish. So for real results I mostly used [hf.co/unsloth/Qwen3-30B-A3B-GGUF:Q5_K_M](https://huggingface.co/unsloth/Qwen3-30B-A3B-GGUF). A mixture of experts model that, while big in data, only uses one 3B part of the model at a time. This runs on my Macbook with apple Max 3 system on a chip without running the fans, and it is fast enough.

The last search I did was about Kagi search, and for some reason the 30B-A3B model kept coming back with answers in chinese. So I switched to qwen3:32b, which is a dense model. It is slower, spins up the fans, but produced results in English.

**Programming questions** As mentioned in the introduction, I have used the qwen2-coder models a lot since last fall, on a vintage coding project. They have largely replaced search queries for details like 'How do I do <X> with Kafka in CSharp'. I generally started with the 7B model - that runs comfortably in the GPU of my framework laptop, or on my mac, and then increased to 14B or 32B. The 32B made the fans spin and I could go tidy up around the house while I did it. Qwen3 smaller models seem good, and the mixture of experts model also runs quite fast, so I will be playing with those.

And now I can, if the local model does not come up with an answer, mix in facts from my own shallow research tool if needed. I think the theory behind this is that there are only so many facts you can train in to a small model, and adding search makes smaller models both more viable, and more accurate.

Consequences:

Less energy used, and usually faster responses, so better feedback loop.

It has only been one day, but I generally preferred the 30B-A3B model. Good enough results, does searches I would not have done - Serendipty in writing is not necessarily a bad thing.

Heuristic: Start fast, but inaccurate, so you can iterate {#start-small}
--------

A kind of corollary to the previous one, I started the agentic search spike with a 0.6B model. There were a lot of new models at once, in various formats, and I was not sure which ones would work with the tools on my mac. I started out with a big one, ignoring my previous heuristic ;-). And it turned out that the format I downloaded ([mlx](https://github.com/ml-explore/mlx-lm), optimised for M series Macs) did not yet work with [LLM, my go to local prompt tool](https://github.com/simonw/llm). 

The tiny model runs very fast, and that was handy when trying to find a search tool that worked. I tried three or four. Some had major issues, some minor, but having a model that goes fast makes that I could quickly try out a tool, and move on to the next when needed.


Heuristic : Make it run, make it right {#make-it-run-make-it-right}
--------

I was thinking and reading about [Retrieval Augmented Generation (RAG)](https://blogs.nvidia.com/blog/what-is-retrieval-augmented-generation/), but having something minimal that works makes it more relaxed to think about. I have some grounding and first-hand observations.

Getting something up and running was worth it.
I can search! Without clicking many pages, and get ok-ish (it is shallow in several dimensions) summaries and links that I can copy paste into my notes. Editing code for a prompt is not that bad - passing it in from standard out, like I do with the LLM tool would be nice - I often make a little markdown, or a block in my editor and pass that in.

There are many things to explore and improve, see [what's next](#whats-next)
