#!/usr/bin/env bash

set -euxo pipefail

# Get latest cl-liballegro
git clone --depth=1 https://github.com/resttime/cl-liballegro /root/quicklisp/local-projects/cl-liballegro

# Get latest cl-liballegro-nuklear
git clone --depth=1 https://gitlab.com/lockie/cl-liballegro-nuklear /root/quicklisp/local-projects/cl-liballegro-nuklear

# Get d2clone-kit
git clone --depth=1 --branch master https://gitlab.com/lockie/d2clone-kit.git /root/quicklisp/local-projects/d2clone-kit

# Do build
VERSION=$(git describe --tags | sed 's/\(.*\)-\(.*\)-.*/\1.\2/')
export VERSION
echo "${VERSION}" > version.txt
sbcl --dynamic-space-size 2048 --disable-debugger --load build.lisp
linuxdeploy --appimage-extract-and-run --executable=bin/dld --custom-apprun=AppRun --icon-file=dld.png --desktop-file=dld.desktop --appdir=appimage $(find bin -name "lib*" -printf "-l%p ")
rm -fr appimage/usr/share/doc appimage/usr/lib/libxcb*
install -D bin/dld appimage/usr/bin/
install -D Resources/assets.zip -m 644 "appimage/usr/share/Darkness Looming The Dawn/assets.zip"
ARCH=x86_64 appimagetool --appimage-extract-and-run --comp xz -g appimage "Darkness_Looming_The_Dawn-${VERSION}.AppImage"

# Save artifact
tar cvf Darkness_Looming_The_Dawn.tar "Darkness_Looming_The_Dawn-${VERSION}.AppImage"
