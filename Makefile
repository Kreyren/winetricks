#!/usr/src/make
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020 under the terms of GNUv3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

PREFIX = /usr

all:
	@ printf '%s\n' "Nothing to compile. Use: check, clean, cleanup, dist, install"

vendor:
	@ emkdir vendor
