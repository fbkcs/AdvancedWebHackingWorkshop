#!/usr/bin/env bash

set -e
set -u
set -o pipefail


###
### Run
###
run() {
	_cmd="${1}"

	_red="\033[0;31m"
	_green="\033[0;32m"
	_yellow="\033[0;33m"
	_reset="\033[0m"
	_user="$(whoami)"

	printf "${_yellow}[%s] ${_red}%s \$ ${_green}${_cmd}${_reset}\n" "$(hostname)" "${_user}"
	sh -c "LANG=C LC_ALL=C ${_cmd}"
}



###
### Get 15 character random word
###
function get_random_name() {
	local chr=(a b c d e f g h i j k l m o p q r s t u v w x y z)
	local len="${#chr[@]}"
	local name=

	for i in {1..15}; do
		rand="$( shuf -i 0-${len} -n 1 )"
		rand=$(( rand - 1 ))
		name="${name}${chr[$rand]}"
		i="${i}" # simply to get rid of shellcheck complaints
	done
	echo "${name}"
}
