---
layout: post
title: Architecture Granularity
tags:
  - architecture
  - design
author: Marc Evers
image: 
---

Course grained vs fine grained architecture

Fine grained: more options to (re)combine (cf. Snowden, scaling by recombining stuff)

Course grained: where we come from; unit is whole applications, big services

Fine grained does not imply "micro services"

"Create small messes"

smaller parts are doable to understand, modify, rewrite; "complexity tax" grows exponentially with size



Use Event Storming, Bounded Contexts, Aggregates + heuristics to find boundaries

Think Pace Layering (https://aicoding.leaflet.pub/)