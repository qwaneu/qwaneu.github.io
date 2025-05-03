---
layout: post
title: Prompts are iterative 
tags:
- LLM
author: Willem van den Ende
image: 
---


Wouter Lagerweij remarked *TODO exact quote** that he should practice writing prompts more. If at first you don't succeed etc. 

Asking questions is a skill
-----


Disable the AI in your editor while writing prompts
-----

Unless you want even more serendipity. I was writing a prompt, because I couldnt find a particular skill concept I remember hearing about, and PyCharm completed a full sentence, that had little bearing on what I wanted to ask.
Yesterdays opening prompt had a 'compelling URL' - compelling is not a word I would use in that context, so I suspect I may have autocompleted the prompt in a flash. That did get a funny result though.


Let the model tell you how to ask it questions {#model-informs-prompt}
-----

Models are trained in different ways. I picked this tactic up from somewhere **TODO was it Simon Willison?**. It can work surprisingly well. 


Let the model tell you what it can do 
------

Try different models
----

**TODO** link to start small heuristic. Iterating on a prompt can take a few forms. Trying different models, is easy, and low hanging fruit. Especially if you can store your prompts and point them at multiple models - the hosted models do this, OpenWebUI **TODO link** has this.

**TODO** can I get a RAG to go over all of the **TODO link** bits and find a link to put in?

Pair thinking for one
----

Step away from the prompt, and come back while your subconcious does work.

Thinking and doing
---
I wasn't a big fan of the 'thinking' models initially, it was unclear to me what they were for. But the mixed models, let's call them *thinking and doing models* make that fun. With a streaming client, you can see interpretations of your prompt forming, giving multiple perspectives on a few sentences you wrote. Hosted models now offer a 'thinking under the hood' UI, where you can open it to show the thinking as you wait for an outcome.
