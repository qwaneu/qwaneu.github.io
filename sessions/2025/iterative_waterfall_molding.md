---
title: Going down the waterfall iteratively - molding a view on our vibes
layout: other-accessible
---

Session idea developed by Stephan Eggermont and Willem van den Ende.

Title
---

Going down the waterfall iteratively \- molding a view on our vibes

Abstract
----

With AI Assisted Development, creating code is cheap. Maintaining and running it maybe not. How do we know if we are still on track for a maintainable solution? Join us to work with us through a growing code base. How can we see what good looks like at scale? What can we visualise, what can we check \- so that our models get fast feedback.

Code is cheap, so is documentation. What if we iterate quickly on documentation, driving our LLM to co-create examples, then break it down into steps that can be developed in a BDD / ATDD / TDD cycle.

We lean on documentation much more than with a traditional "agile" workflow. We also generate much more code per unit of time. What do we do to track quality?

Code reading is slow. So if we generate lots of code, even well factored, reading will be slow. It would be nice if we could keep an eye on the overall quality of the code, and decide on a higher level what and when to refactor, and where we should maybe spend effort reading the code. 

Questions we would like our moldable tools to answer, so that we don't have to read all the code:

- Where does the code change, and how often?   
- What do our tests / specifications by example cover? How do they give feedback when they fail?   
- What does our model look like? What are the concepts and relations? Which relations have changed in the last couple of hours. Where are the change hotspots in our models, views and code?  
- Where does the model spend more time debugging? Which parts need(ed) most iteration? What things should we *not* ask the model, because it is incapable?

Learning outcomes
----

* **Fast feedback loop on internal quality:** Participants will gain insight into techniques for rapid feedback on the quality of AI-generated code.  
* **Refresh your perspective on what can be visualised on code, AI generated or not**  
* **Going fast with value delivery while staying in control of complexity**  
* **Useful visualisations to re-use or develop in your own work:** Participants will be exposed to practical visualizations that they can apply or adapt in their own development work. Moldable development enables prototyping and engineering of situational tools  
* **Rules and checkers that can be integrated:** Participants will learn about rules and checkers that can be integrated into their workflows to assess AI-generated code.

Intended Audience
----
Developers, Vibe coders who want to gain more insight in what goes on 'under the hood'. Anyone interested in visualisations.

Timetable / workshop process
-----

Participants work in pairs through a web browser. We bring a local host with containers they can work in. The virtual environment is set up with visualisation and check tools. There are a number of tags the participants will be invited to check out, each showing progress of a vibe Document and Test Driven session with different problems surfacing in the code that can be visualised.

We will choose a widely used programming language like python and a moldable development toolkit for the visualizations.. We currently have a Voice to Blog tool vibe TDD'ed that is a good starting point (161 tests, and makes text from voice with  but no idea). We may change this based on how the exercise works.

60 minute process
----

0 Introduction  
   What is AI Assisted Development  
   How do we see the resurgence of Document Driven Design working with Test Driven Development?  
   What problems do we encounter when generating masses of commits, tests and code quickly.  
15 Round 1 \- vibe TDD'ed code with some history of prompts and commits, only focusing on the outcome, not having looked at the code. What do we see? Visualizations: scope of change, and hot spots of change.  
30 Round 2 \- another, smaller step. See the changes. How would you prompt for changes? Visualisations: method size, complexity, coverage map. Visualise before and after.   
45 wrap up \- would this have gone faster if we had used more of these visualisations from the start? Would we have gone to our documents and started over? Would the outcome be different?  
55 feedback, questions. take home

90 minute process. Start with a larger requirements document, participants prompt \_and\_ visualise. 

0 Introduction  
   What is AI Assisted Development  
   How do we see the resurgence of Document Driven Design working with Test Driven Development?  
   What problems do we encounter when generating masses of commits, tests and code quickly.  
15 Round 1 \- Pre-iterated Product Requirequirents Document. Participants  prompt (guided by us) for acceptance tests. Generate code. We explain visualisations while participants wait for code to be generated. What do we see? Visualizations: scope of change, and hot spots of change.  
45 Round 2 \- another, smaller step. What do you prompt for now, after seeing the result of round 1? We explain the next visualisations at the start of the round. Generate code while watching the visualisations: method size, complexity, coverage map. Visualise before and after.   
75 wrap up \- would this have gone faster if we had used more of these visualisations from the start? Would we have gone to our documents and started over? Would the outcome be different?  
85 feedback, questions. take home

Options
----

- pre set sequence of checkpoints. No coding by participants, they check out a check point, and play with the tools to get an impression  
- participants prompt a little, then get the next tool  
- [Highway](https://www.qwan.eu/2020/09/02/dimensional-planning.html) version: divide pairs into sets of different llms (3) Highlight differences in code generated by different LLMs and how that shows in the visualisations. Set participants up to develop their own evals. 



