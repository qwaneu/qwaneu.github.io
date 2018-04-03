---
layout: post
title:  Seven interesting reads up to June 17 2016.
author: Willem
image: /attachments/blogposts/2016/reading.svg
---

## Head in the cloud - feet on the ground; Setting up https with utility computing

We have added https to the [QWAN site](https://www.qwan.eu) and made it the default. We overengineered it in babysteps, so we could experiment with [Terraform and AWS](https://www.terraform.io/docs/providers/aws/index.html).

Our site is hosted at [GitHub pages](https://pages.github.com), so that we did not have to worry about version upgrade, and could just `push` changes as we would with a bit of software.

We needed to do _something_ as GitHub pages does not appear to support https for custom domains. The least complicated solutions that did not involve moving away from github appeared to use a Content Distribution Network and let that provide `https`. As goals we set:
- all of us must be able to set it up and maintain it (that means understanding it and having access to it).
- as much as possible configuration managed, so we can track changes in version control, and easily roll bck if needed.
- should not be expensive (preferably with clear costs).
- should be relatively easy to set up (otherwise we'd be better of running it on a server).
- should keep it self running with little or preferably no effort on our part.

We tried two different ones, and got [Amazon Cloudfront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html) working with the least friction. It also comes with `terraform` support, so we can manage its configuration.

expand on: babysteps (use cloudfront auto generated http address first, move DNS later), terraform (using [example](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html) first, and then finding import. import does create a lot of changes, so not that easy to read, probably only for first set-up).

The good:

- we get some monitoring of traffic volume without any effort (the cloudfront UI has this). This was on the wishlist somewhere further down.
The trade-off:

- generating an https certificate still requires a manual step, as we don't use AWS for our DNS (we probably could use amazon's route53 for our DNS servers), we have to copy-paste a key-value pair in a `CNAME` record at our domain name registrar.
- One has to be careful which options to enable on the CDN, as selecting the wrong one could cost several hundred dollars a month. We expect the bill for our setup to be low (one or two US dollar a month), but have to wait for the next bill to come in. We did make IAM accounts with restricted abilities, but some expensive options remained open nevertheless.
The overkill:
- we probably don't need a content-distribution network for our small static website, it wasn't particularly slow to begin with.

Next up: adding https to an existing static site with letsencrypt, for comparison.

Background:

We decided  to do more experiments together with utility computing. We have, worked with clients who use AWS (which seems by some margin the most popular platform amongst our clients), and one of us has gone cloud native, using only a Backend As A Service (BAAS) for a product.

We're all comfortable administering unix (mac and linux) systems (physical and virtual) and were early adopters of configuration management tools such as puppet, chef and more recently propellor. The question for us is: given we could do this ourselves, what benefits do we get from utility computing?
