---
 layout: post
 title: A view to a vibe - investing in keeping, fixing or binning vibe-engineered code
 tags:
 - moldable development
 - LLM
 author: Willem van den Ende, Stephan Eggermont, Marc Evers
 image: /attachments/blogposts/2025/gt-ts-black-and-green-squares.svg
---

Since April, I've been experimenting more intensively with augmented code generation, quite often with a clear-ish vision, a pair, tests and other of our [favourite engineering practices](2025/10/06/practices-are-patterns.html). 

Whether we are working in a team on fresh or vintage code, or working 'LL-MAD' (LLM Assisted Development), there is value in having fact-based views that we can make on the fly as we ask questions. Iterating on what we know, what we want to know, and what questions we can and should ask.

When generating software with an agent, sometimes it is hard to assess the output of a coding agent by 'just' looking at the outcomes, and some of the outputs. Does this step provide value? Are the exploratory tests satisfying? can we maintain a sustainable pace? When the code base has become too large, and the LLM can not make more progress, we are stuck. We don't want to go hands-on on code that is not malleable. There is value in knowing why the LLM got stuck, and once we find that out, having automated checks and visuals to inform us about the direction of travel. We can take a step back, or start over and run another experiment.

We tried having the coding agent (mostly Claude code) generate documentation with diagrams. This works, but it generates a lot of text to read, and you can't be sure which of the words and pictures are facts, and which ones are beliefs. These documents mostly have value to reflect back to us what the coding agent makes of our code base. If we want to use these reports to steer the direction of travel, we have to go in ourselves, and read the code. This is time consuming and error prone. On the surface, the code looks good enough, and people are not good at spotting the faulty outliers.

So let's take you through some of the diagrams we made to assess whether a small Typescript front-end that Claude Code generated overnight for a web-based game has a decent structure, and if it could responsibly add tests to it when we found there were to few. 


## Sometimes creating code is the bottleneck

When you have many ideas, the bottleneck is refining ideas and exploring options.
We can explore options in several ways. When it comes to 'can we build this?', we can pair, we can chat back and forth with an LLM, or create code. We love doing architectural spikes, and we love working in small increments. Architectural spikes are rarely a problem. If we intend to throw away the code after the learning happened, we don't need to look at the code in depth. If we want to make a next step, however, we need to have confidence that our system is sustainable and the code malleable.

LLMs helped me go back and forth on my ideas. LLM Augmented Development, or LL-MAD for short helps in generating code. Sometimes to explore options, sometimes to go into production. Ideally we want to work in steps, and work incrementally. We can generate a lot more code, in a lot less time than before. How can we assess whether it is any good, in a reasonable amount of time? 

## ...and then the bottleneck moves to assessing

The bottlenecks then shifts to assessing the output. We need exploratory testing to assess the output works. Putting on a product manager's hat and looking at the cycle time works, as long as we can go in one move from one stable state to another. A stable state is roughly: are the tests green, do the exploratory tests pass, are the tests of satisfactory quality? If the assessment ends its' work in an unstable state, how do we know? And how many tries does it take to get back to a stable state. We can e.g. read the code, discuss with the assistant, but it is slow going. We made two graphic web front-ends (each over 600 tests, 5000 and 30000 lines of production Javascript code as measured by [Cloc](https://github.com/AlDanial/cloc)). They each validated some of our assumptions. The larger one had some annoying defects. The smaller one could not evolve further. Both gave rise to a system metaphor - Massive Multiplayer Co-operative Online Game (MMCOG) that made the designs in both of them obsolete. Progress!

> Editors note: discussions about design have been kept generic, so as to not to distract from the narrative, and hopefully make it accessible for a larger audience.

But the next time, I did not want to find out after six large stories that we could not continue developing. Now that we have a good metaphor, I want to make incremental progress. To check the output, I will have to read code. But if I let the assistant run while I sleep, I may have several thousand lines of changes to wade through. Sometimes it took me an hour or more to identify that new components had been made where I did not expect them.


# A birds-eye view, with precision

We want to ship working software, that is of value to the people it serves. Feedback is not always pleasant, but usually useful, and helps us go forward, or retrace our steps when necessary. 

Creating this is an iterative process. It starts with gut feel. Or, as [Stephan](https://www.legacycode.nl) says, this is where experience comes in handy. We are looking to get insight in the code, at a high level, with details ready to hand. One perspective leads to another.


## Baby steps - get the view you need, not the view you want

We wanted to see the dependencies in the generated code, both inside and to the outside. As a first step, we had a look at the directory structure and searched through the files. We will spare you these views, they are relatively uninteresting to look at. But it does help to get a foothold and a sense of space. They weren't the views we wanted, but the views we needed to be able to make the next step.

Working in small steps, and making progress remains one of our favourite practices.

![Black squares. most are the same size roughly, some are smaller](/attachments/blogposts/2025/gt-ts-black-squares.svg)


## More squares - where are the tests? 



space

![Four of the squares are now green. one square is smaller than the other three.](/attachments/blogposts/2025/gt-ts-black-and-green-squares.svg)




## How are our dependencies going?

We first plotted the dependencies in a circle. This does not tell us much about how the dependencies are going, but it looks pretty.

![tbd](/attachments/blogposts/2025/gt-ts-dependencies-circle.svg)

For me it was a useful exploration to see some of the visualisations available in [Glamorous Toolkit](https://gtoolkit.com/).
Next up we tried a 'dominance tree'. This gives us a bit more oversight, but still a bit cluttered. 

![tbd](/attachments/blogposts/2025/gt-ts-dependencies-dominance-tree.svg)

The 'force layout' option was more like what I had in mind when I thought about dependencies.

![tbd](/attachments/blogposts/2025/gt-ts-dependencies-force-layout.svg)

I still cannot see at a glance which files have more imports than I expect. Stephan suggested a different kind of view. 

You may have noticed that not all files have arrows pointing to them in the previous diagram. We didn't need them to make an assessment. Knowing where to stop is important. 

## Know where to stop

We build tools, so that we can build useful software, not tools to build tools. We can live with precise, but imperfect views. As long as they provide enough information to make an assessment. Situational awareness is what we are after.

The views in the next session were not what I wanted, but what we needed. I had asked for boxes and arrows, but it turned out that boxes-in-boxes was much more useful.

## A birds-eye view, with details ready to hand

Each of the file names in the previous graphs, and the blocks in the visualizations below, you can click for more details. You can go to the source of the file, or in the case of the imports, click on a small square and see exactly what import it refers to. We want images based on facts, not beliefs **TODO** link to a Tudor Girba post, or Wardley.

We went back to the block views from earlier, and added the imports as small squares inside. This went in a number of steps, but the post is getting long, so I will spare you the details.

**CONTINUE HERE**. explain legend, and our interpretation. Three test files, but their dependencies are ok. red is external dependencies, not too many. Reason to track red: we got burned by this in previous experiments, despite our best efforts at prompting for one of our favourite design patterns TODO link to hex arch post.

![tbd](/attachments/blogposts/2025/gt-ts-imports-three-test-files.svg)

second run, having the agent generate tests:

![tbd](/attachments/blogposts/2025/gt-ts-imports-more-test-files.svg)

We can see that this was a success in the sense that we have more tests, but a failure, in that the tests are tightly coupled to other files. I would expect two coloured blocks, one for a test framework maybe and one for a domain object. Five or six imports for a test file is a lot. Might be ok for an integration test if there is no facade, but not here.

# Summary

To be honest, making the first round of tools was quite a bit of work, we needed to do some undifferentiated heavy lifting to work with the typescript code. Having said that, the vast majority of what we needed to work with Typescript code was already there. It was mostly making connections between a file and its' relations, and creating some custom views that made it easier to navigate said relations interactively. Not something we can easily show in a blog post.

While writing this post, we got more ideas, of course. But we did not need more to make the assessment we needed. The spike was a success in the sense that we know the Game metaphor works, and that related tools can save us from writing code, while having a simple system to work on.

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

The value of dumb questions - Stephan is getting better at glamorous toolkit by me asking beginner questions. I don't know w 

We did make a. maybe separate post about making a custom view on the analyzer for dependencies and imports.

How to export images from Glamorous Toolkit for blog posts. SVG has interesting aspects.

-> situational awareness

Follow up post: treemap for the larger repos - what kinds of file live where? 

I'm working on a successor for WeReview - a conference session review system (needs one liner. stephan?) and, with Stephan Eggermont in stealth on something that has Multiplayer Online Collaborative Game as systems metaphor. We'll refer to this as 'Game' going forward. FOOTNOTE this metaphor only came about as a result of several rounds of experimentation. It is, I think, paying off, because it allows us to think of designs that are relatively simple, and libraries and designs that we can re-purpose or re-use.

I left out the Massive, because as we are iterating, we are also finding smaller applications, which could help us launch sooner. FOOTNOTE investing with your own money.

One of the engineering practices I adapted later, was pair programming. And pair business development. Which leads to bottlenecks FOOTNOTE like generating ideas faster than we can keep track of. 

For WeReview, using Claude Code turned out to be surprisingly successful, at least initially. Generating a couple of models and screens was quite fluid, in conversation. The initial WeReview uses dependencies for some of its' features that are no longer maintained, and they do not all have suitable alternatives. So in our imaginary wardley map, things are moving from Product to Custom built. Just to sustain the product as it is. 

For the Game, we have had some success with generating graphical front-ends. I was able to make a MacOS prototype without previous experience of MacOS development. We made two graphical web frontend prototypes of some complexity. One has over 700 tests and almost 5000 lines of production code (as measured by cloc). Lines of code is not a measure of complexity, but a measure of how much time it costs us to evaluate the outcome if we have to read through the code. 

We cared about the result, and glanced at the code occasionally. If we had run `cloc` earlier we could have seen the disparity between tests (>10k lines) and code (5K lines) growing. In the end, we could not add more features to it, because Claude had trouble with javascript (parameters can be present or not - explain in more detail), and having it do a typescript migration turned out to generate even more code (unwanted validations for internal code). So we parked it, until we could have a better handle at it, or use a library - this was before we came up with the Game metaphor. After the Game metaphor we found some well maintained libraries that could fulfill the same need (Wardley map ot the right). Blog post: *vibing our way to a system metaphor*

The other frontend spike is in typescript - this also has a backend, but just focusing on the front-end, the backend was relatively easy to put together, it has passing tests, but also has some annoying failures (*Heuristic: What do we carry forward, if anything*). It has a little over 600 front-end tests, 1359 lines in about 30 end to end tests, almost 31000 lines of typescript code (code and tests, not split out for now, we may do a separate visualisation of this). 2500 lines of backend code, (including websockets, custom session management etc), 1800+ lines of test code.

Visualizations do not need to be pretty or have legends - we made them, and use them every day, so I know what the colors mean. Green = test, Red is :w
 
spec-driven development is a post for another day, might be good for a few clicks. I still have to read the documents - LLMs can produce a lot more documentation than I can read in detail. So there too, I need a birds eye view with precision

Before that I was too busy at a client that had an AI policy that was too ambiguous for us **TODO footnote**, so we decided to delete all assistant, and only do chats with e.g. local LLMs, and when we did use public ones, we changed the domain. (this is worth a separate short post - exploit symmetry between domains to hide your intention from LLMs)

This is the domain of spikes - build many to throw away, you will anyway [TODO brooks reference]  - that is its' own post. 


 These files were re-exported through a kind of 'facade' files. We could also parse the  'export' lines in the code, but we had enough information that we decided to bin this experiment. We learnt that using a particular kind of framework is useful, and that we want to create the initial tests and structure by hand. Hoping that that gives enough context for a LLM to fill in some of the boilerplate.
I may have been successful in getting a line of business application to a point where 80% of the features can be co-created with LLM augmented development. 20% is still hard. 
