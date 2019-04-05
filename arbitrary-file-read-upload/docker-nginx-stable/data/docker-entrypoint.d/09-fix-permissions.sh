#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################


###
### Change UID
###
fix_perm() {
	local uid_varname="${1}"
	local gid_varname="${2}"
	local directory="${3}"
	local recursive="${4}"
	local debug="${5}"

	local perm=

	# Get uid
	if env_set "${uid_varname}"; then
		perm="$( env_get "${uid_varname}" )"
	fi

	# Get gid
	if env_set "${gid_varname}"; then
		perm="${perm}:$( env_get "${gid_varname}" )"
	fi

	if [ -n "${perm}" ]; then
		if [ "${recursive}" = "1" ]; then
			run "chown -R ${perm} ${directory}" "${debug}"
		else
			run "chown ${perm} ${directory}" "${debug}"
		fi
	fi
}
