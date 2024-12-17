#!/bin/bash

set -euo pipefail

_HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "dir: ${_HERE}"
echo "pwd: $(pwd)"

echo "package config: $(which pkg-config)"
env

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
