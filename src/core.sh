#!/bin/sh
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020 under the terms of GNUv3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

: '
Core management of kreytricks-next'

while [ $# -ge 1 ]; do case $1 in
	--help|-help|-h|help)
		printf '%s\n' \
			"Usage: kreytricks [OPTION|VERB] [VERB]" \
			"Configurator for wineprefixes and wine itself" \
			"" \
			"Options:" \
			"  -h, --help         Display help menu" \
			"" \
			"Verbs:" \
			"  stub               stub" \
			"" \
			"kreytricks online help: <$UPSTREAM>" \
			"Full documentation at: <$UPSTREAM_DOCS>"
		shift 1 ;;
	*)
		die 2 "Unknown argument '$1' has been parsed"
esac; done
