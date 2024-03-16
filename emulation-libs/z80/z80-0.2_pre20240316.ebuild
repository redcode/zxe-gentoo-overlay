# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake multibuild flag-o-matic

DESCRIPTION="Zilog Z80 CPU emulator"
HOMEPAGE="https://zxe.io/software/Z80"
SRC_URI="https://zxe.io/software/Z80/download/Z80-0.2-pre-2024-03-16.tar.xz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+static-libs +z80_execute +z80_full_im0 +z80_im0_retx_notifications +z80_q z80_special_reset z80_unofficial_reti +z80_zilog_nmos_ld_a_ir_bug"

DEPEND=">=dev-libs/zeta-0.1_pre20231020"
BDEPEND=""
RDEPEND=""

S="${WORKDIR}/Z80"

DOCS=(AUTHORS HISTORY README THANKS)

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
			-DZ80_FETCH_TEST_FILES=NO
			-DZ80_WITH_CMAKE_SUPPORT=YES
			-DZ80_WITH_HTML_DOCUMENTATION=NO
			-DZ80_WITH_PDF_DOCUMENTATION=NO
			-DZ80_WITH_STANDARD_DOCUMENTS=NO
			-DZ80_WITH_TESTS=NO
			-DZ80_WITH_EXECUTE=$(usex z80_execute)
			-DZ80_WITH_FULL_IM0=$(usex z80_full_im0)
			-DZ80_WITH_IM0_RETX_NOTIFICATIONS=$(usex z80_im0_retx_notifications)
			-DZ80_WITH_Q=$(usex z80_q)
			-DZ80_WITH_SPECIAL_RESET=$(usex z80_special_reset)
			-DZ80_WITH_UNOFFICIAL_RETI=$(usex z80_unofficial_reti)
			-DZ80_WITH_ZILOG_NMOS_LD_A_IR_BUG=$(usex z80_zilog_nmos_ld_a_ir_bug)
		)

		if [[ ${MULTIBUILD_VARIANT} == shared ]]; then
			mycmakeargs+=(
				-DZ80_NOSTDLIB_FLAGS=Auto
				-DBUILD_SHARED_LIBS=YES
				-DZ80_WITH_PKGCONFIG_SUPPORT=YES
			)
		else
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=NO
				-DZ80_WITH_PKGCONFIG_SUPPORT=NO
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
