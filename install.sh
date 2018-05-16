#!/bin/sh

cd "$(dirname "$0")"

# Setup haxelib
haxelib install hashlink
haxelib install hscript
haxelib dev hxbit submodules/hxbit
haxelib dev heaps submodules/heaps
haxelib dev hlsdl submodules/hashlink/libs/sdl
haxelib dev hlopenal submodules/hashlink/libs/openal

# Generate heaps samples
cd submodules/heaps/samples
haxe gen.hxml

# Install hashlink dependencies
brew install libpng jpeg-turbo libvorbis sdl2 mbedtls openal-soft libuv

# Make install hashlink
cd ../../../submodules/hashlink
make all && make install