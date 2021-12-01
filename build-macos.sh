#!/usr/bin/env bash

set -euxo pipefail

# Install prerequisites
brew update
brew upgrade
brew install wget sbcl zlib allegro
wget -q -P /tmp https://github.com/jtanx/lddx/releases/download/v0.1.0/lddx-0.1.0.tar.xz
tar -xf /tmp/lddx-0.1.0.tar.xz -C /usr/local/bin
chmod +x /usr/local/bin/lddx

# Install Quicklisp
wget -q -P /tmp https://beta.quicklisp.org/quicklisp.lisp
echo '(quicklisp-quickstart:install) (ql-util:without-prompting (ql:add-to-init-file))' | sbcl --load /tmp/quicklisp.lisp

# Get latest cl-liballegro
git clone --depth=1 https://github.com/resttime/cl-liballegro "$HOME/quicklisp/local-projects/cl-liballegro"

# Get latest cl-liballegro-nuklear
git clone --depth=1 https://gitlab.com/lockie/cl-liballegro-nuklear "$HOME/quicklisp/local-projects/cl-liballegro-nuklear"

# Get d2clone-kit
git clone --depth=1 --branch master https://gitlab.com/lockie/d2clone-kit.git "$HOME/quicklisp/local-projects/d2clone-kit"

# Do build
VERSION=$(git describe --tags | sed 's/\(.*\)-\(.*\)-.*/\1.\2/')
export VERSION
echo "$VERSION" > version.txt
LDFLAGS='-lallegro -lallegro_font -lallegro_image -lallegro_primitives -lallegro_ttf' DYLD_LIBRARY_PATH=/usr/local/opt/zlib/lib:/usr/local/opt/libffi/lib sbcl --dynamic-space-size 2048 --disable-debugger --load build.lisp
outdir="Darkness Looming: The Dawn.app/Contents"
mkdir -p "$outdir"/{Frameworks,MacOS,Resources}
cp Info.plist "$outdir/"
cp Resources/* "$outdir/Resources"
cp bin/* "$outdir/MacOS/"
lddx -q -r -c "$outdir/Frameworks" "$outdir/MacOS/"*.dylib
hdiutil create -quiet -srcfolder "Darkness Looming: The Dawn.app" out.dmg
hdiutil convert -quiet out.dmg -format UDBZ -o "Darkness_Looming_The_Dawn-$VERSION.dmg"

# Save artifact
tar cvf Darkness_Looming_The_Dawn.tar "Darkness_Looming_The_Dawn-$VERSION.dmg"
