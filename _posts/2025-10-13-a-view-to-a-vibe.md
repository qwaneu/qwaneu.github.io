---
 layout: post
 title: A view to a vibe - investing in keeping, fixing or binning vibe-engineered code
 tags:
 - moldable development
 - LLM
 author: Willem van den Ende, Stephan Eggermont
 image: /attachments/blogposts/2025/gt-ts-black-and-green-squares.svg
---

Since April, I've been experimenting more intensively with augmented code generation, quite often with a clear-ish vision, a pair, tests and other of our [favourite engineering practices](2025/10/06/practices-are-patterns.html). 

Whether we are working in a team on fresh or vintage code, or working 'LL-MAD' (Large Language Model Assisted Development), there is value in having fact-based views that we can make on the fly as we ask questions. Iterating on what we know, what we want to know, and what questions we can and should ask.

When generating software with an agent, sometimes it is hard to assess the output of a coding agent by 'just' looking at the outcomes, and some of the outputs. Does this step provide value? Are the exploratory tests satisfying? can we maintain a sustainable pace? When the code base has become too large, and the LLM can not make more progress, we are stuck. We don't want to go hands-on on code that is not malleable. There is value in knowing why the LLM got stuck, and once we find that out, having automated checks and visuals to inform us about the direction of travel. We can take a step back, or start over and run another experiment.

We tried having the coding agent (mostly Claude code) generate documentation with diagrams. This works, but it generates a lot of text to read, and you can't be sure which of the words and pictures are facts, and which ones are beliefs. These documents mostly have value to reflect back to us what the coding agent makes of our code base. If we want to use these reports to steer the direction of travel, we have to go in ourselves, and read the code. This is time consuming and error prone. On the surface, the code looks good enough, and people are not good at spotting the faulty outliers.

So let's take you through some of the diagrams we made to assess whether a small Typescript front-end that Claude Code generated overnight for a web-based game has a decent structure, and if it could responsibly add tests to it when we found there were to few. We will discuss the rationale for a _small_ front-end along the way.


## Sometimes creating code is the bottleneck

When you have many ideas, the bottleneck is refining ideas and exploring options.
We can explore options in several ways. When it comes to 'can we build this?', we can pair, we can chat back and forth with an LLM, or create code. We love doing architectural spikes, and we love working in small increments. Architectural spikes are rarely a problem. If we intend to throw away the code after the learning happened, we don't need to look at the code in depth. If we want to make a next step, however, we need to have confidence that our system is sustainable and the code malleable.

LLMs helped me go back and forth on my ideas. LLM Augmented Development, or LL-MAD for short helps in generating code. Sometimes to explore options, sometimes to go into production. Ideally we want to work in steps, and work incrementally. We can generate a lot more code, in a lot less time than before. How can we assess whether it is any good, in a reasonable amount of time? 

## ...and then the bottleneck moves to assessing

The bottlenecks then shifts to assessing the output. We need exploratory testing to assess the output works. Putting on a product manager's hat and looking at the cycle time works, as long as we can go in one move from one stable state to another. A stable state is roughly: are the tests green, do the exploratory tests pass, are the tests of satisfactory quality? 

If the assessment ends its' work in an unstable state, how do we know? And how many tries does it take to get back to a stable state? 

We can e.g. read the code, discuss with the assistant, but it is slow going. We made two graphic web front-ends (each over 600 tests, 5000 and 30000 lines of production Javascript code as measured by [Cloc](https://github.com/AlDanial/cloc)). They each validated some of our assumptions. The larger one had some annoying defects. The smaller one could not evolve further. 

Both gave rise to a *system metaphor* - Massive Multiplayer Co-operative Online Game (MMCOG) that made the designs in both of them obsolete. Progress!

> Editors note: discussions about design have been kept generic, so as to not to distract from the narrative, and hopefully make it accessible for a larger audience.

But the next time, we did not want to find out after six large stories that we could not continue developing. Now that we have a good system metaphor, we want to make incremental progress. To check the output, we will have to read code. But if we let the assistant run while we sleep, we may have several thousand lines of changes to wade through. Sometimes it took me an hour or more to identify that new components had been made where we did not expect them.


# A birds-eye view, with precision

We want to ship working software, that is of value to the people it serves. Feedback is not always pleasant, but usually useful, and helps us go forward, or retrace our steps when necessary. 

Creating this is an iterative process. It starts with gut feel. Or, as [Stephan](https://www.legacycode.nl) says, this is where experience comes in handy. We are looking to get insight in the code, at a high level, with details ready to hand. One perspective  /leads to another.


## Baby steps - get the view you need, not the view you want

We wanted to see the dependencies in the generated code, both inside and to the outside. As a first step, we had a look at the directory structure and searched through the files. We will spare you these views, they are relatively uninteresting to look at. But it does help to get a foothold and a sense of space. They weren't the views we wanted, but the views we needed to be able to make the next step.

Working in small steps, and making progress remains one of our favourite practices.

![Black squares. most are the same size roughly, some are smaller](/attachments/blogposts/2025/gt-ts-black-squares.svg)
{: class="post-image post-image-50" }

These are only squares, with no filenames. First I wanted to see where the tests were. It was interesting to not have the names of the files. It made me look inside files where I would not normally look. This was quite interesting, I learned a few things about typescript project structure and about what had been generated. I am normally biased to look into particular files (e.g. the tests). This brought some serendipity to the process. 


## More SWAN - Squares Without A Name - where are the tests? 

As another baby step, we plotted the test files as green. We see that a small fraction of the squares are tests.

![Four of the squares are now green. one square is smaller than the other three.](/attachments/blogposts/2025/gt-ts-black-and-green-squares.svg)
{: class="post-image post-image-50" }

In the next steps we went for the names and relations, and left 'is it a test or not' and 'how large are they' aside for a bit. 


## How are our dependencies evolving?

We first plotted the dependencies in a circle. This does not tell us much about how the dependencies are going, but it looks pretty.

![File dependencies plotted in a circle](/attachments/blogposts/2025/gt-ts-dependencies-circle.svg)
{: class="post-image}

For me it was a useful exploration to see some of the visualisations available in [Glamorous Toolkit](https://gtoolkit.com/).
Next up we tried a 'dominance tree'. This gives us a bit more oversight, but still a bit cluttered. 

![Dominance tree view of file dependencies](/attachments/blogposts/2025/gt-ts-dependencies-dominance-tree.svg)
{: class="post-image}

The 'force layout' option was more like what I had in mind when I thought about dependencies.

![Dominance tree view of file dependencies, after a 'force layout'](/attachments/blogposts/2025/gt-ts-dependencies-force-layout.svg)
{: class="post-image}

I still cannot see at a glance which files have more imports than I expect. Stephan suggested a different kind of view. 

We could make more improvements here. This diagram is far from perfect. For instance, you may have noticed that not all files have arrows pointing to them - they are floating in space. We didn't need these arrows to make an assessment. Knowing where to stop is important. 

## Know where to stop

We build tools, so that we can build useful software, not tools to build tools. We can live with precise, but imperfect views. As long as they provide enough information to make an assessment. Situational awareness is what we are after.

The views in the next session were not what we wanted, but what we needed. I had asked for boxes and arrows, but it turned out that boxes-in-boxes was much more useful.

## A birds-eye view, with details ready to hand

Each of the file names in the previous graphs, and the blocks in the visualisations below, you can click for more details. You can go to the source of the file, or in the case of the imports, click on a small square and see exactly what import it refers to. We want images based on facts, not beliefs. 

We went back to the block views from earlier, and added the imports as small squares inside. This went in a number of steps, but the post is getting long, so I will spare you the details.

*legend*** From the squares view, we kept the black for implementation files, and green for test files. They are now rendered as outlines around small squares. Each small square is an import, a dependency the file needs to function. The small squares are coloured as follows:

- yellow: import inside our own code
- red: import to an external dependency
- cyan: zero imports in file

The cyan was not planned, but emerged from running the visualisation. We need something to represent 'no imports', or our visualisation would crash.

The red was important, because in previous experiments the coding agent would add external dependencies where we did not expect them. 


We can now see, that the green test files, have ok dependencies. There are some dependencies in other files, but they are not everywhere. Not too bad, as we had not prompted for [hexagonal architecture](/2020-09-09-how-to-keep-complexity-in-check-with-hexagonal-architecture.md) yet.

![Dependencies plotted as squares inside](/attachments/blogposts/2025/gt-ts-imports-three-test-files.svg)
{: class="post-image post-image-50" }

We saw that we had few test files, and the coverage report confirmed that it was on the low side. So far we have found  generating tests by coding agents based on loose prompts a mixed bag. Let's see if the visuals can help us assess.
We prompted the the agent generate tests, and had a look at the results:

![More test files, many of them have several dependency blocks in them](/attachments/blogposts/2025/gt-ts-imports-more-test-files.svg)
{: class="post-image post-image-50" }

We can see that this was a success in the sense that we have more tests, but a failure, in that the tests are tightly coupled to other files. For focused unit tests, we  would expect a maximum of two coloured blocks, one for a test framework maybe and one for a domain object. Five or six imports for a test file is a lot. Might be ok for an integration test, but we would expect fewer new test files in that case.

Clicking through on a couple of the new test files confirmed our suspicion, unfortunately. These tests did not add much value. We want tests to explain the software to us _and_ prevent regressions. Only preserving behaviour is not enough. So this is a case of going in by hand, or prompting differently and rolling the dice again.

In Glamorous Toolkit we can click on each of the blocks to see what the fact behind the block is. When we click on the outside, we get the whole file, when we click on one of the small blocks, we get the exact import. We can then choose to show these imports in isolation, together with the other imports or in the context of the rest of the file. Each of these views is fully customisable, so can see what _we_ need. This doesn't translate neatly to a screenshot in a blog post yet, so we have left that out for now.

# Conclusions

To be honest, making the first round of tools was quite a bit of work, we needed to do some undifferentiated heavy lifting to work with the Typescript code. Having said that, the majority of what we needed to work with Typescript code was already there. It was mostly making connections between a file and the relations we were interested in, and creating some custom views that made it easier to navigate said relations interactively. 

While writing this post, we got more ideas, of course. But we did not need more to make the assessment we needed. The spike was a success in the sense that we know the Game metaphor works, and that related tools can save us from writing code, while having a simple system to work on.

Some of the aspects can also be covered with static analysis, e.g. linting. We did this in previous experiments. As agents and the tools around them evolve, we find it worthwhile to occasionally start from a blank slate, and revisit our assumptions about which checks we want, and when we want them.

After an initial investment, I believe that [moldable development](https://moldabledevelopment.com/) will save us time in figuring out what we and agents develop. With or without agents, it can be difficult to keep up with what code is produced. If we turn our perspective in to views, we hit refresh, and our intuition support system shows us what we need.


# Further reading 

- [Know where to Stop](/2025-10-22-know-when-to-stop.md) - a follow up post we made on determining when we have enough tools and insight to continue in a sustainable way.

- Tudor Girba - [Developers spend most of their time figuring the system out](https://lepiter.io/feenk/developers-spend-most-of-their-time-figuri-9q25taswlbzjc5rsufndeu0py/)
- Tudor Girba, Simon Wardley - [Moldable Development](https://moldabledevelopment.com/)



# Credits

- [Stephan Eggermont](https://www.domeinmodel.nl) was instrumental in co-creating the visualisations and editing the blogpost. As well as editing.
- Marc Evers for clarifying my intent. 
- Participants and facilitators at [CITCON 2025](/2025/09/29/citcon-2025.html). The blog post title gelled as I was jotting down a session description on an index card. I have attempted to weave some more detailed answers to questions in the session into the post.

<aside>
  <p>
Do you have legacy or vibed code that could benefit from a fact-based birds-eye view?
  </p>
  <p>
    <a href="/contact">Contact us for a chat over (virtual) coffee</a>
  </p>
</aside>
