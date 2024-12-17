#!/bin/bash

set -euo pipefail

_ICU_DIR="/tmp/build/icu"
_ICU_SRC="https://github.com/unicode-org/icu/releases/download/release-76-1/icu4c-76_1-src.tgz"

mkdir -p $_ICU_DIR
cd $_ICU_DIR

wget -q -O icu.tgz $_ICU_SRC
gunzip -d < icu.tgz | tar xf -
cd icu/source

chmod +x runConfigureICU configure install-sh
# TODO: probably not necessary?
# --enable-static
./runConfigureICU Linux
gmake
gmake install
