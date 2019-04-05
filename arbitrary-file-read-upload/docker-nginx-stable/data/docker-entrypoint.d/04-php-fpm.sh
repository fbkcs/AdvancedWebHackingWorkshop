#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################

###
### Ensure PHP_FPM_ENABLE is set
###
export_php_fpm_enable() {
	local varname="${1}"
	local debug="${2}"
	local value="0"

	if ! env_set "${varname}"; then
		log "info" "\$${varname} not set. Disabling PHP-FPM." "${debug}"
	else
		value="$( env_get "${varname}" )"
		if [ "${value}" = "0" ]; then
			log "info" "PHP-FPM: Disabled" "${debug}"
		elif [ "${value}" = "1" ]; then
			log "info" "PHP-FPM: Enabled" "${debug}"
		else
			log "err" "Invalid value for \$${varname}: ${value}"
			log "err" "Must be '1' (for On) or '0' (for Off)"
			exit 1
		fi
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}


###
### Ensure PHP_FPM_SERVER_ADDR is set (if needed)
###
export_php_fpm_server_addr() {
	local varname="${1}"
	local debug="${2}"
	local value=

	if [ "${PHP_FPM_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "err" "PHP-FPM is enabled, but \$${varname} not specified, but required." "${debug}"
			exit 1
		fi
		value="$( env_get "${varname}" )"
		if [ -z "${value}" ]; then
			log "err" "PHP-FPM enabled, but \$${varname} is empty." "${debug}"
			exit 1
		fi
		log "info" "PHP-FPM: Server address: ${value}" "${debug}"
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}


###
### Ensure PHP_FPM_SERVER_PORT is set (if needed)
###
export_php_fpm_server_port() {
	local varname="${1}"
	local debug="${2}"
	local value="9000"

	if [ "${PHP_FPM_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"

			if [ -z "${value}" ]; then
				log "err" "\$${varname} is empty." "${debug}"
				exit 1
			fi
			if ! isint "${value}"; then
				log "err" "\$${varname} is not a valid integer: ${value}" "${debug}"
				exit 1
			fi
			if [ "${value}" -lt "1" ] || [ "${value}" -gt "65535" ]; then
				log "err" "\$${varname} is not in a valid port range: ${value}" "${debug}"
				exit 1
			fi
			log "info" "PHP-FPM: Server port: ${value}" "${debug}"
		fi
	fi

	# Ensure variable is exported if not set
	eval "export ${varname}=${value}"
}


###
### Ensure PHP_FPM_TIMEOUT is set (if needed)
###
export_php_fpm_timeout() {
	local varname="${1}"
	local debug="${2}"
	local value="180"

	if [ "${PHP_FPM_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"

			if [ -z "${value}" ]; then
				log "err" "\$${varname} is empty." "${debug}"
				exit 1
			fi
			if ! isint "${value}"; then
				log "err" "\$${varname} is not a valid integer: ${value}" "${debug}"
				exit 1
			fi
			if [ "${value}" -lt "0" ]; then
				log "err" "\$${varname} must be greater than 0: ${value}" "${debug}"
				exit 1
			fi
			log "info" "PHP-FPM: Timeout: ${value}" "${debug}"
		fi
	fi

	# Ensure variable is exported if not set
	eval "export ${varname}=${value}"
}
