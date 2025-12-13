TTRMUX_PKG_HOMEPAGE=https://github.com/ZDoom/ZMusic
TERMUX_PKG_DESCRIPTION="A library to play music for all ZDoom engines"
TERMUX_PKG_LICENSE="GPL-3.0, BSD 3-Clause, LGPL-2.1, LGPL-3.0"
TERMUX_PKG_MAINTAINER=@alexdvn
TERMUX_PKG_VERSION=1.3.0
TERMUX_PKG_SRCURL=https://github.com/ZDoom/ZMusic/archive/refs/tags/$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=f49f3ac3d4845304f45f485f5dd11095504caaf9f1c26b4995b45b1582ee03bc
TERMUX_PKG_DEPENDS="fluidsynth, game-music-emu, libmpg123, libsndfile"
TERMUX_PKG_BUILD_DEPENDS="clang, make, pkg-config, cmake"

