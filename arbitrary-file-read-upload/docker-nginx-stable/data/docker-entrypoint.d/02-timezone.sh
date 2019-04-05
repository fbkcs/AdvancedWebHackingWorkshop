#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################

###
### Change Timezone
###
set_timezone() {
	local env_varname="${1}"
	local debug="${2}"
	local timezone=

	if ! env_set "${env_varname}"; then
		log "info" "\$${env_varname} not set." "${debug}"
		# Unix Time
		log "info" "Setting container timezone to: UTC" "${debug}"
		run "ln -sf /usr/share/zoneinfo/UTC /etc/localtime" "${debug}"
	else
		timezone="$( env_get "${env_varname}" )"
		if [ -f "/usr/share/zoneinfo/${timezone}" ]; then
			# Unix Time
			log "info" "Setting container timezone to: ${timezone}" "${debug}"
			run "ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime" "${debug}"
		else
			log "err" "Invalid timezone for \$${env_varname}." "${debug}"
			log "err" "Timezone '${timezone}' does not exist." "${debug}"
			exit 1
		fi
	fi
	log "info" "Docker date set to: $(date)" "${debug}"
}
