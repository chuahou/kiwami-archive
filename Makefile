# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

.PHONY: all build install clean

all: build

build:
	cd kiwami; \
		debuild -us -uc -b; \
		debuild -T clean

install: build
	sudo apt-get install *.deb

clean:
	rm *.deb *.build *.buildinfo *.changes
