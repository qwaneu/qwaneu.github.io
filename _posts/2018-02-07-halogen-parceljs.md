---
layout: post
title:  Hot reloading a purescript Halogen UI with minimal configuration
tags:
  - feedback
  - purescript
  - halogen
  - parceljs
author: Willem van den Ende
image: /attachments/blogposts/2018/hotreload.png
---

## TLDR:
hot reloading a [Halogen app](https://github.com/slamdata/purescript-halogen) with [Parcel](https://parceljs.org/) requires _almost_ no configuration. [Demo](https://qwaneu.github.com/purescript-halogen-template)

I'm doing an archtitecural spike with Halogen and Firebase (if you want to know why, see Background near the end, I won't bore you with the details otherwise).

I want hot-reloading, as it is sometimes useful when working on a UI, but I was dreading to use webpack again. Webpack is fine when you are using someone else's template, but a year or two in, upgrading a webpack configuration can easily take me a couple of days. Justin Woo explained how he [uses parcel to build a web audio player](https://qiita.com/kimagure/items/24e6d3a0f47814c9630b).

It turns out hot-reloading with [Parcel](https://parceljs.org/) works out of the box with the halogen template application, only it will display the UI again and again after each reload.

In case you want to follow along, check out this [fork of purescript-halogen-template](https://github.com/qwaneu/purescript-halogen-template).

It has an `.nvmrc`, because Parcel requires node 8.

```
nvm use
npm install
psc-package install
npm run build
```
We need to build the app once, and after that tell parcel to watch the `output` directory and reload on changes.

```
npm run parcel:watch

> @ parcel:watch /home/willem/dev/spikes/purescript-halogen-parcel
> parcel index-watch.html

Server running at http://localhost:1234
✨  Built in 2.09s.
```

As the prompt suggests, this will run a server on http://localhost:1234 .

Any rebuilt file ends up in `output` and parcel will reload the file for you. I let `psc-ide` rebuild the source when I edit with  spacemacs. You could run `psc-ide-server` from the command line instead, or a bit easier, put `pulp -w watch` in package.json.

The script for `npm run parcel:watch` in `package.json` is brief:
```
parcel index.html
```

Just like webpack hot-reloading (included in the template as well), it requires an `entry.js` file to figure out where the main is. On top of that, it needs an html file of some kind. I gave it a separate name to let it stand out from the one in `/dist`.

There is one gotcha though. Every time you rebuild, you'll get a copy of the UI below the previouw one. Unless you remove the old one.

It appears I had got it working by accident, and when cleaning it up for this blog post, by starting from scratch, things fell apart. Justin Woo helped me out, it appears that besides hooking in to `module.hot` to detect hot-loading, we also need two different entrypoints in `Main`. One for the first time the app loads, and one for each time it reloads

So `Main.purs` now has a `main` and a `rerunUI`, with some console logging so we can see which part is executing. Here is the final entry.js:

```
if(module.hot) {
  module.hot.accept(function () {
    console.log('hot module accepted');
    Array.from(document.querySelectorAll('body > div')).map(x => x.remove());
    console.log('deleted old entries');
    require("./output/Main").rerunUI(document.body)();
  });

  require("./output/Main").main();
  console.log('started in hot reloading mode');
} else {
  require("./output/Main").main();
  console.log('started in normal mode');
}

```

The way this works is that you do get a fresh state on each reload. After some discussion and reflection on #purescript on [Slack](functionalprogramming.slack.com), I realized that is not necessarily a bad thing. `@monoidmusication` suggested the state implementation might change, and how would you know. The other thing one can do wit ha setup like this, make a main per component, so there is not that much state to load anyway.

I've got an experimental setup where authentication happens before loading Halogen (maybe more on that later), so I stay logged in, even when Halogen reloads.

There is a way to keep the state, but I'm nog sure it's worth it, given the above. This setup allows for some very rapid prototyping (parcel rebuilds in < 200 milliseconds on my machine).

## Conclusion

Recreating the setup for this blog post was a bit more work than I hoped, given that I got lucky the first time around. I do think I understand hot reloading and Halogen's main a bit better now. I hope you do too.

## Further reading / doing

- [using parcel to build a web audio player](https://qiita.com/kimagure/items/24e6d3a0f47814c9630b)
- [upgrade to psc-package from bower](https://https://qiita.com/kimagure/items/0d9354900d7a7dbd3864)
