---
layout: post
title: Hexagonal Front End - An Example
tags:
  - architecture
  - ports and adapters
  - web development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/PortsAndAdapters-8.png
---

In a [previous post](/2020/09/09/how-to-keep-complexity-in-check-with-hexagonal-architecture.html), we elaborated on how we apply [Hexagonal Architecture](/2020/08/20/hexagonal-architecture.html) in front end applications. 

We have also written about how hexagonal architecture informs test architecture. We also apply this thinking for a front end component: as we distinguish ports, adapters and domain logic, we will have unit tests, adapter integration tests, and possibly some component end-to-end tests.



Let's look at an example, taken from the Agile Fluency Diagnostic application we are developing.

![screenshot van applicatie deel]()

![architectuur/hexagon tekening]()

```javascript
UI component (primary adapter)
```

We don't like singletons or globals for managing our dependencies, nor do we like dependency injection magic. The Vue.js construct of $xxx fields on the components is like a global. Instead we decided to inject the module via props (either the router or the encompassing component has to provide the dependency)
Because we want Vue to detect changes on the module, we need to include it in the data part.


```javascript
module
```

We started out with Vuex for state management. Vuex is highly opinionated on structuring state management. We decided to implement our own, following a comparable, slightly different structure: 
- module manages and exposes state
- it offers actions to the UI component; the actions are comparable to DDD commands and queries, we expect the function names to reflect domain language
- the module knows any repositories and handles async behaviour
- module tries to delegate view logic as much as possible to plain JS objects
- modules are wired with repository instances, somewhere in main code

We are still a bit undecided about the name 'module' (borrowed this from Vuex).

Module provides an (implicit, duckly typed) interface on which the UI component depends. It acts as a Facade, hiding the domain details.


```javascript
API adapter (secondary adapter)
```

Duck-typed interface (using TypeScript would allow us to express this interface more explicit).

These adapters do:
- API call (using axios in this case)
- mapping data to domain object, in separate functions to make code more glanceable
- handling errors, converting these to a relevant thing in the front end domain

```javascript
some domain object
```

How is this all wired together? Currently through the main.js:

```javascript
excerpt of main
```


