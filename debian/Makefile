# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

#####################
##### Functions #####
#####################

# Function for building package and cleaning up after
# First argument is package name, builds package in folder $(1) to file in
# $(BUILD_DIR)/$(1).deb
define build_pkg
./build_pkg.sh $(1) $(BUILD_DIR)
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

# List of packages to build
PKGS := kiwami-pkgs kiwami-scripts kiwami-mgr fonts-iosevka teams-apt-source

# Dummy targets
# Building dummy target involves building corresponding deb and installing it.
# .dummy file is created upon dpkg installation, so we do not install packages
# that are not outdated
DUMMY_TGT := $(PKGS:%=$(BUILD_DIR)/%.dummy)

# List of PPAs and its dummy target
PPA_LIST  := ppa.list
DUMMY_PPA := $(PPA_LIST:%=$(BUILD_DIR)/%.dummy)

#######################
##### Phony rules #####
#######################

.PHONY: all clean cleanaux

# Build all and install
all: | $(BUILD_DIR) $(DUMMY_PPA) $(DUMMY_TGT) ../prereq.deb

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

$(BUILD_DIR)/%.deb: %.meta
	grep -v '^\s*#' $< | sed '/^\s*$$/d' | \
		xargs quickdep $$(sed 's/\.meta$$//' <<< $<)
	mv $$(sed 's/\.meta$$//' <<< $<)*.deb $@

.PRECIOUS: $(BUILD_DIR)/%.deb

$(BUILD_DIR)/kiwami-scripts.deb: kiwami-scripts $(shell find kiwami-scripts -type f)
	$(call build_pkg,$<)
	$(call clean_aux)

$(BUILD_DIR)/kiwami-mgr.deb: kiwami-mgr $(shell find kiwami-mgr -type f)
	$(call build_pkg,$<)
	$(call clean_aux)

$(BUILD_DIR)/fonts-iosevka.deb: fonts-iosevka $(shell find fonts-iosevka -type f)
	$(call build_pkg,$<)
	$(call clean_aux)

$(BUILD_DIR)/teams-apt-source.deb: teams-apt-source $(shell find teams-apt-source -type f)
	$(call build_pkg,$<)
	$(call clean_aux)

../prereq.deb: $(BUILD_DIR)/kiwami-prereq.deb
	cp $< $@

$(BUILD_DIR)/teams-apt-source.dummy: $(BUILD_DIR)/teams-apt-source.deb
	sudo dpkg -i $< || sudo apt-get install -fy
	sudo apt-get update
	sudo apt-get install teams -y
	touch $@

###########################
##### Automated rules #####
###########################

%.dummy: %.deb
	sudo dpkg -i $< || sudo apt-get install -fy
	touch $@

$(BUILD_DIR):
	mkdir -p $@
