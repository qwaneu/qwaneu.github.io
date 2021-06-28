---
layout: post
title: "TDD Heuristics: Wishful thinking"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/wishful-2.png
---

Write the test based on how you wish the object under test could be
used. Then make it work. Don't be guided by constraints
and implementation details...nothing is holding you back! 
Just write it as you'd wish it to be...

![@@todo: text](/attachments/blogposts/2021/tdd/tdd-cycle-small.png)
{: class="post-image" }

The [Growing Object Oriented Software book](http://www.growing-object-oriented-software.com/) calls this "Write the Test That You'd Want to Read".

By writing test scenarios like this, we can already get feedback about our 
design ideas without having to implement them first. This enables us to 
steer the design just in time, based on concrete examples in code. It is a bit 
like sketching an [interaction diagram](https://en.wikipedia.org/wiki/Unified_Modeling_Language#Interaction_diagrams) on the whiteboard, but you are expressing 
it precisely in code.

![Wishful thinking](/attachments/blogposts/2021/tdd/wishful-2.png)
{: class="post-image" }

Actually, [thinking about design in test](@@todo) is usually an act of wishful
thinking, because you are expressing a piece of design in your test that is about
to come to life. 

Jim Shore: 'Programming by Intention': 
1. call the functions you wish you had
2. comment it out
3. implement the missing functions
4. test, uncomment, fix up

In his [video series sabout Test Driven Development](https://www.jamesshore.com/v2/projects/lunch-and-learn)

## Wishful thinking in practice

We also use wishful thinking for instance when we kind of get stuck
writing a test because the new idea does not readily fit the currently existing
code. By wishful thinking, we don't let ourselves be constrained by the current
solution (for now), but just express how we imagine it to be. Once we have
expressed that, we can evaluate and see what it means for the existing code.

If we get stuck in a design discussion or need to be more precise than just
drawing the lines and boxes on the whiteboard, we can do wishful thinking to
express our train of though and share with our colleagues. It is a cheap and
fast way to get feedback.

## Sources

The practice of wishful thinking has been around for a while. As far as we know,
it comes from: _Abelson, Sussman & Sussman, [Structure and Interpretation of
Computer Programs](https://mitpress.mit.edu/sites/default/files/sicp/index.html)

We use [Interaction diagrams](https://en.wikipedia.org/wiki/Unified_Modeling_Language#Interaction_diagrams) sparingly. If we do use them while writing tests we find the [sequence diagram](https://en.wikipedia.org/wiki/Sequence_diagram) on a napkin or whiteboard useful. Especially with potentially complicated interactions or mock objects.
