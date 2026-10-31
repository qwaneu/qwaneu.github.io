# Build of record for qwan.eu: the GitHub Pages gem set, in a pinned container.
# See docs/findings.md §2 and the `gate-ghpages-232` yak.
#
#   docker compose up                                   # serve on :4000, drafts on
#   docker compose run --rm jekyll bundle exec jekyll build   # one-shot build
#
# The base image is pinned by digest on purpose: the site has no other way to
# verify a change, so "which Ruby and which Debian" must not drift silently.
FROM docker.io/library/ruby:3.2-slim-bookworm@sha256:6cb22cf2353c2d7e74c648707f0a55e6200f3077f528f69ce30a640081dea827

ENV DEBIAN_FRONTEND=noninteractive \
    JEKYLL_ENV=production \
    PAGES_REPO_NWO=qwaneu/qwaneu.github.io \
    BUNDLE_PATH=/usr/local/bundle

# git is required at build time: jekyll-github-metadata (pulled in by the
# github-pages gem set, even though nothing on the site reads site.github)
# shells out to `git` for the revision.
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential git \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.4.22 --no-document

WORKDIR /site

# Gems first, so a source-only change does not re-resolve the lock.
COPY Gemfile Gemfile.lock ./
RUN bundle _2.4.22_ install --jobs 4

# The repo is bind-mounted at /site and is owned by the host user; without this
# git refuses to read it ("dubious ownership") and the metadata plugin fails.
RUN git config --system --add safe.directory /site

EXPOSE 4000 35729

CMD ["bundle", "_2.4.22_", "exec", "jekyll", "serve", "--drafts", "--force-polling", "--host", "0.0.0.0", "--port", "4000", "--livereload"]
