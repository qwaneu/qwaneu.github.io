---
layout: post
title: Logical Architecture vs Deployment Architecture
tags:
  - architecture
author: Marc Evers
image: 
---

When visiting clients and talking about the architecture of their software systems, we notice that quite often, people conflate different concerns under the term 'architecture'. They tend to mix logical concerns (the main concepts/objects in the application, the dynamics of this, and how these are connected) with deployment concerns (REST APIs, components, microservices, lambdas). The movement to 'cloud' has made this even worse, especially with the addition of serverless infrastructure concepts.

An example of this is the post on "What a typical 100% Serverless Architecture looks like in AWS!" by Xavier Lefèvre. The diagram shown talks AWS lambdas, S3 buckets, API gateway, etc. It is not about the domain concepts and how they relate (they talk a bit about it in the text). Neither does it focus on how business logic is mapped onto the infrastructure concepts. The view presented is a deployment view, not a logical view of the application.

## Views on software systems 

I am not saying this view on an application is wrong. On the contrary, I find the post insightful in how they are using the serverless infrastructure concepts and how the infrastructure is connected. It is however one of multiple views on a software system. For any non trivial software system, we need to have different views, to facilitate us in managing its complexity and to be able to make different trade-offs, about business rules, about how concepts work together, about how everything is deployed/mapped to infrastructure.

At least separate the logical/conceptual view and the deployment view of your software system. Having separate views greatly helps you in making better design choices.

@@voorbeeld plaatje gemixt -> 2 views

## This is not a new idea

Philippe Kruchten's [4+1 Architecture View Model](https://www.cs.ubc.ca/~gregor/teaching/papers/4+1view-architecture.pdf) (PDF) from 1995; distinguishes Logical View, Process View, Development View, Physical View + Scenarios

@@plaatje

Visual Architecting Process by Ruth Malan & Dana Bredemeyer distinguishes Meta Architecture, Conceptual Architecture, Logical Architecture, Execution Architecture. -> great architecture course, recommended

@@ plaatje

Simon Brown's C4 model

@@zie https://pauldambra.dev/amp/2018/02/serverless-part-one/ voor voorbeeldje

## But now we have cloud!

cloud -> makes it worse, the way we use/connect all the cloud services becomes the leading view. Imaginable, because cloud is quite complicated and has a steep learning curve. But conflating different views, or leaving the conceptual view implicit altogether will make it even more complicated.

Serverless does not mean you can stop thinking how to model your domain in software and how to manage dependencies. 

## Microservices will solve this!

No. 

Microservices (or rather appropriately sized services) are a deployment concept, they are about what you deploy together and what do you need to separate. The logical view of your software system is about capturing your domain and managing dependencies and consistency boundaries. If you conflate the logical design with microservices, you mix these, making it very hard to make good decisions. 

Alberto Brandolini elaborates on this in his recent post [About Bounded Contexts and Microservices](https://blog.avanscoperta.it/2020/06/11/about-bounded-contexts-and-microservices/). He specifically talks about the DDD concept of Bounded Contexts, which is all about the logical architecture. 

## But it is all connected!

It is. But that does not reduce the value of having the separate views. We still have to map the logical view onto the deployment view, which might result in some restrictions on the logical design decisions. But with separate clear views, this becomes easier, a bit like well-factored code that is way easier to optimize for performance than cluttered, entangled code.

An interesting development is the financial model linked to serverless infrastructure - moving towards pay-per-use/mostly variable costs (contrary to classical hardware / VMs that have mostly fixed costs). The deployment view can provide interesting financial feedback on logical design decisions. Refactoring could have direct financial benefit (source: Simon Wardley, DevOps is the new legacy).

## MISC

- event driven microservices -> what about connascence?
  - pulling things apart is not necessarily decoupling!
