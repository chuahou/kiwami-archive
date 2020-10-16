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

# install prerequisite package
# this depends on, and will trigger the install of, the dependencies needed to
# build everything else
sudo apt-get install ./prereq.deb -y

# install quickdeps used for kiwami metapackages
QUICKDEP_URL=https://github.com/chuahou/quickdep/releases/download
QUICKDEP_URL=$QUICKDEP_URL/0.1.1.0/quickdep_0.1.1.0_amd64.deb
wget -c $QUICKDEP_URL
sudo apt-get install ./$(basename $QUICKDEP_URL)

# install kiwami debian packages
make -C debian

# install kiwami-mgr packages
kiwami-mgr init

# install snaps
snap install spotify
snap install --classic heroku

# rcup rcfiles
cp rcfiles/rcrc $HOME/.rcrc
rcup -i
