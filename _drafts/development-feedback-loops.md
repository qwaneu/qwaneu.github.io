

# The three loops

![initial whiteboard sketch](/attachments/blogposts/2022/3-feedback-loops-sketch.jpg)

# Summary

Looking at software product development, we can distinguish 3 important feedback loops.

Improvements in the inner loop have the most impact, because the loop is iterated over most. Any effects (whether good or bad) get multiplied. This means that continuous attention to an investment in technical excellence is essential.

Many 'agile transformations' tend to focus on the middle and outer loops only, which is necessary but not sufficient. According to Jason Gorman, this is the reason most agile transformations fail.

For effective, sustainable development, we need to work on all three feedback loops eventually. Focusing on the middle and outer loops is not sufficient, but focusing mostly on the inner loop isn't sufficient either. Productivity and ROI come from the interplay between the loops. You still can decide to focus on a specific loop at specific points in time, but over time you need to tend to all three.

The three feedback loops is a model and a model is a simplification. We think it provides a useful lens on the systemic effects in software product development and helps to find more effective (and efficient) interventions.

Looking through the frame of the 3 loops allows us to investigate: length of the feedback loops, delays, handovers of work, waiting for decision making, "rework" (work going through the loop again because it is not good enough; cf. failure demand)




# Three feedback loops in software product development

"Good morning! One thing I'd like to add one thing to the 3 loops view on product development we used in the retro: even though you need to work on all 3 loops for being effective, (small) improvements in the inner development loop have the biggest effect because of multiplication effects. So it pays to invest time in improving build times, fixing flaky tests, getting quicker PR feedback, etc." (message by Marc to the team at ZorgDomein)

Inner loop has most leverage: "Continuous attention to technical excellence and good design enhances agility." (Agile Manifesto principle 9)

Middle loop: "Simplicity--the art of maximizing the amount of work not done--is essential." (Agile Manifesto principle 10, although this applies to the other 2 loops as well)

# Sources

Ref: Jason Gorman, [Why agile transformations fail](https://www.youtube.com/watch?v=-wNH6YgZQtw) July 2021
- Most Agile transformations tend to focus mostly on optimising the outer feedback loops of the development process, which produces disappointing results. To speed up delivery cycle times, focus on the innermost loop - build & test 
- The kernel of agility in software development - and the business models that rely on that software - is how long it takes to build and test your software. I can pretty accurately predict the future of a software-dependent business with that one metric.
- If your build + test times are slow, the cost of changing your systems will be high, and - no matter how successful you are now - you're just doing market research for a more agile competitor.
- The key point in my video on why Agile transformations tend to fail is they try to speed up nested feedback loops by focusing on the outer loops. As any programmer of performance-critical code will tell you, optimising the innermost loop usually produces much faster cycle times

The other source for the 3 loops is: Agile Fluency model with its Focusing, Delivering & Optimizing zone capabilities correspond to the 3 feedback loops.

# Related work

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Programming is a leverage game. Making the lever longer is *way* better than pushing the lever harder.</p>&mdash; Kent Beck (@KentBeck) <a href="https://twitter.com/KentBeck/status/1489301473380864000?ref_src=twsrc%5Etfw">February 3, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

XP loops; the "2 parts" of XP (the Scrum-like part and the 'technical' part)

Related to XP: BDD has inner and outer loop - https://twitter.com/AntonyMarcano/status/1450394615304044546?t=fQX1saqyXxU9o-WTf8dVQw - the TDD loop, one failing test at a time concerns the inner dev loop; the BDD or 'acceptance test loop' concerns the getting things done loop  

Martin Fowler, [Is High Quality Software Worth the Cost?](https://www.martinfowler.com/articles/is-quality-worth-cost.html)

# Follow up posts:

## Improving the inner loop?
- what does improving the inner loop means? e.g. "smoothness of delivery", no more flakey tests, shift left

## Serious investment in the inner loop
- improving inner loop is necessity but it requires serious investment, e.g. training and coaching 
 
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">
Too many companies think “coaching” is a benefit they might offer under the learning &amp; development budget, when actually it is an existential concern for any technical team. 
<a href="https://t.co/Z3Ih1CRZJr">https://t.co/Z3Ih1CRZJr</a></p>&mdash; Beth (@bethcodes) <a href="https://twitter.com/bethcodes/status/1437153928362160131?ref_src=twsrc%5Etfw">September 12, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Training often seen as something for the individual, and as a fringe benefit (? "secundaire arbeidsvoorwaarde"). This misses the point of structurally improving the inner loop in a teams based environment. 

Team > individuals + it's about team capabilities. We need to train & coach teams. This is another bit point of leverage. It also requires a different frame of thinking, not software development = many hands programming (we are still learning what software product development really is)

## 3 feedback loops seen from complex systems perspective

safe-to-fail probes; being able to dampen negative effects
