#!/usr/bin/env bash

set -e

# Install prerequisites
brew install sbcl allegro
(cd /tmp; curl -sLO https://github.com/jtanx/lddx/releases/download/v0.1.0/lddx-0.1.0.tar.xz)
tar -xf /tmp/lddx-0.1.0.tar.xz -C /usr/local/bin
chmod +x /usr/local/bin/lddx

# Install quicklisp
(cd /tmp; curl --insecure -sO https://beta.quicklisp.org/quicklisp.lisp)
echo "(quicklisp-quickstart:install) (ql-util:without-prompting (ql:add-to-init-file))" | sbcl --load /tmp/quicklisp.lisp

# Get latest cl-liballegro
git clone --depth=1 https://github.com/resttime/cl-liballegro $HOME/quicklisp/local-projects/cl-liballegro

# Get latest cl-liballegro-nuklear
git clone --depth=1 https://gitlab.com/lockie/cl-liballegro-nuklear $HOME/quicklisp/local-projects/cl-liballegro-nuklear

# Get d2clone-kit
git clone -b develop --depth=1 https://gitlab.com/lockie/d2clone-kit.git $HOME/quicklisp/local-projects/d2clone-kit

# Do build
VERSION=$(git describe --tags | sed 's/\(.*\)-.*/\1/')
export VERSION
sbcl --dynamic-space-size 2048 --disable-debugger --load build.lisp
outdir="Darkness Looming: The Dawn.app/Contents"
mkdir -p "$outdir"/{Frameworks,MacOS,Resources}
cp Info.plist "$outdir/"
cp Resources/* "$outdir/Resources"
cp bin/* "$outdir/MacOS/"
lddx -q -r -c "$outdir/Frameworks" "$outdir/MacOS/"*.dylib
cd "$outdir/MacOS"
ln -s liballegro.5.2.6.dylib liballegro.5.2.dylib
ln -s liballegro_audio.5.2.6.dylib liballegro_audio.5.2.dylib
ln -s liballegro_font.5.2.6.dylib liballegro_font.5.2.dylib
cd -
hdiutil create -quiet -srcfolder "Darkness Looming: The Dawn.app" out.dmg
hdiutil convert -quiet out.dmg -format UDBZ -o Darkness_Looming_The_Dawn-$VERSION.dmg

# Install butler
(cd /tmp; curl -sJLO https://broth.itch.ovh/butler/darwin-amd64/LATEST/archive/default)
unzip /tmp/butler-darwin-amd64.zip -d /usr/local/bin
chmod +x /usr/local/bin/butler

# Upload
butler push Darkness_Looming_The_Dawn-*.dmg awkravchuk/darkness-looming-the-dawn:mac --userversion $VERSION --noprogress
