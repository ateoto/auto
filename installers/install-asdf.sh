#!/usr/bin/env bash

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
	pushd "${INSTALL_DIRECTORY}"
		#TODO: Check for dirty status before doing this
		git fetch origin "${ASDF_VERSION}"
		git checkout "${ASDF_VERSION}"
	popd
fi

if ! grep -q '# ASDF Configuration' ~/.bashrc; then
	echo '# ASDF Configuration' >> ~/.bashrc
	echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
	echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
else
	echo "Already in the config"
fi
