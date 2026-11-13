# AGENTS.md — qwan.eu

This repository is the QWAN website: a Jekyll site that GitHub Pages publishes to
`qwan.eu`. `master` is trunk. **A human pushes; the push is the deploy.** Anything
committed here is one `git push` away from customers.

Read [`docs/findings.md`](docs/findings.md) before changing anything structural.
It is the measured record of how the build works, what is broken, and why the
automation looks like this. It is evidence, not preferences.

## Zero defects

Never continue past a red or unexpected result: a failing build, a failed check, a
warning, an exception, a check you could not run, a result you do not understand.
A red result is a **finding, not an obstacle**. Fix the cause — never the check,
and never the input that makes a check pass.

If something looks pre-existing, unrelated, or out of scope: stop and say so. Do
not quietly work around it. "It was already broken" is a report, not a pass.

The gate:

1. the build exits 0 in the pinned container
2. the rendered HTML parses
3. internal links resolve
4. `git diff --name-only` stays inside the files this yak names
5. *(once `gate-a11y-ratchet` lands)* no new axe violations against the committed
   baseline

Screenshots at 390 / 768 / 1440 widths belong in `runs/<run-id>/` as evidence for
the human. They are not a pass condition, but any change with a visual effect
should produce them — "mobile design" is judged by looking at it.

**Never edit the a11y baseline to make a run green.** It exists to say "this is
still broken". Changing it is a human decision, in its own commit, with a reason.

Status, 2026-10-31: checks 1–4 do not exist yet (yaks `gate-ghpages-232`,
`gate-a11y-ratchet`). Until they do, you cannot verify a change, and the honest
move is to say so rather than to claim green.

## Blast radius

- **Never push, never deploy, never touch `origin`.** Local `master` may run
  ahead; that is expected.
- Never force-push, rewrite history, `git add -A`, or bypass a check.
- One yak = one commit, or a small series that only makes sense together.
  Revertibility is the point: `git revert <sha>` must undo exactly that yak.
- Never move or rename a published post, page or permalink. `feed.xml`, inbound
  links and search results all point at the old URL. If the yak requires it, it
  is a redirect yak (`jekyll-redirect-from` is available), not a rename.
- Commits are authored `QWAN site factory <factory@qwan.eu>`, supplied per
  invocation through `GIT_AUTHOR_*` / `GIT_COMMITTER_*`. Do not write an identity
  into `.git/config`; a human commit from this machine must keep theirs.

## The job you are most likely being asked to do

The human hands you **exactly one yak**. They do not ask you to choose.

1. `yx show <id>` — the context is written for a stranger and supersedes anything
   you remember. `yx start <id>` when you begin.
2. Read the files the context names. If it is ambiguous, or asks for a decision
   (design, content, privacy, dependencies), **ask**. One question at a time.
   Never invent an answer; a plausible guess about a client-facing page is a
   defect you will ship.
3. Make the smallest change that satisfies the yak's "done when". If the yak
   turns out bigger than it says, stop and report — do not expand scope.
4. Run the gate. Then `yx done <id>`, then report what changed and what you could
   not verify.

`yx` traps: never run two `yx` commands in parallel — it takes a git ref lock and
fails with `Locked (-14)`. Retry once, sequentially.

## Never

- Never change published prose, titles, prices, dates, author names or client
  names unless the yak is about exactly that. You are not an editor.
- Never translate content. The public pages are English; notes and drafts are
  partly Dutch. Bilingual-by-accident is not a style.
- Never touch `_drafts/` or `_ideas/` unless the yak names the file. Those are a
  person's unfinished thinking, not a backlog.
- Never add a JS framework, a build tool, a CDN dependency, or a tracking pixel.
  `js/` already carries jQuery, owl-carousel, scrollReveal and smoothscroll; none
  of them should grow.
- Never rewrite `docs/findings.md` to make a finding go away. It records
  measurements: append what changed and when, and correct an entry only by saying
  what the earlier measurement got wrong.
- Never claim accessibility work is done without checking keyboard focus order
  and reading order at 390 width, not just how it looks.

## Layout

```
_config.yml          Jekyll config; `exclude` keeps README, docs/, AGENTS.md off the site
Gemfile              github-pages pin — the build of record (see findings §2)
_layouts/            post, blog-index, other-accessible, accessibletwo,
                     service-description, training-description
_includes/           header_clean.html (nav + ribbon), footer, disqus, upcoming
_sass/               partials imported by css/main.scss
_posts/              130 published posts; _drafts/ 16 unfinished files, _ideas/ 40 notes
_training/ _consulting/ _workshops/   collections with output
attachments/ images/ static assets referenced by posts
js/ css/ fonts/      legacy assets; treat as load-bearing and fragile
docs/findings.md     measured facts, defect inventory, build order
bin/                 gate + run-yak (planned; see findings §6)
```

Three layout families coexist because an accessibility migration is mid-flight:
`post` (156 files), `other-accessible` (13), `accessibletwo` (11). A fix in one
family does not fix the others — always say which families a change covers.

## Principles we hold ourselves to

These are ours, written down on our own blog. They are the reason this file is
short and the gate is code.

- **[Stochastic to deterministic](/2025/12/11/stochastic-to-deterministic.html).**
  Trial and error produces knowledge; knowledge becomes a tool; tools make the
  next attempt predictable. If you do the same thing twice, the second time
  should be a script, not a prompt.
- **Small, reversible steps.** The quality of an individual decision matters less
  when a step is easy to check and easy to undo. One yak, one commit, one revert.
- **Tools before prompts.** A check that always does the same thing beats a model
  that usually does the right thing. Prefer determinism wherever a deterministic
  answer exists.
- **Programming as theory building.** If a tool is too rigid and you need a
  prompt again, that is feedback that the process is not what we thought it was —
  not a failure of the tool.
- **Accessibility is a requirement, not a polish task.** It is in the "done when"
  of every UI yak, or the yak is not done.

## Work is a yak

Everything gets a yak; nothing is silently dropped. `yx list` shows the tree,
`yx list --tag defect` the known defects.

```sh
yx show <id>                     # context, state, tags
yx start <id>                    # wip
yx done <id>                     # only after green + commit
yx add "verb the thing" --under <parent> --state todo --context "<context>"
```

A new yak's context answers: why, which files, decisions already made, traps, and
what "done when" means. Written for a stranger with no memory of this session.
