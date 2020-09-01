---
layout: post
title: Hexagonal Architecture in the Front End
tags:
  - architecture
  - ports and adapters
  - web development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/PortsAndAdapters-1.png
---

Developing Front end components: UI often tend to start out simple, 'just' a form or a grid representing the data that comes from the backend (in other words, it's 'just' putting a visual layer over backend APIs), but when the front end evolves, they become more complex than that, because of all kinds of concerns (many UX - user experience related):

- we want to guide users through specific flows, e.g. depending on user level (novice vs expert) or variations in the data (simple product vs extensive details)
- we want to provide quick validation feedback on input, to prevent errors
- we want to provide all kinds of feedback so that our users know what's happening and know what is expected of them, e.g. provide spinners while waiting, green check marks when some input is correct
- we want to prevent distracting or confusing the users, so we hide buttons for actions that are not possible yet, or hide functionalities that the user cannot use from their current role
- we want to connect to APIs or even collecting data from 2 or 3 API and present it in a coherent way; the available APIs might not 100% match the view you want to present
- we want to move a whole concern over to the front end, like a shopping basket that fully lives in the front end so that we prevent extra complexity in the backend for managing temporary state for many users

## Hexagonal Architecture to manage complexity

Having applied [Hexagonal Architecture](/2020/08/20/hexagonal-architecture) to back end components, well-structured monoliths and desktop client applications, we have found that thinking hexagonally helps to keep complexity manageable. Taking a hexagonal perspective on our componpent, we see distinguish and decouple different concerns: ports (sets of interactions with the outside world), adapters, domain logic. It allows us to focus on domain logic and business rules and it facilitates independent evolution of different services/components. It also allows for better automated testing of all these concerns (@@upcoming blog entry).

Another aspect of the Hexagonal Architecture pattern is that it is fractal: we apply it at component or service level, but we can also zoom out and see our application landscape as a network of connected hexagons. This includes front end components, but we can also see a relational database (having constraints, views, possibly stored procedures) as a hexagon on its own.

![application as a network of hexagons](/attachments/blogposts/2020/hextesting-01.jpg)
{: class="post-image" }

## Hexagons applied to front end

@@[picture: front end ball of mud with the different concerns]

Looking at a front end component through a hexagonal lens, we see distinguish and decouple different concerns: 

| Port | set of interactions with outside world |
| Adapter | translates from and to outside world | 
| Domain | model of the domain, independent of frameworks, libraries | 

The concepts in the Domain have meaning for users, they are in our stakeholders' language. 

![ports and adapters](/attachments/blogposts/2020/ports-and-adapters.jpg)
{: class="post-image" }

So what could be the domain logic, the ports, the adapters in a front end component?

Ports: 
- the UI forms the primary port through which our users drive the component
- resources and operations on them offered by (backend) services are our secondary ports
- any intents for which we need browser functionality are also ports (e.g. local storage can be one, or alerts)

So what is 'domain logic' in this case? As a guideline, because front end components run in user's browsers (untrusted environment), backend components are responsible for ensuring adherence to business rules, so the domain logic should be encapsulated there. In the front end we do have logic related to our domain, but its intent is to facilitate, guide, enable the user: **view logic** or **view models**.


Our front end is about domain concepts (facilitators, diagnosticSessions), we get these from backend APIs but we still translate these to our own classes in the front end code to decouple the front end from back end API evolution (we want to facilitate independent evolution of our different components and their APIs) but also to safeguard from interesting vulnerabilities that could occur when we just base our code on the objects coming in from the backend; backend API classes/functions are our secondary ports

## Hexagonal perspective on a Vue.js application

Let's look at a sample [Vue.js](https://vuejs.org/)/[Vuex](https://vuex.vuejs.org/) application, a web shop in this case. We have a few UI components (Vue.js based views/components), like a ProductList. We have a 'store' that can retrieve the available from some backend API and which holds the current list of products.

![vue.js application main concepts: UI components, store, API access](/attachments/blogposts/2020/PortsAndAdapters-3.png)
{: class="post-image" }

We see the Vue.js based UI components as adapters. Although we've drawn the UI adapter pretty small, this will be a substantial part of the code. This adapter code will have its own automated tests.

The state objects are part of our view domain; they reside on the edge of our view domain and offer an interface to the UI components (they act as a [Facade](https://en.wikipedia.org/wiki/Facade_pattern)). 

We created adapters for the interaction with backend APIs. They act as [Repositories](https://www.martinfowler.com/eaaCatalog/repository.html) in our domain (e.g. `ProductRepository` that offers an `allAvailable()` function to get all available products). We test-drive these adapters independently. 

![UI components, store, API adapter put in a hexagon](/attachments/blogposts/2020/PortsAndAdapters-8.png)
{: class="post-image" }

How do we structure our view domain? Instead of putting all logic in the store objects, we introduce domain objects (plain Javascript/Typescript classes) that represent the concepts and their responsibilities. The store objects delegate as much as possible to these objects. We see that these domain objects don't tend to be very responsibility-heavy; we end up with a bunch of simple objects that are very easy to understand and to write tests for.

The backend API adapters also take care of mapping from/to our domain objects. We make this explicit mapping because of a mix of reasons:
- allow independent evolution of different components
- represent the domain objects (resources) explicitly in our front end code, to make it easier for ourselves as developers
- shield against any interesting malicious JS stuff coming in
- (for future exploration) allow contract based testing

## Consequences

Separating these concerns allows us to decouple the view logic from the UI structure, styling, details. It allows us to let our front end evolve more independently from the backend

Using the Hexagonal lens helps us with WTPW (What To Put Where), we have places in our code for UI stuff, for view logic, for APIs based stuff. 

This also triggers a number of follow up questions:
- what to do with the logic in our UI components, like disabling a button as long as the input is not yet valid?
- how to structure the view domain in detail? 
- structuring the hexagon: how can we make the domain part more modular?

Keep an eye on this blog, we will dive deeper into these questions and our ideas/experiences.

## Notes

Difference between front ends / back ends: domain/business heavy, front ends tends to be more adapter heavy (more code that is about integrating)

## References

- [Growing Object Oriented Software guided by Tests](http://www.growing-object-oriented-software.com/) book by Steve Freeman & Nat Pryce.
- The [original article on Hexagonal Architecture](https://alistair.cockburn.us/hexagonal-architecture/) by Alistair Cockburn
