#!/usr/bin/env bash
export OPAMYES=1
export OPAMJOBS=3
set -ex
if [[ -e ~/.opam/config ]]; then
  echo Already configured from cache
  opam update
  exit 0
fi

echo Preparing Cygwin environment
if [ "$1" = "" ]; then
  OCAML_VERSION="4.07.1"
else
  OCAML_VERSION="$1"
fi
OPAM_REPOSITORY="$2"
SWITCH="${OCAML_VERSION}+mingw64c"
export OPAM_LINT="false"
export CYGWIN='winsymlinks:native'
export OPAMYES=1
set -eu
# if a msvc compiler must be compiled from source, we have to modify the
# environment first
case "$SWITCH" in
  *msvc32)
    eval "$(ocaml-env cygwin --ms=vs2015 --no-opam --32)"
    ;;
  *msvc64)
    eval "$(ocaml-env cygwin --ms=vs2015 --no-opam --64)"
    ;;
esac
# XXX This is wrong - we should init here and make the switch later
opam init -c "ocaml-variants.${SWITCH}" --disable-sandboxing --enable-completion --enable-shell-hook --auto-setup default "$OPAM_REPOSITORY"
opam config set jobs "$OPAMJOBS"
is_msvc=0
case "$SWITCH" in
  *msvc*)
    is_msvc=1
    eval "$(ocaml-env cygwin --ms=vs2015)"
    ;;
  *mingw*)
    eval "$(ocaml-env cygwin)"
    ;;
  *)
    echo "ocamlc reports a dubious system: ${ocaml_system}. Good luck!" >&2
    eval "$(opam env)"
    ;;
esac
if [ $is_msvc -eq 0 ]; then
  opam install depext-cygwinports depext
else
  opam install depext
fi
