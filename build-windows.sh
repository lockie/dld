#!/usr/bin/env bash

set -e

ALLEGRO_VERSION=${ALLEGRO_VERSION:-5.2.7.0}
SBCL_VERSION=${SBCL_VERSION:-2.1.7}
PREFIX="$HOME/.wine"

# Bootstrap wine
winetricks > /dev/null

# Bootstrap mingw64
wget -q https://pilotfiber.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/seh/x86_64-8.1.0-release-win32-seh-rt_v6-rev0.7z -P /tmp
7z x /tmp/x86_64-8.1.0-release-win32-seh-rt_v6-rev0.7z -o"$PREFIX/drive_c/" -y > /dev/null

# Install required libraries
packages=(
    "mingw-w64-x86_64-libffi-3.3-4-any.pkg.tar.zst"
    "mingw-w64-x86_64-make-4.3-1-any.pkg.tar.xz"
    "mingw-w64-x86_64-pkg-config-0.29.2-3-any.pkg.tar.zst"
    "mingw-w64-x86_64-zlib-1.2.11-9-any.pkg.tar.zst"
)
for pkg in ${packages[*]}; do
    wget -q "http://repo.msys2.org/mingw/x86_64/$pkg" -P /tmp
    tar -xf "/tmp/$pkg" -C "$PREFIX/drive_c"
done
cp "$PREFIX/drive_c/mingw64/bin/libffi-7.dll" "$PREFIX/drive_c/windows"
cp "$PREFIX/drive_c/mingw64/bin/zlib1.dll" "$PREFIX/drive_c/windows"
cp "$PREFIX/drive_c/mingw64/bin/mingw32-make.exe" "$PREFIX/drive_c/mingw64/bin/make.exe"
wget -q https://github.com/liballeg/allegro5/releases/download/"$ALLEGRO_VERSION"/allegro-x86_64-w64-mingw32-gcc-10.2.0-posix-seh-dynamic-"$ALLEGRO_VERSION".zip -P /tmp
unzip -qqj /tmp/allegro-x86_64-w64-mingw32-gcc-10.2.0-posix-seh-dynamic-"$ALLEGRO_VERSION".zip 'allegro/bin/*' -d "$PREFIX/drive_c/windows/"
unzip -qq /tmp/allegro-x86_64-w64-mingw32-gcc-10.2.0-posix-seh-dynamic-"$ALLEGRO_VERSION".zip 'allegro/include/*' -d /tmp && cp -r /tmp/allegro/include "$PREFIX/drive_c/mingw64/lib/gcc/x86_64-w64-mingw32/8.1.0"
unzip -qqj /tmp/allegro-x86_64-w64-mingw32-gcc-10.2.0-posix-seh-dynamic-"$ALLEGRO_VERSION".zip 'allegro/lib/*' -d "$PREFIX/drive_c/mingw64/lib"
echo "REGEDIT4

[HKEY_CURRENT_USER\Environment]
\"PATH\"=\"C:\\\\\\\\mingw64\\\\\\\\bin\"" > /tmp/path.reg
wine regedit /tmp/path.reg

# Install SBCL & Quicklisp
wget -q https://github.com/roswell/sbcl_bin/releases/download/"$SBCL_VERSION"/sbcl-"$SBCL_VERSION"-x86-64-windows-binary.msi -P /tmp
wine msiexec /q /i /tmp/sbcl-${SBCL_VERSION}-x86-64-windows-binary.msi
wget -q https://beta.quicklisp.org/quicklisp.lisp -P /tmp
(cd /tmp && echo "(quicklisp-quickstart:install) (ql-util:without-prompting (ql:add-to-init-file))" | wine sbcl --load quicklisp.lisp)

# Get latest cl-liballegro
git clone --depth=1 https://github.com/resttime/cl-liballegro "$PREFIX/drive_c/users/$(whoami)/quicklisp/local-projects/cl-liballegro"

# Get latest cl-liballegro-nuklear
git clone --depth=1 https://gitlab.com/lockie/cl-liballegro-nuklear "$PREFIX/drive_c/users/$(whoami)/quicklisp/local-projects/cl-liballegro-nuklear"

# Get d2clone-kit
git clone --depth=1 --branch master https://gitlab.com/lockie/d2clone-kit "$PREFIX/drive_c/users/$(whoami)/quicklisp/local-projects/d2clone-kit"

# Do build
VERSION=$(git describe --tags | sed 's/\(.*\)-\(.*\)-.*/\1.\2/')
export VERSION
echo "$VERSION" > version.txt
CC=gcc LDFLAGS="-lallegro -lallegro_font -lallegro_image -lallegro_primitives -lallegro_ttf" wine sbcl --dynamic-space-size 2048 --disable-debugger --load build.lisp
cp "$PREFIX/drive_c/mingw64/bin/libgcc_s_seh-1.dll" bin/
cp "$PREFIX/drive_c/mingw64/bin/libstdc++-6.dll" bin/
makensis installer.nsi

# Install butler
wget -q https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default -P /tmp --content-disposition
unzip /tmp/butler-linux-amd64.zip -d /usr/local/bin
chmod +x /usr/local/bin/butler

# Upload
butler push Darkness_Looming_The_Dawn-*-setup.exe awkravchuk/darkness-looming-the-dawn:windows --userversion $VERSION --noprogress
