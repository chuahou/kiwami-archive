#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Installs everything for the first time.

set -e

# check invoked from kiwami directory
[ $(dirname $0) = "." ]

# log files
readonly LOG_FILE="./init.log"
readonly ERR_FILE="./init.err"
touch $LOG_FILE
touch $ERR_FILE
exec 1> >(tee -a "$LOG_FILE")
exec 2> >(tee -a "$ERR_FILE")

# use Windows clock system
timedatectl set-local-rtc 1 --adjust-system-clock

# add self to video group to control backlight
sudo usermod -a -G video $USER

# update and upgrade apt packages
if [ ! -f init.stage.apt ]; then
	sudo apt-get update
	sudo apt-get upgrade -y
	touch init.stage.apt
fi

# install prerequisite package and prebuild packages
# this depends on, and will trigger the install of, the dependencies needed to
# build everything else
if [ ! -f init.stage.prereq ]; then
	sudo apt-get install ./binaries/*.deb -y
	touch init.stage.prereq
fi

# install kiwami debian packages
make -C debian

# install kiwami-mgr packages
if [ ! -f init.stage.kiwami-mgr ]; then
	kiwami-mgr init
	touch init.stage.kiwami-mgr
fi

# install snaps
if [ ! -f init.stage.snaps ]; then
	snap install spotify
	snap install --classic heroku
	touch init.stage.snaps
fi

# rcup rcfiles
if [ ! -f init.stage.rcm ]; then
	cp rcfiles/rcrc $HOME/.rcrc
	rcup -i
	touch init.stage.rcm
fi

# rename userdirs
del_userdir () {
	if [ -d $1 ]; then
		read -p "Remove directory $1? [yn] " yn
		case $yn in
			[Yy]) rm -rf $1 ;;
			*) echo "Skipping $1" ;;
		esac
	fi
}
if [ ! -f init.stage.userdirs ]; then
	for i in Desktop Downloads Templates Public Documents Music Pictures Videos
	do
		del_userdir $HOME/$i
	done
	mkdir -p $(sed -n 's/^.*="$HOME\/\(.*\)"$/\1/p' ~/.config/user-dirs.dirs \
		| uniq | xargs printf "$HOME/%s ")
	touch init.stage.userdirs
fi

# delete stage files
rm init.stage.*
