---
layout: post
title: Wrapping dates, logging and UUIDs in concepts of their own
tags:
  - architecture
  - design
author: Marc Evers
image: 
---

In our previous post on [Hexagonal Architecture in a
back-end](/2021/01/04/hexagonal-backend-example.html), we mentioned wrapping ID
generation and timestamps in concepts of their own. This might feel a bit
over-designed, but we have some good, pragmatic reasons to do so. In this post,
we will share the trade-offs and rationale behind wrapping even 'standard' stuff
in abstractions of your own.

- [Forces](#forces)
- [It hurts when writing unit tests](#it-hurts-when-writing-unit-tests)
- [Standard stuff is stable...until it changes](#standard-stuff-is-stableuntil-it-changes)
- [Standard stuff does the job...does it communicate?](#standard-stuff-does-the-jobdoes-it-communicate)
- [Standard stuff offers all you need...and so much more](#standard-stuff-offers-all-you-needand-so-much-more)
- [Introduce a seam?](#introduce-a-seam)
- [Resolution: thinking from the domain](#resolution-thinking-from-the-domain)
- [Example: timestamps](#example-timestamps)
- [Example: ID and ID Generator](#example-id-and-id-generator)
- [Consequences](#consequences)
- [Considerations](#considerations)
- [References](#references)

## Forces

When we find ourselves using primitive types like integers, strings, lists to
represent something, we quickly start looking for the hidden abstractions behind
these primitive types. Our code will make assumptions about what the integer or
string means, and those assumptions tend to get spread out over the code, making
it hard to change. 

If we represent monetary amounts by integers, everywhere those integers are
used, we need to have knowledge of how it works - is it cents or euros? or
dollars? This will make the code hard to change.

So we'd better encapsulate that knowledge in a type or class of its own. We can
express more meaning in the code in that way and we make the code better
maintainable. This is what the [Primitive Obsession code
smell](https://www.thecodebuzz.com/awesome-code-primitive-obsession-code-smell-with-example/)
is all about.

We tend to take a similar approach with other standard language/library things
as well, like dates, timestamps, logging, UUIDs. Most developers just use these
things in their code, they are standard, stable, why would you put extra
boilerplate around those?

We have run into a number of things that make us encapsulate the standard,
stable things as well rather than use it directly everywhere in our code.

## It hurts when writing unit tests

If the code under test generates for instance a timestamp, we cannot do an
assert/expect on the whole object, because the timestamps will differ. We can
assert all the individual attributes except the timestamp, but this makes our
test long and less readable. We can assert the approximate timestamp, if it is
between some before and after values, but this makes the test even more obscure.

In the Online Diagnostic application, we use Python `datetime` objects to
represent timestamps.

```
TODO: small python example with timestamp
```

With timestamps we can at least assert something about them. It hurts even more
when the code under test generates a UUID as a unique identifier.We have to work
around that in our test.

```
TODO: small python example with UUID
```

## Standard stuff is stable...until it changes

The standard language and library constructs tend to be pretty stable, but still
their APIs will sometimes changes. Or, you get dissatisfied with the current
logging library and decide this new library does the job better, faster, etc.
Having dependencies on the standard library all over the place will turn this
into a migration nightmare.

The standard stuff doesn't change that much, but if it does it will hurt.

## Standard stuff does the job...does it communicate?

We use the functions provided by the standard libraries to express our (domain) logic. The names and the intention might be close to what we are trying to do in our domain, but usually there is a gap. 

A token is valid for 60 minutes and we need to check if it is expired. so we compare its timestamp plus 60 minutes to the current time. We get something like this:

```
TODO: python example with comparing timestamps with timedeltas
```

For us this code is not obvious at first glance. Our unit tests will save us
here, but we always make mistakes in the < vs >, or adding the time delta to the
wrong side. This piece of code does not express our intent very clearly. The
meaning will remain implicit in the code, probably duplicated in several places.

## Standard stuff offers all you need...and so much more

Python `datetime` objects have all kinds of different methods, like
`isoweekday`, `replace`, - (subtraction) which we don't need for representing
timestamps. Comparing timestamps, adding a time delta and converting them to and
from strings (for serialization) is all we need.

Having an interface that is way broader that the concept it is representing
needs, creates an [affordance](https://jnd.org/affordances_and_design/) for
using the other stuff when it seems convenient, without having to think hard
about what this means for this concept. 

## Introduce a seam?

From a testing perspective, we would like to create a _seam_ in the production
code so that we have control over generation of a timestamp or UUID. For our
test, we'd like to influence the line of code where the timestamp or UUID is
generated, to make it more deterministic for the test.

> _Seams_ is a concept from Working Effectively with Legacy Code (WELC) book by Michael
> Feathers, the classic book on handling legacy code and getting your first test
> in. A seam is a place in the code where you would like to vary behaviour,
> without having to change that code. You want to be able to vary the behaviour
> from the test

We can start using the refactoring techniques from the WELC book, like
extracting a method that encapsulates creation. These are good techniques when
dealing with legacy code (i.e. code with tests), but they do not necessarily
make the code better - _sometimes it gets worse before it gets better_ is the
legacy code adage. Let's take a slightly different perspective.

## Resolution: thinking from the domain

We prefer to approach it differently, especially when we are test
driving the code and working from the domain. 

We see the need for a timestamp or a unique identifier, where the `datetime`
instance or the UUID instance are mere (yet important) implementation details.
Our domain cares about uniqueness of identifiers, not about UUIDs.

So we introduce a small domain concept representing the 'thing' we are dealing with, in this case a unique identifier. Introducing domain concepts means:
- thinking about a good, domain-oriented name for the thing
- thinking about what we want from the thing - what is its interface? what does our domain need from this thing?

This domain focus helps us to get to the core of the 'thing' instead of letting us be guided by the particularities of the libraries at hand.

## Example: timestamps

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

```python
class Timestamp:
    def __init__(self, timestamp):
        self._timestamp = timestamp
    ...

class Clock:
    def now(self):
        return Timestamp(datetime.now(timezone.utc))
```

The Timestamp class expresses what the responsibilities of a Timestamp are in
this specific domain, and no more. We cannot accidentally and implicitly
introduce a new timestamp related responsibility.

We found this when we realized we had to deal with time zones. We store our
dates as UTC, but we found out that the database libraries and database we were
using (SQAlchemy & SQLite) do not save time zone information. So we started
having UTC time zone knowledge in several places, for instance re-adding the
correct time zone when a `datetime` object is read back from the database. 

This might be the moment to start wrapping `datetime` objects in its own
Timestamp abstraction. Even more so once you realize that UTC and time zones
[have some interesting
properties](https://codeblog.jonskeet.uk/2019/03/27/storing-utc-is-not-a-silver-bullet/).

## Example: ID and ID Generator

We use UUIDs to get unique identifiers for our objects. Testing creation logic that assigns a new id is hard because the UUIDs are not predictable. So we introduced an `ID` concept and an `IDGenerator`. 

```python
@dataclass(frozen=True)
class ID:
    _uuid: UUID

    @staticmethod
    def from_string(potential_uuid_value):
        ...
        try:
            return ID(UUID(potential_uuid_value))
        except ValueError as e:
            return InvalidID()

    @staticmethod
    def invalid():
        return InvalidID()
    ...
    def __str__(self):
        return str(self._uuid)

class IDGenerator(object):
    def generate_id(self):
        return ID(uuid.uuid4())
```

The IDGenerator gets injected in creation logic, an example from the Online Agile Fluency Diagnostic:

```python
class DiagnosticSessionCreator:
    def __init__(self, id_generator=IDGenerator(), ...):
        self.id_generator=id_generator
        ...

    def create_with_id(self, ...):
        ...
        diagnostic_session=DiagnosticSession(id=self.id_generator.generate_id(), ...)
        ...
```

This allows us to introduce a `FixedIDGeneratorGenerating` subclass of
`IDGenerator`  which always returns the same stubbed ID:

```python
class TestCreateWithId:
    @pytest.fixture(autouse=True)
    def setup(self):
        self.id_generator = FixedIDGeneratorGenerating(aValidID('12'))
        self.creator = DiagnosticSessionCreator(id_generator=self.id_generator, ...)
    def test_creates_a_diagnostic_session_with_a_generated_id(self):
        diagnostic_session = self.creator.create_with_id(...)
        assert diagnostic_session.id == aValidID('12')
```

The `aValidID` is a [test data builder](/2020/10/09/test-data-builders.html) we introduced for IDs. We have published
the ID, IDGenerator and corresponding test data builder as part of the
[quiltz-domain library on GitHub](https://github.com/qwaneu/quiltz-domain).

> We actually started pretty quickly with the IDGenerator so that we'd be in
> control of id generation in our tests. Later on we decided to introduce the ID
> concept to represent identifiers but also to represent invalid identifiers
> (incoming data in a web application might be wrong, but we want to be able to
> work with wrong data conveniently). We found out the hard way that we waited
> too long, because the ids were all over the place and it took us quite a bit
> of effort to refactor it all.

## Consequences

Once we start wrapping standard language and library primitives in our own, meaningful abstractions, we see the following benefits:

- Our code reflects more of our intent and gets less cluttered by language library constructs.
- Our code becomes better unit testable, as we have more of the behaviour under control.
- We explicitly document the fraction we use from the standard library and we insulate ourselves from changes in these dependencies. This lowers the cost of testing and replacing them when necessary.

Seen through a [Hexagonal Architecture](@@) lens, we see the standard library
stuff as external dependencies we want to separate from our domain. The
implementations of our `Clock` and `IDGenerator` become adapters. This is in
line with the Hexagonal Architecture principle of **Domain in the centre,
libraries on the outside**.

It feels as extra work that does not seem to add much value, especially at the
start, when the codebase is still small and innocent. But it is just a little
extra effort that pays off later on.

## Considerations

It initially feels a bit overkill to wrap stable, well-known, relatively simple
standard library constructs in an abstraction of its own. So we sometimes start
out with directly using the library within our domain code. We tolerate
libraries in the centre, as libraries are not in control and are less intrusive.
We wrap it later on when we notice some logic around the use of that library.
The longer we wait however, the more painful it becomes to wrap it, because it
tends to be widely used. 

We are not testing the actual timestamp / UUID part any more. That's ok, as we
do not need to test the standard library behaviour. We trust that it does its
job correctly. Even if we wouldn't trust it, we would write a few specific tests
around the standard library to capture its behaviour. This can be quite useful
to 'fix' the behaviour and get early feedback if a newer version subtly breaks
the standard library API.

Creating small, domain-oriented abstractions around standard library primitives
creates a new home for responsibilities. This helps in the quest for [What To
Put Where](/2020/12/23/what-to-put-where.html).

## References

- If you'd like to learn the vocabulary of code smells like Primitive Obsession
  and appropriate refactorings, have a look at our [Code Smells & Refactoring
  cards](/shop)
- Working Effectively with Legacy Code (2004) by Michael Feathers is the
  standard work on refactoring legacy code. Even though it is already over 16
  years old, it is still relevant for the problems we run into today.
- The concept of [Connascence](https://connascence.io/), a model for reasoning
  about coupling in code, also provides a foundation for wrapping standard
  library things in your own abstractions
