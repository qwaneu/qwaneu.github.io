---
 layout: post
 title: A view to a vibe - investing in keeping, fixing or binning vibe-engineered code
 tags:
 - moldable development
 - LLM
 author: Willem van den Ende
 image: 
---

Since April, I've been experimenting more intensively with augmented code generation, quite often with a clear-ish vision, tests and other of our favourite engineering practices **TODO link to practices are paterns post**. Before that I was too busy at a client that had an AI policy that was too ambigous for us **TODO footnote**, so we decided to delete all assistant, and only do chats with e.g. local LLMs, and when we did use public ones, we changed the domain. (this is worth a separate short post - exploit symmetry between domains to hide your intention from LLMs)

I'm working on a successor for WeReview - a conference session review system (needs one liner. stephan?) and, with Stephan Eggermont in stealth on something that has Multiplayer Online Collaborative Game as systems metaphor. We'll refer to this as 'Game' going forward. FOOTNOTE this metaphor only came about as a result of several rounds of experimentation. It is, I think, paying off, because it allows us to think of designs that are relatively simple, and libraries and designs that we can re-purpose or re-use.

I left out the Massive, because as we are iterating, we are also finding smaller applications, which could help us launch sooner. FOOTNOTE investing with your own money.

One of the engineering practices I adapted later, was pair programming. And pair business deveopment. Which leads to bottlnecks FOOTNOTE like generating ideas faster than we can keep track of. 

For WeReview, using Claude Code turned out to be surprisingly succesful, at least initially. Generating a couple of models and screens was quite fluid, in conversation. The initial WeReview uses dependencies for some of its' features that are no longer maintained, and they do not all have suitable alternatives. So in our imaginary wardley map, things are moving from Product to Custom built. Just to sustain the product as it is. 

For the Game, we have had some success with generating graphical front-ends. I was able to make a MacOS prototype without previous experience of MacOS development. We made two graphical web frontend prototypes of some complexity. One has over 700 tests and almost 5000 lines of production code (as measured by cloc). Lines of code is not a measure of complexity, but a measure of how much time it costs us to evaluate the outcome if we have to read through the code. 

We cared about the result, and glanced at the code occasionally. If we had run `cloc` earlier we could have seen the disparity between tests (>10k lines) and code (5K lines) growing. In the end, we could not add more features to it, because Claude had trouble with javascript (parameters can be present or not - explain in more detail), and having it do a typescript migration turned out to generate even more code (unwanted validations for internal code). So we parked it, until we could have a better handle at it, or use a library - this was before we came up with the Game metaphor. After the Game metaphor we found some well maintained libraries that could fulfill the same need (Wardley map ot the right). Blog post: *vibing our way to a system metaphor*

The other frontend spike is in typescript - this also has a backend, but just focusing on the front-end, the backend was relatively easy to put together, it has passing tests, but also has some annoying failures (*Heuristic: What do we carry forward, if anything*). It has a little over 600 front-end tests, 1359 lines in about 30 end to end tests, almost 31000 lines of typescript code (code and tests, not split out for now, we may do a separate visualisation of this). 2500 lines of backend code, (including websockets, custom session management etc), 1800+ lines of test code.

Visualizations do not need to be pretty or have legends - we made them, and use them every day, so I know what the colors mean. Green = test, Red is :w
 
