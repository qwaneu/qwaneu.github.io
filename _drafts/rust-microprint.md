---
layout: post
title: Extract test responsibilities with microprints and an LLM
tags:
- moldable development, LLM
author: Willem van den Ende
image: /attachments/blogposts/2025/gt-microprints/after-plan-test-extraction.png
---

    
One thing I find LLMs can be good at is splitting out a test file into separate responsibilities. I was doing an experiment, creating a custom coding agent in Rust. Claude code had generated tests first, as agreed. It had even recognized there were multiple responsibliities. But instead of separating these out in to files, it had named them as comments near the top of the test file. This became evident when I made a microprint of the tests directory. Three large columns, one for each test file.

Easy to see, easy to assess, easy to decide
----

The Microprint made it easy to see the files were too long. In the second iteration, [Stephan Eggermont](domeinmodel.nl) added a red line at the bottom of files that were more than 1000 lines long.

The coding agent has a 'plan' responsibility. This is the third column in the print. Instructing Claude Code to factor out the responsibilities, after a check by me that they were all right. The second print shows many more smaller files:

![Extracted the plan tests, one long column less](/attachments/blogposts/2025/gt-microprints/after-plan-test-extraction.png)

We can zoom in to only show the plan tests, since we put them in a separate directory. This is a size where we can easily have an opinion on the meaning of the tests. Which can be difficult in a very large file - too overwhelming.

![Zoomed in plan tests](/attachments/blogposts/2025/gt-microprints/factored_out_plan_tests.png)

The agent also has an 'Execution' responsibility - to run a sub-agent for code generation, refactoring etc. Similar thing as the 'Plan' responsibility. So now we only have one column less

![Factored out execution, one large column remaining,m any small tests](/attachments/blogposts/2025/gt-microprints/extracted_execution_tests.png)

Tradeoffs, and then some more tradeoffs
-----

It is not ideal that the initially generated tests were so long. Could the coding agent have generated better tests if I had instructed it to separate responsibilities, for units, into separate files? Perhaps. It is worth another experiment, now that I have micro prints to keep track of the whole more easily.

Earlier, I had claude code generating too much separate responsibilities. Once a system gets a bit larger, it seems prompting specifically to find responsibilities, or telling which ones to look at is necessary. LLM Augmented programming for me is still experimental. There are trade-offs in putting too much in a prompt, and then having the LLM ignore half of the instructions, or stating less, and then refactoring later. Currently I am experimenting more with separate refactoring steps. A bit like in regular TDD, but with larger steps. Implement new functionality, or refactor, but not both at the same time. New functionality may then look a bit gnarly, but when a set of refactorings can be prompted quickly and done reliably, this can work.

Do we always choose this set of refactorings when we se a large test file? No, we do take a peek inside, and sometimes find other things to look at. But that is for another episode. Thank you for reading, I hope you find this useful.


Further Reading
---

[Microprints: A Pixel-based Semantically Rich Visualization of Methods](https://scg.unibe.ch/archive/papers/Robb05b-microprintsESUG.pdf) by Romain Robbes, Stephane Ducasse and
Michele Lanza

You can write a coding agent by hand, probably. The second half of [You should write an agent](https://fly.io/blog/everyone-write-an-agent/) suggests as much.

[I accidentally wrote a shallow research tool](/2025/05/01/agentic-search.html) is in a similar vein. A large language model is tokens in, tokens out, and 'tool calls' are strings, handled by whatever wrapper we use, or whatever wrapper we make.

TODO add Call To Action
