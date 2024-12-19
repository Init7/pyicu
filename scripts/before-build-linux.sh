#!/bin/bash

set -euo pipefail

_HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# NOTE: add `ID` to environment
source /etc/os-release

echo "release:"
cat /etc/os-release

case "${ID}" in
  debian)
    apt-get update
    apt-get -y upgrade
    apt-get -y install pkg-config
    ;;

  centos)
    yum install -y wget
    ;;

  almalinux)
    dnf -y install wget
    ;;

  alpine)
    apk upgrade
    apk add --no-cache wget
    ;;

  *)
    echo "$0: unexpected Linux distribution: '${ID}'" >&2
    exit 1
    ;;
esac


if [ ! -d "${_BUILD_DIR}/lib" ]; then
  ${_HERE}/install-libicu.sh Linux
fi


# NOTE: configure library search paths
case "${ID}" in
  almalinux)
    echo "${_BUILD_DIR}/lib" >> /etc/ld.so.conf
    ldconfig
    ;;

  alpine)
    _DEFAULT_LIBS="/lib:/usr/local/lib:/usr/lib"
    echo "${_BUILD_DIR}/lib:${_DEFAULT_LIBS}" >> /etc/ld-musl-$(uname -m).path
    ldconfig "${_BUILD_DIR}/lib:${_DEFAULT_LIBS}"
    ;;

  *)
    ;;
esac
