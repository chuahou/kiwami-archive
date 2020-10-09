# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

.PHONY: all build install clean

build:
	cd kiwami; \
		debuild -us -uc -b; \
		debuild -T clean

all: | build install

install:
	sudo apt-get install ./*.deb

clean:
	rm *.deb *.build *.buildinfo *.changes || true
