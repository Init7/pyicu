#!/bin/bash

set -euo pipefail

_TMP_DIR="$(dirname "${_BUILD_DIR}")/.libicu.tmp"
_ICU_SRC="https://github.com/unicode-org/icu/releases/download/release-76-1/icu4c-76_1-src.tgz"


# NOTE: see the docs for `runConfigureICU` for the options
_PLATFORM=$1


# NOTE: figure out which make to use
if command -v gmake 2>&1 >/dev/null; then
  _MAKE="gmake"
fi
if command -v make 2>&1 >/dev/null; then
  _MAKE="make"
fi


mkdir -p $_TMP_DIR
cd $_TMP_DIR

wget -q -O icu.tgz $_ICU_SRC
gunzip -d < icu.tgz | tar xf -
cd icu/source

chmod +x runConfigureICU configure install-sh
# TODO: probably not necessary?
# --enable-static
./runConfigureICU ${_PLATFORM} --prefix=${_BUILD_DIR}
${_MAKE}
${_MAKE} install



case $_PLATFORM in
  "Linux"*)
    # TODO: fix?
    echo "${_BUILD_DIR}/lib" >> /etc/ld.so.conf
    ldconfig
    ;;

  "macOS"*)
    # TODO: doesn't do anything, but worth adding wherever needed
    export DYLD_LIBRARY_PATH="${_BUILD_DIR}/lib"
    ;;

  *)
    ;;
esac
