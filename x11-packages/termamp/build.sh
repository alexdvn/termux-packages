TERMUX_PKG_HOMEPAGE=https://github.com/quydev-fs/TermAMP
TERMUX_PKG_DESCRIPTION="A simple WinAMP 2.X inspired Music player built specifically for termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.3b
TERMUX_PKG_SRCURL=https://github.com/quydev-fs/TermAMP/archive/refs/tags/v$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=e8fe95f33450beee7d154f3f1107ecf087e98a77935d9dfc9546758342058a2c
TERMUX_PKG_DEPENDS="gtk3, gstreamer"
TERMUX_PKG_BUILD_DEPENDS="clang, make, pkg-config"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
    make -j$(nproc --all)
}

termux_step_make_install() {
    install -Dm700 TermAMP "$TERMUX_PREFIX/bin/TermAMP"
	ln -s $TERMUX_PREFIX/bin/TermAMP $TERMUX_PREFIX/bin/termamp
}
