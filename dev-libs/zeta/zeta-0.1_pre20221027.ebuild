# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Header-only, multi-platform, general purpose library"
HOMEPAGE="http://zeta.st"
SRC_URI="http://zeta.st/download/Zeta-0.1-pre-2022-10-27.tar.xz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
BDEPEND=""
RDEPEND=""

S="${WORKDIR}/Zeta"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	mycmakeargs+=(
		-DZeta_WITH_CMAKE_SUPPORT=YES
		-DZeta_WITH_PKGCONFIG_SUPPORT=YES
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}
