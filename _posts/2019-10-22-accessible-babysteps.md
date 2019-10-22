---
layout: post
title:  A baby step in making our site more accessible
tags:
  - accessibility
  - web development
author: Willem van den Ende
image: /attachments/blogposts/2019/w.png
---

The QWAN site currently is not accessible for blind users. If you were to use a screen reader, the page might just as well be blank. A blind colleague mentioned to us a while ago that they could not read the home page at all. I have just started improving it.

After doing some accessibility work, I know a bit more, but worse, also am more aware there is much that I don't. As usual, getting started is one of the biggest steps. I chose to run [Firefox accessibility inspector](https://developer.mozilla.org/en-US/docs/Tools/Accessibility_inspector) and fix a small thing. I previously found using assistive tools more effective than static checkers, and actual users of course, even more.

But, apart from writing blog posts, I had not done any development on the qwan site for quite a while, so I needed something small to start iterating.

The number one reason our site is not accessible, is that we took a layout off the shelf, an don't understand well how it works at all. Another reason to change a thing, any thing.

So today we have unglamorously made some decorative svgs pass a static checkers' test. I'm documenting it here, in the hope that some of this will be easier to find for you than it was for me.

## FYI: svg details
The layout for a blog post has a curved line at the bottom of the page, the home page has several lines curving up and down. These are made by an Scalable Vector Graphic. I settled on adding a `role` and an `aria-label` to the svgs.  This took more digging than I hoped (not more than expected or feared though). I settled on adding `role="img" aria-label="decorative curve down."` to the svg, and then after some more digging found that elements inside the svg also needed `role=presentation`. So if you have a circle or a path, that needs attributes too.

For svgs that actually mean something, it may be worth [adding title and desc properties](https://developer.paciellogroup.com/blog/2013/12/using-aria-enhance-svg-accessibility/).

## Building
We use `jekyll` to generate our html. I found [jekyll-serve](https://github.com/BretFisher/jekyll-serve) useful to keep dependency hell manageable. I did need to add `vendor` to be excluded in `_config.yml`:

```
exclude: [README.md, vendor]

```

Only found that out after searching for [an error message and ending in a github issue](https://github.com/jekyll/jekyll/issues/5267). I ended up committing Bret Fishers' `docker-compose.yml` and now have an auto-rebuilding local jekyll that is not to onerous to setup (until next year ;)).

The firefox accessibility inspector is forcing me to understand some of the quirkier aspects of the site design. It found a checkbox that I can't see, even with the inspector highlighting it in the page. I don't understand the purpose of it, so annotating is probably not going to be worthwile.

Next step is to install NVDA and a demo version of JAWS, and work top-down from the start of the site. Probably removing that invisible checkbox and see what happens.

We decided, for now, not to have a completely new layout for the site. I am torn. A redesign would take a lot of time, but this might as well...
