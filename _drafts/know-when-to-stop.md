---
 layout: post
 title: A view to a vibe 2 - you better stop (building tools) 
 tags:
 - moldable development
 - LLM
 author: Willem van den Ende
 image: /attachments/blogposts/2025/stop.svg 
---

Building your own tools is kind of addictive. Once [we learn how to make productive tools](/2025/10/13/a-view-to-a-vibe.html), it can be hard to stop. There is much to see in a code base. But as we learned from using static analysers to find code smells in the past, you want just enough information for what you are doing right now. 

## Make new mistakes

We do not track what was important in the past, but has been resolved, because we learnt from mistakes and are not making these any more. We want to learn from the mistakes we, and our coding agents, are making right now.

We want to create insight. And we want to do that continuously, in small steps.

In the [previous episode](/2025/10/13/a-view-to-a-vibe.html) we made a view to show the code, test files and their imports. But there were no names for the file.

At first I quite liked the serendipity of not being able to see the file names. But looking at our now growing codebase, I wanted to go back and forth between the code view and the imports view. I could not easily see which files there were, nor which imports when I went back to the imports view.

## Small additions to our view

After some back and forth with Stephan, we decided on doing two small steps: 
1. Show the file name when hovering over the file tile
2. Show the import when hovering over the smaller import tiles inside the file

We did have some discussion on what to print in the hovers. We decided to show the kind of node that comes out of parsing typescript - so that it is clear if it is the file or the import in the file. And we show both of them. When the mouse hovers over the edge of the file, it is just the name of the containing file. When it hovers over an import, it shows the name of the import and at the bottom the name of the containing file.

![Screenshot, two test files with green border, one implementation file. Two hovers, one with an import, one with a file name](/attachments/blogposts/2025/show-imports-in-view-and-filename.png)

While some tests had reasonable imports, others had too many. And it was getting worse as we iterated. More often than not, LLMs find it a lot easier to write code than to re-rwite or remove it. So the blocks, and our failing prompts, were telling us that it was time to go in by hand. Going in by hand told us it was time to abort this as a spike, and start again, keeping what we learnt for the next round.

## Keep, fix, or bin?

We also read some of the code. This was a case where, even though the amount of code is not massive (about 2000 lines of production code, 3000 lines of tests), the errors were slowly but surely starting to mount:

- dependencies that were just not quite right
- tests that were too integrated
- calculations that were sometimes a bit off, and needed more tests

In this case we decided to **bin** the code and keep the learning. We also decided to do the next one test first, with three large-ish architectural spikes under our belt, we felt we had learnt enough, and could incorporate the learning, and maybe some code snippets in a well-understood, well-tested and well-factored way. 

## In closing

Refactoring can be fast and light work, but it is often difficult to step away from the dependencies in front of you. Sometimes it is easier to think with a new box than to think outside of the existing box.

## Credits

Stephan Eggermont for pair programming with me on the visualisation, and having a productive conversation on which tools to make, and where to stop.

<aside>
  <p>
Do you have legacy or vibed code that could benefit from a fresh perspective in small steps?
  </p>
  <p><div>
    <a href="/contact">Contact us for a chat over (virtual) coffee</a>
  </div></p>
</aside>
