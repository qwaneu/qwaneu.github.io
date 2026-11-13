# Findings — site automation (2026-10-31)

Evidence gathered while deciding whether this repo gets a "factory" (an agent
loop) like `~/research/mastra-factory` and `~/research/wereview-deps`, or
something smaller. Nothing here is implemented yet. Every claim below was
measured in this working tree on 2026-10-31; the commands to re-check are at
the end.

Status: **investigation**. `AGENTS.md` does not exist yet.

---

## 1. Decisions taken

| # | Decision | Rationale |
|---|----------|-----------|
| Q1 | Any automation commits **locally to `master`**; a **human pushes**. Never push, never deploy from the harness. | Trunk-based development; the push is the deploy. The local trunk may run ahead of `origin/master` (same model as wereview-deps). |
| Q2 | **A now:** build of record is the `github-pages` gem, bumped `225` → `232`, built in a container. **B queued** as its own yak: GitHub Actions + Jekyll 4.4.1. | A gives production parity today at near-zero risk. B is a migration and must not be entangled with the first layout commits, or regressions become unattributable. |
| Q2a | Container-only build, pinned by digest. No host `Gemfile` path. | The host has Ruby 3.2.3 and no `bundle`; a host gem set that drifts from the image is how "green locally, red on Pages" happens. |
| Q3 | **1 now:** ratchet — a committed baseline, gate fails on new a11y violations. **2 later:** a yak drives the gate set to zero, shrinking the baseline to `{}`. | The site is already non-compliant (§4); an absolute-zero gate would block the harness behind a remediation pass. The baseline doubles as an honest defect inventory. |
| Q4 | The queue is **`yx`**, initialised in this repo on 2026-10-31 and seeded from §4 plus `README.md`. `.yaks` is gitignored, so the tracker is local state and not published. | One backlog, machine-readable, the same tool as the other two factories. The `README.md` TODO stays as prose but is no longer the source of work. |

| Q5 | Gate = build exits 0 from the pinned container, rendered HTML parses, internal links resolve, diff stays inside the files the yak names. Screenshots at 390/768/1440 are evidence for the human, not pass/fail. The a11y ratchet joins as a fifth check when `gate-a11y-ratchet` lands. | Catches the recorded defects without blocking on a remediation pass. |

| Q6 | The human **hands** the harness one yak at a time. The harness never chooses its own next item. | Every candidate is a design judgement; picking from a 17-item tree would optimise for the machine's convenience, not the business. |

| Q7 | **B — thin harness.** `bin/run-yak <id>`: load the yak context, do the work, run the gate, hard-stop on red, commit, never push. No Mastra, no plan pass, no `REVIEW.md`. Lives in this repo, not in `~/research/`. | A third sibling repo would mean a third copy of the same code. The gate is deterministic; the LLM only does the edit. |

| Q8 | **On-demand only.** No cron, no nightly loop. A run starts when a human hands it a yak. | Bursty cadence (§3), and a run whose gate is red should be looked at, not retried at 03:00. |
| Q9 | **Separate bot identity**, `QWAN site factory <factory@qwan.eu>`, supplied per invocation via `GIT_AUTHOR_*` / `GIT_COMMITTER_*` — not in `.git/config`. | `git log --author` then separates machine work from the human's. Repo config is not hijacked: a human commit from this machine keeps their identity. |

All questions from the 2026-10-31 session are answered. Build order: §6.

The human expects to pick up the pace on this repo, which weakens the "the loop will idle" objection in §3 — but it does not settle cadence (nightly vs on-demand).

Notes recorded for the queued work:

- Q2/B can avoid clickops: `POST /repos/{owner}/{repo}/pages` with
  `build_type: workflow` flips the Pages source from a script (`gh api` makes it
  reviewable). The only manual step is the initial credential.
- With Pages dictating the Jekyll version, "dependency updates" for this repo is
  one line (`Gemfile:2`). It does not justify a factory; see §5.

---

## 2. Build and deploy — the gate has nothing to attach to

| Fact | Evidence |
|---|---|
| Build happens on GitHub Pages, not here | No `.github/`, no CI config anywhere |
| Pinned to 2022 | `Gemfile:2` → `github-pages =225` → `jekyll 3.9.0`, `kramdown 2.3.1`, `sass 3.7.4` |
| Latest available | `github-pages 232` (2024-08-06) → `jekyll = 3.10.0`, `jekyll-sass-converter 1.5.2`, `kramdown 2.4.0`, Ruby ≥ 2.3 |
| Jekyll 4 exists but Pages cannot run it | latest `jekyll` is 4.4.1; Pages is frozen at 3.10.0 for 14 months |
| Local build has never been exercised | no `_site`; `bundle` is not installed; the only path is `docker-compose.yml` → `bretfisher/jekyll-serve:stable-20220916052939`, image not present locally |
| Ruby mismatch | `.tool-versions` and `.ruby-version` say `2.7.8` (EOL); host has 3.2.3 |
| Deploy is a push to `master` → `qwan.eu` | `CNAME`, remote `git@github.com:qwaneu/qwaneu.github.io.git` |
| Commits would be authored by a placeholder | `git config --show-origin user.name` → `/home/cardfanatic/.gitconfig`: `Your Name <you@example.com>`; last 5 commits: `Marc Evers <marc@qwan.eu>`. Blocks the harness's commit step — filed as `git-identity` |

Consequence: today "zero defects" means "the build did not visibly break on the
live site". A harness committing against an unreproducible build would produce
confident, unverified commits — so the first deliverable is the build, not the
loop.

## 3. Shape of the repo and the work

- 130 posts in `_posts`, 16 `_drafts`, ~46 `_ideas`, 24 collection/pages.
- The a11y migration is **mid-flight**, three layout families in use:
  `post` (156 files), `other-accessible` (13), `accessibletwo` (11),
  `training-description` (13), `service-description` (6), `blog-index` (2).
- Commit cadence, last 12 months: 487 commits, very spiky — 105 in 2025-12,
  59 in 2026-06, 1 in 2026-07, 2 in 2026-10.
- Last 20 commits touch almost only content (`_consulting/`, `_training/`,
  `README.md`). Layout/SCSS changes are rare bursts, not a nightly stream.
- `yx` is installed here but this repo has **no yaks** (no `refs/notes/yaks`).
  The work inventory lives in the `README.md` TODO (Dutch, partly stale) plus
  the GitHub issue surface, which is unused.

Consequence: on the 2025–2026 record the automation would idle most days, and a
nightly loop that fires once a fortnight is a machine you forget how to read.
The human intends to pick up the pace, so treat this as a forecast to re-measure,
not a constraint — but it still argues for on-demand runs until the cadence is
actually higher.

## 4. Defect inventory (measured, not fixed)

| # | Where | Defect |
|---|-------|--------|
| D1 | `_includes/header_clean.html:30` | `<a class="ribbon__element" >{{page.title}}</a>` — anchor with no `href`: not a link, not focusable. On every blog post. |
| D2 | `_layouts/post.html:10-11` | `<p class="post-meta">` wrapping `<div>` elements — invalid HTML; browsers reparent it, assistive tech gets the structure the spec never allowed. `--check-html` would catch this class of defect. |
| D3 | `_layouts/accessibletwo.html:23` | `initial-scale=0.86` shrinks default text for every visitor (zoom is still allowed, `maximum-scale=5.0`) |
| D4 | `_layouts/accessibletwo.html:10-15` | `.find(row => row.startsWith('cookieconsent_status')).split('=')` throws when the cookie is absent → the inline script aborts → `gtag('config', …)` never runs, so first-time visitors are not tracked at all. The consent branch is dead until a consent cookie exists. |
| D5 | `privacy.md:18-28` vs `_layouts/accessibletwo.html:7-8` | `gtag.js` is fetched from `googletagmanager.com` before consent is resolved; the privacy page documents `_ga` cookies. Re-check under GDPR before "fixing" D4 — making tracking work on first visit is a policy change, not a bug fix. |
| D6 | `_config.yml:68` + `_sass/_qwan-overrides.scss:9` | `kramdown.line_numbers: true`, hidden again with a `.no-line-numbers` CSS hack. `README.md` already says turn it off in config. |
| D7 | `Gemfile:3-4` | `jekyll-assets` and `sprockets` are unused: no `_assets/`, no `{% asset %}`, no `asset_path`. Also not in the Pages plugin whitelist. |
| D8 | `README.md` ("IN PROGRESS"/"Styling") | Open a11y/mobile items: blog archive + post pages, hamburger menu, services grid overflow, ribbon on narrow screens, line numbers |

D1–D4 are exactly the kind of thing a human eyeball misses on a 154-page site
and a static checker finds in seconds. That is the argument for the gate being
code rather than prose in an AGENTS.md.

## 5. Does this need a factory?

The three named jobs are not one job:

| Job | Nature | Factory? |
|---|---|---|
| Gem updates | 3 direct gems; Pages dictates versions; 2 of the 3 are dead | No. One line plus a build. A `bin/` script at most. |
| Jekyll 3.10 → 4 + Actions | Migration, one-off, wide blast radius | No. A yak with its own plan. |
| A11y / mobile tweaks | Judgement + verification, recurring, bursty | Yes — this is the only genuinely stochastic part, and the only place an LLM loop pays for its maintenance. |

wereview-deps earned its complexity: a 40-package umbrella lock, OSV advisories,
six dependency waves, an e2e gate, and a "commit touches only `mix.lock`" rule.
Here the dependency graph is three edges, so that machinery would be pure
overhead.

Maintenance cost is real: mastra-factory and wereview-deps already share code —
wereview-deps is a *fork* of mastra-factory's dependency engine. A third sibling
repo means three places to fix the same bug and three AGENTS.md files to keep
true. If a third is built, it should be an *instance* of a shared engine with a
site adapter, not a third fork.

By the repo's own principle (["Stochastic To
Deterministic"](/2025/12/11/stochastic-to-deterministic.html)): extract repeated
knowledge into reliable tools first. pa11y/axe, a link check, a parse check and
breakpoint screenshots are those tools. A loop built before them is
stochasticity stacked on stochasticity.

## 6. Build order

Every question from the 2026-10-31 session is answered in §1. The order below is
the order the yaks are meant to land in; it is also the order in which the gate
becomes true rather than aspirational.

1. `gate-ghpages-232` — the container build. Nothing else can be verified
   before this exists. Blocks `gate-a11y-ratchet`.
2. `git-identity` — decided: a separate bot identity, set per-invocation by the
   harness (`GIT_AUTHOR_*` / `GIT_COMMITTER_*`), **not** in `.git/config`, so a
   human commit from this machine is not silently attributed to the bot. The
   global gitconfig placeholder is left alone; flagged to the human because it
   affects their own commits too.
3. `gate-a11y-ratchet` — checks 1–4 plus the baseline. After this, AGENTS.md's
   gate section stops saying "not yet available".
4. `bin/run-yak <id>` — the thin harness (Q7): load yak, work, gate, hard-stop,
   commit, never push. No Mastra, no plan pass.
5. Then the defect yaks, one per commit, in whatever order the human hands them.

Known trap: `yx` takes a git ref lock (`refs/notes/yaks`). Two yx commands in
parallel fail with `Locked (-14)`; a harness must run them sequentially and may
retry once.

## 7. Publishing note

`_config.yml:19` excludes only `README.md` and `vendor`, so this file (and any
future `AGENTS.md`) would be served from `qwan.eu`. `docs` and `AGENTS.md` have
been added to `exclude`. `Gemfile`, `Gemfile.lock` and `docker-compose.yml` are
*already* published by the same gap — not fixed here, recorded as a finding.

## 8. How to re-check

```sh
# build pin and what it implies
sed -n '1,5p' Gemfile
curl -s https://rubygems.org/api/v1/versions/github-pages/latest.json

# layout families / migration progress
grep -rh '^layout:' --include='*.md' --include='*.html' . | sort | uniq -c | sort -rn

# cited defects
sed -n '28,32p' _includes/header_clean.html
sed -n '8,20p' _layouts/post.html
sed -n '7,25p'  _layouts/accessibletwo.html
sed -n '60,72p' _config.yml

# unused asset gems
ls -d _assets 2>/dev/null; grep -rn 'asset_path\|{% asset' --include='*.html' --include='*.scss' .

# cadence
git log --since='1 year ago' --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
```
