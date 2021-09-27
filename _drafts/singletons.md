
singletonitis

the most widely misunderstood and misapplied design pattern from the book

in practice, very problematic; hurts testability; makes tests dependent in non-obvious ways, or prevents having good unit/microtests

Singleton is creational pattern: there should only be 1 instance constructed of a class

Problem with singletons in practice:
- mixing concerns: mixing creation and behaviour
  - classes like in Java, C#, C++ tend to mix these (affordance) because constructors are defined inside the class together with the object behaviour
- the instances of the class and all its collaborators do not need to know the singleton-ness of the object; if collaborators know about the singleton-ness, they know too much - in other words too much dependency (connascence?)


Don't mix these concerns!

The singleton concern should only be relevant in the wiring (main) part of a component/application. From there, the wiring ensures the (one and only) instance gets wired.

(doing proper hexagons)

-> what to do with the current singleton-all-over-the-place?

-> 
