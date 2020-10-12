#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Installs Haskell stack and tool packages.

set -e
check-root user || exit 1

command -v stack || curl -sSL https://get.haskellstack.org/ | sh
stack install hlint ghcid stylish-haskell -v -j4
