#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

set -e
check-root root || exit 1

apt-get purge ttf-mscorefonts-installer
