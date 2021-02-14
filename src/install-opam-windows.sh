#!/usr/bin/env bash
export OPAMYES=1
export OPAMJOBS=3
set -ex
if [[ -e /usr/bin/opam ]]; then
  echo Already configured from cache
  exit 0
fi

echo Preparing opam environment
OPAM_DL_SUB_LINK=0.0.0.2
OPAM_URL="https://github.com/fdopen/opam-repository-mingw/releases/download/${OPAM_DL_SUB_LINK}/opam64.tar.xz"
OPAM_ARCH=opam64
export OPAM_LINT="false"
export CYGWIN='winsymlinks:native'
export OPAMYES=1
set -eu
curl -fsSL -o "${OPAM_ARCH}.tar.xz" "${OPAM_URL}"
tar -xf "${OPAM_ARCH}.tar.xz"
"${OPAM_ARCH}/install.sh" --quiet --prefix=/usr
rm "${OPAM_ARCH}.tar.xz"
rm -rf opam64
