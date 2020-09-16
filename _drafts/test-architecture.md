---
layout: post
title: Automated test architecture
tags:
  - architecture
  - ports and adapters
  - continuous delivery
  - test driven development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/hextesting-02.jpg
---

In this post, we will share another benefit of looking through the Hexagonal Architecture lens: it helps you in making decisions about your the architecture of automated tests of your application landscape. 

- What kinds of tests cover which concerns and which risks?
- What mix of automated tests is appropriate for my context?
- What mix of tests will provide confidence that your changes are ready for delivery?
- How can I move a test around in my test architecture so that I get faster, more specific feedback?

We have introduced our view on Hexagonal Architecture in previous post: [hexagonal architecture](/2020/08/20/hexagonal-architecture) and [How to keep Front End complexity in check with Hexagonal Architecture](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html). 

## An example application landscape

Say we have an application that consists of a backend component that uses a database, and a frontend running in a web browser. The backend component exposes an API to the frontend. In the picture below, the API is represented by the perpendicular line between frontend and backend.

![typical architecture: front end, back end, database](/attachments/blogposts/2020/hextesting-01.jpg)
{: class="post-image post-image-50" }

We see both the frontend and the backend as hexagons, each with its own domain, own ports and own adapters. Domain logic is in the center, dependencies go outside-in.

## Automated tests

If we look at our application landscape in this way, we can define different types of tests and specify the scope of these tests:

- unit tests
- adapter integration tests
- contract tests
- end to end tests

### Unit tests

The term _unit tests_ is often used for any automated test written by a developer, but we'd like to stay close to its actual meaning: an automated test for a *unit*, i.e. one object or function, or a small cluster of objects.

We write **Unit Tests** for the domain logic inside the hexagons. Because the domain does not depend on outside stuff, we can test the domain in isolation and write clear tests that speak the domain language.

Unit tests for a component have a small scope and they run fast, the whole suite should run in seconds.

![Unit tests](/attachments/blogposts/2020/hextesting-02.jpg)
{: class="post-image" }

### Adapter integration tests

Having adapters decoupled from the domain allows focused automated tests for adapter concerns: such tests are known by different names, we call them **Adapter Integration Tests** or **Integration Point Tests**. This name is a pragmatic choice, we want to focus on the intent of such tests, not debate about what name is best.

Adapter Integration Tests verify whether an adapter integrates properly with the database, external API, etc. Preferably the test exercises the adapter through its domain interface.

![Adapter integration tests](/attachments/blogposts/2020/hextesting-03.jpg)
{: class="post-image" }

In the backend component of the Agile Fluency® Diagnostic application we're working on, we have a Facilitator Repository that stores its data in an SQLite database. It provides domain oriented functions like `save` and `all`, to save a facilitator and to retrieve all facilitators.

```python
class DBFacilitatorRepository:
    def all(self):
        return map(as_facilitator, FacilitatorRecord.query.all())

    def save(self, facilitator):
        record = FacilitatorRecord(...)
        db.session.add(record)
        db.session.commit()

    def as_facilitator(record):
      return Facilitator(...)
  ...
```

The adapter integration test for this class sets up an in-memory SQLite database, creates the schema and runs any migrations, and then runs its test via the domain interface - via the `save` and `all` functions.

```python
class TestDbFacilitatorRepository:
    class TestConfig(object):
        SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'

    @pytest.fixture(autouse=True)
    def setupDb(self):            
        the_app = create_app(self.TestConfig)
        with the_app.app_context():
            self.repo = DBFacilitatorRepository()
            db.create_all()
            yield

    def test_creating_a_facilitator_makes_it_available_in_the_repo(self):
        facilitator = aValidFacilitator()
        self.repo.save(facilitator=facilitator)
        assert list(self.repo.all()) == [ facilitator ]
    ...
```

> We can choose how much of the integration we cover in the test: our `TestDbFacilitatorRepository` test could also run against a real database running on our local machine and in the build environment, to make the difference with the production situation even smaller.

For sending emails, we have written an adapter integration test that checks our `SMTPBasedMessageEngine` with a fake SMTP server that we start and stop from the test. Alternatively, we could test with a real SMTP server and poll a test mailbox for messages. Although closer to the actual production situation, this approach is slower and more brittle - again a trade-off.

The automated tests we write for our UI components (e.g. using Vue.js) are also adapter integration tests. UI components are by definition tightly coupled to the UI framework, so they play the role of adapters. UI component tests test how components integrate with the UI framework. Looking in this way at UI components, guides us in moving view logic out of UI components, so that the components mostly perform their adapter role. We can then test them more in isolation, while we have specific, fast unit tests for the view logic.

Testing your front end application with different browsers is another form of adapter integration tests. The intent of these tests is to check if the UI behaves correctly in different browsers. We do not want to use end-to-end system tests for this, but just the front end component running with a stubbed backend. By [decoupling the UI components using hexagonal architecture](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html), you might even run the tests with more isolated UI components, e.g. with stubbed data.

### Contract tests

We can define tests around the contracts between the producers and consumers of an API. Recently, contract tests have been given a boost by [Pact](https://docs.pact.io). Pact offers a specific way of contract testing: [Consumer based contract testing](https://martinfowler.com/articles/consumerDrivenContracts.html).

Consumer based contract testing means that all consumers of an API publish examples of how they use that API. In an automated tests, these examples are checked against the producer implementing the API. In this way, contract testing provides quick and specific feedback, by checking if all known consumers can still work with the changes in the API.

![contract testing](/attachments/blogposts/2020/hextesting-contracts.jpg)

In practice, we often see teams using end-to-end tests to catch contract related problems. Contract tests however provide better feedback faster.

As an alternative, you can use explicitly versioned and checked schemas for contracts. Schemas make evolution of APIs a bit of a hassle (and sometimes that's a good thing, especially with more public APIs). Contract testing provides a more flexible way of securing API contracts and supports smoother evolution. For every API change, it checks if all consumers can still talk to a producer.

### End to end tests

**End to end tests** exercise a larger part of the application landscape, end to end. In practice, teams implement end to end tests as tests covering almost the whole application landscape through the UI running in a browser, but this is not the only form of end to end testing. Full system, UI based tests have a number of problems:

- a large scope and many components involved means many moving parts, and _slow, fragile tests_
- _testing through the web browser is notoriously fragile and slow_, although recent developments like [Cypress](https://www.cypress.io) make it less burdensome
- the many moving parts all behave asynchronously; _handling asynchronous behaviour is a challenge_ and many teams are struggling with _flakey tests_ as a result
- _the feedback from the tests is often not helpful_; a test fails for instance complaining about a button that does not appear. What is the actual cause? Where can we find the cause? In the front end? Is it a mistake in the API? Or a mistake in a business rule buried deep in the backend?

![end-to-end tests, whole system via UI](/attachments/blogposts/2020/hextesting-05.jpg)
{: class="post-image" }

We are not saying full system end to end tests through the UI are bad per se, but they come at a huge price. You can play with the _end-to-end-ness_ of these tests however, to arrive at a better mix of automated tests.

We can create an end-to-end test that uses the API of a component and exercises the component with its database and possibly some other (real) components. Testing though an API is much simpler and less fragile than testing through a UI.

![end-to-end tests, via API](/attachments/blogposts/2020/hextesting-06.jpg)
{: class="post-image" }

We can decide to test end-to-end with a fake database, instead of a real database. This speeds up the test and avoids state that needs to be cleaned up.

![end-to-end tests, faking the database](/attachments/blogposts/2020/hextesting-07.jpg)
{: class="post-image" }

![end-to-end tests, faking the database](/attachments/blogposts/2020/hextesting-08.jpg)
{: class="post-image" }

We can have our test check access the fake to verify if the expected interactions took place.

![end-to-end tests, via UI with faked database](/attachments/blogposts/2020/hextesting-10.jpg)
{: class="post-image" }

Or test the backend component end to end via its API, with a fake database.

![end-to-end tests, via API with faked database](/attachments/blogposts/2020/hextesting-11.jpg)
{: class="post-image" }

So there are many ways of creating end to end tests, with different trade-offs. A few years ago, Nat Pryce for example did a thought provoking presentation about [end to end functional tests that can run in milliseconds](https://www.youtube.com/watch?v=Fk4rCn4YLLU).

## Conclusion

Looking at your application landscape and your services through the Hexagonal lens provides you with useful options on how to design and structure different automated tests. It moves away from ideological debate about automated tests and puts focus on getting useful, fast feedback with reasonable investment.

**There is no single right way or best practice for your test architecture**. We do have preferences:

- we work test driven; we test-drive our domain, our adapters, our UIs
- many small, focused, fast unit tests provide continuous feedback; we try to cover concerns in unit tests, rather than end to end tests
- as we test drive our adapters, our adapter integration tests become quite thorough; this sometimes requires a bit of effort, but this pays off in high degree of trust in our adapter code; we don't need end-to-end tests any more for this
- we keep broadly scoped end to end tests to a minimum, maybe just a few scenarios that touch the different parts
- when we find an issue in an end to end test, we will analyse if the concern could be covered by a unit test (meaning it is actually a domain concern), by an adapter integration test (if it concerns adapters or mapping), or by a contract test (if it concerns two components talking to each other)

We let us guide by the feedback loops in our development process: we continuously seek early, high quality feedback.

## References

- [Growing Object Oriented Software guided by Tests](http://www.growing-object-oriented-software.com/) book by Steve Freeman & Nat Pryce
- The [original article on Hexagonal Architecture](https://alistair.cockburn.us/hexagonal-architecture/) by Alistair Cockburn
- Insightful presentation by Alistair Cockburn from 2017, on the history and the considerations that led to the Hexagonal Architecture: [part 1](https://www.youtube.com/watch?v=th4AgBcrEHA&t=4s), [part 2](https://www.youtube.com/watch?v=iALcE8BPs94), [part 3](https://www.youtube.com/watch?v=DAe0Bmcyt-4)
- [End to end functional tests that can run in milliseconds](https://www.youtube.com/watch?v=Fk4rCn4YLLU) by Nat Pryce

<aside>
  <h3>Right sizing your automated tests</h3>
  <p>Getting the right mix of automated tests and making good trade-offs can be a challenge. We can support you in this process, through advice or reviews.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>
