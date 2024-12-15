#!/bin/bash

echo "package config: $(which pkg-config)"
env

echo "this is pwd"
pwd
ls -la
ls -la .ci
ls -la .ci/out
ls -la .ci/out/lib
ls -la .ci/out/lib/pkgconfig

echo "this is pkg_config_path"
ls -la $PKG_CONFIG_PATH

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
        yum install -y libicu
        ;;

    almalinux)
        dnf -y install libicu
        ;;

    *)
        echo "$0: unexpected Linux distribution: '$ID'" >&2
        exit 1
        ;;
esac
