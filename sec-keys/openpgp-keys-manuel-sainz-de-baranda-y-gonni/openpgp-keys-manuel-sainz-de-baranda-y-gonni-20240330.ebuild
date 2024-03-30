# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used by Manuel Sainz de Baranda y Goñi"
HOMEPAGE="https://zxe.io"
SRC_URI="https://zxe.io/keys/manuel-pgp-key.public.asc -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - manuel-sainz-de-baranda-y-gonni.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
