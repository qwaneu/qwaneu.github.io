---
layout: post
title: Logical vs Deployment Architecture
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

An example:

web shop back end component processes product orders; it creates/stores/retrieves orders from a relational database; it also offers order overview with full text search option, and the possibility to export of orders per time period (up to a year). For the overview/search and export, an Elastic Search based index is used. Seen through the hexagonal architecture lens, it looks like this:

![plaatje: hex arch ingevuld]()

Principle followed: each component responsible for its own data storage (i.e. logical database per component)

Initially it was a single component deployed.

In practice, we notice that the different functionalities have different runtime characteristics: 
- exports are run only a few times a month but have a very high CPU and memory demand, sometimes causing unavailability of the component, impeding the primary business process (processing orders).
- the search queries are sometime quite complicated, causing the component to busy, slowing down responsiveness of the component, again affecting the primary process

Let's split it into order processing, order search and order export components, in separate git repositories:

![plaatje: 3 components]()

The 3 components can have their own deployment characteristic, like the export component can be a single instance with a lot of memory, the order processing component can be configured for auto scaling during busy times, etc.

But now we have 3 components that are tightly coupled and that share a database, violating our architecture principles...or not? Did we create a mess or...? Because different concerns, like dependencies, logical coupling, runtime issues, get all mixed up, things get unnecessarily complicated.

And we split the codebase, but pulling things apart is not necessarily decoupling! As a matter of fact, the coupling is still there, but obfuscated. We have made things worse.

Let's take a different perspective on this: logically we can see it as one component, with one codebase/one git repository:

![plaatje: hex arch ingevuld - herhaling]()

This is a single logical coherent component. We have some coupling here, but it is local to this codebase so acceptable/manageable.

This single logical component can be deployed as three separate deployables.

![plaatje: deployment view, 3 components met dependencies]()

So by separating the two views, we can discuss logical concerns and deployment/runtime concerns separately. This allows us to make better trade-offs. An example: by deploying a single logical component as multiple deployment units, we probably need to ensure no compatibility issues occur during deployment (the export already being the new version, while order processing is still the old version), but the benefit of allowing different runtime characteristics outweighs the costs in this case.


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

## Conclusion

Having just one view on components mixes different concerns and makes it more difficult to make good decisions about e.g. dependencies. This can lead to suboptimal design decisions, like splitting code at the wrong spots or a less optimal runtime environment, ultimately leading to production issues.

Having a logical view and a deployment view allows you to address different design and runtime trade-offs separately. It can prevent quite a few tiresome discussions.

@@More

## References

- Alberto Brandolini, [About Bounded Contexts and Microservices](https://blog.avanscoperta.it/2020/06/11/about-bounded-contexts-and-microservices/)
- Gregor Riegler, [Levels of Modularity](http://gregorriegler.com/2020/08/08/levels-of-modularity.html)
- Vasco Figueira, [Microservices - architecture nihilism in minimalism's clothes](https://vlfig.me/posts/microservices)

<aside>
  <h3>Seeing your systems through different lenses</h3>
  <p>Making informed architecture decisions across your application landscape is a tough skill. We can support you with for instance architecture reviews, carrying out experiments and facilitating collaborative architecture sessions.</p>
  <p><div>
    <a href="/consulting">Learn more about our consultancy services</a>
  </div></p>
</aside>

## MISC

- event driven microservices -> what about connascence?
