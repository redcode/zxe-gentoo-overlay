# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/sofia-ortega-sosa.asc
inherit cmake multibuild flag-o-matic verify-sig

DESCRIPTION="Z80 instruction clock"
HOMEPAGE="https://zxe.io/software/Z80InsnClock"
SRC_URI="
	https://zxe.io/software/Z80InsnClock/download/Z80InsnClock-0.1-pre-2024-12-24.tar.xz
	verify-sig? ( https://zxe.io/software/Z80InsnClock/download/Z80InsnClock-0.1-pre-2024-12-24.tar.xz.asc )
"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+static-libs"

DEPEND=">=dev-libs/zeta-0.1_pre20240418"
BDEPEND="verify-sig? ( sec-keys/openpgp-keys-sofia-ortega-sosa )"
RDEPEND=""

S="${WORKDIR}/Z80InsnClock"

DOCS=(AUTHORS LICENSE-0BSD README)

pkg_setup() {
	MULTIBUILD_VARIANTS=(shared $(usev static-libs))
}

src_prepare() {
	multibuild_foreach_variant cmake_src_prepare
}

src_configure() {
	filter-flags -fstack-protector -fstack-protector-all -fstack-protector-strong -fstack-protector-explicit
	append-cflags -fno-stack-protector

	myconfigure() {
		mycmakeargs=(
			-DZ80InsnClock_WITH_CMAKE_SUPPORT=YES
			-DZ80InsnClock_WITH_HTML_DOCUMENTATION=NO
			-DZ80InsnClock_WITH_PDF_DOCUMENTATION=NO
			-DZ80InsnClock_WITH_STANDARD_DOCUMENTS=NO
			-DZ80InsnClock=All
		)

		if [[ ${MULTIBUILD_VARIANT} == shared ]]; then
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=YES
				-DZ80InsnClock_NOSTDLIB_FLAGS=Auto
				-DZ80InsnClock_WITH_PKGCONFIG_SUPPORT=YES
			)
		else
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=NO
				-DZ80InsnClock_WITH_PKGCONFIG_SUPPORT=NO
			)
		fi

		cmake_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_install() {
	multibuild_foreach_variant cmake_src_install
}
