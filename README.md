# xcode-heaps

Running heaps on iOS / Mac OSX

This project aims mainly at getting heaps to run on iOS easily, it's quite 
unclear yet what is the "official" way of getting heaps to run on mobile 
devices (there's no easy to run `heaps run ios`).

This is the setup I came up with, far from perfect but I was quite impatient 
on getting it to run on my iPhone and play with heaps.

The possibility of having the VM run on mobile device and having hot-reload
capability would be a breath of fresh air, for now tho, this is using hlc.

# Getting Started

Install latest version of haxe ([4.0.0-preview.3](https://haxe.org/download/version/4.0.0-preview.3/)) available on [haxe.org](https://haxe.org/).

Makes sure you ran `--recursive` when cloning this repo (or run `git submodule update --init --recursive` if not) 
as it rely on submodules for now.

Run `./install.sh` (setup haxelib to use the submodule path)

The example heaps code display a rotating red rectangle (`src/Main.hx`).

Then compile to hlc using `haxe build-hlc.hxml`.

Open the XCode project at `xcode/iOS/heaps-iOS.xcodeproj`, press Build.

To quickly generate a heaps sample, call `./sample.sh base2D`, then open the XCode project and hit "Build"!

# 3rd Party

Some 3rd party libraries need to be download and available to the xcode project.

!!! TODO !!!

- [ ] jpegturbo
- [ ] libpng
- [ ] vorbis
- [ ] ogg

# TODO

- [ ] Compile all Heaps samples
- [ ] Add a command line tool to build hlc, the xcode project and run on device without opening XCode.
