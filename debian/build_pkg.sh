#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Builds package in folder $1 to file $2/$1.deb

set -e

cd $1
debuild -us -uc -b
debuild -T clean

cd -
mv $1*.deb $2/$1.deb
