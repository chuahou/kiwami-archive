# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

SHELL := bash

# Function for building package and cleaning up after
define build_deb
debuild -us -uc -b && debuild -T clean
endef

# Function for cleaning auxiliary files
define clean_aux
rm *.build *.buildinfo *.changes || true
endef

# List of kiwami packages to build
KIWAMI_PKGS := \
	kiwami-all.deb \
	kiwami-pkgs.deb \
	kiwami-ppa-pkgs.deb \
	kiwami-scripts.deb

pkgs: kiwami-pkgs.deb kiwami-ppa-pkgs.deb
	sudo dpkg -i $^ || sudo apt-get install -fy
	$(call clean_aux)

# Build all and install
all: $(KIWAMI_PKGS) fonts-iosevka.deb
	sudo dpkg -i $^ || sudo apt-get install -fy
	$(call clean_aux)

# Build kiwami packages
$(KIWAMI_PKGS) &: kiwami $(shell find kiwami -type f)
	@echo "Building kiwami packages..."
	@rm $(KIWAMI_PKGS) || true
	@cd $< && $(call build_deb)
	@for pkg in $(KIWAMI_PKGS); do \
		mv `sed 's/\.deb/*\.deb/' <<< $$pkg` $$pkg; \
	done

# Build Iosevka package
fonts-iosevka.deb: iosevka $(shell find iosevka -type f)
	@echo "Building Iosevka package..."
	@rm $@ || true
	@cd $< && $(call build_deb)
	@mv fonts-iosevka*.deb $@

# Target to add PPAs listed in ppa.list
ppas: ppa.list
	@echo "Adding PPAs listed in $<..."
	@while read ppa; do \
		grep -h "^deb.*$$ppa" /etc/apt/sources.list.d/* > /dev/null 2>&1; \
		if [ $$? -ne 0 ]; then \
			echo "Adding ppa:$$ppa"; \
			sudo add-apt-repository -y "ppa:$$ppa"; \
		else \
			echo "ppa:$$ppa already added"; \
		fi; \
	done < $<
	@echo

# Clean up deb and auxiliary outputs
clean: cleanaux
	rm *.deb || true

# Clean up auxiliary outputs
cleanaux:
	$(call clean_aux)

.PHONY: all clean cleanaux ppas pkgs
