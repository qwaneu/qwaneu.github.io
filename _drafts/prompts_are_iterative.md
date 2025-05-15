---
layout: post
title: Prompts are iterative 
tags:
- LLM
author: Willem van den Ende
image: 
---


Wouter Lagerweij remarked *TODO exact quote** that he should practice writing prompts more. If at first you don't succeed etc. 

While trying to get useful results out of [my happy shallow research accident](), I was unsure for how to best prompt the model to use the available tools (searching the web, and fetching urls). The exact question has gotten lost in time, I did not use the `llm` tool that keeps track of questions and answers it seems (I could not find the question). 



Asking questions is a skill, practice makes better
-----

I find that, like in Test Driven Development, wishful thinking is great. And the barrier to ask your computer a question is low. So making a habit of asking questions works wonders. It works better if you don't have to think about remembering the questions and answers, hence the next item:

Use a tool that remembers your questions and answers {#reflect-on-questions}
-----

As mentioned, I forgot to copy-paste the prompt I used to ask the model about its agentic capabilities. I can guess from the answer, but it is not ideal. And I had to copy-paste them in my notes, which also does not always happen.


The `llm` tool logs all of your questions, answers and metadata (e.g. how many tokens were used, which model was involved, time of request) and makes them searchable. 

Disable the AI in your editor while writing prompts
-----

Unless you want even more serendipity. I was writing a prompt, because I couldnt find a particular skill concept I remember hearing about, and PyCharm completed a full sentence, that had little bearing on what I wanted to ask.
Yesterdays opening prompt had a 'compelling URL' - compelling is not a word I would use in that context, so I suspect I may have autocompleted the prompt in a flash. That did get a funny result though.


Let the model tell you how to ask it questions {#model-informs-prompt}
-----

Models are trained in different ways. It can work surprisingly well to 'just' ask them what they can do, or how to ask certain kinds of questions.


Asking `mlx-community/Qwen3-30B-A3B-8bit` 'How can I best ask you programming questions?' was not necessarily super insightful, but the common pitfalls were kind of interesting:

>> **7. Avoid Common Pitfalls**
    - Don’t just post a code snippet and say "It doesn’t work.**  
   - Avoid asking for entire solutions without showing your own effort.  
   - Don’t ask for help with homework or assignments unless you’ve already tried solving it yourself.

It is the kind of thing you might read on stack overflow as a recommendation. 

_What are you good at?_ Often gives me good results. or _How can I best ask you a refactoring question?_. The answer will be different from one model to the next.

Let the model tell you what it can do 
------

This was fun. I copied it somewhere - is it in the qwen3 repo? No, but the llm tool will have the history **TODO find prompt explanation**

The question was not about asking questions, or generic what can you do. I was trying to figure out how to get the model to search (TODO link to agentic search)  2025/05/01/agentic-search.html

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


