---
layout: post
title:  Why red-green does not keep you clean
tags:
  - feedback
  - refactoring
  - UX
  - task modeling
author: Willem van den Ende
image: /attachments/blogposts/2018/hotreload.jpg
---

## TLDR; 

Red-Green-Refactor is broken, because the psychological reward happens at green. When you get that reward, you feel the task has been completed, and are inclined to stop. Therefore refactoring is a lot rarer than it should be.

Instead, turn the cycle 120 degrees, start at Refactor and end at Green, so that the short-term psychological reward and the medium to long term effects of well factored code are aligned. 

## Why it is red - green - skip-the-refactoring?

I'm at Agile in the City Bristol today. It had two talks back-to-back in the morning that made something click for me that should have clicked years earlier, but did not. 

I've often wondered why me, and other developers, don't more often refactor first to make space for a new feature. I remember this got advocated in the early days of eXtreme Programming, but I rarely see it. Instead we teach red-green-refactor, and emphasize that you really should do the refactoring. It is a bit like you _should_ take your vitamins. In which case the cycle looks like: spice - sugar -  vitamins. Not feeling much of a crescendo there after the sugar rush. 

The second talk was by [Kevlin Henney](https://twitter.com/kevlinhenney), who mentioned that the red-green-refactor model is broken, because people/we often skip the refactor step, or do only a little bit of it, instead of stepping back and looking at the bigger picture. 

Kevlin compared the red - green - refactor to the Plan - Do - Study - Act cycle, where Plan and Do are often drawn at the top, and Study and Act are drawn at the bottom. Study is where one tries to understand the current product or situation, and Act is where one acts on the Study and carries out improvements, and then another Plan and Do round starts.

![Plan - do - study - act - waterline](/attachments/blogposts/2018/planDoStudyAct.png)

The name study is already deliberate, as Kevlin said, Check is something that sounds like something you can check of a list, do easily. The waterline in the picture depicts that Study and Act rarely happen, or at least less popular or likely to happen.

The first talk was about User Task Modeling by [Jesmond Allen](https://twitter.com/jesmond). 

As an aside, I don't know if you've noticed, I've used a trick from @Jesmonds laws of task modeling - law number 2: 'user has an incomplete task'. The incomplete task being: what was 
in talk number one? Incomplete tasks create stress, and a desire to complete. So mentioning the first talk after the second, did it create more tension in you than the other way around would have?

Alright, back on topic. What has user task modeling to do with red-green-refactor. A task model is a diagram of steps a user goes through. We can consider red - green - refactor to be an instance of that model. 

The third law of task modeling is: _users forget about the task afterwards._

What does afterwards mean in this context? Afterwards means thatonce the user feels the task has been completed they can walk away from it. Jesmond started the talk with an example from early cash machines (also known as ATMs). People would take their money, and forget about their card. Their task was to get money, and once that was completed, they would forget about the whole transaction and walk away. The way that was solved was to let the user take out their card first, so the duration of the transaction was aligned with what the user perceives as the task. 

Oops, I did it again. Start with law three. Lets' finish the task of enumerating the laws then, shall we?

[@Jesmonds](https://twitter.com/jesmond] Laws of User Task Models:

1. Order of events
2. Fixated on completing the task
3. Forget afterwards

In red green refactor, we have an order of events. We fixate on getting to green, and forget refacgtoring afterwards.

So do refactor - red - green - (maybe) refactor instead. You, your colleagues and your code  will feel better for it.
