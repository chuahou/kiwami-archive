# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

.PHONY: all build install clean ppas

# list of PPAs to add
define PPAS
kgilmer/speed-ricer
endef
export PPAS

# build packages and clean up
build:
	cd kiwami; \
		debuild -us -uc -b; \
		debuild -T clean

# build then install
all: | build install

# install build packages (manually call build before)
install: ppas
	sudo apt-get install ./*.deb

# clean up all built packages and auxiliary files
clean:
	rm *.deb *.build *.buildinfo *.changes || true

# add PPAs defined in $PPAS
ppas:
	for ppa in $$PPAS; do \
		grep -h "^deb.*$$ppa" /etc/apt/sources.list.d/* > /dev/null 2>&1; \
		if [ $$? -ne 0 ]; then \
			sudo add-apt-repository -y ppa:$$ppa; \
		fi; \
	done
