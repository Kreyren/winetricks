# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3
# Based in part on 'kreytricks-99999999.ebuild' which is:
#     Distributed under the terms of the GNU General Public License v2
#     Copyright 1999-2019 Gentoo Authors
#     Copyright Robert Walker 2019


# DO NOT USE - NOT FINISHED

# shellcheck disable=SC2034
EAPI=7

inherit bash-completion-r1 xdg-utils-r1

if [ "$PV" = "99999999" ]; then
	EGIT_REPO_URI="https://github.com/Kreytricks/$PN.git"
	inherit git-r3
	unset SRC_URI
else
	SRC_URI="https://github.com/Kreytricks/$PN/archive/$PV.tar.gz -> $P.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Previously contribution-focused fork of kreytricks, now standalone project"
HOMEPAGE="https://github.com/Kreytricks/kreytricks"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="gtk kde rar test"

DEPEND="test? (
		dev-python/bashate
		dev-util/checkbashisms
		dev-util/shellcheck
	)"

RDEPEND="
	|| ( net-misc/aria2 net-misc/curl net-misc/wget www-client/fetch )
	app-arch/cabextract
	app-arch/p7zip
	app-arch/unzip
	virtual/wine
	x11-misc/xdg-utils
	gtk? ( gnome-extra/zenity )
	kde? ( kde-apps/kdialog )
	rar? ( app-arch/unrar )"

# Test targets include syntax checks only, not the "heavy duty" tests
# that would require a lot of disk space, as well as network access.

# This uses a non-standard "Wine" category, which is provided by
# app-emulation/wine-desktop-common package.
# https://bugs.gentoo.org/451552
# QA: Is this valid for kreytricks too?
QA_DESKTOP_FILE="usr/share/applications/kreytricks.desktop"

kreytricks_disable_gui_component() {
	file="$1"
	#[ -n "$file" ] && shift 1

	(($# == 2)) || die "Invalid parameter count: ${#} (2)"
	[ ! -f "$file" ] && die "kreytricks script file not valid: '$file'"

	mv "$file" "$file.bak" || die "Moving of '$file' in '$file.bak' failed"
	if [ "$2" = true ]; then
		awk_file="disable_gui"
	else
		awk_file="disable_gui_component"
	fi
	awk -vgtk_use="$(use gtk && printf '%s\n' 1)" \
		-vkde_use="$(use kde && printf '%s\n' 1)" \
		-f "$FILESDIR/$PN-$awk_file.awk" \
		"$file.bak" > "$file" || die "awk for '$file.bak' failed"

	unset file awk_file
}

kreytricks_disable_version_check() {
	(($# == 1)) || die "Invalid parameter count: ${#} (1)"
	[ ! -f "$1" ] || die "kreytricks script file not valid: '$1'"

	local awk_file="disable_version_check"

	mv "$1" "$1.bak" || die "mv failed"
	awk -f "$FILESDIR/$PN-$awk_file.awk" \
		"$1.bak" > "$1" || die "awk failed"
}

src_unpack() {
	if [ "$PV" = "99999999" ]; then
		git-r3_src_unpack

		(use gtk || use kde) && unpack "$kreytricks_gentoo.tar.bz2"
	else
		default
	fi
}

src_prepare() {
	local PATCHES
	if [ "$PV" = "99999999" ] && [ ! -z "$EGIT_VERSION" ]; then
		sed -i -e '/kreytricks_VERSION=/{s/=/=\"/;s/$/ '"$EGIT_VERSION"'\"/}' \
			"$S/src/kreytricks" || die "sed failed"
	fi
	if use gtk || use kde; then
		kreytricks_disable_gui_component "$S/src/kreytricks" false
	else
		kreytricks_disable_gui_component "$S/src/kreytricks" true
	fi
	kreytricks_disable_version_check "$S/src/kreytricks"
	default
}

src_test() {
	./tests/shell-checks || die "test(s) failed"
}

src_install() {
	default
	newbashcomp "src/$PN.bash-completion" "$PN"
	if use gtk || use kde; then
		cd "$WORKDIR/$kreytricks_gentoo" || die "Changing directory to '$WORKDIR/$kreytricks_gentoo' failed"
		domenu "kreytricks.desktop"
		insinto "/usr/share/icons/hicolor/scalable/apps"
		doins "wine-kreytricks.svg"
	fi
}

pkg_preinst() {
	(use gtk || use kde) && xdg_icon_savelist
}

pkg_postinst() {
	(use gtk || use kde) && xdg_icon_cache_update
}

pkg_postrm() {
	(use gtk || use kde) && xdg_icon_cache_update
}
