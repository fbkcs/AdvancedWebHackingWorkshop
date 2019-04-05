#!/usr/bin/env bash

set -e
set -u
set -o pipefail

###
### Globals
###

# Set via Dockerfile
# MY_USER
# MY_GROUP
# HTTPD_START
# HTTPD_RELOAD

# OpenSSL Certificate Authority file to generate
CA_KEY=/ca/devilbox-ca.key
CA_CRT=/ca/devilbox-ca.crt


# Path to scripts to source
CONFIG_DIR="/docker-entrypoint.d"
VHOST_GEN_DIR="/etc/vhost-gen/templates"
VHOST_GEN_CUST_DIR="/etc/vhost-gen.d"


# Wait this many seconds to start watcherd after httpd has been started
WATCHERD_STARTUP_DELAY="3"


###
### Source libs
###
init="$( find "${CONFIG_DIR}" -name '*.sh' -type f | sort -u )"
for f in ${init}; do
	# shellcheck disable=SC1090
	. "${f}"
done



#############################################################
## Basic Settings
#############################################################

###
### Set Debug level
###
DEBUG_LEVEL="$( env_get "DEBUG_ENTRYPOINT" "0" )"
log "info" "Debug level: ${DEBUG_LEVEL}" "${DEBUG_LEVEL}"

DEBUG_RUNTIME="$( env_get "DEBUG_RUNTIME" "0" )"
log "info" "Runtime debug: ${DEBUG_RUNTIME}" "${DEBUG_LEVEL}"


###
### Change uid/gid
###
set_uid "NEW_UID" "${MY_USER}"  "${DEBUG_LEVEL}"
set_gid "NEW_GID" "${MY_GROUP}" "${DEBUG_LEVEL}"


###
### Set timezone
###
set_timezone "TIMEZONE" "${DEBUG_LEVEL}"


###
### Nginx settings
###
set_worker_processess "WORKER_PROCESSES" "${DEBUG_LEVEL}"
set_worker_connections "WORKER_CONNECTIONS" "${DEBUG_LEVEL}"


#############################################################
## Variable exports
#############################################################

###
### Ensure Docker_LOGS is exported
###
export_docker_logs "DOCKER_LOGS" "${DEBUG_LEVEL}"


###
### Ensure PHP-FPM variables are exported
###
export_php_fpm_enable "PHP_FPM_ENABLE" "${DEBUG_LEVEL}"
export_php_fpm_server_addr "PHP_FPM_SERVER_ADDR" "${DEBUG_LEVEL}"
export_php_fpm_server_port "PHP_FPM_SERVER_PORT" "${DEBUG_LEVEL}"
export_php_fpm_timeout "PHP_FPM_TIMEOUT" "${DEBUG_LEVEL}"


###
### Ensure MAIN_VHOST variables are exported
###
export_main_vhost_enable "MAIN_VHOST_ENABLE" "${DEBUG_LEVEL}"
export_main_vhost_ssl_type "MAIN_VHOST_SSL_TYPE" "${DEBUG_LEVEL}"
export_main_vhost_ssl_gen "MAIN_VHOST_SSL_GEN" "${DEBUG_LEVEL}"
export_main_vhost_ssl_cn "MAIN_VHOST_SSL_CN" "${DEBUG_LEVEL}"
export_main_vhost_docroot "MAIN_VHOST_DOCROOT" "${DEBUG_LEVEL}"
export_main_vhost_tpl "MAIN_VHOST_TPL" "${DEBUG_LEVEL}"
export_main_vhost_status_enable "MAIN_VHOST_STATUS_ENABLE" "${DEBUG_LEVEL}"
export_main_vhost_status_alias "MAIN_VHOST_STATUS_ALIAS" "${DEBUG_LEVEL}"


###
### Ensure MASS_VHOST variables are exported
###
export_mass_vhost_enable "MASS_VHOST_ENABLE" "${DEBUG_LEVEL}"
export_mass_vhost_ssl_type "MASS_VHOST_SSL_TYPE" "${DEBUG_LEVEL}"
export_mass_vhost_ssl_gen "MASS_VHOST_SSL_GEN" "${DEBUG_LEVEL}"
export_mass_vhost_tld "MASS_VHOST_TLD" "${DEBUG_LEVEL}"
export_mass_vhost_docroot "MASS_VHOST_DOCROOT" "${DEBUG_LEVEL}"
export_mass_vhost_tpl "MASS_VHOST_TPL" "${DEBUG_LEVEL}"


###
### Default and/or mass vhost must be enabled (at least one of them)
###
if [ "${MAIN_VHOST_ENABLE}" -eq "0" ] && [ "${MASS_VHOST_ENABLE}" -eq "0" ]; then
	log "err" "Default vhost and mass vhosts are disabled." "${DEBUG_LEVEL}"
	exit 1
fi



#############################################################
## vhost-gen Configuration
#############################################################

###
### Copy custom vhost-gen template
###
vhost_gen_copy_custom_template "${VHOST_GEN_CUST_DIR}" "${VHOST_GEN_DIR}" "nginx.yml" "${DEBUG_LEVEL}"


###
### Enable and configure PHP-FPM
###
vhost_gen_php_fpm "${PHP_FPM_ENABLE}" "${PHP_FPM_SERVER_ADDR}" "${PHP_FPM_SERVER_PORT}" "${PHP_FPM_TIMEOUT}" "/etc/vhost-gen/main.yml" "${DEBUG_LEVEL}"
vhost_gen_php_fpm "${PHP_FPM_ENABLE}" "${PHP_FPM_SERVER_ADDR}" "${PHP_FPM_SERVER_PORT}" "${PHP_FPM_TIMEOUT}" "/etc/vhost-gen/mass.yml" "${DEBUG_LEVEL}"


###
### Configure Docker logs
###
vhost_gen_docker_logs "${DOCKER_LOGS}" "/etc/vhost-gen/main.yml" "${DEBUG_LEVEL}"
vhost_gen_docker_logs "${DOCKER_LOGS}" "/etc/vhost-gen/mass.yml" "${DEBUG_LEVEL}"


###
### Main vhost settings
###
vhost_gen_main_vhost_httpd_status \
	"${MAIN_VHOST_STATUS_ENABLE}" \
	"${MAIN_VHOST_STATUS_ALIAS}" \
	"/etc/vhost-gen/main.yml" \
	"${DEBUG_LEVEL}"

vhost_gen_generate_main_vhost \
	"${MAIN_VHOST_ENABLE}" \
	"/var/www/default/${MAIN_VHOST_DOCROOT}" \
	"/etc/vhost-gen/main.yml" \
	"/var/www/default/${MAIN_VHOST_TPL}" \
	"${MAIN_VHOST_SSL_TYPE}" \
	"${DEBUG_RUNTIME}" \
	"${DEBUG_LEVEL}"


###
### Mass vhost settings
###
vhost_gen_mass_vhost_docroot \
	"${MASS_VHOST_ENABLE}" \
	"${MASS_VHOST_DOCROOT}" \
	"/etc/vhost-gen/mass.yml" \
	"${DEBUG_LEVEL}"

vhost_gen_mass_vhost_tld \
	"${MASS_VHOST_ENABLE}" \
	"${MASS_VHOST_TLD}" \
	"/etc/vhost-gen/mass.yml" \
	"${DEBUG_LEVEL}"



################################################################################
# cert-getn Configuration
################################################################################

###
### Create Certificate Signing request
###
cert_gen_generate_ca "${CA_KEY}" "${CA_CRT}" "${DEBUG_RUNTIME}" "${DEBUG_LEVEL}"


###
### Generate main vhost ssl certificate
###
cert_gen_generate_cert \
	"${MAIN_VHOST_ENABLE}" \
	"${MAIN_VHOST_SSL_TYPE}" \
	"${CA_KEY}" \
	"${CA_CRT}" \
	"/etc/httpd/cert/main/localhost.key" \
	"/etc/httpd/cert/main/localhost.csr" \
	"/etc/httpd/cert/main/localhost.crt" \
	"${MAIN_VHOST_SSL_CN}" \
	"${DEBUG_RUNTIME}" \
	"${DEBUG_LEVEL}"



################################################################################
# Fix directory permissions
################################################################################

fix_perm "NEW_UID" "NEW_GID" "/ca" "1" "${DEBUG_LEVEL}"



################################################################################
# RUN
################################################################################

###
### Supervisor or plain
###
if [ "${MASS_VHOST_ENABLE}" -eq "1" ]; then

	verbose=""
	if [ "${DEBUG_RUNTIME}" -gt "0" ]; then
		verbose="-v"
	fi

	# Create watcherd sub commands
	watcherd_add="create-vhost.sh '%%p' '%%n' '${MASS_VHOST_TLD}' '%%p/${MASS_VHOST_TPL}/' '${CA_KEY}' '${CA_CRT}' '1' '${verbose}'"
	watcherd_del="rm /etc/httpd/vhost.d/%%n.conf"
	watcherd_tri="${HTTPD_RELOAD}"

	supervisord_create \
		"${HTTPD_START}" \
		"bash -c 'sleep ${WATCHERD_STARTUP_DELAY} && exec watcherd -v -p /shared/httpd -a \"${watcherd_add}\" -d \"${watcherd_del}\" -t \"${watcherd_tri}\"'" \
		"/etc/supervisord.conf"

	log "info" "Starting supervisord: $(supervisord -v)" "${DEBUG_LEVEL}"
	exec /usr/bin/supervisord -c /etc/supervisord.conf
else
	log "info" "Starting webserver" "${DEBUG_LEVEL}"
	exec ${HTTPD_START}
fi

$(chown -R www-data /var/www/default/htdocs)
