#!/bin/sh

cd "$(dirname "$0")"

# Generate heaps samples
cd submodules/heaps/samples
haxe gen.hxml

# Hack the hl hxml to generate hlc
SAMPLE="$@"
FILE=hlc.hxml
if [ -z "${SAMPLE}" ]; then
    SAMPLE="base2D"
fi

cd build/$SAMPLE

cp *_hl.hxml $FILE
sed -i "" "s/-hl.*/-hl ..\/..\/..\/..\/hashlink\/src\/_main.c/" hlc.hxml

haxe hlc.hxml -dce full