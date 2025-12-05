TERMUX_PKG_HOMEPAGE=https://github.com/kraflab/dsda-doom
TERMUX_PKG_DESCRIPTION="A BOOM-compatible DOOM engine made for speedrunners"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER=@alexdvn
TERMUX_PKG_VERSION=0.29.4
TERMUX_PKG_SRCURL=https://github.com/kraflab/dsda-doom/archive/refs/tags/v$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=e36886e94f5a74a95e9f212540a1fe0a979caeee8b5ef55e299c797f7bf59f15
TERMUX_PKG_DEPENDS="libc++, opengl, glu, sdl2, sdl2-mixer, sdl2-image, zlib, libsndfile, libzip"
TERMUX_PKG_RECOMMENDS="libmad, fluidsynth, portmidi, vorbisfile"
TERMUX_PKG_BUILD_DEPENDS="clang, make, cmake, libglvnd-dev"

# Define the name of the folder containing the source/CMakeLists.txt
# This is the path *inside* the extracted source archive.
DSDA_DOOM_SOURCE_SUBDIR="prboom2"

termux_step_pre_configure() {
	# Termux extracts the archive into TERMUX_PKG_SRCDIR (e.g., $HOME/termux-packages/dsda-doom/src/dsda-doom-0.29.4)
    # Since the real source is inside a 'prboom2' folder, we adjust the variable
	
	echo "Adjusting TERMUX_PKG_SRCDIR to point to the nested '${DSDA_DOOM_SOURCE_SUBDIR}' directory."
	
    # We set a new variable to hold the actual source path for clarity in the configuration step
    export DSDA_SOURCE_PATH="$TERMUX_PKG_SRCDIR/$DSDA_DOOM_SOURCE_SUBDIR"
    
    if [ ! -d "$DSDA_SOURCE_PATH" ]; then
        termux_die "Error: The expected source subdirectory '$DSDA_SOURCE_PATH' does not exist! Check the archive structure."
    fi
}

termux_step_configure() {
	# Use the adjusted path for the source directory
	local SOURCE_DIR="$DSDA_SOURCE_PATH"
	
	termux_setup_cmake
	
	# Configure the build using CMake
	cmake "$SOURCE_DIR" \
		-DCMAKE_INSTALL_PREFIX="$TERMUX_PREFIX" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_SKIP_INSTALL_RPATH=ON \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DBUILD_SHARED_LIBS=OFF \
		-DUSE_SDL=ON \
		-DUSE_SDL_MIXER=ON \
		-DUSE_SDL_IMAGE=ON \
		-DUSE_FLUIDSYNTH=ON \
		-DUSE_LIBZIP=ON \
		-DUSE_LIBMAD=ON \
		-DUSE_VORBISFILE=ON \
		-DUSE_PORTMIDI=ON \
		-DUSE_FREETYPE=ON \
		\
		-DCMAKE_CXX_FLAGS="$CXXFLAGS" \
		-DCMAKE_C_FLAGS="$CFLAGS" \
		-DCMAKE_SHARED_LINKER_FLAGS="$LDFLAGS" \
		-DCMAKE_MODULE_LINKER_FLAGS="$LDFLAGS"
}

termux_step_make() {
	# Standard Termux build using the number of available cores
	# The build is executed from the build directory created in termux_step_configure
	make -j$(nproc --all)
}

termux_step_install() {
	# Standard Termux install, normally assumes root.
	cmake --install .
	
	# Assuming the built binary is named 'dsda-doom'
	local BINARY_NAME="dsda-doom"
	
	# Check if the binary was installed
	if [ ! -f "$TERMUX_PREFIX/bin/$BINARY_NAME" ]; then
		termux_die "Error: Expected binary '$BINARY_NAME' not found in $TERMUX_PREFIX/bin/"
	fi
}

