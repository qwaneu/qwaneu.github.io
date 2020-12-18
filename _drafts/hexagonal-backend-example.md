---
layout: post
title: Hexagons in the back end - an example
tags:
  - architecture
  - patterns
  - ports and adapters
  - test driven development
author: Marc Evers
image: /attachments/blogposts/2020/t-h-chia-1-Zr2ye5588-unsplash.jpg
---

We have shared a number of posts on the Hexagonal Architecture architecture
pattern: how it helps in your automated test  architecture, how it looks like
when applied in a Vue.js based front-end. In this post, we will share how we
applied it in the Python based back-end component for the Online Agile Fluency®
Diagnostic application we are working on.

![hexagons image](/attachments/blogposts/2020/t-h-chia-1-Zr2ye5588-unsplash.jpg)
{: class="post-image post-image-70" }

- [Hexagonal Architecture](#hexagonal-architecture)
- [Our domain](#our-domain)
- [Working domain driven: Commands and Queries](#working-domain-driven-commands-and-queries)
- [Creating a diagnostic session](#creating-a-diagnostic-session)
- [Inside the command](#inside-the-command)
- [Creation domain logic](#creation-domain-logic)
- [Repositories](#repositories)
- [Putting it all together, guided by tests](#putting-it-all-together-guided-by-tests)
- [Conclusion](#conclusion)
- [References](#references)

## Hexagonal Architecture

Apply the Hexagonal Architecture pattern enables us to focus on the language of
our domain in the components we develop. The pattern describes that domain logic
resides in the centre, mapping to/from the outside world is managed through
ports and adapters, and dependencies go outside-in. See [our previous blog post](/2020/08/20/hexagonal-architecture.html) for details.

![hexagonal architecture](/attachments/blogposts/2020/ports-and-adapters.jpg)
{: class="post-image post-image-70" }

## Our domain 

We are working on a web application for the [Agile Fluency
project](https://www.agilefluency.org/), to support licensed Agile Fluency
facilitators to run remote [diagnostic
workshops](https://www.agilefluency.org/diagnostic.php) with development teams.
Team members fill in a survey using the application, and the application creates
an aggregated visualisation of the survey results in a 'rollup chart'

We prefer to work domain driven. We started out in spring 2020 with a quick
[event storming](https://www.eventstorming.com/) session and identified domain concepts like Facilitator,
Diagnostic Session (the workshop), Survey, and Rollup Chart. We made sure that
our front end and our back end components speak this domain language, by having
the components, classes and function reflect these concepts.

So how does the Hexagonal Architecture manifest itself in our back-end component? What other design decisions did we make to structure our code?

Let's use creating a new diagnostic session as an example. 

The back-end component is Python based. It provides a HTTP REST API, stores its
data in a SQLite database, and sends emails using an SMTP server. The relevant
domain concepts are `DiagnosticSession` and the `CreateDiagnosticSession`
command. The persistence concern is represented by a
`DiagnosticSessionRepository` port, an interface within our domain.

The REST API is implemented by routes code based on the
[Flask library](https://flask.palletsprojects.com/en/1.1.x/). This is a primary
adapter driving the back-end component. We have create a
`DiagnosticSessionRoutes` class that translates and delegates to the domain
objects

The `DiagnosticSessionRepository` port is implemented by the
`DBDiagnosticSessionRepository` adapter which uses the [SQLAlchemy library](https://www.sqlalchemy.org/) and
SQLite to store and retrieve data. It takes care of any side effects that result
from decisions taken by the domain logic.

The diagram below illustrates these different concepts.

![hexagonal architecture in back-end - create diagnostic session](/attachments/blogposts/2020/hexagonal-backend.jpg)

An overview of the different adapters in our back-end:

| Adapter | primary/secondary | module | responsibility |
| DiagnosticSessionRoutes | primary | /app/adapters/routes | offer HTTP REST API; translate incoming requests to calls on domain logic |
| DBDiagnosticSessionsRepository | secondary | /app/adapters/repositories | map DiagnosticSession to/from a SQLite database; implement the DiagnosticSessionRepository interface  |
| SMTPBasedMessageEngine | secondary | from quiltz.messaging library | use SMTP to send messages; implement the MessageEngine interface, which is part of our domain |

## Working domain driven: Commands and Queries

We have structured our domain code in behaviour-rich domain objects and command
& query objects. When a HTTP REST request comes in, the routes code transforms
incoming JSON into data objects and delegates to an appropriate Command or Query
object within our domain.

The command and query objects are based on _Commands_ and _Read Models_ we have
found in our event storming session. In this way, our code speaks the same
language as our domain model and we have traceability all the way. In our code
for example, we have the CreateDiagnosticSession, JoinSession, and
AnswerQuestion commands.

> Commands and Read Models are patterns from [Domain Driven
Design](https://www.dddcommunity.org/). A Command represents a user's intent to
change something, a Read Model is the information a user needs to issue a
command - what does the user need to know to take that decision?

A Command object's responsibility is to:
- perform validation (optional)
- look up an [aggregate](https://lostechies.com/gabrielschenker/2015/05/25/ddd-the-aggregate/) - i.e. the 'thing' the command is operating on
- delegate the actual work to the aggregate
- store any updates or events
- take care of other side effects (like sending out a message)

We keep commands mostly free of domain decisions. Domain logic should be as much
as possible in the rich domain objects, like `DiagnosticSession` or
`Facilitator`. A command just does a lookup, delegates, takes care of side
effects. Most of the times conditional logic in a command is a smell.

> A Command is an example of the Command design pattern. It is basically a
function turned into an object, which facilitates injecting any dependencies
needed for handling side-effects.

Although we prefer to use the Command pattern from Domain Driven Design, other
people use other concepts in their domain code like 'use cases', which fulfil a
similar role.

## Creating a diagnostic session

Let's have a look at some code. To create a new diagnostic session, the front
end does a POST on `/api/diagnostic-sessions`. The route code looks like this:

```python
class DiagnosticSessionRoutes(object):
    @staticmethod
    def withDiagnosticSessionsRepository(diagnostic_session_repository, ...):
      return DiagnosticSessionRoutes(
        diagnostic_session_repository=diagnostic_session_repository, 
        create_diagnostic_session=CreateDiagnosticSession(diagnostic_session_repository), 
            ...)

    def __init__(self, diagnostic_session_repository,  create_diagnostic_session, ...):
        self.diagnosticSessionsRepository = diagnostic_session_repository
        self.create_diagnostic_session = create_diagnostic_session
        ...
        
    def register(self, application):
        route = RouteBuilder(application)

        @route('/api/diagnostic-sessions', methods=['POST'], login_required=True)
        def create():
            result = self.create_diagnostic_session({**request.get_json(), **dict(facilitator=self.current_user_repository.current_user())})
            if result.is_success():
                return jsonify(id=str(result.id)), 201
            else:
                return jsonify(result.body), 400
        ...
```

We have a static creation method `withDiagnosticSessionsRepository` that creates
the route and instantiates commands based on the injected repositories. In the
tests, we use the constructor, because it enables us to inject a test double for
commands.

`RouteBuilder` is a thin wrapper around Flask which helps us among other things in securing routes when necessary (the `login_required`).

The POST on `/api/diagnostic-sessions` delegates to the instance of the
`CreateDiagnosticSession` command. It extracts the fields of the JSON data into
a Python dictionary, adds the currently logged in facilitator to this dictionary
and passes this to the command as arguments. When successful, the command
returns the id of the new session, which is put in the HTTP response. If the
command is not successful, the body of its result will contain an error message,
which is returned in the HTTP response.

To represent the command results, we have introduced a small Results library.
We'd prefer to have success and failure explicitly in our code, rather than
checking `None` return values. Result is available as part of our
[quiltz-domain library on GitHub](https://github.com/qwaneu/quiltz-domain) and is worth a blog post of its own.

We have introduced a `register` function that allows us to write focused adapter integration tests to cover the integration with Flask. An example test:

```python
def createDiagnosticSessionRoutes(**kwargs):
  validRouteParams = dict(
    diagnostic_session_repository = None, 
    current_user_repository = None,
    create_diagnostic_session = None,
    ...)
  return DiagnosticSessionRoutes(**{**validRouteParams, **kwargs})

class TestDiagnosticSessionRoutes_Post(RoutesTests):
  @pytest.fixture(autouse=True)
  def setUp(self):
    self.setup_app()
    self.do_signin()
        
  def create_routes(self):
    self.create_diagnostic_session = Mock()
    self.create_diagnostic_session.return_value = Success(id=aValidID(33))
    return createDiagnosticSessionRoutes(
      create_diagnostic_session=self.create_diagnostic_session, 
      current_user_repository=self.current_user_repository
    ).register(self.application)

  def test_post_diagnostic_session_invokes_create_diagnostic_session(self):
    self.client.post('/api/diagnostic-sessions', 
      data=json_dumps(validDiagnosticSessionCreationParameters()), 
      content_type='application/json')
    self.create_diagnostic_session.assert_called_with(
      validDiagnosticSessionCreationParameters(facilitator=aValidFacilitator())
    )
```

We have hidden the Flask setup boilerplate in a `RoutesTests` base class. This
also creates a test_client for doing HTTP calls. The setUp makes sure all
request in the test are performed as an authenticated user (`self.do_signin()`). It also provides a `current_user_repository`.

The `createDiagnosticSessionRoutes` function conveniently provides dummy `None`
references for the different dependencies these routes need (in a quite Pythonic
way), so that we can focus on the ones that are relevant in the specific tests.

We have decided to mock the `CreateDiagnosticSession` command. This has a risk
of having green tests even though the route and the actual command are not
working together, especially with Python's flexible duck typing. Therefore we
have also created a suite of component end-to-end tests that test the full
component wired with in-memory repositories.

## Inside the command

The `CreateDiagnosticSession` command code looks like this. We have left out some details for convenience:

```python
class CreateDiagnosticSession:
  def __init__(self, diagnostic_session_repository, id_generator=IDGenerator(), clock=Clock()):
    self.id_generator = id_generator
    self.repo = diagnostic_session_repository
    self.clock = clock
      
  def __call__(self, attributes):
    result = DiagnosticSessionCreator(id_generator=self.id_generator, clock=self.clock)
      .create_with_id(**attributes)
    if not result.is_success(): 
      return Failure(message='failed to create diagnostic session')

    self.repo.save(event=result.diagnostic_session_created)
    return Success(id = result.diagnostic_session_created.id)
```

We have implemented the command as a Python Callable, which allows us to call it
as a function. The actual creation (domain logic) is delegated to
`DiagnosticSessionCreator`, a factory. After successful creation, it stores the
resulting event in a diagnostic session repository.

The command needs dependencies to do its job. We inject a diagnostic session
repository via the constructor. We also inject an IDGenerator to generate unique
ids based on UUIDs. Because generating UUIDs introduces randomness and because
it is an Operating System dependency, we have created our own thin abstraction
around it: the ID and IDGenerator classes, which are also part of the
[quiltz-domain library](https://github.com/qwaneu/quiltz-domain). This allows us
to test this command with a predictable 'fixed ID generator'.

Because the command needs dependencies, we find it appropriate to apply the
Command design pattern and turn it into class. An alternative is to use [higher
order functions and
currying](https://www.geeksforgeeks.org/higher-order-functions-currying/), but
we prefer the explicitness of a class.

As we work test-driven, we have focused unit tests for the command:

```python
class TestCreateDiagnosticSession:
  @pytest.fixture(autouse=True)
  def setUp(self):
    self.repo = Mock(DiagnosticSessionsRepository) 
    self.id_generator = FixedIDGeneratorGenerating(aValidID(12))
    self.clock = Clock.fixed()
    self.create_diagnostic_session = CreateDiagnosticSession(
        diagnostic_session_repository=self.repo, 
        id_generator=self.id_generator, 
        clock=self.clock)
        
  def test_saves_a_new_diagnostic_session_with_an_id_in_the_repo(self):
    session_creator = DiagnosticSessionCreator(id_generator=self.id_generator, clock=self.clock)
    self.create_diagnostic_session(validDiagnosticSessionCreationParameters())
    expected_event = session_creator.create_with_id(**validDiagnosticSessionCreationParameters())
                                    .diagnostic_session_created
    self.repo.save.assert_called_once_with(event=expected_event)
            
  def test_returns_success_if_all_ok(self):
        ...

  def test_returns_failure_if_something_failed(self):
    result = self.create_diagnostic_session(dict())
    assert result == Failure(message='failed to create diagnostic session')
```

Here we decided to mock the `DiagnosticSessionsRepository`. An alternative would
be to use an `InMemoryDiagnosticSessionsRepository`. We find ourselves moving
away from mocking repositories and prefer to use in-memory variants of the
repositories, as they are behaviourally closer to the database based variants.

We inject a fixed ID generator and a fixed clock - we control time, how cool is
that? We use [test data builders](/2020/10/09/test-data-builders.html) for both
the fixed id and for the diagnostic session creation parameters, to reduce
clutter and irrelevant details in the test.

## Creation domain logic

The `DiagnosticSessionCreator` is responsible for validating and creating a
valid diagnostic session:

```python
class DiagnosticSessionCreator:
  def __init__(self, id_generator=IDGenerator(), clock=Clock()):
    self.id_generator=id_generator
    self.clock = clock

  def create_with_id(self, team=None, date=None, 
                     participant_count=0, is_test=False, facilitator=None, language="en"):
    return validate(
        presence_of('team', team),
        max_length_of('team', team, 140),
        presence_of('date', date),
        ...
    ).map(lambda validParameters:
        Success(diagnostic_session_created = DiagnosticSessionCreated(
          timestamp=self.clock.now(), 
          diagnostic_session=DiagnosticSession(
            id = self.id_generator.generate_id(), 
            team = validParameters.team, 
            date = validParameters.date,
            ...
        )))
    )
```

The create_with_id function provides default values for incoming data, so that
it can handle missing data. It validates the data using a small validation
library that is part of the [quiltz-domain
library](https://github.com/qwaneu/quiltz-domain). Only if validation is
successful, a `DiagnosticSessionCreated` event is instantiated, containing a new
diagnostic session. If the data is not valid, a Failure object is returned by
the validation functions.

## Repositories

The diagnostic sessions repository interface has just a few functions. We have
expressed it using a Python [abstract base
class](https://docs.python.org/3/library/abc.html) (ABC). It can save a
diagnostic session event and it can provide a specific session by id or a list
of all sessions:

```python
class DiagnosticSessionsRepository(ABC):
    @abstractmethod
    def all(self, facilitator):
        pass
        
    @abstractmethod
    def by_id(self, diagnostic_session_id, facilitator):
        pass

    @abstractmethod
    def save(self, event):
        pass
```

This interface is part of our domain. It describes the role a diagnostic session
repository plays. We have an in-memory implementation which is used in tests,
and a SQLAlchemy/SQLite based implementation `DBDiagnosticSessionsRepository`.

The `DBDiagnosticSessionsRepository` has its own adapter integration test, where
we test the DB mapping and the queries against an in-memory SQLite database. For
each test case, an SQLite database is created and schema migrations are run so
that the database schema corresponds to the current schema. This all runs in
milliseconds.

## Putting it all together, guided by tests

Looking back on how we have applied Hexagonal Architecture principles, we
distinguish a number of rings, where the 'domain' consist of a ring of commands
and queries and a core of rich domain objects.

![different rings in hexagonal architecture ](/attachments/blogposts/2020/hexagonal-rings.jpg)
{: class="post-image" }

The Hexagonal Architecture pattern also provides us [a lens to look at our
automated tests](/2020/09/17/test-architecture.html). Our domain objects and
commands have unit tests with limited scope (indicated by the green lines):

![hexagonal architecture in back-end - create diagnostic session - unit tests](/attachments/blogposts/2020/hexagonal-backend-unit-tests.jpg)

We have created a primary adapter for the HTTP routes and a secondary adapter
for the SQLAlchemy/SQLite based diagnostic session repository. They have their
own adapter integration tests that test how our code integrates with the
different libraries:

![hexagonal architecture in back-end - create diagnostic session - adapter integration tests](/attachments/blogposts/2020/hexagonal-backend-adapter-integration-tests.jpg)

We also have a suite of component end-to-end tests, which test the whole
back-end component through its REST API. This end-to-end test plugs in
in-memory repository adapters to improve speed and reliability. We don't
need to run the end-to-end test against a real database, because our adapter
integration tests cover that concern extensively.

![hexagonal architecture in back-end - create diagnostic session - end-to-end tests](/attachments/blogposts/2020/hexagonal-backend-end-to-end-tests.jpg)

The component end-to-end test run fast enough to include in the back-end
automated test suite. The whole suite of over 560 tests runs in under 10
seconds, giving us rapid feedback on every line we change.

## Conclusion

In this post, we have shown how we have applied the Hexagonal Architecture pattern and how it helps us to let different concerns find their place in the code. It also helped us in creating a fast and focused test suite that gives us rapid feedback when developing.

Hexagonal Architecture fits well with Domain Driven Design. It facilitates using domain language in the core of your components.

## References

- The Domain Driven Design community offers lots of design goodness; [dddcommunity.org](https://www.dddcommunity.org/) is a good starting point for further exploration
- Event Storming is a powerful collaborative domain modelling technique invented
  by Alberto Brandolini; we is [writing a
  book](https://www.eventstorming.com/book/) on this (recommended!)
- We work test-driven, because the discipline of Test Driven Development greatly
  helps us to deliver working software continuously; the [Growing Object
  Oriented Software, Guided by Tests](https://www.goodreads.com/book/show/4268826-growing-object-oriented-software-guided-by-tests) book by Nat Pryce & Steve Freeman is a
  recommended starting point. Or [contact
  us](/contact) if you're interested in a workshop.

This post is part of a series on Hexagonal Architecture:

- [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html)
- [TDD & Hexagonal Architecture in front end - a journey](/2020/08/26/hexagonal-vue.journey.html)
- [How to decide on an architecture for automated tests](/2020/09/17/test-architecture.html)
- [How to keep Front End complexity in check with Hexagonal Architecture](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html)
- [A Hexagonal Vue.js front-end, by example](/2020/09/25/hexagonal-frontend-example.html)
- Hexagons in the back end - an example

_Credits: Photo by <a href="https://unsplash.com/@teckhonc?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">T.H. Chia</a> on <a href="https://unsplash.com/s/photos/hexagons?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>_

<aside>
  <h3>working domain driven</h3>
  <p>@@.</p>
  <p><div>
    <a href="/training">Learn more about our workshops and courses</a>
  </div></p>
</aside>
