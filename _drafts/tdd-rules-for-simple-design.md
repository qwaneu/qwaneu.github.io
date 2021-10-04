# rules for simple design

Maybe we should call this heuristic '(re)write tests for your audience'.

(TODO [link to the glanceable post](2021/09/27/tdd-glanceable-tests.html)) 
> Extract method refactorings are often more about the place where they are called, than the place where they are defined.
> We prioritize making the whole more readable, even when we have to introduce more parts.
 
Code must be undertandable for the whole team (and other people and teams when
appropriate). Questions about 'what is this?' are an opportunity to improve the
design, not for defensiveness. We love having interns and new team members: They
ask innocent questions. This reveals assumptions we made when we wrote the code
that were invisible to us.

We had a debate about whether you could see this 'understandable for the whole team' as embedded in (TODO link the
four rules of simple design) on twitter a long time ago. We find it important to
emphasize that code is, generally, written for an audience. 

That sometimes also means letting go of 'cool abstractions' that we came up with. Marc and Willem once worked on a team, where only half of the developers could work on some of the 'cleverer' parts of the code. On a good day. If you locked that half in a hotel for a weekend. Maybe. And then they'd rewrite it in an attempt to make it more understandable. And fail. And the cycle would start again. (we were some of those clever bastards - this is how we came up with calling someting 'clever bastard code' it is not necessarily positive).

Contextually appropriate code
----


>obsessing over "clean code" as opposed to "contextually appropriate code" holds
>developers back from learning the strategic skills necessary to success at
>senior levels
@betsythemuffin [on twitter](https://twitter.com/betsythemuffin/status/1280930684819787776)

Why should I care? Personal growth is one thing. Design patterns and heuristics are about contextually appropriate code, but especially with design patterns. 

Even if it is just you, do you stil understand code that you wrote last year?
-----

Further reading and viewing
----

The book A philosophy of software design by John Ousterhout (of TCL). We don't agree with everything in the book, but there is food for thought and things we hadn't considered before in it. Reading and working outside our design comfort zone zone helps us grow, and eveluate trade-offs differently.

Talk: the wet codebase by Dan Abramov (of React)
https://www.deconstructconf.com/2019/dan-abramov-the-wet-codebase about the benefits and costs of abstraction.
"it is hard to explain all the trade-offs to then next generation, they don't have the context to decide when it is a bad idea". "when we teach something to the next generation we should explain what are the benefits, and what we are trading away". "what are you actually trading away". "what if the context changes." "what exactly was traded off and why".

From [this twitter thread](https://twitter.com/rebeccawb/status/1281248011427786752) by Rebecca Wirfs-Brock:

> And that, indeed is the challenge. How to *support new requirements without eroding*
  or overcomplicating or fracturing or obscuring an already good enough
  abstraction...


Wider considerations of clean code, also from the @betsythemuffin tread (@TODO check reference) probably

>it also creates a world in which developers are encouraged to focus on code as
>logic puzzles rather than a tool whose use always has political implications

Something about design patterns
>>>>>>> 804a341... Groping towards publishable posts
