---
layout: post
title:  Feature toggles, no thank you, I'd rather ship piecemeal
author: Willem
image: /attachments/blogposts/2018/feature-toggle.jpeg
---

Feature toggles - no thank you, I would rather ship piecemeal.

Ron Jeffries asked me what I would use instead of feature toggles. Instead of feature toggles I would ship piecemeal, and If we don’t want to release something to all users at once, I will first explore and use existing variation points, for instance role based permissions and hidden URLs in a web application. 

Martin Fowlers was way ahead of me with [a 2010 post on feature toggles](https://martinfowler.com/bliki/FeatureToggle.html), but buried the lead.

Let us [invert the pyramid](https://en.m.wikipedia.org/wiki/Inverted_pyramid_(journalism)) and quote from the bottom of that post:
 "Release toggles are a useful technique and lots of teams use them. However they should be your last choice when you're dealing with putting features into production.

Your first choice should be to break the feature down so you can safely introduce parts of the feature into the product. The advantages of doing this are the same ones as any strategy based on small, frequent releases. You reduce the risk of things going wrong and you get valuable feedback on how users actually use the feature 
that will improve the enhancements you make later." [the remainder is also worth reading, but I don’t want to quote it in its entirety.l](https://martinfowler.com/bliki/FeatureToggle.html)

Feature toggles lead a life of their own these days, there are even products to help you manage them if there are (too?) many. When you need a product to manage your feature toggles, and before each and every toggle, ask yourself - do we really need this? Why?
