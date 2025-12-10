TERMUX_PKG_HOMEPAGE="https://github.com/Pedro-Beirao/dsda-launcher"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@alexdvn"
TERMUX_PKG_VERSION=1.4
TERMUX_PKG_SRCURL=https://github.com/Pedro-Beirao/dsda-launcher/archive/refs/tags/v$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=b8f80047ee39a0bc49d2e06a6e0a862f60aa9cf5c86e01ef960426d978cb5c22
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, dsda-doom"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, xorgproto, make"
TERMUX_PKG_BUILD_IN_SRC=true 

termux_step_pre_configure() {
	# Ensure the source directory is clean before configuration
	# This step is sometimes necessary for qmake projects
	rm -rf $TERMUX_PKG_BUILDDIR
	mkdir -p $TERMUX_PKG_BUILDDIR
}

termux_step_configure() {
	# The qmake executable for cross-compilation is qmake6,
	# provided by the qt6-qtbase-cross-tools dependency.
	# We run it from the source directory, which is also the build directory
	# due to TERMUX_PKG_BUILD_IN_SRC=true.

	# Configure the project using qmake6.
	# The -set QMAKE_LFLAGS ... and -set QMAKE_CXXFLAGS ... are crucial 
	# for ensuring the resulting executable links correctly with Termux libraries.
	# The target name is inferred from the .pro file (or set via TARGET in .pro).
	
	${TERMUX_PREFIX}/opt/qt6/cross/lib/qt6/bin/qmake6 \
		-set QMAKE_LFLAGS+="-Wl,-rpath=${TERMUX_PREFIX}/lib" \
		-set QMAKE_CXXFLAGS+="-Wl,-rpath=${TERMUX_PREFIX}/lib"
}

termux_step_make() {
	# Build the project using the generated Makefile and 'make'
	make -j$(nproc --all)
}

termux_step_make_install() {
	# Install the built application files
	# 'make install' is often sufficient for qmake projects
	make install
}
