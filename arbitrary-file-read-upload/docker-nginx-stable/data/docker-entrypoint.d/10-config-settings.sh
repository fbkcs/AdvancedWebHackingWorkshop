#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################

###
### Change worker_processes
###
set_worker_processess() {
	local wp_varname="${1}"
	local debug="${2}"
	local default="auto"
	local config="/etc/nginx/nginx.conf"

	if ! env_set "${wp_varname}"; then
		log "info" "\$${wp_varname} not set. Keeping default worker_processes: '${default}'." "${debug}"
		run "sed -i'' 's/__WORKER_PROCESSES__/${default}/g' ${config}" "${debug}"
	else
		wp="$( env_get "${wp_varname}" )"

		if [ "${wp}" = "auto" ]; then
			log "info" "\$${wp_varname} set to its default value: '${default}'." "${debug}"
			run "sed -i'' 's/__WORKER_PROCESSES__/${default}/g' ${config}" "${debug}"
		else
			if ! isint "${wp}"; then
				log "err" "\$${wp_varname} is not an integer: '${wp}'" "${debug}"
				exit 1
			else
				log "info" "Setting worker_processes to: ${wp}" "${debug}"
				run "sed -i'' 's/__WORKER_PROCESSES__/${wp}/g' ${config}" "${debug}"
			fi
		fi
	fi
}


###
### Change worker_connections
###
set_worker_connections() {
	local wc_varname="${1}"
	local debug="${2}"
	local default="1024"
	local config="/etc/nginx/nginx.conf"

	if ! env_set "${wc_varname}"; then
		log "info" "\$${wc_varname} not set. Keeping default worker_connections: '${default}'." "${debug}"
		run "sed -i'' 's/__WORKER_CONNECTIONS__/${default}/g' ${config}" "${debug}"
	else
		wc="$( env_get "${wc_varname}" )"

		if ! isint "${wc}"; then
			log "err" "\$${wc_varname} is not an integer: '${wc}'" "${debug}"
			exit 1
		else
			log "info" "Setting worker_connections to: ${wc}" "${debug}"
			run "sed -i'' 's/__WORKER_CONNECTIONS__/${wc}/g' ${config}" "${debug}"
		fi
	fi
}
