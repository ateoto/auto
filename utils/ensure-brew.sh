#!/usr/bin/env bash
# Thin wrapper around the official homebrew installer script.

if [[ -z $AUTO_DETERMINED ]]; then
	source "${PWD}/utils/determine-os.sh"
fi

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

if [[ "${AUTO_DARWIN}" = true ]]; then
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | tee brew_installer.sh
	chmod +x brew_installer.sh
	./brew_installer.sh
fi

