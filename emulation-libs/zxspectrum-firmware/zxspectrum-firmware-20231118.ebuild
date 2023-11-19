# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="ZX Spectrum firmware"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://zxe.io/depot/download/ZX%20Spectrum%20-%20Firmware%20%282023-11-18%29.7z -> ${P}.7z"

LICENSE="Sinclair-Firmware"
SLOT="0"
KEYWORDS="amd64 arm64 ppc ppc64 x86"

BDEPEND="$(unpacker_src_uri_depends)"

S=${WORKDIR}

src_install() {
	insinto /usr/lib/emulation/firmware
	doins *.rom
}
