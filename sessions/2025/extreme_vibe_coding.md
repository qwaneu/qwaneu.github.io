---
title: Conference and meetup sessions
layout: other-accessible
---

Accepted for XP Days Benelux 2025 by Wouter Lagerweij and Willem van den Ende

# eXtreme Vibe Coding

Subtitle: Working software through comprehensive documentation and manual testing

Programming is changing, and eXtreme Programming is changing along. We are still having fun iterating on useful software, but we don’t necessarily have to write much of the code ourselves. This opens up programming for people who would not normally do so, and lets experienced XPers navigate more than they drive. Interestingly enough, several eXtreme Programming values, principles and practices work as well, and maybe even better, when using LLM assisted coding. 

Join us to see how you can benefit, even if you don't program (yet, or no longer), how you can co-create production quality prototypes using the practices you know and love, and new rules of thumb to help go from the first prototype towards a maintainable codebase. We will build a new prototype in the workshop, decide "what good looks like", and discover what is needed to check we’re getting results that are good enough to go into production. We will learn how to guide the work in small steps towards improvement.

## Intended audience

Anyone who wants computers to do useful and fun things for them. Things that require code. Things that, until recently, required programming.

"Ask not what you can do for the computer, but what the computer can do for you."

## Learning objectives

1. **Rapid Prototyping & Iteration:** Participants will experiment with quickly building out core functionality with minimal concern for initial quality, fostering a fast-paced, iterative development approach.  
2. **Identifying LLM Limitations:** Participants will gain hands-on experience in recognizing various types of "breakage" from LLM-generated code (e.g., functional hallucination, missing details, poor quality, lack of tests) and develop methods for detection..  
3. **Prompt Engineering for Quality:** Participants will learn how  to integrate quality checks and design constraints into their prompts, enabling LLMs to generate more robust and accurate code in subsequent iterations.  
4. **Strategic Refactoring & Re-prompting:** Participants will practice deciding what to keep from initial prototypes and how to leverage LLMs to generate context, domain language, and test cases to guide future development or complete overhauls.  
5. **Team Collaboration in AI-Assisted Development:** Participants will learn about evolving dynamics of team collaboration in an AI-assisted development environment, including roles, necessary skills, and the concept of a "whole team" in this context.

## Materials

At least one in two attendants needs a laptop or a tablet with keyboard to work in our (shared, remote) environment, working in pairs.  
The laptop/tablet needs to have a web browser to access our environment, but don't need local development environments.

We currently have two options for timetables. The 90 minutes one is more hands-on, 60 minutes more paint by numbers or live demo.

## Timetable \- Fake it ‘till you break it \- 90 minutes

Build out as much functionality as you can in a short set of iterations, without caring about quality or maintainability, or even much about the details of the functionality in the beginning.  
After the first  rounds, we put in some checks (on functionality, on quality), or even do those manually.   
Add a number of iterations where you build the checks into the prompts: either by (letting the LLM do the) refactoring, or by throwing away and starting over. What do you keep from the functionality built? Can you let the LLM generate a context from your current state? Create a Domain language? Tests/scenarios/examples that capture the functionality? How do you plug those into the next prompts to generate a new iteration of the product, with the right constraints in place to ensure better quality and adherence to the wished functionality?

Q: How are we going to do  reflection during the session? I'm "afraid" there is a lot of learning going to come out of each round, and if we have a packed room (think 40 people or so) this is going to take time. I do want participants to take as much explicit learning with them as they can. For the session to run, we need at each round: 1: some plan(s) 2\. some breakage(s) 3: which prompts will you refine / reuse 

| Start | Heading                         | Notes                                                                                                                                                                                                                                                         |
|:------|:--------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 0     | Introduction                    | Learning goals, approach, setup of environments                                                                                                                                                                                                               |
| 15    | 1 . Continuous Discovery        | Co-creating a plan, iterative brainstorming. Initial generation of functional, working, software through comprehensive documentation, extend the system functionality in quick steps.                                                                         |
| 30    | 2\. Fake it ‘till you break it  | Reflect on types of issues with LLM assisted code (functional hallucination, missing details, code quality, code breakage, missing tests, code design)Facilitators introduce prepared build script with static checks, and prepared improvements to prompts |
| 45    | 3\. You know we've got problems | Look for the next problem and see how a prompt change corrects it. Facilitators introduce extended build script with more checks for the next round                                                                                                           |
| 60    | 4\. Throw away and try again    | Combine fixed prompts from the first part of the session with added guardrails, and try again.                                                                                                                                                                |
| 75    | 5\. Perfect day \- Reflection   | What have we learnt from doing? What puzzles us? How do we apply this to our roles?                                                                                                                                                                           |
| 85    | End                             | Closing, questions, request for feedback.                                                                                                                                                                                                                     |


## Comments for the programme committee

Looking half a year into the future of LAC (LLM Assisted Coding) and the impact of craft requires a crystal ball. Today's wardley maps are out of date tomorrow, because the terrain of feedback loops has shifted. 

We could run this workshop today with the tools we have. We aim for people working in pairs, the fallback positions are ensemble programming / coding dojo or prepared kata's. 

We intend to run the exercise for ourselves several times, and try it out with small groups online. Filling 90 minutes is not the problem, the challenge is scoping it just right. We have eXtreme vibe coded a number of cases (now, probably more by november), e.g. a session review system (of course :-) ), voice-to-blog to turn dictation into blog posts with summarised key points, sticky notes board that can be driven from an LLM, small utility scripts for the day to day etc. We'll probably choose something relatively small so it is easier to see for all attendees what is going on, and we can (hopefully) keep the variation in prompt outcomes within bounds, so that we have a bounded number of outcomes each round.


