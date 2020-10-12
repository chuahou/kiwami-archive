#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Downloads and installs binaries for haskell-language-server.

set -e

# haskell-language-server version to use
HLS_VER=0.5.0

# where to install to
INSTALL_PATH=$HOME/.local/bin

# URL of haskell-language-server releases
HLS_RELEASES=https://github.com/haskell/haskell-language-server
HLS_RELEASES=$HLS_RELEASES/releases/download/$HLS_VER

# downloads and unzips $1.gz from URL $2/$1.gz to $3
download() {
	DL_NAME=$1
	DL_URL_ROOT=$2
	TARGET=$3

	wget -c $DL_URL_ROOT/$DL_NAME.gz
	gzip -d $DL_NAME.gz
	mv $DL_NAME $TARGET
	chmod +x $TARGET
}

# checks if $3 exists; if not, or if user chooses to overwrite, download and
# unzip $1.gz from URL $2/$1.gz
check_install_and_download() {
	DL_NAME=$1
	DL_URL_ROOT=$2
	TARGET=$3

	if [[ -f $TARGET ]]; then
		read -p "$TARGET found... Overwrite? (yn) " yn
		case $yn in
			[Yy]*) download $DL_NAME $DL_URL_ROOT $TARGET;;
			*) echo "Skipping $TARGET." ;;
		esac
	else
		download $DL_NAME $DL_URL_ROOT $TARGET
	fi
}

# check not root
check-root user || exit

# install system GHC version if no arguments given
DEFAULT_GHC_VER=$(ghc --version | rev | cut -d ' ' -f 1 | rev)
if [[ "$#" -eq 0 ]]; then
	GHC_VER=$DEFAULT_GHC_VER
elif [[ "$#" -eq 1 ]]; then
	GHC_VER=$1
else
	echo "Expected 1 argument: GHC version. For example, run"
	echo "	\$ $0 $DEFAULT_GHC_VER"
	echo "to install haskell-language-server for GHC $DEFAULT_GHC_VER."
fi

# download
check_install_and_download haskell-language-server-wrapper-Linux \
	$HLS_RELEASES $INSTALL_PATH/haskell-language-server-wrapper
check_install_and_download haskell-language-server-Linux-$GHC_VER \
	$HLS_RELEASES $INSTALL_PATH/haskell-language-server-$GHC_VER
