#!/bin/bash

set -x
set -e

DEBPACKAGE="${1%.deb}"

[[ -z "$1" ]] && echo "Usage: $0 <package.deb>" && exit 1

ar x $DEBPACKAGE.deb
zstd -d < control.tar.zst | xz > control.tar.xz
zstd -d < data.tar.zst | xz > data.tar.xz
ar -m -c -a sdsd "$DEBPACKAGE"_repacked.deb debian-binary control.tar.xz data.tar.xz
rm debian-binary control.tar.xz data.tar.xz control.tar.zst data.tar.zst

echo "Repack done. Use the following command to install."