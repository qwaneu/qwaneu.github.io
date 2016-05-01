---
layout: post
title:  N days of Web development with Haskell, day 0 - Why?
author: Willem
summary: Zeroth in a series of blog posts about web development in Haskell. Today we ask ourselves "Why on earth redevelop something we already have?"
---

Inspired by [Ollie Charles](http://ocharles.org.uk) 24 days of Hackage, I decided to try my hand at writing a series of daily blog posts about my experience developing a web application in Haskell.

Why on earth am I doing that? From the set of programming languages I have not tried yet, there were two that I really wanted to try in a real project: Clojure and Haskell. I am in the process of wrapping up a client project I did with Clojure. I hope to write more about that. With Haskell, like with Clojure before, I mostly did small exercises, and a side project. The best way to learn a language is to do a project with it. That way you get all of the benefits and warts, and it gives more of a feel for what kinds of things the language, it libraries and community is most suitable for.

This series is called N days, and not 24 days, because I don't know how many days I'm going to need.

## More Why, for the project.

So I want to try Haskell for real. What benefits and pitfalls do I expect for this particular project. What project? At QWAN we have developed our own registration system for courses, that we want to roll out and sell to more people like us. We wanted something that we could easily on top of a simple static site or a wordpress blog, that respects the branding of our site, and that does not charge a percentage of our revenues.

The side that course participants see is mostly javascript, with some trickery to run it on a different site then where it is hosted. The client-side is pure javascript, with some jquery, which had its own problems, the back-end and the admin site for course organisers we made in Ruby.

I don't plan to rewrite the whole thing in one go, but try my hand on a small part. We also made our contact forms as javascript widgets with a ruby backend, so that all our sites can use the same server and we could convert the PHP sites we had to simple static sites. Less maintenance, smaller attack surface for hackers and more time for writing and other things. So I'm going to rewrite that multi-tenant contact service first, and put it up on github as open source.

Why? It looks like Haskell can do with a few more complete sample projects, warts and all, that people can use. I also hope to get some feedback on my choices and coding style, and maybe publish a little library for things that are not yet there in the eco-system (I was looking for something to support A/B testing and could not find it, for instance, other things are well covered however).

We started last year, and now I want to continue. I probably will spend a lot more time on this. I want to have fun, iterate fast, and be sure I make a reasonable choice for development and deployment. So I'll evaluate one more option. If it fails, it's back to Ruby, or perhaps forward in Clojure.



## So what do I expect from Haskell?

### Test interesting things, in interesting ways
I love TDD, and one of the basic tenets is 'test everything that could possibly break'. I love TDD best when I can use it to drive a design, and every test gives me new insight about what I am trying to do. I find tests for correct routing and links not to be very insightful, and often the most useful of these tests are integration tests, running slowly against the whole application.

QCourses is a small system, yet we spent quite a bit of time wiring up the javascript with itself, the javascript with Ruby, Ruby with HTML, some of the work felt repetitive, and I got the distinct impression that a language like Haskell, with a decent typesystem could help us work in babysteps, and catch errors, freeing us up to reserve writing tests for more interesting things.

### Powertools

QuickCheck, a very powerful testing library I played around with, originates from Haskell. I want to try it out in a real project and see how it goes.

### Performance and elegance

The Haskell community seems sufficiently performance obsessed, so I hope to marry elegance and performance. Some people believe they are opposites, I don't. TDD and simple design have helped me do that before, and the small experiments I've done so far have shown me a good type system helps baby steps most of the time, and at other times forces you to step back and drive the design differently. Safety, speed and understandable design all come from the same source: thinking hard about what you are trying to do, and getting as much feedback from as many sources as you can and incorporate it in your work. Haskells' type system is an additional source of feedback.

### Out of our comfort zone

In our trainings we consistenly ask participants to go out of their comfort zone and learn new things. We should lead by example and do the same.

## What am I going to start with?

[Gabriel Gonzales](http://www.haskellforall.com) wrote in [Introductions to advanced haskell topics]((http://www.haskellforall.com/2014/03/introductions-to-advanced-haskell-topics.html):

<blockquote>
I wish people would spend more time diversifying coverage on more mundane topics, like how to apply well-established libraries to architect various types of applications.
</blockquote>

I don't know how to apply Yesod, being a well established library, to architect an application. I can show you how I, being a somewhat newbie Haskell programmer, go about it. So I hope fellow newbies might find this useful, and experienced Haskelites maybe rejoice in the [Arrival of the idiots](http://shadow.cat/blog/matt-s-trout/love-your-idiots/) and get inspiration for the kind of things not yet covered in documentation.

### Yesod Web Framework
I'm going to start with the Yesod framework. Normally in Ruby I would start most of the time with a micro-framework, because we know our way around the ecosystem. Sometimes I still use Rails, if the problem fits its model well. In Haskell, I don't know my way around, and from what I've read so far, the Yesod maintainers have thought hard about the tradeoffs they make, and explain the trade-offs they made well. The [Yesod Book](http://www.yesodweb.com/book/haskell). explains things simply, and where necessary explains where you need to look if you want something more complicated. They also show how you can use Yesods' pieces in isolation, so you can combine them with something else. An open attitude that gives me confidence diving in.

What I like most is that they strive to use type-safety together with Don't Repeat Yourself to eliminate the errors I commonly make, which should free up time for more interesting things, like solving business problems or spending time with my family.

On the one hand, Yesod looks like a classic MVC web framework, and as a wannabe hipster I might prefer something more fashionable client-side like Om in Clojurecript. On the other hand, I want to validate our ideas as soon as possible, we already have the javascript we need for the participants, and we can start with a more conservatively built backend. Yesod's REST implementation looks like a solid enough base to build another front-end later.

### Fay, elegant and performant javascript
Haskell now features a number of haskell to javascript generators. I played with Fay, and it seems to be capable of generating javascript that can be made light enough to serve up as widgets, using the google clojure compiler resulted in something small enough. Before last year, I was weary of javascript generators. But I dove into javascript for our widgets, and a legacy javascript refactoring course we ran for a games company that I am happy to set aside a little cycle time for compiling to javascript and catching the silly little mistakes I make to save me some time in end-to-end testing.

I hope to reuse the domain model and validation logic that we write on the server-side on the client-side.

I'd rather sit with a client to see if the flow I come up with is understandable, than spend time writing end-to-end test automation to catch all the silly mistakes I made. I might stil write some, but I hope it is going to be less than before.

### VanillaJS

After quite a bit of puzzle work we managed to equip our javascript widgets with JQuery. If a widget runs in someone else's page, you don't want it to contaminate their JQuery or the other way around. It turns out we don't use that much JQuery at all. From building the widgets last year, and the work we did at the game company, I learnt that eventually you have to understand browsers and what they can do with javascript. Often a library is a crutch preventing you from learning in the first place what you eventually have to. And what we need is not earth shattering. So VanillaJS, hopefully generated by Fay.

Since Fay has very simple javascript interop, we can do that in baby steps.

### Where does the data go?

I don't know yet. For the Ruby + Javascript version we chose MongoDB just to try it out. I might do that as well. Probably start with sending out mail. You want to know when people register or contact you, having stuff in a website as a reminder is a nice to have at first. I'm a big fan of postponing big design decisions when I can. Having said that, I am going to figure out how Yesod deals with persistence, because eventually we will need it.

## Now what?

In the upcoming episodes I'm going to work as patiently as I can through the [Yesod Book](http://www.yesodweb.com/book/haskell) and start working on the multi-tenant contact form. I chose something with almost no domain model, so that we can pay attention to 'non-functional' aspects of the software and see how that works - things like authentication, authorization, cross-domain scripting, performance, persistence and last but not least, how fast we can iterate on an idea, ship and incorporate feedback.

## Feedback

I would love your feedback. I'm @mostalive on Twitter, the comment section is also open.

