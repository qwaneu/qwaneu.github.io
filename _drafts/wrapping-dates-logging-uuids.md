---
layout: post
title: Wrapping dates, logging and UUIDs in concepts of their own
tags:
  - architecture
  - design
author: Marc Evers
image: 
---

In a previous post on Hexagonal Architecture in a back-end, we mentioned
wrapping ID generation and timestamps in concepts of their own. This might feel
a bit overdesigned, but we have some good, pragmatic reasons to do so. In this
post, we will share the trade-offs and rationale behind wrapping even 'standard'
stuff in abstractions of your own.

## Forces

When we find ourselves using primitive types like ints, strings, lists to
represent something, we quickly start looking for the hidden abstractions behind
these primitive types. Our code will make assumptions about what the int or
string means, and those assumptions tend to get spread out over the code, making it hard to change. 

If we represent monetary amounts by ints, everywhere those ints are used, we need to have knowledge of how it works - is it cents or euros? or dollars? This will make the code hard to change.

So we'd better encapsulate that knowledge in a type or class of
its own. We can express more meaning in the code in that way and we make the
code better maintainable. This is what the [Primitive Obsession code smell](https://www.thecodebuzz.com/awesome-code-primitive-obsession-code-smell-with-example/) is all about.

We tend to take a similar approach with other standard language/library things
as well, like dates, timestamps, logging, UUIDs. Most developers just use these
things in their code, they are standard, stable, why would you put extra
boilerplate around those?

We have run into a number of things that make us encapsulate the standard, stable things as well rather than use it directly everywhere in our code.

### It hurts when writing unit tests

something with generated timestamp, we cannot do an assert/expect on the whole object, because the timestamps will differ slightly. We can assert everything but the timestamp, but this makes our test long and less readable. We can assert the approximate timestamp, it should be between a before and an after.

It hurts even more when we generate unique ids, e.g. UUIDs.

### Standard language stuff is stable...until it changes

### Standard language stuff offers all you need...and much more


### Introduce a seam?

From the testing perspective, we would like to create a seam in the production
code so that we have control over timestamp/id generation. Seam is a concept from WELC. It is a place in the code where you would like to vary behaviour, in this case the line where the timestamp or UUID is generated.

We can start using the refactoring techniques from WELC, like extracting a
method that encapsulates creation. These are good techniques when dealing with
legacy code (i.e. code with tests), but they do not necessarily make the code
better - _sometimes it gets worse before it gets better_ is the legacy code
adage.

## Resolution: thinking from the domain

We prefer to approach it differently, especially when we are writing / test
driving the code. We work from the domain. We see the need for a timestamp or a
unique ID, where the datetime or Date instance and the UUID instance is a mere
(yet important) implementation detail. Our domain cares about uniqueness of
identifiers, not about the specifics of UUIDs.

So we introduce small domain concepts representing the 'thing' we are dealing with. Introducing domain concepts means:
- thinking about a good, domain-oriented name for the thing
- thinking about what we want from the thing - what is its interface? again seen from the domain.

This domain focus helps us to get to the core of the 'thing' instead of letting us be guided by the particularities of the libraries.

### Example: timestamps

To represent time and timestamps, we introduced a Clock class that has just a `now` function to get the current time:

```python
class Clock:
    def now(self):
        return datetime.now(timezone.utc) 

class FixedClock:
    def __init__(self, the_time=datetime.now(timezone.utc)):
        self._the_time = the_time

    def now(self):
        return self._the_time 
```
In this case, creating an abstraction for the clock was sufficient. In Java, C# or other statically typed languages, we'd create a Clock interface with SystemClock and FixedClock implementations

We can however go further and wrap the `datetime` object in e.g. a Timestamp class. 

In this project, the Clock was good enough for some time, but if we find ourselves
writing logic around the `datetime` objects in several places in the code, we are
probably better off with our own Timestamp abstraction. The Timestamp class
would express what the responsibilities of a Timestamp in this context are, and
no more.

We found this when we realized we had to deal with time zones. We store our
dates as UTC, but we found out that the database libraries and database we were
using (SQAlchemy & SQLite) do not save time zone information. So we started
having UTC time zone knowledge in several places, for instance re-adding the
correct time zone when a `datetime` object is read back from the database. It is
not that big of a problem yet, so now would be a good moment to start wrapping
`datetime` objects in our own abstraction. Even more so once you realize that UTC and time zones [have some interesting properties](https://codeblog.jonskeet.uk/2019/03/27/storing-utc-is-not-a-silver-bullet/).

## Consequences

- our code reflects more of our intent and gets less cluttered by language library constructs
- our code becomes better unit testable, as we have more of the behaviour under control

Seen through a Hexagonal Architecture lens, the implementations of our Clock and
IDGenerator become adapters. So we start seeing the 'standard stuff' as external
libraries that we want to separate from our domain. This is in line with the
Hexagonal Architecture principle of **Domain in the center, libraries on the
side**.

## Considerations

"We sometimes tolerate libraries in the center: libraries are not in control and are less intrusive. But we tend to even wrap lower level library concepts like logging, date/time, and UUIDs, because these still tend to get in the way[plaatje met de libs]" (
  
  WE: maybe expand a little bit: we only use a fraction, which we want to document, and we insulate ourselves from changes in these dependencies. This lowers the cost of testing and replacing them when necessary)


## References

- qwan cards
- refactoring book
- WELC
- connascence
