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

We have shared a number of posts on the Hexagonal Architecture, how it helps in
your automated test  architecture, how it looks like when applied in a Vue.js
based front-end. In this post, we will share how we applied it in the back-end
component for the Online Agile Fluency® Diagnostic application we are
developing.

![hexagons image](/attachments/blogposts/2020/t-h-chia-1-Zr2ye5588-unsplash.jpg)
{: class="post-image post-image-70" }


## Hexagonal Architecture

We apply the Hexagonal Architecture because we want our component to speak the domain language. We create adapter to manage the mapping between our domain and the outside world.

## Our domain 

We have been working on a web application for the Agile Fluency project, which
supports Agile Fluency facilitators to run diagnostic workshops with
development teams remotely. The application offers a survey to team members and
creates an aggregated visualisation of the survey results in a 'rollup chart'

So we have identified all kinds of domain concepts, like Facilitator, Diagnostic
Session (the workshop), Survey, Rollup Chart. We work domain-driven: both our
front end component and our back end component speak this language: the concepts
/ names are reflected by classes and functions in our code.

So how does the hexagonal architecture manifest itself in our back end? What
other design decisions did we make to structure our code?

Let's use the creation of a new diagnostic session as an example. In short,
illustrated by the diagram below, we have created a DiagnosticSessionRoutes
which defines HTTP REST routes using the Python Flask library.
DiagnosticSessionRoutes translates and delegates to the domain objects
(CreateDiagnosticSession & DiagnosticSession). Any updates and side effects are
delegated to the secondary adapters, in this case a new diagnostic session will
be stored in a SQLite database using the DBDiagnosticSessionRepository adapter.

![hexagonal architecture in backend - create diagnostic session](/attachments/blogposts/2020/hexagonal-backend.jpg)

## Adapters

| Adapter | primary/secondary | module | responsibility |
| diagnostic session routes | primary | /app/adapters/routes | offer a HTTP REST API; translates incoming requests to calls on domain logic |
| DBDiagnosticSessionsRepository | secondary | /app/adapters/repositories | maps DiagnosticSessions to/from a SQLite database using the Flask-SQLalchemy library; it implements the DiagnosticSessionRepository interface (which is implicit);  |
| SMTPBasedMessageEngine | secondary | from quiltz.messaging library | uses SMTP to send messages; implements the MessageEngine interface |

We have structured our domain code in behaviour-rich domain objects and command
& query objects. The command and query objects are based on the Commands and
Read Models we have found in our event storming. A Command represents a user's
intent to change something, a Read Model is the decision information a user
needs to issue a command.

## Commands and Queries

So when a HTTP REST request comes in, the data is transformed into a data object and delegate to the appropriate command or query object.

A command object represents a domain command and their names reflect our domain
model. In our code, we have a CreateDiagnosticSession, JoinSession,
AnswerQuestion. A Command is an example of the Command design pattern. It is
basically a function turned into an object which facilitates passing the
dependencies needed for any side-effects.

A command object responsibility is to:
- optionally do some validation
- look up an aggregate
- delegate to the aggregate
- store any updates or events
- perform other side effects (like sending out a message)

We keep commands free of most domain decisions. This domain logic should be as
much as possible in the rich domain objects, like DiagnosticSession or
Facilitator. A command just does a lookup, delegates, takes care of side
effects. Conditional logic (apart from a pre condition check) in a command is a
smell.

Although we use the Command term from the field of Domain Driven Design, other
terms are also used in practice. Some teams create objects that represent Use
Cases; these fulfil a similar role.

## Creating a diagnostic session

What happens when we create a new diagnostic session? The front end does a POST on `/api/diagnostic-sessions` (which is an authenticated route by the way).

The route looks like this:

```python
class DiagnosticSessionRoutes(object):
    @staticmethod
    def withDiagnosticSessionsRepository(diagnostic_session_repository, ...):
        return DiagnosticSessionRoutes(diagnostic_session_repository = diagnostic_session_repository, 
            create_diagnostic_session = CreateDiagnosticSession(diagnostic_session_repository), 
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

We have a creation method that creates the route including any commands based on
repositories that get injected from the `main`. We use the constructor in our
tests, because it enables us to inject a test double for the commands.

The POST on `/api/diagnostic-sessions` gets delegates to the instance of the
CreateDiagnosticSession command. It returns the id of the new session in the
response.

We have introduced a `register` function that allows us to be in control of the
Flask framework and write focused adapter integration tests testing the routes
in isolation. An example test:

```python
class TestDiagnosticSessionRoutes_Post(RoutesTests):
    @pytest.fixture(autouse=True)
    def setUp(self):
        self.setup_app()
        self.do_signin()
        
    def create_routes(self):
        self.create_diagnostic_session_command = Mock()
        self.create_diagnostic_session_command.return_value = Success(id=aValidID(33))
        return createDiagnosticSessionRoutes(create_diagnostic_session=self.create_diagnostic_session_command, current_user_repository=self.current_user_repository).register(self.application)

    def test_post_diagnostic_session_invokes_create_diagnostic_session_command_with_body_parameters_and_facilitator(self):
        self.client.post('/api/diagnostic-sessions', data=json_dumps(validDiagnosticSessionCreationParameters()), content_type='application/json')
        self.create_diagnostic_session_command.assert_called_with(validDiagnosticSessionCreationParameters(facilitator=aValidFacilitator()))
```

We have hidden some of the boilerplate in a `RoutesTests` base class, like
creating a Flask application, registering the routes, creating a test_client for
doing the HTTP calls, and handling authentication where needed.

We have decided to use a mock for the CreateDiagnosticSession command. This
brings the risk of having green tests even though the route and the actual
command are not working together, especially with Python's flexible duck typing.
Therefore we have also created a number of component end-to-end tests which
exercise the fully wired component (with in-memory repositories) with a number
of scenarios.

## Looking inside the command

The command code looks like this:

```python
class CreateDiagnosticSession:
    def __init__(self, diagnostic_session_repository, id_generator = IDGenerator(), clock=Clock()):
      self.id_generator = id_generator
      self.repo = diagnostic_session_repository
      self.clock = clock
      
    def __call__(self, attributes):
      result = DiagnosticSessionCreator(id_generator=self.id_generator, clock=self.clock).create_with_id(**attributes)
      if not result.is_success(): 
        return Failure(message='failed to create diagnostic session')

      self.repo.save(event=result.diagnostic_session_created)
      return Success(id = result.diagnostic_session_created.id)
```

We have implemented the CreateDiagnosticSession command as a Python Callable
(hence the `__call__` function), which allows us to call it as a function. It
delegates the actual creation (which is domain logic) to the
DiagnosticSessionCreator, a factory. After successful creation, it stores the
resulting even in a diagnostic session repository.

The command needs some dependencies to do its job. So a diagnostic session
repository gets injected via the constructor. We also inject an IDGenerator,
which generates unique ids based on UUIDs. Because UUID generation introduces
randomness and because it is a library/OS dependency, we have created our own
thin abstraction around it. This allows us to test this command with a 'fixed ID
generator' that has predictable behaviour.

The dependencies that the command needs is a motivation for applying the Command
pattern and turning it into class. An alternative would be to use higher order
functions and currying, but we like the explicitness of a class here.

The command allows focused unit tests (we work test driven):

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
        expected_event = session_creator.create_with_id(**validDiagnosticSessionCreationParameters()).diagnostic_session_created
        self.repo.save.assert_called_once_with(event=expected_event)
            
    def test_returns_success_if_all_ok(self):
        ...

    def test_returns_failure_if_something_failed(self):
        result = self.create_diagnostic_session(dict())
        assert result == Failure(message='failed to create diagnostic session')
```

We inject a fixed ID generator and a fixed clock (we control time, how cool is
that?). We use a [test data builder](@@link) for the creation parameters, to reduce clutter and irrelevant details in the test.

## Finally, the domain logic for creating

The actual logic for validating and creating a diagnostic session is in the DiagnosticSessionCreator:

```python
class DiagnosticSessionCreator:
    def __init__(self, id_generator=IDGenerator(), clock=Clock()):
        self.id_generator=id_generator
        self.clock = clock

    def create_with_id(self, team=None, date=None, participant_count=0, is_test=False, facilitator=None, language="en"):
        return validate(
            presence_of('team', team),
            max_length_of('team', team, 140),
            presence_of('date', date),
            ...
        ).map(lambda validParameters:
            Success(diagnostic_session_created = DiagnosticSessionCreated(timestamp=self.clock.now(), diagnostic_session=DiagnosticSession(
                id = self.id_generator.generate_id(), 
                team = validParameters.team, 
                date = validParameters.date,
                ...)))
        )
```

It validates the incoming data, using a small validation library we developed
and published as @@. It validation is successful, a DiagnosticSessionCreated
event is instantiated, containing a new diagnostic session.

## On to the repository

The diagnostic sessions repository interface has just a few functions. We have expressed it as an Abstract Base Class (from the Python abc module):

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

This interface definition is part of our domain. It describes the role a
diagnostic session repository plays. We have an in-memory implementation (used
in tests) and a Flask-SQLAlchemy/SQLite based implementation.

The DBDiagnosticSessionsRepository has its own adapter integration test, where
we test the DB mapping and the queries we use against an in-memory SQLite
database. For each test case, this test creates a SQLite database and runs the
schema migrations so that the database schema is the current schema. This all
runs in milliseconds.

## Putting it all together, guided by tests

Looking back on how we applied Hexagonal Architecture principles, you could say we distinguish a number of rings, where the central 'domain' consist of a ring of commands/queries (or 'use cases') and a core of rich domain objects.

![different rings in hexagonal architecture ](/attachments/blogposts/2020/hexagonal-rings.jpg)
{: class="post-image" }

Our domain objects are in the centre, with unit tests:

![hexagonal architecture in back-end - create diagnostic session - unit tests](/attachments/blogposts/2020/hexagonal-backend-unit-tests.jpg)

We have created a primary adapter for the HTTP routes and a secondary adapter for the SQLAlchemy/SQLite based diagnostic session repository. They have their own adapter integration tests, which test our code together with the libraries we use:

![hexagonal architecture in back-end - create diagnostic session - adapter integration tests](/attachments/blogposts/2020/hexagonal-backend-adapter-integration-tests.jpg)

Finally, we have a series of component end-to-end tests, which test the who;le back-end component through its HTTP REST API. This end to end tests plugs in in-memory repository adapters to improve test speed and reliability. We don't need to run the end to end test against a real database, because our adapter integration tests have covered that concern extensively.

![hexagonal architecture in back-end - create diagnostic session - end-to-end tests](/attachments/blogposts/2020/hexagonal-backend-end-to-end-tests.jpg)

The component end to end test runs fast enough to be included in the back end
automated test suite. The whole test suite runs in under 10 seconds, giving us
rapid feedback on every line we change.

## Conclusion



_Credits: Photo by <a href="https://unsplash.com/@teckhonc?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">T.H. Chia</a> on <a href="https://unsplash.com/s/photos/hexagons?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>_

## References


