#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

set -e
check-root root || exit 1

# install InstantRST
# https://github.com/gu-fan/InstantRst
pip3 install https://github.com/Rykka/instant-rst.py/archive/master.zip

# install vim-rst-tables
# https://github.com/ossobv/vim-rst-tables-py3
pip3 install vim_bridge3

# install Sphinx and read the docs theme
# install breathe for doxygen interface
pip3 install sphinx_rtd_theme breathe
