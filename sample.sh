#!/bin/sh

cd "$(dirname "$0")"

SAMPLE="$@"
FILE=hlc.hxml
if [ -z "${SAMPLE}" ]; then
    SAMPLE="Base2D"
fi

cd submodules/heaps/samples/build/$SAMPLE

cp *_hl.hxml $FILE
sed -i "" "s/-hl.*/-hl ..\/..\/..\/..\/hashlink\/src\/_main.c/" hlc.hxml

haxe hlc.hxml -dce full