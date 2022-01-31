#!/usr/bin/env bash

function download-and-extract {
	AUTO_CACHE_DIR="${HOME}/.config/auto/cache"

	mkdir -p "${AUTO_CACHE_DIR}"
	
	local url="${1}"
	local package="${2}"
        local release="${url}/${package}"
	local temp_dir="${package//.tar.*/}"
        if [[ ! -s "${AUTO_CACHE_DIR}/${package}" ]];then
		curl -fsSLo "${AUTO_CACHE_DIR}/${package}" "${release}"
        fi
        rm -rf "${AUTO_CACHE_DIR:?}/${temp_dir}"
        mkdir -p "${AUTO_CACHE_DIR}/${temp_dir}"
        tar xf "${AUTO_CACHE_DIR}/${package}" --directory "${AUTO_CACHE_DIR}/${temp_dir}"
	export AUTO_EXTRACT_DIR="${AUTO_CACHE_DIR}/${temp_dir}"
}
