#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################

###
### Ensure MAIN_VHOST_ENABLE is exported
###
export_main_vhost_enable() {
	local varname="${1}"
	local debug="${2}"
	local value="1"

	if ! env_set "${varname}"; then
		log "info" "\$${varname} not set. Enabling default vhost." "${debug}"
	else
		value="$( env_get "${varname}" )"
		if [ "${value}" = "0" ]; then
			log "info" "Main vhost: Disabled" "${debug}"
		elif [ "${value}" = "1" ]; then
			log "info" "Main vhost: Enabled" "${debug}"
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
### Ensure MAIN_VHOST_SSL_TYPE is set (if needed)
###
export_main_vhost_ssl_type() {
	local varname="${1}"
	local debug="${2}"
	local value="plain"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, defaulting to: plain" "${debug}"
		else
			value="$( env_get "${varname}" )"
			if [ "${value}" = "plain" ]; then
				log "info" "Main vhost: Setting SSL type to: http only" "${debug}"
			elif [ "${value}" = "ssl" ]; then
				log "info" "Main vhost: Setting SSL type to: https only" "${debug}"
			elif [ "${value}" = "both" ]; then
				log "info" "Main vhost: Setting SSL type to: http and https" "${debug}"
			elif [ "${value}" = "redir" ]; then
				log "info" "Main vhost: Setting SSL type to: redirect http to https" "${debug}"
			else
				log "err" "Invalid value for \$${varname}: '${value}'. Allowed: plain, ssl, both or redir" "${debug}"
				exit 1
			fi
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}


###
### Ensure MAIN_VHOST_SSL_GEN is set (if needed)
###
export_main_vhost_ssl_gen() {
	local varname="${1}"
	local debug="${2}"
	local value="0"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, defaulting to not generate SSL certificates" "${debug}"
		else
			value="$( env_get "${varname}" )"
			if [ "${value}" = "0" ]; then
				log "info" "Main vhost: Disable automatic generation of SSL certificates" "${debug}"
			elif [ "${value}" = "1" ]; then
				log "info" "Main vhost: Enable automatic generation of SSL certificates" "${debug}"
			else
				log "err" "Invalid value for \$${varname}: '${value}'. Allowed: 0 or 1" "${debug}"
				exit 1
			fi
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}


###
### Ensure MAIN_VHOST_SSL_CN is set (if needed)
###
export_main_vhost_ssl_cn() {
	local varname="${1}"
	local debug="${2}"
	local value="localhost"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			if [ -z "${value}" ]; then
				log "err" "\$${varname} set but empty. Cannot determine CN name for SSL certificate generation." "${debug}"
				exit 1
			else
				log "info" "Main vhost: SSL CN: ${value}" "${debug}"
			fi
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}


###
### Ensure MAIN_VHOST_DOCROOT is set (if needed)
###
export_main_vhost_docroot() {
	local varname="${1}"
	local debug="${2}"
	local value="htdocs"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			log "info" "Main vhost: changing document root to: ${value}" "${debug}"
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}


###
### Ensure MAIN_VHOST_TPL is set (if needed)
###
export_main_vhost_tpl() {
	local varname="${1}"
	local debug="${2}"
	local value="cfg"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			log "info" "Main vhost: changing template dir to: ${value}" "${debug}"
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}


###
### Ensure MAIN_VHOST_STATUS_ENABLE is set (if needed)
###
export_main_vhost_status_enable() {
	local varname="${1}"
	local debug="${2}"
	local value="0"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, defaulting to disable httpd status page" "${debug}"
		else
			value="$( env_get "${varname}" )"
			if [ "${value}" = "0" ]; then
				log "info" "Main vhost: Disabling httpd status page" "${debug}"
			elif [ "${value}" = "1" ]; then
				log "info" "Main vhost: Enabling httpd status page" "${debug}"
			else
				log "err" "Invalid value for \$${varname}: '${value}'. Allowed: 0 or 1" "${debug}"
				exit 1
			fi
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}


###
### Ensure MAIN_VHOST_STATUS_ALIAS is set (if needed)
###
export_main_vhost_status_alias() {
	local varname="${1}"
	local debug="${2}"
	local value="/httpd-status"

	if [ "${MAIN_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			log "info" "Main vhost: Changing status page alias to: ${value}" "${debug}"
		fi
		# Ensure variable is exported
		eval "export ${varname}=${value}"
	fi
}
