# How to run locally

```
cd ~/qwan/sites/qwaneu.github.io
docker compose up          # serve on http://localhost:4000, drafts included
```

The image is built from the `Dockerfile` in this repo: the `github-pages` gem set
on a pinned Ruby base image. That container is the **build of record** — see
[AGENTS.md](AGENTS.md) and [docs/findings.md](docs/findings.md). Do not build on
the host; the host Ruby and the gem set will drift apart.

One-shot build, same container, same environment as GitHub Pages
(`JEKYLL_ENV=production`):

```
docker compose run --rm jekyll bundle _2.4.22_ exec jekyll build
```

The current directory is mounted as `/site`, so source changes are picked up
without a rebuild. Rebuild the image (`docker compose build`) when `Gemfile` or
`Gemfile.lock` change.

Known local-only noise: `GitHub Metadata: No GitHub API authentication could be
found` — the `github-pages` gem set loads `jekyll-github-metadata`; it needs a
token only to fill in `site.github`, which this site does not use.

# Useful links

Where to get free, human-made, royalty-free images:  
https://humancode.us/2026/08/28/royalty-free-images

# IN PROGRESS

## Pagina van lijst van blog entries accessible maken

Blog archief en individuele blog entries hebben wat minder grafische elementen. [Firefox accessibility inspector](https://developer.mozilla.org/en-US/docs/Web/Accessibility/Understanding_WCAG/Text_labels_and_names?utm_source=devtools&utm_medium=a11y-panel-checks-text-label#Content_with_images_must_be_labeled) in developer tools lijkt een redelijk begin te zijn.

### hamburger menu toegankelijk maken

Q: How do we bundle css?
A: https://jekyllrb.com/docs/assets/

Main.scss already has media queries. This might get messy.

Q: how do we bundle javascript?
A: not known yet - we push to github and the rest is magic at the moment.

# TODO

Verbeteringen:

- [X] DDD intro training verbeteren
- [ ] Systems thinking training verbeteren
- [ ] Example Mapping workshop: 'quote' toevoegen ("Example Mapping combines just enough up-front thinking with 
  working from concrete examples, which allows for smooth development and testing of user stories")
- [ ] Diensten: 
  - [ ] Special projects uitwerken
- [ ] Specials toevoegen?
  - [ ] toevoegen: knowledge workshop; TDD-AI; 

Diensten & marketing:

- [ ] "AI Scan" toevoegen (hoe zit dit als traject er uit?)
- [ ] bij diensten: ook heel 'traject' als dienst toevoegen; nu vooral componenten; in de vorm van 3 opties (ipv dat 
  klant zelf wat bij elkaar moet zoeken)
- [ ] 'specials' toevoegen aan trainingspagina (workshops e.d.)
- [ ] client quotes uitbreiden + enkele logo's toevoegen (Sky, Qwoater?, 
- [ ] Idee: Training concept tot cash in a Day (experience agile 2nd ed)
- [ ] Idee: https://www.hyperact.co.uk/services opdeling "where we can help", "How we work with you", "Where to start"
- Inspiratie: https://daverooney.dev/services

Styling:

- [ ] mobile weergave diensten pagina: grid met diensten valt buiten beeld
- [ ] Pagina van individuele blog entry accessible maken
- [ ] #blog pagina accessible maken (zie ook 'grid' to do)
- [ ] analytics toevoegen (heeft implicaties voor cookie melding/toestemming)
- [ ] ribbon op mobile (smal) aanpassen; nu valt het blog titel deel buiten beeld
- [ ] zet code rendering line numbers uit in _config.yml ipv via css - of gebruiken we line numbers ergens?

Optional:

- [ ] eventueel: expliciet landen benoemen waar we actief zijn
- [ ] training agenda
- [ ] upcoming appearances (conferenties, cursussen, ...)
- [ ] pasfoto's vernieuwen

# Verwerken

## Positionering & meerwaarde van QWAN

Wat maakt ons bijzonder?
- Bomen en het bos
- denken + doen
- eerst luisteren en waardering voor wat werkt (er werkt altijd al wat!), niet zozeer zenden (zoals Xebia meer doet)
- voor de lange termijn

Link AI en good engineering practices (XP?):
https://www.hyperact.co.uk/blog/methods-of-software-delivery-in-the-era-of-agentic-engineering


## Overig

"Snelheid van begrip" (zeker in context van AI)

Friction: accidental vs intentional
Weten wanneer te stoppen

# Prompts

Evaluate workshop description:
- The current file describes a workshop we offer; evaluate it from the perspective of a potential client (development
  manager, CTO, engineering manager): does it speak to them? are the benefits for them clear? what is
  missing?

Evaluate workshop title:
- The workshop described in the current file is called "Event Storming Workshop"; technically this is correct, but this
  speaks mostly to potential buyers and participants that are already familiar with this concept. What would be a more
  enticing name, also taking into account the previous feedback about the description?

Evaluate service:
- The current file describes a consulting service we offer; evaluate it from the perspective of a potential client 
  (development manager, CTO, engineering manager): does it speak to them? are the benefits for them clear? what is
  missing? What is a good call-to-action? Keep it concise but not too short.

Misc:
- How can this call to action become more effective in context of the current file?

