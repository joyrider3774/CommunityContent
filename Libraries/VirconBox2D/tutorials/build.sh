#!/usr/bin/env bash
# Build a tutorial lesson ROM through the full Vircon32 pipeline.
# Usage: ./build.sh <lesson>        e.g.  bash build.sh lesson1_hello
# Produces obj/<lesson>.asm, obj/<lesson>.vbin, bin/<lesson>.v32
set -e
NAME="${1:?usage: build.sh <lesson>   e.g. build.sh lesson1_hello}"
TOOLS="E:/Claude/Projects/Vircon32/DevTools"
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"
mkdir -p obj bin

echo "[1/3] compile  $NAME.c"
"$TOOLS/compile.exe"  "$NAME.c"        -o "obj/$NAME.asm"
echo "[2/3] assemble $NAME.asm"
"$TOOLS/assemble.exe" "obj/$NAME.asm"  -o "obj/$NAME.vbin"
# lessons with sprites reuse the parent project's textures
if compgen -G "../textures/*.png" > /dev/null; then
    for png in ../textures/*.png; do
        base="$(basename "${png%.png}")"
        echo "[tex]  png2vircon $png"
        "$TOOLS/png2vircon.exe" "$png" -o "obj/$base.vtex"
    done
fi
echo "[3/3] packrom  $NAME.xml"
"$TOOLS/packrom.exe"  "$NAME.xml"      -o "bin/$NAME.v32"
echo "OK -> bin/$NAME.v32"
