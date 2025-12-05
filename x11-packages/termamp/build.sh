TERMUX_PKG_HOMEPAGE=https://github.com/quydev-fs/TermAMP
TERMUX_PKG_DESCRIPTION="A simple WinAMP 2.X inspired Music player built specifically for termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_SRCURL=https://github.com/quydev-fs/TermAMP/archive/refs/tags/v$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=e7ef3a1bffe85b5fd6321bbfdd53a09d3252b8ec8c31b73b75546a1d7a691f3b
TERMUX_PKG_DEPENDS="gtk3, gstreamer"
TERMUX_PKG_BUILD_DEPENDS="clang, make, pkg-config"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
    make -j$(nproc --all)
}

termux_step_make_install() {
    install -Dm700 build/bin/TermAMP "$TERMUX_PREFIX/bin/TermAMP"
	ln -s $TERMUX_PREFIX/bin/TermAMP $TERMUX_PREFIX/bin/termamp
	install -Dm700 $TERMUX_PKG_BUILDER_DIR/termamp.desktop $TERMUX_PREFIX/share/applications
}
