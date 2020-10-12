# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

#####################
##### Functions #####
#####################

# Function for building package and cleaning up after
define build_deb
debuild -us -uc -b && debuild -T clean
endef

# Function for cleaning auxiliary files
define clean_aux
rm *.build *.buildinfo *.changes || true
endef

#########################
##### Configuration #####
#########################

# We use bash features in some of our rules' loops
SHELL := bash

# Build directory
BUILD_DIR := build

# List of kiwami packages to build
KIWAMI_PKGS := kiwami-pkgs kiwami-ppa-pkgs kiwami-scripts
KIWAMI_PKGS_BUILD := $(KIWAMI_PKGS:%=$(BUILD_DIR)/%.deb)

# List of all packages including kiwami packages
ALL_PKGS := $(KIWAMI_PKGS) fonts-iosevka
ALL_PKGS_BUILD := $(ALL_PKGS:%=$(BUILD_DIR)/%.deb)

# Dummy targets
# Building dummy target involves building corresponding deb and installing it.
# .dummy file is created upon dpkg installation, so we do not install packages
# that are not outdated
DUMMY_TGT := $(ALL_PKGS_BUILD:%.deb=%.dummy)

# List of PPAs
PPA_LIST := ppa.list

# Dummy target for PPA addition
DUMMY_PPA := $(PPA_LIST:%=$(BUILD_DIR)/%.dummy)

#######################
##### Phony rules #####
#######################

.PHONY: all clean cleanaux

# Build all and install
all: | $(DUMMY_PPA) $(DUMMY_TGT)

# Clean up deb and auxiliary outputs
clean: cleanaux
	rm $(BUILD_DIR)/* || true

# Clean up auxiliary outputs
cleanaux:
	$(call clean_aux)

########################
##### Manual rules #####
########################

# Target to add PPAs listed in PPA_LIST
$(DUMMY_PPA): $(PPA_LIST)
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
	@touch $@

# Build kiwami packages
$(KIWAMI_PKGS_BUILD) &: kiwami $(shell find kiwami -type f)
	@echo "Building kiwami packages..."
	@rm $(KIWAMI_PKGS_BUILD) || true
	@cd $< && $(call build_deb)
	@mkdir -p $(BUILD_DIR)
	@for pkg in $(KIWAMI_PKGS_BUILD); do \
		mv `sed 's/$(BUILD_DIR)\/\(.*\)\.deb/\1\*\.deb/' <<< $$pkg` $$pkg; \
	done
	$(call clean_aux)

# Build Iosevka package
$(BUILD_DIR)/fonts-iosevka.deb: iosevka $(shell find iosevka -type f)
	@echo "Building Iosevka package..."
	@rm $@ || true
	@cd $< && $(call build_deb)
	@mkdir -p $(BUILD_DIR)
	@mv fonts-iosevka*.deb $@
	$(call clean_aux)

###########################
##### Automated rules #####
###########################

%.dummy: %.deb
	sudo dpkg -i $< || sudo apt-get install -fy
	touch $@
