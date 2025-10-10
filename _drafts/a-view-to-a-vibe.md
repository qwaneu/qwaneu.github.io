---
 layout: post
 title: A view to a vibe - investing in keeping, fixing or binning vibe-engineered code
 tags:
 - moldable development
 - LLM
 author: Willem van den Ende
 image: 
---

Since April, I've been experimenting more intensively with augmented code generation, quite often with a clear-ish vision, a pair, tests and other of our [favourite engineering practices](2025/10/06/practices-are-patterns.html). I may have been successful in getting a line of business application to a point wher 80% of the features can be co-created with LLM augmented development. 20% is still hard. 

## Sometimes typing is the bottleneck

When you have many ideas, the bottleneck consists of refining ideas, exploring options. LLMs helped me go back and forth on my ideas (although they tend to agree, so you have to be careful how to phrase questions, or run them multiple times) is generating code. LLM Augmented Development, or LL-MAD for short helps in generating code. Sometimes to explore options, sometimes to go into production. Ideally we want to work in steps, and work incrementally. 

## And then the bottleneck moves to judging
The bottlenecks then shifts to judging the output. Explorory testing (see vasco duarte podcast) to judge the output works. Putting on a product managers' hat and looking at the cycle time, how many attempts are needed to get back to a stable state (tests green, exploratory tests pass, tests of satisfactory quality) works, but is slow. We made two graphic web front-ends (each over 600 tests, 5000 and 30000 lines of production javascript code as measured by [cloc]). They each validated some of our assumptions. The larger one had some annoying defects. The smaller one could not evolve further. Both gave rise to a system metaphor - Massive Multiplayer Co-operative Online Game (MMCOG) that made the designs in both of them obsolete. Progresss!

Editors note: Discussions about design have been kept generic, so as to not to distract from the narrative, and hopefully make it accessible for a larger audience.

But. The next time, I did not want to find out after six large stories that we could not continue developing. Now that we have a good metaphor, I want to make incremental progress. To do check the output, I will have to read code. But if I let the assistant run while I sleep, I may have several thousand lines of changes to wade through. Sometimes it took me an hour or more to identify that new components had been made where I did not expect them.


# A birds-eye view, with precision

We want to ship working software, that is of value to the people it serves. Frequently. Feedback is not always pleasant, but usually useful, and helps us go forward, or retrace our steps when necessary. 

Creating this is an iterative process. It starts with gut feel. Or, as Stephan says, this is where experience comes in handy. We are looking to get insight in the code, at a high level, with details ready to hand. One perspective leads to another.


## Baby steps - get the view you need, not the view you want

We wanted to see the dependencies in the generated code, both inside and to the outside. As a first step we had a look at the directory structure and searched through the files. We will spare you these views, they are relatively uninteresting to look at. But it does help to get a foothold, and a sense of space. And they weren't the views we wanted, but the views we needed to be able to make the next step.

Working in small steps, and making progress remains one of our favourite practices.

## More squares - where are the tests? 


## How are our dependencies going?


## Know where to stop


## Relation with linting

Not sure if this belongs in the post. The relation with linting is iterative. LL-MAD makes it easy to create linting rules that work well enough, but as with regular development, the amount of linting and the timing of it matters. As Steve Freeman said at CITCON, it is a bummer when a long build fails, because in the last step, after all the compilation steps and tests have been done, a linter finds that an incorrect amount of spaces was used for indentation and rejects the build. Coding assistants can get in a loop when they try to commit, and are prevented because of linting. The linting feedback may not neatly fit into the current context. We are experimenting with where to put what linting rules and tools. 


# Further reading

- Adrian Cockroft
- Vasco Duarte podcast
- Mythical man month
- Tudor Girba - [Developers spend most of their time figuring the system out](https://lepiter.io/feenk/developers-spend-most-of-their-time-figuri-9q25taswlbzjc5rsufndeu0py/)

# Credits

[Stephan Eggermont](https://www.legacycode.nl) was instrumental in co-creating the visualisations and editing the blogpost.

# Cutting room floor 

Assessment is the process of understanding a situation around a system enough to make a decision - Tudor Girba. 

Post about our favourite practices.

-> situational awarenes

Follow up post: treemap for the larger repos - what kinds of file live where? 

I'm working on a successor for WeReview - a conference session review system (needs one liner. stephan?) and, with Stephan Eggermont in stealth on something that has Multiplayer Online Collaborative Game as systems metaphor. We'll refer to this as 'Game' going forward. FOOTNOTE this metaphor only came about as a result of several rounds of experimentation. It is, I think, paying off, because it allows us to think of designs that are relatively simple, and libraries and designs that we can re-purpose or re-use.

I left out the Massive, because as we are iterating, we are also finding smaller applications, which could help us launch sooner. FOOTNOTE investing with your own money.

One of the engineering practices I adapted later, was pair programming. And pair business deveopment. Which leads to bottlnecks FOOTNOTE like generating ideas faster than we can keep track of. 

For WeReview, using Claude Code turned out to be surprisingly succesful, at least initially. Generating a couple of models and screens was quite fluid, in conversation. The initial WeReview uses dependencies for some of its' features that are no longer maintained, and they do not all have suitable alternatives. So in our imaginary wardley map, things are moving from Product to Custom built. Just to sustain the product as it is. 

For the Game, we have had some success with generating graphical front-ends. I was able to make a MacOS prototype without previous experience of MacOS development. We made two graphical web frontend prototypes of some complexity. One has over 700 tests and almost 5000 lines of production code (as measured by cloc). Lines of code is not a measure of complexity, but a measure of how much time it costs us to evaluate the outcome if we have to read through the code. 

We cared about the result, and glanced at the code occasionally. If we had run `cloc` earlier we could have seen the disparity between tests (>10k lines) and code (5K lines) growing. In the end, we could not add more features to it, because Claude had trouble with javascript (parameters can be present or not - explain in more detail), and having it do a typescript migration turned out to generate even more code (unwanted validations for internal code). So we parked it, until we could have a better handle at it, or use a library - this was before we came up with the Game metaphor. After the Game metaphor we found some well maintained libraries that could fulfill the same need (Wardley map ot the right). Blog post: *vibing our way to a system metaphor*

The other frontend spike is in typescript - this also has a backend, but just focusing on the front-end, the backend was relatively easy to put together, it has passing tests, but also has some annoying failures (*Heuristic: What do we carry forward, if anything*). It has a little over 600 front-end tests, 1359 lines in about 30 end to end tests, almost 31000 lines of typescript code (code and tests, not split out for now, we may do a separate visualisation of this). 2500 lines of backend code, (including websockets, custom session management etc), 1800+ lines of test code.

Visualizations do not need to be pretty or have legends - we made them, and use them every day, so I know what the colors mean. Green = test, Red is :w
 
spec-driven development is a post for another day, might be good for a few clicks. I still have to read the documents - llms can produce a lot more documentation than I can read in detail. So there too, I need a birds eye view with precision

Before that I was too busy at a client that had an AI policy that was too ambigous for us **TODO footnote**, so we decided to delete all assistant, and only do chats with e.g. local LLMs, and when we did use public ones, we changed the domain. (this is worth a separate short post - exploit symmetry between domains to hide your intention from LLMs)

This is the domain of spikes - build many to throw away, you will anyway [TODO brooks reference]  - that is its' own post. 
