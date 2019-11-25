![kreytricks_header](/files/img/Kreytricks_header.png)

# Kreytricks
[![linux-tests-badge](https://github.com/Kreytricks/kreytricks/workflows/Linux/badge.svg)](https://www.google.com)
[![macosx-tests-badge](https://github.com/Kreytricks/kreytricks/workflows/MacOS/badge.svg)](https://www.google.com)

(FIXME: macos tests are invalid https://github.com/Kreytricks/kreytricks/issues/37)

[![License](http://img.shields.io/:license-lgpl-green.svg)](https://tldrlegal.com/license/gnu-lesser-general-public-license-v2.1-(lgpl-2.1))

Originally contribution-focused winetricks fork, now standalone fork since winetricks doesn't provide required environment for this kind of development.

This fork is true rolling-release where recommended method to sync with upstream is to use git.

## Maintainance
- This fork is less strict and relies mostly on Travis-Cl tests, issues with merged contribution will be blames on the author if there is an issue.
- Mistakes of new contributors are tolerated and questions related to the project will be answered. If needed project mentors are willing to invest their time into new contributors. If you are unsure of what to do then the best thing to do is to make a broken merge request and wait for review. The review will help guide you on what to do.

## Compatibility
Our current ethique is to support everything, so if you are able to run POSIX shell on your system, then we are going to support it.

## Tests
The tests need `bashate`, `checkbashisms`, and `shellcheck>=0.4.4` installed.
Makefile supports a few test targets:

* `check` - runs './tests/winetricks-tests quick' (without first clearing $WINETRICKS_CACHE)
* `shell-checks` - runs './tests/shell-checks'
* `test` - runs './tests/winetricks-tests full' (and clears $WINETRICKS_CACHE first)
* `xvfb-check` - runs './tests/winetricks-tests xvfb-check' (without first clearing $WINETRICKS_CACHE first)
