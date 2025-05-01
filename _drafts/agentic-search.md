---
layout: post
title: I accidentally made a shallow research tool 
tags:
- LLM, 
author: Willem van den Ende, Rob Westgeest, Marc Evers
image: 
---

I accidentally made a local shallow research tool, while learning about Large Language Models.

I have been enjoying ChatGPT's deep research feature that came out recently. I'll tell you about that later. I also have been enjoying local Large Language Models (LLMs) for programming and sometimes summarizing sources or my own writing. For programming the qwen2-coder models 

Yesterday I was looking at the new [Qwen 3 LLMs](https://github.com/QwenLM/Qwen3?tab=readme-ov-file) as I have been enjoying the qwen2 models for answering programming questions. LLMs are still very much trial and error, and they have some very small models now. So I downloaded a few sizes.

One of the more interesting new models is a larger model, that consists of a number of smaller models. It runs only one model at a time, and reports were that people managed to run this successfully on systems with limited GPU, but a fair amount of RAM. Rob, Marc and I have beefy laptops for development and running courses, but they don't necessarily have much in the way of GPU power.

I was also doing some research with ChatGPT on doing searches and working with text from webpages. It was interesting, and I learnt a bit about how LLMs were doing it, and I would have gone ahead and done a spike with it, until I had a minor issue with [this model](https://huggingface.co/Qwen/Qwen3-30B-A3B) and read the extensive Readme further, it had an example of [Agentic Use](https://huggingface.co/Qwen/Qwen3-30B-A3B#agentic-use) that already had a **fetch***' for fetching webpages. How hard could it be to add a search function?

Surprisingly hard. The devil is always in the details. But I can't complain about having a walking skeleton my own search and summarize tool that runs locally on my laptop after a day, in much less than 100 lines of python code.




Heuristic - start small, increase power in models as needed
-------

When you are not looking for perfect results, but _good enough_ or _interestin__, smaller models often perform surprisingly well.
Smaller models are starting to perform better, month by month. Smaller models use less data and energy, and provide responses faster (in general**.

Therefore:

Increase the power of the model as needed. Start with a small one, pick the next better one if needed.

Example:

**Search** For this post I accidentally started out with qwen 3 0.6B, a tiny model. The results were funny, but if and when it produced links, they were all to [example.com](example.com), although some of the paths after it looked plausble ish. So for real results I mostly used `hf.co/unsloth/Qwen3-30B-A3B-GGUF:Q5_K_M**. A mixture of experts model that, while big in data, only uses one 3B part of the model at a time. This runs on my Macbook with apple Max 3 system on a chip without running the fans, and it is fast enough.

The last search I did was about Kagi search, and for some reason the 30B-A3B model kept coming back with answers in chinese. So I switched to qwen3:32b, which is a dense model. It is Slower, spins up the fans, but produced results in English.

**Programming questions**

As mentioned in the introduction, I have used the qwen2-coder models a lot since last fall, on a vintage coding project. They have largely replaced search queries for details like 'How do I do <X> with Kafka in CSharp'. I generally started with the 7B model - that runs comfortably in the GPU of my framework laptop, or on my mac, and then increased to 14B or 32B. The 32B made the fans spin and I could go tidy up around the house while I did it. Qwen3 smaller models seem good, and the mixture of experts model also runs quite fast, so I will be playing with those.

And now I can, if the local model does not come up with an answer, mix in facts from my own shallow research tool if needed. I think the theory behind this is that there are only so many facts you can train in to a small model, and adding search makes smaller models both more viable, and more accurate.

Consequences:

Less energy used, and usually faster responses, so better feedback loop.

It has only been one day, but I generally preferred the 30B-A3B model. Good enough results, does searches I would not have done - Serendipty in writing is not necessarily a bad thing.
