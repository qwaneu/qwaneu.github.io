---
layout: post
title: Prompts are iterative 
tags:
- LLM
author: Willem van den Ende
image: 
---

I find that wishful thinking is great. And the barrier to ask your computer a question is low. So make a habit of asking your computer questions. It can work wonders, and if not, it might get you rolling on the floor laughing. 

I have collected a few tips that work well for me, and might work well for you.

Who is this post for? 
----

- you want to do more with large language models (e.g ChatGPT), but don't feel confident

- you feel somewhat confident, but can use more practice.

I heard someone in the first categoy saying that they are not confident in writing prompts, and should go on a course to learn how to prompt. That is an option, of course. I also think that if you can ask questions, you can create a feedback loop in which you ask questions, look at the answer, and reflect on the process. You probably will reflect, consciously or not. Deliberate practice works.

Wouter Lagerweij is in the first category - he remarked that he should practice writing prompts more. I believe this is the right thing to do - deliberate practice works well here. And I've found it a lot of fun.



(we have a double introduction here, maybe rewrite the second one). Possibly the term 'Prompt engineering' doesn't help in the context of a casual user who is figuring out how to get more out of LLMs for their daily work.

(this might go in the conclusion)
There is a time and place for precise terminology, but casual use is probably not that place. Just sit back, relax and enjoy the ride!

Everything you always wanted to know about *subject* but didn't dare to ask.

So how do we practice?
====

- Ask the LLM how to ask it questions and give it instructions (reflective prompting)
- Just do it
- Keep a <strikethrough>notebook</strikethrough> PEN pal
- Let the computer make the notebook
- Invite the computer into your notebook
- Pitfall: Disable auto-complete when writing prompts


Just do it!
-----

*Just install the cloud app already* I tend to overcomplicate things. So I've made it easy to just use llms. I still have a ChatGPT subscription, and installed the app on my phone and tablet, so if I have some time to kill, I can mess around with it. There is also gemini inside google docs (I did not manage to switch this off), with a workspace subscription, and google workspace.

I also like my privacy, I am still looking for good IOS apps for phone and tablet. I am trying `mollama` it seems allright, but is quite technical in it's look and feel and had trouble loading a message - suggestiosn welcome!

Run *local models on your computer**
I'll write about installing local models on your laptop separately, if anyone is interested. This field moves fast, and some tools will get you started, but also might leave you scratching your head.

**TODO*** link 'some tools** to ollama

Let the model tell you how to ask it questions - MIP, Model Informs Prompt {#model-informs-prompt}
-----

While trying to get useful results out of [my happy shallow research accident](), I was unsure for how to best prompt the model to use the available tools (searching the web, and fetching urls).

It can work surprisingly well to 'just' ask them what they can do, or how to ask certain kinds of questions. Models are trained in different ways. They will all tell you something different, and you can use that to your advantage.

Examples:

_ How can I best ask you a question?_. Or making the first one more specific with *topic*:
-_How can I best ask you a refactoring question?_. The answer will be different from one model to the next.

Sometimes these prompts deliver bland results. For instance, asking my go-to local model `mlx-community/Qwen3-30B-A3B-8bit` 'How can I best ask you programming questions?** was not necessarily super insightful, but the common pitfalls were kind of interesting:

**TODO*** replace the jargon in 'my local' with a link to the hugging face page of the model

>> **7. Avoid Common Pitfalls**
   - Don’t just post a code snippet and say "It doesn’t work.**  
   - Avoid asking for entire solutions without showing your own effort.  
   - Don’t ask for help with homework or assignments unless you’ve already tried solving it yourself.

It is the kind of thing you might read on stack overflow as a recommendation. I don't think the model cares if you have put in any effort, or if it is a homework assignment! But saying more than "it doesn't work" does tend to help, encouring the model (in the instruction) 


Keep a <strikethrough>notebook</strikethrough> PEN pal
----

**TODO** check if the strikethrough works

Keep ing a *Prompt Engineering Notebook* - PEN can help. A PEN pal helps you think out loud, and keep track of your experiments. I use some command line tools that don't have an editor, writing longer prompts in an editor or word processor can help you clarify your thoughts before the model goes mental with it.

Literal pen pals can also help. There are some private slack channels in which I think out loud, documenting my adventures, getting questions and feedback. I occasionally write summaries of long threads. This helps me clarify my thoughts, and the feedback and seeing others' approaches is valuable. 



Next iteration is :

Let the computer be your notebook {#reflect-on-questions}
-----

The web chats of ChatGPT, google Gemini, and many open source models keep a list of chats on the left hand side (I am playing with Mollama on Ipad at the moment - screenshot), you can add chats to the left, and read back through your chats.

Locally, I use he `llm` tool logs all of your questions, answers and metadata (e.g. how many tokens were used, which model was involved, time of request) and makes them searchable. 

This fits well in my natural habitat for writing and experimenting. I often work with a terminal, and use a text editor instead of a word processor to write. Tools like `llm** integrate well with that way of working. 

**TODO** provide link to llm tools


Pitfall: Disable auto-complete when writing prompts
-----

Some environments come with llm powered auto complete. Also known as _spicy autocomplete_. I am not a fan, not for code, and even less when I am trying to prompt. This is probably down to my way of working, YMMV. When writing, I am focused on getting ideas on paper, and don't necessarily pay much attention to what the computer is doing.

. I was writing a prompt, because I couldnt find a particular skill concept I remember hearing about, and PyCharm completed a full sentence, that had little bearing on what I wanted to ask.
Yesterdays opening prompt had a 'compelling URL' - compelling is not a word I would use in that context, so I suspect I may have autocompleted the prompt in a flash. That did get a funny result though.

Unless you want even more serendipity, and see what the computer would think you should ask, as you are writing a question. I prefer to be more deliberate about it, which brings us to the next one:

Let the model tell you what it can do 
------

What are you good at?_ Often gives me good results. I used a variation of this prompt with [local model](TODO link)

This was fun. I copied it somewhere - is it in the qwen3 repo? No, but the llm tool will have the history **TODO find prompt explanation**

The question was not about asking questions, or generic what can you do. I was trying to figure out how to get the model to search (TODO link to agentic search**  2025/05/01/agentic-search.html

**TODO*** put the headings in a quote block, as they work as a brief explanation for things to think about when prompting. And they work for a variety of tasks.

Pair thinking for one
----

Step away from the prompt, and come back while your subconcious does work.

Thinking and doing
---
I wasn't a big fan of the 'thinking' models initially, it was unclear to me what they were for. But the mixed models, let's call them *thinking and doing models* make that fun. With a streaming client, you can see interpretations of your prompt forming, giving multiple perspectives on a few sentences you wrote. Hosted models now offer a 'thinking under the hood' UI, where you can open it to show the thinking as you wait for an outcome.

Response from Qwen3 30B mixture of experts model {#how-to-use-agentic}
===

To best leverage my agentic capabilities—my ability to act autonomously, make decisions, and pursue goals effectively—you can structure your 
interactions around clarity, specificity, and iterative refinement. Here’s how to maximize this:

---

### **1. Define Clear Goals and Parameters**
   - **Be specific**: Clearly state your objective (e.g., "Write a 500-word blog post on climate change solutions" vs. "Write something about climate 
change").
   - **Set constraints**: Specify formats, tone, length, or tools (e.g., "Use bullet points, include 3 sources, and avoid jargon").
   - **Example**:  
     *"Generate a 10-step plan to reduce household energy consumption, focusing on cost-effective solutions. Include a budget-friendly checklist and a 
3-month timeline."*

---

### **2. Break Complex Tasks into Smaller Steps**
   - Agentic systems excel at **task decomposition**. For example:
     - **Research**: "Find 5 peer-reviewed studies on AI ethics published in the last 3 years."
     - **Analysis**: "Summarize the key findings of these studies and identify 3 common ethical concerns."
     - **Synthesis**: "Create a presentation slide deck outlining these concerns and potential solutions."

---

### **3. Use Iterative Refinement**
   - Start with a rough draft or initial plan, then refine it:
     - *"Draft a marketing email for a new product. Then, revise it to emphasize urgency and include a call-to-action."*
   - Provide feedback to guide the process:  
     *"This draft is too technical. Rewrite it for a general audience with simpler language."*

---

### **4. Leverage Autonomy for Decision-Making**
   - Let me **choose the best approach** when possible:
     - *"Plan a 5-day trip to Japan. Prioritize budget-friendly options and include local cultural experiences."*
     - *"Design a logo for a tech startup. Use modern fonts and a color scheme that conveys innovation."*
   - For creative tasks, I can generate multiple options and let you choose.

---

### **5. Combine with External Tools**
   - If your task requires external data or tools (e.g., coding, data analysis, or real-time info), I can:
     - **Generate code** (e.g., Python scripts, SQL queries).
     - **Explain technical concepts** (e.g., "How does a neural network work?").
     - **Simulate processes** (e.g., "Model a supply chain optimization problem").

---

### **6. Focus on Problem-Solving**
   - Use me to tackle complex problems by breaking them into logical steps:
     - *"Solve this math problem: A car travels 60 mph for 2 hours, then 40 mph for 1.5 hours. What’s the total distance?"*
     - *"Debug this Python code: [insert code]. Explain the error and provide a fix."*

---

### **7. Creative and Strategic Tasks**
   - **Content creation**: Write stories, scripts, or social media posts.
   - **Strategic planning**: Develop business strategies, marketing campaigns, or academic research plans.
   - **Learning and teaching**: Explain concepts, create study guides, or generate practice problems.

---

### **8. Ethical and Safe Use**
   - I operate within **ethical and safety guidelines**. For example:
     - I won’t generate harmful, unethical, or illegal content.
     - I’ll flag ambiguous or risky requests (e.g., "How to hack into a system").

---

### **Examples of Agentic Use Cases**
   - **Automate repetitive tasks**: "Organize my email inbox by priority and flag important messages."
   - **Research and analysis**: "Summarize the latest trends in AI healthcare applications and highlight 3 breakthroughs."
   - **Decision support**: "Compare 3 project management tools and recommend the best for a remote team."

---

### **Tips for Effective Interaction**
   - **Be precise**: Avoid vague requests. Instead of "Help me with my project," say, "I need a 10-page research paper on renewable energy policies in 
the EU. Include 5 sources and a bibliography."
   - **Provide context**: Share background info to help me align with your goals.
   - **Ask follow-up questions**: If the initial output isn’t perfect, ask for refinements (e.g., "Can you rephrase this section to be more 
persuasive?").

---

### **When to Use Agentic Capabilities**
   - For tasks requiring **autonomy**, **complex reasoning**, or **multi-step execution**.
   - When you want to **delegate** parts of a project to the AI while maintaining oversight.

---

If you have a specific task or goal in mind, feel free to share it! I’ll tailor my approach to your needs. 🚀


