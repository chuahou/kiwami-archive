#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

check-root root || exit 1

wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
dpkg -i nordvpn-release_1.0.0_all.deb
rm nordvpn-release_1.0.0_all.deb
apt-get update
apt-get install nordvpn -y
