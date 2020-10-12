#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Removes haskell-language-server.

set -e

# where to install to
INSTALL_PATH=$HOME/.local/bin

# check not root
check-root user || exit

rm $INSTALL_PATH/haskell-language-server-*
