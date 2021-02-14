#!/bin/sh

set -ex

# opam has been initialised, but we need to switch to
# the right version from the system compiler

CURRENT_OCAML=$(opam info -f version ocaml --color=never)

if [ "$CURRENT_OCAML" != "$1" ]; then
  opam switch set "$1" 2>/dev/null || opam switch create "$1" "$1"
fi

if [ -e setup-ocaml-cleanup -a ! -e ~/.opam/cache-is-primed ]; then
  opam clean --logs -ac
  rm -rf ~/.opam/repo/default/.git
  rm -rf ~/.opam/repo/default/packages
  rm -f ~/.opam/$1/bin/ocaml*.byte
  rm setup-ocaml-cleanup
  touch ~/.opam/cache-is-primed
else
  touch setup-ocaml-cleanup
fi
