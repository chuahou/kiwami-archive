#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

check-root root || exit 1

apt-get purge nordvpn

APT_SOURCE_FILE=/etc/apt/sources.list.d/nordvpn.list
if [ -f $APT_SOURCE_FILE ]; then
	echo "Delete $APT_SOURCE_FILE? It has contents:"
	echo
	echo "====="
	cat $APT_SOURCE_FILE
	echo
	echo "====="
	echo
	read -p "(yn) " yn
	case $yn in
		[Yy]*) rm $APT_SOURCE_FILE ;;
		*) echo "Leaving $APT_SOURCE_FILE in place..." ;;
	esac
fi
apt-get update
