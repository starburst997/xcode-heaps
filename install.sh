#!/bin/sh

# Setup haxelib
haxelib install hashlink
haxelib dev heaps submodules/heaps
haxelib dev hlsdl submodules/hashlink/libs/sdl
haxelib dev hlopenal submodules/hashlink/libs/openal