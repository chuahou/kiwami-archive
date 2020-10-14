######
kiwami
######

|forthebadge|

A personal utility repository for (more or less) reproducible setups on
Pop!_OS systems.

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
  * `fonts-iosevka <debian/fonts-iosevka>`_: `Iosevka
    <https://github.com/be5invis/Iosevka>`_ as a debian package
  * `teams-apt-source <debian/teams-apt-source>`_: a package containing
    the apt source and GPG key for Microsoft Teams, as I was unhappy
    with the default package not cleanly uninstalling

* `other <other>`_: miscellanous files

* rcfiles: see `rcfiles repo <https://github.com/chuahou/rcfiles>`_

* `zsh-vim-mode <zsh-vim-mode>`_: `this plugin
  <https://github.com/softmoth/zsh-vim-mode>`_ as a submodule for easy
  installation using symlinks in `rcfiles <rcfiles>`_

* `prereq.deb <prereq.deb>`_: the packages in `debian/ <debian>`_
  require some tools to build. This is the prebuilt metapackage of
  `kiwami-prereq <debian/kiwami-prereq>`_, so that a fresh system can
  install this prior to building and installing everything in `debian/
  <debian>`_

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
