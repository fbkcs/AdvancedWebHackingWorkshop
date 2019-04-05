#!/usr/bin/env bash

set -e
set -u
set -o pipefail


############################################################
# Functions
############################################################

###
### Ensure MASS_VHOST_ENABLE is exported
###
export_mass_vhost_enable() {
	local varname="${1}"
	local debug="${2}"
	local value="0"

	if ! env_set "${varname}"; then
		log "info" "\$${varname} not set. Enabling default vhost." "${debug}"
	else
		value="$( env_get "${varname}" )"
		if [ "${value}" = "0" ]; then
			log "info" "Mass vhost: Disabled" "${debug}"
		elif [ "${value}" = "1" ]; then
			log "info" "Mass vhost: Enabled" "${debug}"
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
### Ensure MASS_VHOST_SSL_TYPE is set (if needed)
###
export_mass_vhost_ssl_type() {
	local varname="${1}"
	local debug="${2}"
	local value="plain"

	if [ "${MASS_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, defaulting to: plain" "${debug}"
		else
			value="$( env_get "${varname}" )"
			if [ "${value}" = "plain" ]; then
				log "info" "Mass vhost: Setting SSL type to: http only" "${debug}"
			elif [ "${value}" = "ssl" ]; then
				log "info" "Mass vhost: Setting SSL type to: https only" "${debug}"
			elif [ "${value}" = "both" ]; then
				log "info" "Mass vhost: Setting SSL type to: http and https" "${debug}"
			elif [ "${value}" = "redir" ]; then
				log "info" "Mass vhost: Setting SSL type to: redirect http to https" "${debug}"
			else
				log "err" "Invalid value for \$${varname}: '${value}'. Allowed: plain, ssl, both or redir" "${debug}"
				exit 1
			fi
		fi
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}


###
### Ensure MASS_VHOST_SSL_GEN is set (if needed)
###
export_mass_vhost_ssl_gen() {
	local varname="${1}"
	local debug="${2}"
	local value="0"

	if [ "${MASS_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified, defaulting to not generate SSL certificates" "${debug}"
		else
			value="$( env_get "${varname}" )"
			if [ "${value}" = "0" ]; then
				log "info" "Mass vhost: Disable automatic generation of SSL certificates" "${debug}"
			elif [ "${value}" = "1" ]; then
				log "info" "Mass vhost: Enable automatic generation of SSL certificates" "${debug}"
			else
				log "err" "Invalid value for \$${varname}: '${value}'. Allowed: 0 or 1" "${debug}"
				exit 1
			fi
		fi
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}


###
### Ensure MASS_VHOST_TLD is set (if needed)
###
export_mass_vhost_tld() {
	local varname="${1}"
	local debug="${2}"
	local value="loc"

	if [ "${MASS_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			log "info" "Mass vhost: changing tld to: ${value}" "${debug}"
		fi
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}


###
### Ensure MASS_VHOST_DOCROOT is set (if needed)
###
export_mass_vhost_docroot() {
	local varname="${1}"
	local debug="${2}"
	local value="htdocs"

	if [ "${MASS_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			log "info" "Mass vhost: changing document root to: ${value}" "${debug}"
		fi
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}


###
### Ensure MASS_VHOST_TPL is set (if needed)
###
export_mass_vhost_tpl() {
	local varname="${1}"
	local debug="${2}"
	local value="cfg"

	if [ "${MASS_VHOST_ENABLE}" = "1" ]; then
		if ! env_set "${varname}"; then
			log "info" "\$${varname} not specified. Keeping default: ${value}" "${debug}"
		else
			value="$( env_get "${varname}" )"
			log "info" "Mass vhost: changing template dir to: ${value}" "${debug}"
		fi
	fi

	# Ensure variable is exported
	eval "export ${varname}=${value}"
}
