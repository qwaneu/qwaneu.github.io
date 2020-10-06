---
layout: post
title: WTPW - What To Put Where, The 1M$ question in software development
tags:
  - architecture
  - design
author: Marc Evers
image: 
---

What To Put Where? deciding this is half the work of software development

WTPW ... in such a way that you will be able to find it back

## Examples

## profile dependent menu

@TODO

### Adding export of rollup data in CSV format

We already had a GET endpoint delivering rollup data

- domain object Rollup + logic how to create
- route to expose it at end point with GET
- mapping to JSON data (as part of the routes adapter code)

How does CSV fit in?
- it is a view on the same domain object; it does not affect the domain, no domain changes needed
- so it is a route only concern: we add an endpoint and a mapping function that produces text lines in CSV format
(and yes, the front end component also needed a bit of work to expose this new feature)

So whenever we need to change or add data in the CSV we know exactly where to find it.

### Internationalizing our application with Vue.js / VueI18N

VueI18N integrates with Vue components (you configure it with locale and translations/messages, plug it into Vue, it makes a $t function available on all your UI components, pretty straightforward); so (first idea) language/locale related stuff needs to land in our UI components

We change the language based on the questionnaire data, in our domain code, so we extend UI component. When it delegates questionnaire retrieval, it sets the language when the promise is resolved.

When creating a diagnostic session, we want to select language from a list of languages. The NewDiagnosticSession UI component gets available languages from AppInfoModule, which is initialized by the App.vue (root component) 

When looking at rollup data, this should show in the language of the diagnostic session, but afterwards, it should switch back to English. We had to add some conditional logic in a router hook to make sure the language gets reset when needed. 

Hm, this does not smell good:
- it looks like our UI component is now acting as a Mediator between our domain code and VueI18N; but we do not want dependencies on VueI18N in our domain (Hex rule: no libraries/frameworks inside)
- language/locale related concerns are spread around the code, UI components knowing too much, domain, router, main.js

We are missing a domain concept and an adapter here. So we introduced a Language Store, implemented by a I18nBasedLanguageStore adapter. 
- I18N is yet another (secondary port), VueI18N is yet another library we can wrap in an adapter

So we now have a place for selecting the current language, for knowing the available languages, for resetting when appropriate (still triggered from the router, but without conditional logic). Now our domain can decide on the language and drive the Language Store port. Our UI components just translate, nothing more.

> once you discover/introduce your own concept for something, then suddenly different concerns start finding their place. You start looking in a different way at the different ifs and stuff that you have been adding.

### Introducing 'test' diagnostic sessions

We introduced 'test' sessions for facilitators to try out stuff without consequences (and for us to see how the system is used for real). To prevent unintended usage of test sessions, we fix the number of participants to 3. Where do we put the 'test' concern en the '3 participants' business rule?

## Things that help

- Hexagonal Architecture as a lens - Hex is a typology - look at concerns in code, is it port, adapter (primary/secondary), domain, ...
- Introducing a concept for something in the code; either by design or discovery; finding & giving it a good name
  - duplication
  - similar concept/thing in different places in the code
- A pair - it pays to have a good discussion about what is the nature of the thing, and where does it belong; nitpicking is worthwhile, the minutes you spent bickering about the right place will probably save you and your colleagues many hours of wandering through the code to find the line to change
----
notes:
a summary of what helps should go in the  intro, so the reader knows what to look for
documentation helps too (e.g readme driven development, or high level description of what goes where on a wiki. the links in the documentation may suggest alternative arrangements).
i made a csv export entirely in a frontend. thinking abounwhat goes where helps there too (some of the endpointness/ routing is forced by the browsers mechanism.  my mental model was a pipe and maps. Domain model |headigpngs, rows and columns | csv .  that was useful to keep the parts to work on small, and came in handy when , thanks to obscure BOM handling in excel for mac, we needed two types of csv. also handy when we needed a more limited view of the domain model for an additional persona. 
i think the menu is not needed. the different tratments of csv make for a more coherent post,
