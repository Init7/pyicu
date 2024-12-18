#!/bin/bash


# NOTE: see the docs for `runConfigureICU` for the options
_PLATFORM=$1


case "${_PLATFORM}" in
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
