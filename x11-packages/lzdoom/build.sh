TERMUX_PKG_HOMEPAGE=https://github.com/drfrag666/lzdoom
TERMUX_PKG_DESCRIPTION="GZDoom but with Doom Legacy support, now forked under a!"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER=@alexdvn
TERMUX_PKG_VERSION=4.14.3a
TERMUX_PKG_SRCURL=https://github.com/drfrag666/lzdoom/archive/refs/tags/l$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=03c453d2baa33e89437fc43a6a86980c1c7d71f11169270e2d9b4fc30f86cb1a
TERMUX_PKG_DEPENDS="libc++, libandroid-support, openal-soft, bzip2, zmusic, sdl2, libvpx, opengl, vulkan-loader"
TERMUX_PKG_BUILD_DEPENDS="clang, make, pkg-config, cmake, libglvnd-dev, vulkan-headers, xorgproto"

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
				-DHAVE_GLES2=on \
				-DHAVE_VULKAN=on \
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
