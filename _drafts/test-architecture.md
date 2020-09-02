---
layout: post
title: Hexagonal perspective on automated tests
tags:
  - architecture
  - ports and adapters
  - continuous delivery
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/hextesting-04.jpg
---

We have introduced our perspective on Hexagonal Architecture in a [previous post](/2020/08/20/hexagonal-architecture). In this post, we will share another benefit of looking at your components through the Hexagonal lens: it helps you in making decisions about your automated test architecture - what kinds of tests cover which concerns...and what mix of automated tests will give you sufficient confidence that your changes are ready for delivery.

## An example application landscape, throught the hexagonal lens

Say we have an application that consists of a backend component that uses a database for persistence, a front end running in a web browser. The backend component exposes an API (represented by the line) which is used by the front end.

![typical architecture: front end, back end, database](/attachments/blogposts/2020/hextesting-01.jpg)

The domain logic (business rules, view logic) is in the center, surrounded by adapters, while dependencies go outside-in.

## Unit tests

The term 'unit tests' is often used for any automated test written by a developer, but we'd like to stay close to its actual meaning, an automated test for a *unit*, i.e. one object (or function) or a small cluster of objects.

We write **Unit Tests** for the domain logic inside the hexagons. Because the domain does not depend on outside stuff, we can test the domain in isolation and write clear tests that speak the domain language.

Unit tests for a component have a small scope and they run fast, the whole suite should run in seconds.

![Unit tests](/attachments/blogposts/2020/hextesting-02.jpg)
{: class="post-image" }

## Adapter integration tests

Having decoupled adapters allows focused automated tests for adapter concerns: such tests are known by different names, we call them **Adapter Integration Tests** or **Integration Point Tests** (that's a pragmatic choice, we want to focus on the intent of such tests, not debate about the best names).

Adapter Integration Tests verify whether the adapter integrates properly with the database, external API, etc. Preferably the test exercises the adapter through its domain interface.

![Adapter integration tests](/attachments/blogposts/2020/hextesting-03.jpg) @@TODO: highlight scope of test in picture
{: class="post-image" }

An example: 

Let's say our domain defines a `ProductRepository` interface having `addProduct` and `all` functions to add a new product and get a list of all products. We create a `PostgresqlBasedProductRepository` adapter that implements this and stores the product in a Postgresql database. The Adapter Integration Test for `PostgresqlBasedProductRepository` uses the `addProduct` and `all` functions. 

```java
show me some code
```

> We can choose how much of the integration we cover in the test: our `PostgresqlBasedProductRepository` test can run against a real test database running on your local machine and in the build environment. Or we run the test against an in-memory database, with the risk of differences between the in-memory and real databases.

In the same way, we can write adapter integration tests for our UI components, which test the components in isolation and verify whether it behaves properly (which includes integrating with your UI framework or library).

## Contract tests

We can define tests around the contracts between producers and consumers of APIs. 

Recently, contract tests have been given a boost by [Pact](https://docs.pact.io). Pact offers a specific way of contract testing: [Consumer based contract testing](https://martinfowler.com/articles/consumerDrivenContracts.html).

With Consumer based contract testing, all consumers of an API publish examples of how they use that API. In an automated tests, these examples are checked against the producer code implementing the API. In this way, contract testing provides quick feedback on changes in APIs, by checking if all known consumers can still work with the changes.

![@@TODO plaatje]()

Contract testing offers a more flexible way of securing API contracts than for instance explicitly versioned and checked schemas. Versioned API schemas tend to suffer from long change and feedback cycles.

## End to end tests

Finally, we can define End-to-End Tests. The end to end tests we usually see in practice are automated tests that exercise the whole application landscape through the UI running in a browser. So these tests have quite a large scope. And they have some troubles:

- a large scope and many components involved means many moving parts, resulting in slow, fragile tests
- testing through the UI running in a web browser is notoriously fragile and slow (although recent developments like [Cypress](https://www.cypress.io) make it less burdensome).
- the many moving parts are all behaving asynchronously; handling async behaviour (especially if it is async to the max) is a challenge and many teams are struggling with flakey tests as a result
- the feedback from the tests is often not helpful; for example: the test fails complaining that an expected button does not appear, but what is the cause? And where can we find the cause? In the front end? A mistake in the API? A mistake in some business rule buried deep in the backend?

![end-to-end tests, whole system via UI](/attachments/blogposts/2020/hextesting-05.jpg)
{: class="post-image" }

We are not saying large scoped end to end tests through the UI are bad per se, but they come at a huge price. 

There is not just one type of end to end testing however. You can vary the scope of the test, the amount of 'end-to-end-ness'. Taking this perspective allows us to arrive at a better mix of automated tests.

We can also create an end-to-end test that uses the API of a component and exercises the component with its database and possibly some other (real) components. Testing though an API is much simpler and less fragile than testing through a UI.

![end-to-end tests, via API](/attachments/blogposts/2020/hextesting-06.jpg)
{: class="post-image" }

We can also decide to test end-to-end, but instead of real databases, use a fake to speed up the test and prevent state that needs to be cleaned up.

![end-to-end tests, faking the database](/attachments/blogposts/2020/hextesting-07.jpg)
{: class="post-image" }

![end-to-end tests, faking the database](/attachments/blogposts/2020/hextesting-08.jpg)
{: class="post-image" }

We can also have our test check with the fake if the expected interactions took place:

![end-to-end tests, via UI with faked database](/attachments/blogposts/2020/hextesting-10.jpg)
{: class="post-image" }

Or test the same through the backend component's API:

![end-to-end tests, via API with faked database](/attachments/blogposts/2020/hextesting-11.jpg)
{: class="post-image" }

So there are many ways of creating end-to-end tests, with different trade-offs.

## Conclusion

Looking at your application landscape and your services through the Hexagonal lens provides you with useful options on how to design and structure different automated tests. It moves away from ideological debate about automated tests and focuses on how you can get useful, fast feedback with a reasonable amount of effort.

**There is no single right way not best practices for this**, but we have  preferences:

- we work test driven; we can test-drive our domain but also our adapters
- a lot of small, focused, fast unit tests provide us with continuous fast feedback; we try to cover most concerns in unit tests, rather than via end-to-end tests
- as we test drive our adapters, our adapter integration tests are thorough; sometimes this needs a bit of effort/investment, but this pays off in high trust (we trust our adapter to work), so we don't need end-to-end tests for building this trust
- we keep broad scoped end-to-end tests minimal, just a few scenarios that touch the different parts
- when we find an isuse in our end-to-end tests, we will analyse if the concern that was broken can be covered by a unit test (if it actually is a domain concern), by an adapter integration test (if it is an adapter concern), or by a contract test (if it concerns two components talking to each other)

We let us guide by the feedback loops in our development process: we continuously seek early feedback of high quality.

## References

- [Growing Object Oriented Software guided by Tests](http://www.growing-object-oriented-software.com/) book by Steve Freeman & Nat Pryce
- The [original article on Hexagonal Architecture](https://alistair.cockburn.us/hexagonal-architecture/) by Alistair Cockburn
- Insightful presentation by Alistair Cockburn from 2017, on the history and the considerations that led to the Hexagonal Architecture: [part 1](https://www.youtube.com/watch?v=th4AgBcrEHA&t=4s), [part 2](https://www.youtube.com/watch?v=iALcE8BPs94), [part 3](https://www.youtube.com/watch?v=DAe0Bmcyt-4)
