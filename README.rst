The updated repository can be found at `chuahou/kiwami
<https://github.com/chuahou/kiwami>`_. This is an archived version prior
to a large (destructive) rebase, that removed all traces (hopefully) of
Iosevka binaries from the repository.

######
kiwami
######

|forthebadge|

A personal utility repository for (more or less) reproducible setups on
Pop!_OS systems. Current version for Pop!_OS 20.04.

Contents
========

* `debian <debian>`_: a series of debian packages with tools /
  dependencies, that when installed, sets up the system I need.

  * `kiwami-mgr <debian/kiwami-mgr>`_: a personal installation manager
    that offers the ``kiwami-mgr`` binary, installing / uninstalling
    some software not in standard apt sources
  * `kiwami-pkgs <debian/kiwami-pkgs>`_: a metapackage that depends on
    apt packages I want installed
  * `kiwami-scripts <debian/kiwami-scripts>`_: a collection of useful
    scripts
  * `teams-apt-source <debian/teams-apt-source>`_: a package containing
    the apt source and GPG key for Microsoft Teams, as I was unhappy
    with the default package not cleanly uninstalling
  * `xinit-xsession <debian/xinit-xsession>`_: a simple package
    containing a script and desktop file to run ``$HOME/.xinitrc`` from
    a display manager

* `other <other>`_: miscellanous files

* rcfiles: see `rcfiles repo <https://github.com/chuahou/rcfiles>`_

* `zsh-vim-mode <zsh-vim-mode>`_: `this plugin
  <https://github.com/softmoth/zsh-vim-mode>`_ as a submodule for easy
  installation using symlinks in `rcfiles <rcfiles>`_

* `binaries <binaries>`_: prebuilt binary packages. ``predep.deb`` must
  be installed before we can build the debian folder, and the others are
  binaries from other projects

* `init.sh <init.sh>`_: script that does *everything* for a fresh system

.. |forthebadge| image:: https://forthebadge.com/images/badges/no-ragrets.svg
   :target: https://forthebadge.com

Usage
=====

::

	$ mkdir -p ~/dev
	$ git clone https://github.com/chuahou/kiwami.git ~/dev/kiwami --recurse-submodules
	$ cd ~/dev/kiwami
	$ ./init.sh

Previously
==========

RIP `utility repo <https://github.com/chuahou/utility>`_
