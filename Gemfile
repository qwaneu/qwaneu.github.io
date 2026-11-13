source 'https://rubygems.org'

# The build of record is the GitHub Pages gem set; see docs/findings.md §2 and
# the `gate-ghpages-232` yak before touching this file.
gem 'github-pages', '=232', group: :jekyll_plugins

# github-pages 232 does not pin activesupport, so bundler floats it from 5.2.7 to
# a 2026 release. Nothing on this site needs the newer one, and keeping the older
# one keeps the runtime gem set identical to what the site has been built with.
gem 'activesupport', '5.2.7'
