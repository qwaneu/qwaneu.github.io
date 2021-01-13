---
layout: post
title: The Case Against Dependency Injection Frameworks
tags:
  - architecture
  - design
  - ports and adapters
author: Marc Evers, Rob Westgeest, Willem van den Ende
image: 
---



## We love Dependency Injection

First to be clear, often when developers talk about 'dependency injection' they mean automated dependency injection using a framework. These are two separate things however. We love dependency injection.

TDD 

TDD leads to loosely coupled code: @@arguments

## What we see in practice

We have seen numerous Java project using miscellaneous Spring libraries. Spring comes with dependency injection support and things like Spring Boot and Spring MVC are built on this. 

What we see is teams using the DI framework recklessly, whenever we need some service or repository, we just call it by its name, and automagically, it appears! And in several places in code and XML (well XML configuration is code too, just less human readable) 'beans' are declared. 

## Spaghettissimo

As a result, it has become very obscure how dependencies work in such an application. It takes work to find out which dependency gets injected where. This gets especially messy in unit and integration tests. The teams have to do all kinds of stuff (incantations) to make the test work. Or just let some mocks be injected.

It is not necessarily the DI frameworks that are to blame here. Those frameworks have been designed with the intent to relieve some of the not-so-difficult-but-quite-boring boilerplate code of wiring stuff together, once you have your dependencies right.

In practice, their affordance is way broader, and allow developers to get code to work even if dependencies are all over the place. Unfortunately, DI frameworks do not force or guide you towards better dependencies. Furthermore, developers think of DI frameworks as 'best practice', everyone is doing it, so we should also use it, without understanding the finesses of DI and the intent and trade-offs of DI frameworks.

So Spaghetti code with reckless application of DI frameworks makes things even worse 

## Hexagonal Architecture lights the way

So what do we do with regard to the dependencies in our code?

We usually apply the Hexagonal Architecture pattern to our applications / components / services. Our domain logic sites in the centre. It needs specific implementations of the ports, e.g. of a repository.

We end up with a `main`, a small piece of code that:
- instantiates all adapters for the component
- injects the secondary adapters into the domain logic
- injects the domain logic into the primary adapters
- injects the primary adapters into the application code and fires up the application (e.g. starting a http server)

This can be a few hundred lines of code for a reasonably sized component, but it is all 'boring' code: no decision logic, just instantiating and wiring. Because it is simple and boring, we just write it by hand and we do not use a DI framework.

As a result, we have 1 place in the code where all the knowledge resides of what specific adapters are used, and how everything is wired together.

It is explicit, not complex, the compiler will help us getting the dependencies right.

We have used this approach in Scala with Akka HTTP as web server, which nicely behaves as a library and lends itself for this approach. We have also used this approach in a Vue.js based frontend, where we do the wiring explicitly in a `main.js`.

## DI Framework sometimes helps

Sometimes, we are not in control of instantiating and injecting our dependencies, because of the choice of frameworks we made. An example from way back is Java Servlets, where the servlet container would instantiate the servlet for you. A DI framework solves the problem of getting your dependencies in in a clean, controlled way.

## Conclusion

We have found that often, you don't need a DI framework. Instantiating dependencies by hand is just as easy and will help more in getting your dependencies correct. This approach will provide much better feedback about the way you manage your dependencies.

DI frameworks can reduce boilerplate, but in practice they won't help you with getting your dependencies right. So they are useful, whenever the framework you are using doesn't allow a clean `main`.

So think about your dependencies! If it hurts, fix it, don't hide it with a framework

Applying Test Driven Development (or focusing on unit testable code in general) guides you towards dependency injection. Listening critically to your code and using painful dependency setup in tests as a hint to improve dependencies is a crucial step towards maintainable code.

## References
