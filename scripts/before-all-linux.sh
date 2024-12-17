#!/bin/bash

set -euo pipefail

_HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# TODO: make more reliable perhaps
# NOTE: export build dir, used downstream
export _BUILD_DIR="$(pwd)/.build"


# NOTE: add `ID` to environment
source /etc/os-release

echo "release:"
cat /etc/os-release

case "$ID" in
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

    *)
        echo "$0: unexpected Linux distribution: '$ID'" >&2
        exit 1
        ;;
esac


${_HERE}/install-libicu.sh
