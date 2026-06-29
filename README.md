# How to run locally

```
cd ~/Documents/qwan/sites/qwaneu.github.io
docker compose up
```

Renders the site. Uses [pre-made docker-compose file and images](https://github.com/BretFisher/jekyll-serve).

Q: How to build?
A: current directory is mounted as `./site` so it should be all good.

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

- [ ] "AI Scan" toevoegen (hoe zit dit als traject er uit?)
- [ ] bij diensten: ook heel 'traject' als dienst toevoegen; nu vooral componenten; in de vorm van 3 opties (ipv dat 
  klant zelf wat bij elkaar moet zoeken)
- [ ] Pagina van individuele blog entry accessible maken
- [ ] #blog pagina accessible maken (zie ook 'grid' to do)
- [ ] 'specials' toevoegen aan trainingspagina (workshops e.d.)
- [ ] analytics toevoegen (heeft implicaties voor cookie melding/toestemming)
- [ ] ribbon op mobile (smal) aanpassen; nu valt het blog titel deel buiten beeld
- [ ] zet code rendering line numbers uit in _config.yml ipv via css - of gebruiken we line numbers ergens?
- [ ] client quotes uitbreiden + enkele logo's toevoegen (Sky, Qwoater?, 

Optional:

- [ ] eventueel: expliciet landen benoemen waar we actief zijn
- [ ] training agenda
- [ ] upcoming appearances (conferenties, cursussen, ...)
- [ ] pasfoto's vernieuwen

# Verwerken

Wat maakt ons bijzonder?
- Bomen en het bos
- denken + doen
- eerst luisteren en waardering voor wat werkt (er werkt altijd al wat!), niet zozeer zenden (zoals Xebia meer doet)
- voor de lange termijn

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

Misc:
- How can this call to action become more effective in context of the current file?

