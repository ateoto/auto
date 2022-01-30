#!/usr/bin/env bash

source "${PWD}/utils/determine-os.sh"
source "${PWD}/utils/ensure-brew.sh"

set -euo pipefail

VERSION=${VERSION:-"2.4.0"}
GH_CLI_URL="https://github.com/cli/cli/releases/download"
# https://github.com/cli/cli/releases/download/v2.4.0/gh_2.4.0_linux_armv6.tar.gz

AUTO_CACHE_DIR="${HOME}/.config/auto/cache"
mkdir -p "${AUTO_CACHE_DIR}"

if [[ "${AUTO_LINUX}" = true ]]; then
	if [[ "${AUTO_ARM64}" = true ]]; then
		echo "Install ARM64"	
	fi
	if [[ "${AUTO_ARM}" = true ]];then
		PACKAGE="gh_${VERSION}_linux_armv6.tar.gz"
		RELEASE="${GH_CLI_URL}/v${VERSION}/${PACKAGE}"
		if [[ ! -s "${AUTO_CACHE_DIR}/${PACKAGE}" ]];then
			curl -fsSLo "${AUTO_CACHE_DIR}/${PACKAGE}" "${RELEASE}"
		fi
		TEMP_FOLDER=$(echo "${PACKAGE}" | sed "s/.tar.gz//")
		echo "${TEMP_FOLDER}"
		rm -rf "${AUTO_CACHE_DIR}/${TEMP_FOLDER}"
		mkdir -p "${AUTO_CACHE_DIR}/${TEMP_FOLDER}"
		tar xzf "${AUTO_CACHE_DIR}/${PACKAGE}" --directory "${AUTO_CACHE_DIR}/"
		cp -R "${AUTO_CACHE_DIR}/${TEMP_FOLDER}/"* "${HOME}/.local/"
	fi
elif [[ "${AUTO_DARWIN}" = true ]]; then
	if [[ "${AUTO_ARM64}" = true ]]; then
		# https://github.com/cli/cli/issues/2426
		# Have to use brew for this for now
		brew install gh
	fi
fi
