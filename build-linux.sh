#!/usr/bin/env sh

set -e

# Scavenge latest allegro
wget -q -P /tmp \
     http://mirrors.kernel.org/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg8_8c-2ubuntu8_amd64.deb \
     http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_1.4.2-0ubuntu3.4_amd64.deb \
     http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8-dev_1.4.2-0ubuntu3.4_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-acodec5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-audio5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-dialog5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-image5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-image5-dev_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-physfs5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-ttf5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-ttf5-dev_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro-video5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro5.2_5.2.7.0-1~bionic_amd64.deb \
     https://launchpad.net/~allegro/+archive/ubuntu/5.2/+build/21726487/+files/liballegro5-dev_5.2.7.0-1~bionic_amd64.deb

dpkg -i /tmp/*.deb

ln -s /usr/lib/x86_64-linux-gnu/libwebp.so /usr/lib/x86_64-linux-gnu/libwebp.so.7

# Install linuxdeploy
wget -q -O /usr/local/bin/linuxdeploy https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x /usr/local/bin/linuxdeploy

# Install appimagetool
wget -q -O /usr/local/bin/appimagetool https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x /usr/local/bin/appimagetool

# Install quicklisp
wget -q https://beta.quicklisp.org/quicklisp.lisp -P /tmp
echo "(quicklisp-quickstart:install) (ql-util:without-prompting (ql:add-to-init-file))" | sbcl --load /tmp/quicklisp.lisp

# Get latest cl-liballegro
git clone --depth=1 https://github.com/resttime/cl-liballegro /root/quicklisp/local-projects/cl-liballegro

# Get latest cl-liballegro-nuklear
git clone --depth=1 https://gitlab.com/lockie/cl-liballegro-nuklear /root/quicklisp/local-projects/cl-liballegro-nuklear

# Get d2clone-kit
git clone --depth=1 --branch master https://gitlab.com/lockie/d2clone-kit.git /root/quicklisp/local-projects/d2clone-kit

# Do build
VERSION=$(git describe --tags | sed 's/\(.*\)-\(.*\)-.*/\1.\2/')
export VERSION
echo "$VERSION" > version.txt
sbcl --dynamic-space-size 2048 --disable-debugger --load build.lisp
linuxdeploy --appimage-extract-and-run --executable=bin/dld --custom-apprun=AppRun --icon-file=dld.png --desktop-file=dld.desktop --appdir=appimage $(find bin -name "lib*" -printf "-l%p ")
rm -fr appimage/usr/share/doc appimage/usr/lib/libxcb*
install -D bin/dld appimage/usr/bin/
install -D Resources/assets.zip -m 644 "appimage/usr/share/Darkness Looming The Dawn/assets.zip"
ARCH=x86_64 appimagetool --appimage-extract-and-run --comp xz -g appimage Darkness_Looming_The_Dawn-$VERSION.AppImage

# Install butler
wget -q https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default -P /tmp --content-disposition
unzip /tmp/butler-linux-amd64.zip -d /usr/local/bin
chmod +x /usr/local/bin/butler

# Upload
butler push Darkness_Looming_The_Dawn-*.AppImage awkravchuk/darkness-looming-the-dawn:linux --userversion $VERSION --noprogress
