#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
AUTO_DIR=$(cd "${SCRIPT_DIR}/.." && pwd)

source "${AUTO_DIR}/utils/determine-os.sh"
source "${AUTO_DIR}/utils/ensure-brew.sh"
source "${AUTO_DIR}/utils/download-and-extract.sh"

set -euo pipefail

VERSION=${VERSION:-"0.8.0"}
RELEASE_URL="https://github.com/koalaman/shellcheck/releases/download"
AUTO_CACHE_DIR="${HOME}/.config/auto/cache"

mkdir -p "${AUTO_CACHE_DIR}"

if [[ "${AUTO_LINUX}" = true ]]; then
	if [[ "${AUTO_ARM64}" = true ]]; then
		echo "Install ARM64"	
	fi
	if [[ "${AUTO_ARM}" = true ]];then
		PACKAGE="shellcheck-v${VERSION}.linux.armv6hf.tar.xz"
		download-and-extract "${RELEASE_URL}/v${VERSION}" "${PACKAGE}" 
		mv "${AUTO_EXTRACT_DIR}/shellcheck-v${VERSION}/shellcheck" "${HOME}/.local/bin/"
		rm -rf "${AUTO_EXTRACT_DIR:?}"
	fi
	if [[ "${AUTO_X86_64}" = true ]]; then
		echo "Install Linux x86_64"
	fi
elif [[ "${AUTO_DARWIN}" = true ]]; then
	if [[ "${AUTO_ARM64}" = true ]]; then
		# https://github.com/cli/cli/issues/2426
		# Have to use brew for this for now
		brew install gh
	fi
	if [[ "${AUTO_X86_64}" = true ]]; then
		echo "Install Darwin x86_64"
	fi
fi

