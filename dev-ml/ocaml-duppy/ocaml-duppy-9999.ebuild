# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools findlib git-r3

DESCRIPTION="OCaml advanced scheduler"
HOMEPAGE="https://github.com/savonet/ocaml-duppy"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"
SRC_URI=""
LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+camlp4 debug +ocamlopt profiling ssl"
RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	dev-ml/pcre-ocaml:=
	camlp4? ( dev-ml/camlp4:= )
	ssl? ( dev-ml/ocaml-ssl:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib"
DOCS=( CHANGES README )
PATCHES=( "${FILESDIR}/${P}-configure.patch" )

src_prepare() {
	default

	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "Failed editing m4/ocaml.m4!"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf $(use_enable camlp4) \
		$(use_enable debug debugging) \
		$(use_enable ocamlopt nativecode) \
		$(use_enable profiling) \
		$(use_enable ssl)
}

src_install() {
	findlib_src_install
	einstalldocs
}
