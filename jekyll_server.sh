#!/bin/bash
#Exports port 4000, but server reset
#It will update the content in _site on a change, and you need to manually refresh the browser.

docker run --name jekyll -p 4000:4000 --rm -v "$PWD:/src" grahamc/jekyll serve
