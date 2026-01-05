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

- [ ] Pagina van individuele blog entry accessible maken
- [ ] #blog pagina accessible maken (zie ook 'grid' to do)
- 'specials' toevoegen aan trainingspagina (workshops e.d.)
- [ ] analytics toevoegen (heeft implicaties voor cookie melding/toestemming)
- [ ] trainingen-grid genereren uit training pages? Definieer trainingen en workshops als collections (met eigen folders)
- [ ] eventueel: expliciet landen benoemen waar we actief zijn
- [ ] ribbon op mobile (smal) aanpassen; nu valt het blog titel deel buiten beeld
- [ ] consulting vraag-gedreven opzetten misschien ook met tiles? Pagina is nu vooral aanbod/methode gedreven
- [ ] impact mapping workshop toevoegen
- [ ] story mapping + dimensional planning + example mapping als 1 dag training
- [ ] zet code rendering line numbers uit in _config.yml ipv via css - of gebruiken we line numbers ergens?
