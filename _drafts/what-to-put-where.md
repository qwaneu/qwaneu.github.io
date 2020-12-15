---
layout: post
title: WTPW - What To Put Where, the million dollar question in software development
tags:
  - architecture
  - design
author: Marc Evers
image: /attachments/blogposts/2020/cesar-carlevarino-aragon-NL_DF0Klepc-unsplash.jpg
---


Deciding What To Put Where is half of the work of software development. What
should I put where, in such a way that I (and my colleagues!) will be able to
find it back later? Finding a good place for things in code greatly helps (or
hinders!) maintainability of the code later on.

Knowing what to put where is a skill developed through practice. Some things
that can be helpful: looking at code through a Hexagonal Architecture lens,
making the 'things' in your code explicit by wrapping it in types or classes,
CRC cards, pair programming, documentation.

![](/attachments/blogposts/2020/cesar-carlevarino-aragon-NL_DF0Klepc-unsplash.jpg)
{: class="post-image post-image-70" }

Let's explore this further in this post, through some examples.

## Why WTPW

An important part of our job as software developers is taking design decisions
at all levels: sketching the high level architecture on a whiteboard, where we
decide which responsibility goes in which components; CRC
(class-responsibility-collaborator) design sessions, where we play out scenarios
of object interaction, to see which object will have which responsibility; and
also at the micro-level, where we decide on naming, on functions or methods. 

We are not only trying to make it work, but we are also continuously thinking
about what concern or responsibility should we put where. This is quite an
important task in software development: we spend much more time reading and
understanding code than writing it. If we want to make changes, we'd like to
quickly find out where in the code base we should be. And we hope the concern to
be changed is in one and only one place.

> Putting things in the 'right' place will help us a lot later on. It
is so important that we think it deserves its own acronym ;-)  
> **WTPW - What To Put Where**

How do we decide what to put where? We do not have generic rules and certainly
not best practices. We do apply numerous design heuristics and it is a skill you
learn through (deliberate) practice. So let's have a look at a few examples and
our considerations regarding what should be put where. The examples are from the
online [Agile Fluency® Diagnostic](https://www.agilefluency.org/diagnostic.php)
application we are working on.

## Adding CSV export

In the Online Agile Fluency Diagnostic application, we show a colourful
aggregated view (the 'rollup chart') on team survey results. We decided to make
this aggregated data available for download in CSV (Comma Separated Values), so
that our users can process it using their own tools.

In our back-end component, we already had the following:
- a domain object Rollup with the logic to create it from survey data
- an HTTP GET route to expose the Rollup as JSON data, part of the adapters ring
  of our component
- a function that maps the Rollup object to JSON data, part of the route module

How do we fit in a CSV export? We regard it as a view on the Rollup domain
object. Looking through the [Hexagonal Architecture](http://localhost:8082/2020/08/20/hexagonal-architecture.html) lens, it does not affect the
domain, so we do not need any domain changes. It is an adapter concern: it is
about translating a domain object to a different format on a different endpoint.

![fitting in CSV export into the architecture](/attachments/blogposts/2020/wtpw-csv.jpg)
{: class="post-image post-image-50" }

We added an endpoint and a Rollup object to CSV mapping function that produces
text lines in CSV format. The front-end component also needed a bit of work to
expose this new feature, a button to start the download.

As a result, whenever we need to change or add data in the CSV we know exactly
where to find it: it is an adapter-concern, part of our route code.

The CSV conversion including the headings is currently a single function, 8
lines of Python. Once we'd start doing more with CSV, we might find that 'CSV'
is a thing of itself as well and start extracting a class for it.

## Internationalizing an application
 
Another interesting feature we took on for the Online Agile Fluency Diagnostic
application was internationalization (I18N). We wanted to offer the team survey
in different languages, where the facilitator selects a language for a
diagnostic workshop. While the original survey is in English, our colleague
facilitators had been working on German and Spanish translations. Having the
team survey available in multiple languages makes the online tool much wider
applicable.

In our Vue.js front-end component we decided to use the `VueI18N` library. We
created a file with translations for some of the front-end texts and fed this to
`VueI18N` which plugs itself into the UI components. It works pretty
straightforward. So our first idea was that language and locale related stuff
needs to land in our UI components.

The survey question texts themselves are however not part of the front-end
component, but come from the back-end. So our back-end needs to have multiple
translations of the survey and serve the one based on the team workshop
language.

When creating a diagnostic session, we want to select language from a list of
languages. The `NewDiagnosticSession` UI component ([which we wrote about in an
earlier post](/2020/09/25/hexagonal-frontend-example.html)) gets available
languages from the back-end.

When the front-end Survey component retrieves and shows a survey, it needs to
set its language to the language of the survey, so that the surrounding texts
(like instructions for the survey) also show up in the right language. So the
Survey UI component ended up with some logic around `VueI18N` and current language
selection.

Because a facilitator shares the rollup charts view with team members, it should show in the language of the diagnostic session. Afterwards, it should
switch back to English. We had to add some conditional logic in a router hook to
make sure the language gets reset when needed. 

Hm, it does not smell good...language and `VueI18N` knowledge everywhere...

![I18N creating a mess in our architecture](/attachments/blogposts/2020/wtpw-i18n-1.jpg)

Multiple UI components contain language related logic and depend on the
`VueI18N` library. Our domain knows about languages. Our `main.js` needs to wire
it all up knowing too much intimate details about how `VueI18N` works... We had
for instance code like this in UI components:

```javascript
  retrieveQuestions: function () {
    this.diagnostic.retrieveQuestions(this.sessionId, this.participantId).then(() => {
      this.$i18n.locale = this.diagnostic.language
    })
  }
```

Our UI components are acting as a Mediator between our domain code and
`VueI18N`. We followed the Hexagonal Architecture principle of keeping libraries
and frameworks outside, so we prevented dependencies on `VueI18N` in our domain,
but now our UI components are getting messy.

> Note that the language of the survey is a cross cutting concern. Both front
end and back-end will have knowledge of survey language.  
> **The question is not how to remove this knowledge as much as possible, but
rather how to minimize what each part _really_ needs to know to do its job.**  
> In the back-end we know the language of a diagnostic session and we select an
appropriate version of the survey based on that. We also select the correct
translation for the invitation email sent to team members, but there is no other
language-based logic there.

We concluded that we are missing a domain concept and an adapter in the front
end. Although `VueI18N` is quite closely related to the Vue.js based UI
components, the concept of current and available languages is still a separate
concern. So we introduced a **Language Store** concept, implemented by a
`I18nBasedLanguageStore` adapter which encapsulates the dependencies on the
`VueI18N` libraries.

After we introduced the language store, we suddenly had a place to put all
language related stuff: selecting the current language, knowing the available
languages, resetting current language when appropriate. Now our domain can
_decide_ on the language, but it does not need to know how it works. It
delegates to the Language Store which handles the details. Our UI components
were freed of complicated language related code; they just translate and
visualize, nothing more.

![I18N - improving dependencies through the language store concept](/attachments/blogposts/2020/wtpw-i18n-2.jpg)

> Once you discover, or uncover, a concept in your code and you make it explicit
> through a type of class, suddenly different concerns start finding their
> place. You start looking in a different way at logic you have been adding in
> several places.

## Things that help

What helps us in deciding what to put where? 

- **Use [Hexagonal Architecture](http://localhost:8082/2020/08/20/hexagonal-architecture.html) as a lens** - Hex is a typology - look at concerns in code, is it port, adapter (primary/secondary), domain, ...
- **Introducing a name for a 'thing' in the code**. We can do this either by design or discovery. Whenever we find ourselves fiddling with a string (or any other primitive type) in several places in the code, this string apparently means something. We look for a good name so that we can create a class or type for it. Having a thing represented by a name and a class creates a place in the code where related logic and responsibilities want to go. Duplicated code or doing similar things in different places in the code is usually a strong indicator that there is something to be discovered.
- **Ask ourselves 'who needs to know what? what can we do to reduce that knowledge?'** The more an object or function knows, the more coupled it is, the more sensitive it becomes to changes. And the more code we will need to touch if there is a change. In our I18N example, both front-end and back-end know the language of a diagnostic session. Only the front-end needs to know about the current language, the back-end does not (and should not) care.
- **Working with CRC (Class, Responsibilities, Collaborator) cards to get quick feedback on a design**. With [CRC cards](http://c2.com/doc/oopsla89/paper.html), we create a model of object and their proposed responsibilities on cards, which enables us to quickly play out al;alternative scenarios and get a feel for how the design would work out. It also helps to get feedback on which object needs to know what.
- **Pair programming, or ensemble/mob programming** - it pays to have a good discussion about what is the nature of the thing, and where does it belong; nitpicking is worthwhile, the minutes we spent bickering about the right place will probably save us and our colleagues many hours of wandering through the code to find the line(s) to change
- **Documentation** helps too, e.g [Readme Driven Development](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html) or a high level description of what goes where on a wiki. It helps if we have standard places at least for the main concerns, and we stick to that. The links in the documentation may suggest alternative arrangements@@.

## Learn what to put where

"How can I learn more about what to put where?" a participant recently asked in our refactoring workshop. WTPW is very much about skill and design heuristics. So no best practices or simple lists to learn by heart. So what _can_ you do?

- Practice, lots of practice, **deliberate practice**
- **Practice together** - run frequent team sessions to practice, e.g. in the
  form of [coding dojos](https://codingdojo.org/) or [mob/ensemble programming](https://www.agilealliance.org/glossary/mob-programming/). By putting the code
  under a magnifying glass and nitpicking together, you will learn a lot, and
  have a great time!
- Try out **alternatives and small experiments**, whenever you can; yes, also when you're working on production code; but also when sketching designs on a whiteboard or doing a CRC session
- **Test Driven Development** is a discipline of software development that helps in making you continuously think about what to put where; the **Growing Object Oriented Software, Guided by Tests** book by Nat Pryce & Steve Freeman is highly recommended for this.
- **Read the [99 Bottles of OOP e-book](https://sandimetz.com/99bottles)** by
  Sandi Metz, @@
- Learn yourself **the language of Code Smells and Refactorings**. Code Smells
  provide a vocabulary of things that can be improved in the code. Mastering
  this vocabulary will give you a richer perspective on your code. Refactorings
  provide you with a vocabulary to reason about small, controlled improvements.
- Learn about **[connascence](https://connascence.io/)**, a more formal model of
  different dimensions of coupling in code. Connascence is not widely known, but
  gives you a powerful perspective on dependencies - who needs to know what and
  what else needs to change if I change this? 
- **Don't be afraid to make wrong choices**. Learning how to refactor away
  from your previous, not-so-good decisions is much more powerful than trying to
  learn to do things first time right. The more skilled you get in programming
  yourself out of corners, the less risky wrong design decisions become and the
  more you are able to learn, and the more... see the virtuous cycle here?

## References

- More about [Deliberate Practice](https://jamesclear.com/deliberate-practice-theory)
- [Buy our Code Smells & Refactoring cards](/shop) for learning the vocabulary of code smells & refactoring
- Read more about Connascence in [Kevin Rutherford's blog](https://silkandspinach.net/2015/02/10/connascence-a-retrospective/)


_Credits:  thanks to Willem for editing and helping improve this post._

_Photo credits: tools photo by <a href="https://unsplash.com/@carlevarino?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Cesar Carlevarino Aragon</a> on <a href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>_

<aside>
  <h3>Learning what to put where</h3>
  <p>We can share our experience with WTPW through workshops, courses and team mentoring.</p>
  <p><div>
    <a href="/training">Learn more about our workshops and courses</a>
  </div></p>
</aside>
