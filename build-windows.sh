#!/usr/bin/env bash

set -e

ALLEGRO_VERSION=${ALLEGRO_VERSION:-5.2.6.0}
SBCL_VERSION=${SBCL_VERSION:-2.0.2}
PREFIX="$HOME/.wine"

# Bootstrap wine
winetricks > /dev/null

# Bootstrap mingw64
wget -q https://pilotfiber.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/seh/x86_64-8.1.0-release-win32-seh-rt_v6-rev0.7z -P /tmp
7z x /tmp/x86_64-8.1.0-release-win32-seh-rt_v6-rev0.7z -o"$PREFIX/drive_c/" -y > /dev/null

# Install required libraries
packages=(
    "mingw-w64-x86_64-libffi-3.2.1-4-any.pkg.tar.xz"
    "mingw-w64-x86_64-pkg-config-0.29.2-1-any.pkg.tar.xz"
    "mingw-w64-x86_64-zlib-1.2.11-1-any.pkg.tar.xz"
)
for pkg in ${packages[*]}; do
    wget -q "http://repo.msys2.org/mingw/x86_64/$pkg" -P /tmp
    tar -xf "/tmp/$pkg" -C "$PREFIX/drive_c"
done
cp "$PREFIX/drive_c/mingw64/bin/libffi-6.dll" "$PREFIX/drive_c/windows"
cp "$PREFIX/drive_c/mingw64/bin/zlib1.dll" "$PREFIX/drive_c/windows"
wget -q https://github.com/liballeg/allegro5/releases/download/"$ALLEGRO_VERSION"/allegro-x86_64-w64-mingw32-gcc-9.2.0-posix-seh-dynamic-"$ALLEGRO_VERSION".zip -P /tmp
unzip -qqj /tmp/allegro-x86_64-w64-mingw32-gcc-9.2.0-posix-seh-dynamic-"$ALLEGRO_VERSION".zip 'allegro/bin/*' -d "$PREFIX/drive_c/windows/"
echo "REGEDIT4

[HKEY_CURRENT_USER\Environment]
\"PATH\"=\"C:\\\\\\\\mingw64\\\\\\\\bin\"" > /tmp/path.reg
wine regedit /tmp/path.reg

# Install SBCL & Quicklisp
wget -q https://github.com/roswell/sbcl_bin/releases/download/"$SBCL_VERSION"/sbcl-"$SBCL_VERSION"-x86-64-windows-binary.msi -P /tmp
wine msiexec /q /i /tmp/sbcl-${SBCL_VERSION}-x86-64-windows-binary.msi
wget -q https://beta.quicklisp.org/quicklisp.lisp -P /tmp
(cd /tmp && echo "(quicklisp-quickstart:install) (ql-util:without-prompting (ql:add-to-init-file))" | wine sbcl --load quicklisp.lisp)

# Get d2clone-kit
git clone -b develop --depth=1 https://gitlab.com/lockie/d2clone-kit "$PREFIX/drive_c/users/$(whoami)/quicklisp/local-projects/d2clone-kit"

# Do build
wine sbcl --dynamic-space-size 2048 --disable-debugger --load build.lisp
cp "$PREFIX/drive_c/mingw64/bin/libgcc_s_seh-1.dll" bin/
cp "$PREFIX/drive_c/mingw64/bin/libstdc++-6.dll" bin/
VERSION=$(git describe --tags | sed 's/\(.*\)-.*/\1/')
export VERSION
makensis installer.nsi

# Install butler
wget -q https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default -P /tmp --content-disposition
unzip /tmp/butler-linux-amd64.zip -d /usr/local/bin
chmod +x /usr/local/bin/butler

# Upload
butler push Darkness_Looming_The_Dawn-*-setup.exe awkravchuk/darkness-looming-the-dawn:windows --userversion $VERSION --noprogress
