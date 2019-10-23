# How to run locally:

```
cd ~/Documents/qwan/sites/qwaneu.github.io
docker-compose up
```

Renders the site. Uses [premade docker-compose file and images](https://github.com/BretFisher/jekyll-serve).

Q: How to build?
A: current directory is mounted as `./site` so it should be all good.


# IN PROGRESS

- Pagina van lijst van blog entries accessible maken

Blog archief en individuele blog entries hebben wat minder grafische elementen. [Firefox accessibility inspector](https://developer.mozilla.org/en-US/docs/Web/Accessibility/Understanding_WCAG/Text_labels_and_names?utm_source=devtools&utm_medium=a11y-panel-checks-text-label#Content_with_images_must_be_labeled) in developer tools lijkt een redelijk begin te zijn.

# TODO

- Pagina van individuele blog entry accessible maken

- #blog pagina accessible maken (zie ook 'grid' to do)
- CSS Grid uitzoeken/inzetten voor cursus 'grid' (en blog entry grid)
Waarom? (Grid is leuk, en er is vast een probleem dat het oplost, maar ik weet niet meer wat het is.)
- 2 extra trainingen met eigen page toevoegen; Example Mapping & Hexagonal Architecture?
- 'specials' toevoegen aan trainingspagina (workshops e.d.)
- Springest widgets toevoegen (zinnig zodra we wat reviews hebben)
- analytics toevoegen (heeft implicaties voor cookie melding/toestemming)
- trainingen-grid genereren uit training pages?
- eventueel: expliciet landen benoemen waar we actief zijn

# Done

- run jekyll locally, with docker
- make SVG curve up and curve down pass firefox accesibility checker
