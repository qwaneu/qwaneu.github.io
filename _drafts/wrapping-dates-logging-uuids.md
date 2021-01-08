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
over-designed, but we have some pragmatic reasons to do so. In this post,
we will share the trade-offs and rationale behind wrapping the standard stuff
in abstractions of your own.

- [Forces](#forces)
- [It hurts when writing unit tests](#it-hurts-when-writing-unit-tests)
- [Standard stuff is stable...until it changes](#standard-stuff-is-stableuntil-it-changes)
- [Standard stuff does the job...but does it communicate?](#standard-stuff-does-the-jobbut-does-it-communicate)
- [Standard stuff offers all you need...and so much more](#standard-stuff-offers-all-you-needand-so-much-more)
- [Introduce a seam?](#introduce-a-seam)
- [Resolution: thinking from the domain](#resolution-thinking-from-the-domain)
- [Example: timestamps](#example-timestamps)
- [Example: IDs and ID Generator](#example-ids-and-id-generator)
- [Consequences](#consequences)
- [Considerations](#considerations)
- [References](#references)

## Forces

When we find ourselves using primitive types like integers, strings, and lists
to represent something, we run into the [Primitive Obsession code
smell](https://www.thecodebuzz.com/awesome-code-primitive-obsession-code-smell-with-example/)
and we start looking for the hidden abstractions behind these primitive types.
Our code makes assumptions about what the integer or string means, and those
assumptions are spread out over the code, making it hard to change. 

If we represent monetary amounts by integers for instance, we need to know how
it works in every location where those integers are used. Is it cents or euros?
Or dollars? This will make the code hard to change.

So we'd better encapsulate that knowledge in a type or class of its own. We can
express more meaning in the code in that way and we make the code better
maintainable. 

We tend to take a similar approach with other standard language or standard
library things as well, like dates, timestamps, logging, UUIDs. Most developers
just use these things in their code. They are standard, stable, why would you
put extra boilerplate around those?

We have run into a number of issues that make us encapsulate the standard,
stable things as well rather than use it directly everywhere in our code.

## It hurts when writing unit tests

If an object under test generates a timestamp, we cannot do an
assert/expect on the whole object, because the timestamps will differ. We can
assert all the individual attributes except the timestamp, but this makes our
test long and less readable. We can assert the approximate timestamp, but this makes the test even more obscure.

```python
class Token:
  def __init__(self, token):
    self._token = token
    self._created_time = datetime.now()

def test_initial_token_is_valid():
  token = Token('1234')
  assert token == ???   # how to test this?
```

It hurts even more when the code under test generates a UUID as a unique
identifier. We have to work around that in our test.

```python
class DiagnosticSessionCreator:
  def create_with_id(self, team):
    return DiagnosticSession(id=uuid.uuid4(), team=team)

def test_creates_valid_diagnostic_session():
  creator = DiagnosticSessionCreator()
  session = creator.create_with_id(team='Team A')
  assert token == ???   # how to test this?
```

## Standard stuff is stable...until it changes

The standard language and library constructs tend to be pretty stable, but still
their APIs sometimes changes. Alternatively, you grow dissatisfied with the
current logging library and decide this new library does the job better, faster,
etc.

Having dependencies on the standard library all over the place will turn this
into a migration nightmare. The standard stuff doesn't change that much, but if
it does it will hurt.

## Standard stuff does the job...but does it communicate?

We use functions provided by the standard libraries to express our (domain)
logic. The standard library names might be close to what we are trying to do in
our domain, but usually there is a gap. 

An example: a token is valid for 60 minutes and we need to check if it is
expired. so we compare its timestamp plus 60 minutes to the current time and get
something like this:

```python
from datetime import datetime, timedelta

class Token:
  EXPIRY_IN_MINUTES=60

  def __init__(self, token):
    self._token = token
    self._created_time = datetime.now()

  # how to test this function?
  def is_expired(self):
    return self._created_time + timedelta(minutes=Token.EXPIRY_IN_MINUTES) < datetime.now()
```

For us the code in `is_expired` is not obvious at first glance. Our unit tests
will save us, but we always make mistakes in greater than or less then, or
adding the time delta to the wrong side. This piece of code does not express our
intent of what timestamps mean in our code very clearly. 

## Standard stuff offers all you need...and so much more

Python `datetime` objects offer all kinds of methods, like `isoweekday`,
`replace`, `-` and we don't need all of those for representing timestamps. For
tokens that expire, we only need to be able to compare timestamps, add a time
delta and convert them to and from strings (for serialization).

Having an interface that is way broader that the concept it is representing
needs, creates an [affordance](https://jnd.org/affordances_and_design/) for
using the other stuff when it seems convenient, without having to think hard
about what this means for the concept. 

## Introduce a seam?

When testing code that creates a timestamp or an UUID, we would like to create a
_seam_ in the production code so that we have control over timestamp/UUID
creation. In our test, we'd like to influence the line of code where the
timestamp or UUID is created, to make it more deterministic.

> _Seam_ is a concept from Working Effectively with Legacy Code book by [Michael
> Feathers](https://twitter.com/mfeathers), the classic book on handling legacy
> code and getting your first test in. A seam is a place in the code where you
> would like to vary behaviour, without having to change that code. You want to
> be able to vary the behaviour from the test.

We can start using the refactoring techniques from the Working Effectively with
Legacy Code book, like extracting a creation method. These are good techniques
when dealing with legacy code (i.e. code without tests), but they do not
necessarily make the code better - _sometimes it gets worse before it gets
better_ is the legacy code adage. Let's take a slightly different perspective.

## Resolution: thinking from the domain

We prefer to approach it differently, especially when we are test
driving the code and working from the domain. 

We see the need for a timestamp or a unique identifier, where the `datetime`
instance or the UUID instance are mere implementation details. Our domain cares
about uniqueness of identifiers, not about UUIDs.

So we introduce a small domain concept representing the 'thing' we are dealing with, in this case a unique identifier. Introducing domain concepts means:
- Thinking about an intention-revealing, domain-oriented name for the thing.
- Thinking about the interface of the thing? What services does our domain need from this thing?

This domain focus helps us to get to the core of the 'thing', instead of being guided by the peculiarities of the libraries at hand.

## Example: timestamps

To represent time and timestamps, we can introduce a Clock class that has a
`now` function to get the current time. For testing, we create a FixedClock with
the same interface that always returns a stubbed timestamp.

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
In Java or C#, we'd create a Clock interface with SystemClock and FixedClock
implementations.

We can go a step further and wrap the `datetime` object in a Timestamp
class. 

```python
class Timestamp:
    def __init__(self, timestamp):
        self._timestamp = timestamp
    ...

class Clock:
    def now(self):
        return Timestamp(datetime.now(timezone.utc))
```

The Timestamp class expresses the responsibilities of a Timestamp in
this specific domain, and no more. We cannot accidentally and implicitly
introduce a new timestamp responsibility.

There are more reasons to wrap date/time related behaviour in an abstraction of
its own. It provides a place to handle time zone related logic (which you don't
want to spread around your code base). Even more so once you realize that UTC
and time zones [have some interesting
properties](https://codeblog.jonskeet.uk/2019/03/27/storing-utc-is-not-a-silver-bullet/).

## Example: IDs and ID Generator

We use UUIDs to get unique identifiers for our objects. Testing creation logic
that assigns a new id is hard because the UUIDs are not predictable. So we
introduced an `ID` concept and an `IDGenerator`. 

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

The `IDGenerator` gets injected in the creation code, here is an example from the Online Agile Fluency Diagnostic application:

```python
class DiagnosticSessionCreator:
  def __init__(self, id_generator=IDGenerator(), ...):
    self.id_generator=id_generator
    ...
  def create_with_id(self, ...):
    ...
    diagnostic_session=DiagnosticSession(id=self.id_generator.generate_id(), ...)
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

> We introduced the IDGenerator quite soon so that we'd be in control of id
> generation in our tests. Later on we decided to introduce the ID concept to
> represent identifiers as well as invalid identifiers (incoming data in a web
> application might be invalid and we want to be able to work with invalid data
> conveniently). We found out the hard way that we had waited too long, because
> identifiers were all over the place. It took us quite a bit of effort to
> refactor it all.

## Consequences

If we wrap standard language and library primitives in meaningful abstractions
of their own, we see the following benefits:

- Our code reflects our intent better and gets less cluttered by language or
  standard library constructs.
- Our code becomes better testable, as we have more of the behaviour under
  control.
- We explicitly document the part we use from the standard library and we
  insulate ourselves from changes in these dependencies. This lowers the cost of
  testing and replacing them when necessary.

Seen through a [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html)
lens, we see standard library stuff as external dependencies that we want to
separate from our domain. The implementations of our `Clock` and `IDGenerator`
can be seen as _adapters_. This is in line with the Hexagonal Architecture
principle of **domain in the centre, libraries & frameworks on the outside**.

It feels like extra work, not adding much value initially when the codebase is
still small and innocent. But the extra effort is actually quite limited and
pays off later on.

## Considerations

Initially, it feels like overkill to wrap stable, well-known, relatively simple
standard library constructs in abstractions of their own. So we sometimes start
out with directly using the library within our domain code. We tolerate
libraries in the centre, as libraries are not in control and are less intrusive
than frameworks. We wrap it later on when we notice logic around the use of that
library. The longer we wait however, the more painful it becomes to wrap it. 

We are not testing the actual timestamp / UUID generation any more. That's ok,
as we do not need to test the standard library behaviour. We trust that it does
its job correctly. Even if we wouldn't trust it, we would write a few specific
characterization tests around the standard library to capture its behaviour.
This can be quite useful to 'fix' the behaviour and get early feedback if a
newer version subtly breaks the API.

Creating small, domain-oriented abstractions around standard library primitives
creates a new home for responsibilities. This helps in the quest for [What To
Put Where](/2020/12/23/what-to-put-where.html).

## References

- If you'd like to learn the vocabulary of code smells like Primitive Obsession
  and appropriate refactorings, have a look at our [Code Smells & Refactoring
  cards](/shop)
- [Working Effectively with Legacy
  Code](https://www.goodreads.com/book/show/44919.Working_Effectively_with_Legacy_Code)
  (2004) by Michael Feathers is the standard work on refactoring legacy code.
  Even after 17 years, it is still relevant for the problems we run into today.
- The concept of [Connascence](https://connascence.io/), a model for reasoning
  about coupling in code, provides a foundation for wrapping standard
  library things in your own abstractions

<aside>
  <h3>Seeing your systems through a Hexagonal lens</h3>
  <p>Making informed architecture decisions across your application landscape is a tough skill. We can support you with for instance architecture reviews, carrying out experiments and facilitating collaborative architecture sessions.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
