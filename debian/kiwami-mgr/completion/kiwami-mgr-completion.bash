#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

SCRIPT_LOCATION=/usr/lib/kiwami-mgr

_kiwami_mgr_complete() {
	local curword commands packages
	curword="${COMP_WORDS[COMP_CWORD]}"
	commands="install uninstall"
	packages=$(ls $SCRIPT_LOCATION)

	COMPREPLY=()
	case $COMP_CWORD in
		1) COMPREPLY=( $(compgen -W "$commands" -- $curword) ) ;;
		2) COMPREPLY=( $(compgen -W "$packages" -- $curword) ) ;;
	esac
}

complete -F _kiwami_mgr_complete kiwami-mgr
