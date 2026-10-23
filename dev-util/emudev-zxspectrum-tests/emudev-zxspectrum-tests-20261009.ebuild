# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="ZX Spectrum test collection"
HOMEPAGE="https://zxe.io/depot"
SRC_URI="https://zxe.io/depot/download/ZX%20Spectrum%20-%20Tests%20%282026-10-09%29.zip -> ${P}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 arm64 ppc ppc64 x86"

BDEPEND="$(unpacker_src_uri_depends)"

S=${WORKDIR}

src_install() {
	insinto "/usr/share/emudev/ZX Spectrum/Software"
	local item
	shopt -s nullglob dotglob
	for item in "${S}"/*; do
		if [[ -d ${item} ]]; then
			doins -r "${item}"
		else
			doins "${item}"
		fi
	done
}
