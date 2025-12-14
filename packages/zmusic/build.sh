TERMUX_PKG_HOMEPAGE=https://github.com/ZDoom/ZMusic
TERMUX_PKG_DESCRIPTION="A library to play music for all ZDoom engines"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER=@alexdvn
TERMUX_PKG_VERSION=1.3.0
TERMUX_PKG_SRCURL=https://github.com/ZDoom/ZMusic/archive/refs/tags/$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=f49f3ac3d4845304f45f485f5dd11095504caaf9f1c26b4995b45b1582ee03bc
TERMUX_PKG_DEPENDS="libc++, libandroid-support, fluidsynth, game-music-emu, libmpg123, libsndfile, glib, iconv"
TERMUX_PKG_BUILD_DEPENDS="clang, make, pkg-config, cmake"

termux_step_pre_configure() {
    # This is normal for CMake to use
    mkdir -p $TERMUX_PKG_BUILDDIR
}

termux_step_configure() {
    # Bruh, CMake is cool, also these are regular stuff
	termux_setup_cmake
	
    cmake -G "Unix Makefiles" \
        -S $TERMUX_PKG_SRCDIR \
        -B $TERMUX_PKG_BUILDDIR \
        -DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX \
        -DCMAKE_BUILD_TYPE=Release \
        -Wno-dev
}

termux_step_make() {
    # Use 'make' to compile the project in the build directory.
    # -j $TERMUX_MAKE_PROCESSES is standard for parallel compilation.
    make -C $TERMUX_PKG_BUILDDIR -j$(nproc --all)
}

termux_step_make_install() {
    # This will tell the deb maker where everything goes
    cmake --install $TERMUX_PKG_BUILDDIR
}


