# xcode-heaps

Running heaps on iOS / Mac OSX

This project aims mainly at getting heaps to run on iOS easily, it's quite 
unclear yet what is the "official" way of getting heaps to run on mobile 
devices (there's no easy to run `heaps test ios`).

This is the setup I came up with, far from perfect but I was quite impatient 
on getting it to run on my iPhone and play with heaps.

The possibility of having the VM run on mobile device and having hot-reload
capability would be a breath of fresh air, for now tho, this is using hlc.

# Getting Started

This is of course all done on a mac machine.

Install latest version of haxe ([4.0.0-preview.3](https://haxe.org/download/version/4.0.0-preview.3/)) available on [haxe.org](https://haxe.org/).

Makes sure you ran `--recursive` when cloning this repo (or run `git submodule update --init --recursive` if not) 
as it rely on submodules for now.

Makes sure you have [Brew](https://brew.sh/) installed.

Run `./install.sh` (setup haxelib to use the submodules path, build hashlink, etc.)

The example heaps code display a rotating red rectangle (`src/Main.hx`).

Then compile to hlc using `haxe build-hlc.hxml`, if you see `Code generated in submodules/hashlink/src/_main.c automatic native compilation not yet implemented` then you're in business!.

Open the XCode project at `xcode/iOS/heaps-iOS.xcodeproj`, press Build (you will probably need to modify the signing / bundle identifier).

To quickly generate a heaps sample, call `./sample.sh base2D`, then click "Build" again in the XCode project!

# TODO

- [ ] Remove all those precompiled 3rd party binaries and setup proper xcode project to build them from source (turbojpeg, ogg, vorbis).
- [ ] Bitcode disabled because of turbojpeg pre-compiled library
- [ ] .app for mac instead of executable (with nice icon, does mac support launch image?)
- [ ] Setup fastlane
- [ ] 3D samples looks glitchy (I commented out some stuff in gl.c, might be why?)
- [ ] Framerate of 3D particles goes down over time (probably intended, but I don't think I saw this behavior on non-mobile device)?
- [ ] Add a command line tool to build hlc, the xcode project and run on device without opening XCode.
- [x] Compile all Heaps samples
