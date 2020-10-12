#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

check-root root || exit 1

apt-get purge nordvpn-release nordvpn
