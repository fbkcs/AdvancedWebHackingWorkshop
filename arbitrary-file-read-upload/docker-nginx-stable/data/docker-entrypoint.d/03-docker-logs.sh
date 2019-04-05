#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################

###
### Set docker logs
###
export_docker_logs() {
	local varname="${1}"
	local debug="${2}"
	local value="0"

	if ! env_set "${varname}"; then
		log "info" "\$${varname} not set. Logging errors and access to log files inside container." "${debug}"
	else
		value="$( env_get "${varname}" )"
		if [ "${value}" = "0" ]; then
			log "info" "\$${varname} disabled. Logging errors and access to log files inside container." "${debug}"
		elif [ "${value}" = "1" ]; then
			log "info" "\$${varname} enabled. Logging errors and access to Docker log (stderr and stdout)" "${debug}"
		else
			log "err" "Invalid value for \$${varname}: ${value}"
			log "err" "Must be '1' (for On) or '0' (for Off)"
			exit 1
		fi
	fi

	# Set docker logs variable
	eval "export ${varname}=${value}"
}
