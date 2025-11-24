TERMUX_PKG_HOMEPAGE=https://github.com/quydev-fs/TermuxMusic95
TERMUX_PKG_DESCRIPTION="A simple WinAMP 2.X inspired Music player built specifically for termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.2.2a
TERMUX_PKG_SHA256=a59a2c13be42bf20e1f5a73b5b8b5a1f382565c649e83e9bf05dafbf8d9fe142
TERMUX_PKG_DEPENDS="gtk3, gstreamer"
TERMUX_PKG_BUILD_DEPENDS="clang, make, pkg-config"

termux_step_make() {
    make -j$(nproc --all)
}

termux_step_make_install() {
    install -Dm700 termuxmusic95 "$TERMUX_PREFIX/bin/termuxmusic95"
}
