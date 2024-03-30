# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/manuel-sainz-de-baranda-y-gonni.asc
inherit cmake verify-sig

DESCRIPTION="Header-only, multi-platform, general purpose library"
HOMEPAGE="http://zeta.st"
SRC_URI="
	http://zeta.st/download/Zeta-0.1-pre-2024-01-26.tar.xz
	verify-sig? ( http://zeta.st/download/Zeta-0.1-pre-2024-01-26.tar.xz.asc )
"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
BDEPEND="verify-sig? ( sec-keys/openpgp-keys-manuel-sainz-de-baranda-y-gonni )"
RDEPEND=""

S="${WORKDIR}/Zeta"

DOCS=(AUTHORS)

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
