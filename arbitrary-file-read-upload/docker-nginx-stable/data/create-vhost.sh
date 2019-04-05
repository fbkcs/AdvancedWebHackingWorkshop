#!/usr/bin/env bash

set -e
set -u
set -o pipefail

VHOST_PATH="${1}"
VHOST_NAME="${2}"
VHOST_TLD="${3}"
VHOST_TPL="${4}"
CA_KEY="${5}"
CA_CRT="${6}"
GENERATE_SSL="${7}"
VERBOSE="${8:-}"

if [ "${GENERATE_SSL}" = "1" ]; then
	if [ ! -d "/etc/httpd/cert/mass" ]; then
		mkdir -p "/etc/httpd/cert/mass"
	fi
	_email="admin@${VHOST_NAME}${VHOST_TLD}"
	_domain="${VHOST_NAME}${VHOST_TLD}"
	_domains="*.${VHOST_NAME}${VHOST_TLD}"
	_out_key="/etc/httpd/cert/mass/${VHOST_NAME}${VHOST_TLD}.key"
	_out_csr="/etc/httpd/cert/mass/${VHOST_NAME}${VHOST_TLD}.csr"
	_out_crt="/etc/httpd/cert/mass/${VHOST_NAME}${VHOST_TLD}.crt"
	if ! cert-gen -v -c DE -s Berlin -l Berlin -o Devilbox -u Devilbox -n "${_domain}" -e "${_email}" -a "${_domains}" "${CA_KEY}" "${CA_CRT}" "${_out_key}" "${_out_csr}" "${_out_crt}"; then
		echo "[FAILED] Failed to add SSL certificate for ${VHOST_NAME}${VHOST_TLD}"
		exit 1
	fi
fi

cmd="vhost_gen.py -p \"${VHOST_PATH}\" -n \"${VHOST_NAME}\" -c /etc/vhost-gen/mass.yml -o \"${VHOST_TPL}\" -s ${VERBOSE} -m both"
if [ -n "${VERBOSE}" ]; then
	echo "\$ ${cmd}"
fi

if ! eval "${cmd}"; then
	echo "[FAILED] Failed to add vhost for ${VHOST_NAME}${VHOST_TLD}"
	exit 1
fi
