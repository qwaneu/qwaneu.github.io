---
layout: post
title: Model Informs Prompt - let the model tell you how to ask it questions 
tags:
- LLM Heuristics
author: Willem van den Ende
image: 
---

It can work surprisingly well to ask a Large Language model what it can do, or how to best ask it questions.
The emphasis is on _surprisingly_ - no guarantees, we are playing with randomness after all. They will all tell you something different, and you can use that to your advantage.

While trying to get useful results out of [my happy shallow research accident](), I was unsure for how to best prompt the model to use the tools I had made available to it: searching the web, and fetching urls.

Model Informs Prompt 
===

TODO expand on introduction *prompts are iterative*. The things I ask models changes over time, as I consciously or not, add to the Heuristics I use, and my understanding of what particular tools and models are good at.

Examples:

* How can I best ask you a question?

Making the first one more specific with *topic*:

- How can I best ask you a *refactoring* question?. 

The answer will be different from one model to the next. This a fun exercise, and often 


Sometimes these prompts deliver bland results. For instance, asking my go-to local model `mlx-community/Qwen3-30B-A3B-8bit` 'How can I best ask you programming questions?** was not necessarily super insightful, but the common pitfalls were kind of interesting:

>> **7. Avoid Common Pitfalls**
   - Don’t just post a code snippet and say "It doesn’t work.**  
   - Avoid asking for entire solutions without showing your own effort.  
   - Don’t ask for help with homework or assignments unless you’ve already tried solving it yourself.

It is the kind of thing you might read on stack overflow as a recommendation. I don't think the model cares if you have put in any effort, or if it is a homework assignment! But saying more than "it doesn't work" does tend to help, encouring the model (in the instruction) 

Let the model tell you what it can do 
------

What are you good at?_ Often gives me good results. I used a variation of this prompt with [local model](TODO link)

This was fun. I copied it somewhere - is it in the qwen3 repo? No, but the llm tool will have the history **TODO find prompt explanation**

The question was not about asking questions, or generic what can you do. I was trying to figure out how to get the model to search (TODO link to agentic search**  2025/05/01/agentic-search.html

**TODO*** put the headings in a quote block, as they work as a brief explanation for things to think about when prompting. And they work for a variety of tasks.

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
