#!/bin/sh

cd "$(dirname "$0")"

# Setup haxelib
haxelib install hashlink
haxelib dev heaps submodules/heaps
haxelib dev hlsdl submodules/hashlink/libs/sdl
haxelib dev hlopenal submodules/hashlink/libs/openal

# Generate heaps samples
cd submodules/heaps/samples
haxe gen.hxml