---
layout: post
title: Team Fluency Feedback with Systems Thinking
tags:
  - agile fluency
  - feedback
  - systems thinking
author: Marc Evers, Rob Westgeest
image: 
---

To get a better insight in how a team can grow, and to get to an investment plan, we apply the principles and tools from Agile Fluency. In this post, we'll share how we run a team diagnostic and arrive at recommendations for the team to grow and for management to support and invest. The examples are based on an actual diagnostic we ran with a team, but we have blurred any confidential information.

@@TODO: iets over AF loops met eigen diagram?


We start out with a conversation with management (i.e. people who have the authority to decide on investments the team needs). Together we come to what objectives they have for the team and what fluency zone is appropriate: focusing, delivering or optimizing.

Then we run a diagnostic workshop with the whole team. This workshop is a kind of team retrospective: each team member fills in a survey individually, then we discuss the aggregated results together. The survey consists of a series of method-agnostic statements about team behaviour, team members indicate if the team shows that before on a scale from Never to Always.

The aggregated results look like this:

![rollup example](/attachments/blogposts/2021/afd-rollups-example.jpg)

The dots represent the different team members, the answers marked green is the 'consensus' we arrive at collaboratively. The consensus is not about perfect agreement, it is about a good-enough answer for where the team currently is.

These results do not represent the team's maturity! It is not about a race to the top. Instead we provide a team feedback on how fluent they are in the different capabilities of getting quality software out of the door now and in the future. We use this information to give direction for growth (much more specific direction for growth than what usually comes out of a team retrospective). The fact that this specific team is not fully fluent in everything does not mean that they are a problematic team. On the contrary, this is a team that is doing quite well, they are delivering to production almost every day and have low defect rates. They can still grow in some aspects.

So the exact survey answer are not so relevant, it is all about the conversation we have and shared every team member's perspective. The team has a conversation about how they work. Sharing different perspectives and perceptions is already hugely valuable. Many of the teams we meet do not get to such a depth in their sprint retrospectives. So the session is not just strictly a diagnosis, but also an intervention to some extent. This is to be expected when working with complex systems like teams and organizations.

The survey statements trigger quite deep conversations from the team. We listen for weak signals (like someone saying "we have hardly any serious issues") and  probe about what is really going on. So in a time span of 2 hours we get overloaded with a huge amount of rich information of how the team works and how it interacts with its context. Too much to keep in our head, so we make many, many notes - and process the notes immediately afterwords in some markdown document. 

![example diagnostic notes](/attachments/blogposts/2021/afd-notes-example.jpg)

We do not provide advice or recommendations in the diagnostic session. We take our notes, have a good night of sleep and then try to make sense of it. We are especially interested in any systemic effects at play, things that keep the system the way it is, things that are self-reinforcing and risk running out of control. We know from experience that by diving a bit deeper we can find possible interventions that have much more lasting impact. It prevents us and the team from focusing on symptoms alone.

To make sense of all the details we have heard, we use a technique called Diagrams of Effects (DoE). It originate from the field of systems thinking, we learned it from Gerald Weinberg. In a DoE, we try to map the system in terms of variables and their causal relations. 

We start out with writing down candidate variables on post-its. A variable is something that can increase or decrease, something that you can measure or observe in practice. Initially it is mostly brainstorming and diverging:

![initial brainstorm of variables](/attachments/blogposts/2021/afd-many-postits.jpg)

Some examples of the variables we have found here: 
- Smoothness of delivery to production
- Size of business increments
- Defects in CI/CD pipeline
- Clearness of Why & Value of work
- Time between delivery to production and finding a production issue
- Slow down by technical debt

You might notice that these variables look quite generic, like they could have been written for your team. 

In this case the darker post-its represents variables related to the Delivering zone, and the lighter ones related to Focusing and Optimizing.

Then we get to the daunting task of finding relations between the variables. We do this together as pair of facilitators. We start drawing causal edges and challenging each other if this causal relationship is really there, or is it an indirect relation (i.e. some other variable should be in between). We also start merging duplicate variables, discarding some that do not add much in this context:

![converging to a diagram of effects](/attachments/blogposts/2021/afd-converging.jpg)

Black edges mean a 'same' effect: if one variable goes up, the other also tends to go up. Red edges mean an 'opposite' effect: if one variable goes up, the other tends to go down.

We sometimes add some extra explanation or write down some themes we notice (purple post-its in this case). Or we add some benefits (relevant for what management wants) and how these relate to the system (green post-its).

The DoE we create is not the truth. It represents how we (as facilitators) perceive the system, based on what we heard from management, what we heard from the team, what we heard between the lines and our own experience in software development organizations. So we don't present the complicated diagram shown above as 'the way things are' to the team. Instead, we use the diagram to illustrate how we see the system, and how we think the team can make more effective steps for growth. Previously we have called tools like DoE 'intuition support systems'.

Especially if our efforts result in such a big, complicated diagram, we look for ways to present it in a more manageable way. In this case we noticed that there were actually 3 systems in place. Of course, everything is connected, but this allows us to present our feedback more focused:

![splitting up the DoE](/attachments/blogposts/2021/afd-splitting-up.jpg)

We have also found a number of self-reinforcing loops in the diagrams, represented by the snowball pictures. 

Let's have a look at one of the sub-DoEs. It is about handling technical debt.
When we present a DoE like this to a team, we build it up in steps, so that we take the team along with our story. 

![example DoE: technical debt](/attachments/blogposts/2021/afd-techdebt-example.jpg)

We noticed a self-reinforcing loop: over time, more Technical debt means the Long term maintainability goes down, reducing the Smoothness of Delivery. Lower Smoothness of Delivery makes reliability of forecasts go down, reducing the ability of the organization to steer the development initiatives. This lowers the organization's trust in the team, which negatively impacts the quality of both functional and technical decisions in this context. And this increases technical debt, and so on.

Reducing technical debt as a project is one way of tackling this. It requires more visibility of technical debt (in terms of business impact, short term and long term). Tackling technical debt in projects has all kinds of disadvantages, one of them is increasing the length of development feedback loops. Technical debt project tend to be complex and fairly unpredictable, which impacts forecast reliability, etc. So we put a big 'Beware!' there. So it is not inherently bad, but we find it important to be aware of the impact of tackling technical debt in this way.

Alternatively (or additionally), the team can tackle technical debt by refactoring in (many, many) baby steps. By keeping the actual steps small, enables the team to get in a state where they are continuously working on technical debt in a more predictable way, while keeping capacity for other work as well. Tackling technical debt in this way is a skill however and working in very small, highly controlled steps as well, so some investment (mostly time, and perhaps a bit of training) is needed here.

When reporting back to management, we sometimes create specific DoEs, focusing more on management perspective, or we re-use the DoEs we showed the team (with the team's permission). 

Another benefit of DoEs, besides going beyond symptoms and getting to more effective interventions, is that is is blameless and non-personal: it shifts the focus away from individual's behaviour, to the systemic aspects, to how things are organized and how that affects behaviour. This is in line with e.g. Deming's statement that [90-95% of performance is governed by the
system](https://deming.org/dr-deming-called-for-the-elimination-of-the-annual-performance-appraisal/).

And then?

The feedback we provide to the team and to management is quite rich, so we let them sleep on it. We meet up with the team to check up how it is going, to help them identify experiments they could run. 
