---
layout: post
title:  Back to basics with React
tags:
  - purescript
  - react
author: Willem van den Ende
image: /attachments/blogposts/2019/w.png
---

# Back to basics with React

_this post is a work in progress. You and I have a limited numer of [keystrokes left](https://keysleft.com/), and I want to start writing publicly again. May be revised soonish. Feedback welcome._

For a production application I'm using [PUX](https://github.com/alexmingoia/purescript-pux), a purescript wrapper around React. In the way we use it for [WeReview](https://wereview.eu) we are experiencing performance and usability issues, beyond the slow rendering. We also have stayed behind several versions because we don't want to rewrite our html in a different way (from lists/arrays to monadic) for no gain to our end users. So if we have to rewrite anyway, we might as well try some more performant options. Feedback from our users was that they like the more expensive parts of the UI, so we better get to work to make them fast.

I've previously done an architectural spike with Halogen, which went well. Before I start applying the [Strangler Pattern](https://www.martinfowler.com/bliki/StranglerApplication.html) in anger, I wanted to try out at least one other alternative. I'm eyeing [purescript-react-basic](https://github.com/lumihq/purescript-react-basic), another opinionated wrapper around React.

No amount of opinionated wrapping can save you from performance issues. At some point it pays to understand how the wrapped thing in particular, and single page applications in general work. With more understanding one can later decide whether the opinions of a wrapper are a good match or not.

Having said that, there is nothing wrong starting out with an opinionated wrapper. It will get you started and shipping. Be prepared for learning more about the wrapped thing when necessary though.

Therefore I started working through a [Firebase and React tutorial](https://www.robinwieruch.de/complete-firebase-authentication-react-tutorial/) for beginners today. So far it's been quite enjoyable. I also was interested in e-mail authentication - so far we only support google authentication, plain e-mail is probably easier for end-to-end testing. Google is quite good at preventing bots, and that includes our selenium tests.

One might expect that after four years of on and off development, I would shun a beginners' tutorial. Quite the opposite, using PUX has shielded me from some of Reacts' details. I also find it interesting to see how someone else integrates something like Firebase in their application - using a Backend As A service is still something of a novelty.

I'm halfway through the tutorial, made some notes and got e-mail signup working. Practice is hard work. So I stopped with a feeling of some achievement and made these notes instead.
