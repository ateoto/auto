#!/usr/bin/env bash

set -euo pipefail

ASDF_VERSION=${ASDF_VERSION:-"v0.9.0"}
INSTALL_DIRECTORY=${INSTALL_DIRECTORY:-"${HOME}/.asdf"}

if ! command -v git &> /dev/null; then
	sudo apt update && sudo apt install -y \
		git \
		curl
fi


if [[ ! -d "${INSTALL_DIRECTORY}" ]]; then 
git clone \
	https://github.com/asdf-vm/asdf.git "${INSTALL_DIRECTORY}" \
	--branch "${ASDF_VERSION}"
else
	pushd "${INSTALL_DIRECTORY}" || exit
		#TODO: Check for dirty status before doing this
		git fetch origin "${ASDF_VERSION}"
		git checkout "${ASDF_VERSION}"
	popd || exit
fi

if ! grep -q '# ASDF Configuration' ~/.bashrc; then
	{
		echo "# ASDF Configuration"
		echo ". $HOME/.asdf/asdf.sh"
		echo ". $HOME/.asdf/completions/asdf.bash"
	} >> "${HOME}/.bashrc"
fi
