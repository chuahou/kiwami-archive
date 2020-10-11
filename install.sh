#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Builds and installs all packages.

set -e

# Directory script is located in
SCRIPTDIR=$(realpath $(dirname $0))

# Adds all PPAs listed in PPALIST
add_ppas()
{
	while read ppa; do
		# Check if already added
		grep -h "^deb.*$ppa" /etc/apt/sources.list.d/* > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			# Not yet added, add now
			echo "Adding PPA $ppa"
			sudo add-apt-repository -y "ppa:$ppa"
		else
			# Already added
			echo "PPA $ppa already added"
		fi
	done < "$SCRIPTDIR/ppa.list"
}

# Builds Debian packages in pwd
build()
{
	debuild -us -uc -b
	debuild -T clean # clean up after
}

# Installs all built packages
install_all()
{
	sudo apt-get install $SCRIPTDIR/*.deb -y
}

# Cleans all built packages
clean_all()
{
	rm \
		$SCRIPTDIR/*.deb       \
		$SCRIPTDIR/*.build     \
		$SCRIPTDIR/*.buildinfo \
		$SCRIPTDIR/*.changes || true
}

add_ppas

cd "$SCRIPTDIR/kiwami"
build

cd "$SCRIPTDIR"
install_all
clean_all
