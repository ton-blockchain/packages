#!/usr/bin/env bash
# Build rpm packages

set -x
set -e

BUILD_PATH="$1"
RPM_TEMPLATE_PATH="$2"
RPMBUILD_PATH=$(dirname $(dirname "$2"))
NIX_RESULT_PATH="$3"
PACKAGE_ARCH="$4"
RPM_INSTALL_PATH="$BUILD_PATH"/rpm-install
TON_RELEASE=$5

mkdir -p "$RPMBUILD_PATH"/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
gzip -9 < "$NIX_RESULT_PATH" | tar --create --file "$RPMBUILD_PATH"/SOURCES/ton.tar.gz --transform 's,^,ton-dev/,' -C "$NIX_RESULT_PATH" .

rpmbuild --define "_topdir $RPMBUILD_PATH" \
         --define "_prefix /usr" \
         --define "_bindir /usr/bin" \
         --define "_libdir /usr/lib" \
         --define "_datadir /usr/share" \
         --define "releasever $TON_RELEASE" \
         --target "$PACKAGE_ARCH" \
         -v -bb "$RPM_TEMPLATE_PATH"

mkdir -p "$RPM_INSTALL_PATH"
cp -r "$RPMBUILD_PATH"/RPMS/"$PACKAGE_ARCH" "$RPM_INSTALL_PATH"
