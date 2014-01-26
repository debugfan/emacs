### Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1992-2014 Free Software Foundation, Inc.

# This file is part of GNU Emacs.

# GNU Emacs is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# GNU Emacs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

### Commentary:

# make all	to compile and build Emacs.
# make install	to install it.
# make TAGS	to update tags tables.
#
# make clean  or  make mostlyclean
#      Delete all files from the current directory that are normally
#      created by building the program.	 Don't delete the files that
#      record the configuration.  Also preserve files that could be made
#      by building, but normally aren't because the distribution comes
#      with them.
#
#      Delete `.dvi' files here if they are not part of the distribution.
#
# make distclean
#      Delete all files from the current directory that are created by
#      configuring or building the program.  If you have unpacked the
#      source and built the program without creating any other files,
#      `make distclean' should leave only the files that were in the
#      distribution.
#
# make maintainer-clean
#      Delete everything from the current directory that can be
#      reconstructed with this Makefile.  This typically includes
#      everything deleted by distclean, plus more: .elc files,
#      C source files produced by Bison, tags tables, info files,
#      and so on.
#
# make extraclean
#      Still more severe - delete backup and autosave files, too.
#      Also generated files that do not normally change and can be slow
#      to rebuild (eg leim/ja-dic).
#
# make bootstrap
#      Removes all the compiled files to force a new bootstrap from a
#      clean slate, and then build in the normal way.
#
# make docs
#      Make Emacs documentation files from their sources; requires makeinfo.

SHELL = /bin/sh

# This may not work with certain non-GNU make's.  It only matters when
# inheriting a CDPATH not starting with the current directory.
CDPATH=

# If Make doesn't predefine MAKE, set it here.


# Prevent submakes from outputting "Entering directory ..." and
# "Leaving directory..." diagnostics that would mess up 'make echo-info'.
QUIET_SUBMAKE = MAKELEVEL=0

# ==================== Things `configure' Might Edit ====================

cache_file = /dev/null
CONFIGURE_FLAGS = --cache-file=$(cache_file)

CC=gcc  -std=gnu99
CFLAGS=-g3 -O2 -gdwarf-2
LDFLAGS=
CPPFLAGS=-mtune=pentium4   -DUSE_CRT_DLL=1 -I ${abs_top_srcdir}/nt/inc
EXEEXT=.exe

### These help us choose version- and architecture-specific directories
### to install files in.

### This should be the number of the Emacs version we're building,
### like `18.59' or `19.0'.
version=24.3.50

### This should be the name of the configuration we're building Emacs
### for, like `mips-dec-ultrix' or `sparc-sun-sunos'.
configuration=i686-pc-mingw32

### The nt/ subdirectory gets built only for MinGW
NTDIR=nt

# ==================== Where To Install Things ====================

# Location to install Emacs.app under GNUstep / Mac OS X.
# Later values may use these.
ns_appbindir=
ns_appresdir=
# Either yes or no depending on whether this is a relocatable Emacs.app.
ns_self_contained=no

# The default location for installation.  Everything is placed in
# subdirectories of this directory.  The default values for many of
# the variables below are expressed in terms of this one, so you may
# not need to change them.  This defaults to /usr/local.
prefix=/c/s/emacs

# Like `prefix', but used for architecture-specific files.
exec_prefix=${prefix}

# Where to install Emacs and other binaries that people will want to
# run directly (like etags).
bindir=${exec_prefix}/bin

# The root of the directory tree for read-only architecture-independent
# data files.  ${datadir}, ${infodir} and ${mandir} are based on this.
datarootdir=${prefix}/share

# Where to install architecture-independent data files.	 ${lispdir}
# and ${etcdir} are subdirectories of this.
datadir=${datarootdir}

# Where to install and expect the files that Emacs modifies as it
# runs.  These files are all architecture-independent.
# Right now, this is not used.
sharedstatedir=${prefix}/com

# Where to install and expect executable files to be run by Emacs
# rather than directly by users (and other architecture-dependent
# data, although Emacs does not have any).  The executables
# are actually installed in ${archlibdir}, which is (normally)
# a subdirectory of this.
libexecdir=${exec_prefix}/libexec

# Where to install Emacs's man pages.
# Note they contain cross-references that expect them to be in section 1.
mandir=${datarootdir}/man
man1dir=$(mandir)/man1

# Where to install and expect the info files describing Emacs.
infodir=${datarootdir}/info
# Info files not in the doc/misc directory (we get those via make echo-info).
INFO_EXT=.info
INFO_NONMISC=emacs$(INFO_EXT) eintr$(INFO_EXT) elisp$(INFO_EXT)

# If no makeinfo was found and configured --without-makeinfo, "no"; else "yes".
HAVE_MAKEINFO=yes

# Directory for local state files for all programs.
localstatedir=${prefix}/var

# Where to look for bitmap files.
bitmapdir=

# Where to find the source code.  The source code for Emacs's C kernel is
# expected to be in ${srcdir}/src, and the source code for Emacs's
# utility programs is expected to be in ${srcdir}/lib-src.  This is
# set by the configure script's `--srcdir' option.

# We use $(srcdir) explicitly in dependencies so as not to depend on VPATH.
srcdir=.
abs_srcdir=/c/GiHub/emacs
# MinGW CPPFLAGS may use this.
abs_top_srcdir=/c/GiHub/emacs

# Where the manpage source files are kept.
mansrcdir=$(srcdir)/doc/man

# Tell make where to find source files; this is needed for the makefiles.


# Where to find the application default.
x_default_search_path=

# Where the etc/emacs.desktop file is to be installed.
desktopdir=$(datarootdir)/applications

# Where the etc/images/icons/hicolor directory is to be installed.
icondir=$(datarootdir)/icons

# The source directory for the icon files.
iconsrcdir=$(srcdir)/etc/images/icons

# ==================== Emacs-specific directories ====================

# These variables hold the values Emacs will actually use.  They are
# based on the values of the standard Make variables above.

# Where to install the lisp files distributed with Emacs.
# This includes the Emacs version, so that the lisp files for different
# versions of Emacs will install themselves in separate directories.
lispdir=${datadir}/emacs/${version}/lisp

# Directories Emacs should search for standard lisp files.
# The default is ${lispdir}.
standardlisppath=${lispdir}

# Directories Emacs should search for lisp files specific to this
# site (i.e. customizations), before consulting ${standardlisppath}.
# This should be a colon-separated list of directories.
locallisppath=${datadir}/emacs/${version}/site-lisp:${datadir}/emacs/site-lisp

# Where Emacs will search to find its lisp files.  Before
# changing this, check to see if your purpose wouldn't
# better be served by changing locallisppath.  This
# should be a colon-separated list of directories.
# The default is ${locallisppath}:${standardlisppath}.
lisppath=${locallisppath}:${standardlisppath}

# Where Emacs will search for its lisp files while building.
# This is only used during the process of compiling Emacs,
# to help Emacs find its lisp files before they've been installed
# in their final location.
# This should be a colon-separated list of directories.
# Normally it points to the lisp/ directory in the sources.
# NB lread.c relies on lisp/ being first here.
buildlisppath=${abs_srcdir}/lisp

# Where to install the other architecture-independent
# data files distributed with Emacs (like the tutorial,
# the cookie recipes and the Zippy database). This path
# usually contains the Emacs version number, so the data
# files for multiple versions of Emacs may be installed
# at once.
etcdir=${datadir}/emacs/${version}/etc

# Where to put executables to be run by Emacs rather than
# the user.  This path usually includes the Emacs version
# and configuration name, so that multiple configurations
# for multiple versions of Emacs may be installed at
# once.
archlibdir=${libexecdir}/emacs/${version}/${configuration}

# Where to put the etc/DOC file.
etcdocdir=${datadir}/emacs/${version}/etc

# Where to install Emacs game score files.
gamedir=${localstatedir}/games/emacs

# ==================== Utility Programs for the Build ====================

# Allow the user to specify the install program.
# Note that if the system does not provide a suitable install,
# configure will use build-aux/install-sh.  Annoyingly, it does
# not use an absolute path.  So we must take care to always run
# INSTALL-type commands from the directory containing the Makefile.
# This explains (I think) the cd thisdir seen in several install rules.
INSTALL = /bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_INFO = /bin/install-info
# By default, we uphold the dignity of our programs.
INSTALL_STRIP =
MKDIR_P = /bin/mkdir -p
# Create a link to a file in the same directory as the target.
LN_S_FILEONLY = ln -s

# We use gzip to compress installed .el files.
GZIP_PROG = /bin/gzip

# ============================= Targets ==============================

# Program name transformation.
TRANSFORM = s,x,x,

# What emacs should be called when installed.
EMACS_NAME = `echo emacs | sed '$(TRANSFORM)'`
EMACS = ${EMACS_NAME}${EXEEXT}
EMACSFULL = `echo emacs-${version} | sed '$(TRANSFORM)'`${EXEEXT}

# Subdirectories to make recursively.
SUBDIR = $(NTDIR) lib lib-src src lisp

# The subdir makefiles created by config.status.
SUBDIR_MAKEFILES_IN =  $(srcdir)/lib/Makefile.in $(srcdir)/lib-src/Makefile.in $(srcdir)/oldXMenu/Makefile.in $(srcdir)/doc/emacs/Makefile.in $(srcdir)/doc/misc/Makefile.in $(srcdir)/doc/lispintro/Makefile.in $(srcdir)/doc/lispref/Makefile.in $(srcdir)/src/Makefile.in $(srcdir)/lwlib/Makefile.in $(srcdir)/lisp/Makefile.in $(srcdir)/leim/Makefile.in $(srcdir)/nextstep/Makefile.in $(srcdir)/nt/Makefile.in $(srcdir)/test/automated/Makefile.in $(srcdir)/admin/unidata/Makefile.in $(srcdir)/admin/grammars/Makefile.in
SUBDIR_MAKEFILES = `echo $(SUBDIR_MAKEFILES_IN:.in=) | sed 's|$(srcdir)/||g'`

# Subdirectories to install, and where they'll go.  lib-src's and nt's
# makefiles know how to install them, so we don't do that here.
# Directories that cannot simply be copied, eg info, are treated
# separately.
COPYDIR = ${srcdir}/etc ${srcdir}/lisp
COPYDESTS = "$(DESTDIR)${etcdir}" "$(DESTDIR)${lispdir}"

all: ${SUBDIR}

.PHONY: all ${SUBDIR} blessmail epaths-force epaths-force-w32 FRC

removenullpaths=sed -e 's/^:*//' -e 's/:*$$//g' -e 's/::*/:/g'

# Generate epaths.h from epaths.in.  This target is invoked by `configure'.
# See comments in configure.ac for why it is done this way, as opposed
# to just letting configure generate epaths.h from epaths.in in a
# similar way to how Makefile is made from Makefile.in.
epaths-force: FRC
	@(standardlisppath=`echo "${standardlisppath}" | ${removenullpaths}` ; \
	  locallisppath=`echo "${locallisppath}" | ${removenullpaths}` ; \
	  buildlisppath=`echo "${buildlisppath}" | ${removenullpaths}` ; \
	  x_default_search_path=`echo ${x_default_search_path}`; \
	  gamedir=`echo ${gamedir}`; \
	  sed < ${srcdir}/src/epaths.in > epaths.h.$$$$		\
	  -e 's;\(#.*PATH_LOADSEARCH\).*$$;\1 "'"$${standardlisppath}"'";' \
	  -e 's;\(#.*PATH_SITELOADSEARCH\).*$$;\1 "'"$${locallisppath}"'";' \
	  -e 's;\(#.*PATH_DUMPLOADSEARCH\).*$$;\1 "'"$${buildlisppath}"'";' \
	  -e 's;\(#.*PATH_EXEC\).*$$;\1 "${archlibdir}";'		\
	  -e 's;\(#.*PATH_INFO\).*$$;\1 "${infodir}";'			\
	  -e 's;\(#.*PATH_DATA\).*$$;\1 "${etcdir}";'			\
	  -e 's;\(#.*PATH_BITMAPS\).*$$;\1 "${bitmapdir}";'		\
	  -e 's;\(#.*PATH_X_DEFAULTS\).*$$;\1 "${x_default_search_path}";' \
	  -e 's;\(#.*PATH_GAME\).*$$;\1 "${gamedir}";' \
	  -e 's;\(#.*PATH_DOC\).*$$;\1 "${etcdocdir}";') &&		\
	${srcdir}/build-aux/move-if-change epaths.h.$$$$ src/epaths.h

# Replace "${w32prefix}" with '%emacs_dir%' (which expands to install
# directory at runtime).
msys_w32prefix_subst=sed -e 's!\(^\|;\)'"$${w32prefixpattern}"'\([;/]\|$$\)!\1%emacs_dir%\2!g'

# Quote Sed special characters (except backslash and newline) with
# a double backslash.
msys_sed_sh_escape=sed -e 's/[];$$*.^[]/\\\\&/g'

# The w32 build needs a slightly different editing, and it uses
# nt/epaths.nt as the template.
#
# Use the value of ${locallisppath} supplied by `configure',
# to support the --enable-locallisppath argument.
#
# In this case, the paths written to 'src/epaths.h' must be in native
# MS-Windows format (e.g. 'c:/foo/bar'), because temacs is a MinGW
# program that doesn't support MSYS-style paths (e.g. '/c/foo/bar' or
# '/foo/bar').
epaths-force-w32: FRC
	@(w32srcdir=`${srcdir}/build-aux/msys-to-w32 "${srcdir}"`; \
	  w32prefix=`${srcdir}/build-aux/msys-to-w32 "${prefix}" N`; \
	  w32prefixpattern=`echo "$${w32prefix}" | ${msys_sed_sh_escape}` ; \
	  w32locallisppath=`${srcdir}/build-aux/msys-to-w32 "${locallisppath}" N ":" "\\;" | ${msys_w32prefix_subst}` ; \
	  sed < ${srcdir}/nt/epaths.nt > epaths.h.$$$$		\
	  -e 's;\(#.*PATH_SITELOADSEARCH\).*$$;\1 "'"$${w32locallisppath}"'";' \
	  -e '/^.*#/s/@VER@/${version}/g' 			\
	  -e '/^.*#/s/@CFG@/${configuration}/g' 		\
	  -e "/^.*#/s|@SRC@|$${w32srcdir}|g") &&		\
	${srcdir}/build-aux/move-if-change epaths.h.$$$$ src/epaths.h

# If lib/Makefile would build files in '.', then build them before
# building 'lib', to avoid races with parallel makes.
lib: am--refresh

lib-src src: $(NTDIR) lib

src: lib-src

# We need to build `emacs' in `src' to compile the *.elc files in `lisp'.
lisp: src

# These targets should be "${SUBDIR} without `src'".
lib lib-src lisp nt: Makefile FRC
	cd $@ && $(MAKE) all $(MFLAGS)                         \
	  CC='${CC}' CFLAGS='${CFLAGS}' CPPFLAGS='${CPPFLAGS}' \
	  LDFLAGS='${LDFLAGS}' MAKE='${MAKE}'

# Pass to src/Makefile.in an additional BOOTSTRAPEMACS variable which
# is either set to bootstrap-emacs (in case bootstrap-emacs has not been
# constructed yet) or the empty string (otherwise).
# src/Makefile.in uses it to implement conditional dependencies, so that
# files that need bootstrap-emacs to be built do not additionally need
# to be kept fresher than bootstrap-emacs.  Otherwise changing a single
# file src/foo.c forces dumping a new bootstrap-emacs, then re-byte-compiling
# all preloaded elisp files, and only then dump the actual src/emacs, which
# is not wrong, but is overkill in 99.99% of the cases.
#
# Note the use of single quotes in the value of vcswitness.
# This passes an unexpanded $srcdir to src's Makefile, which then
# expands it using its own value of srcdir (which points to the
# source directory of src/).
src: Makefile FRC
	dirstate='.bzr/checkout/dirstate';				\
	vcswitness='$$(srcdir)/../'$$dirstate;				\
	[ -r "$(srcdir)/$$dirstate" ] || vcswitness='';			\
	cd $@ || exit;							\
	boot=bootstrap-emacs$(EXEEXT);					\
	[ ! -x "$$boot" ] || boot='';					\
	$(MAKE) all $(MFLAGS)						\
	  CC='${CC}' CFLAGS='${CFLAGS}' CPPFLAGS='${CPPFLAGS}'		\
	  LDFLAGS='${LDFLAGS}' MAKE='${MAKE}' BOOTSTRAPEMACS="$$boot"	\
	  VCSWITNESS="$$vcswitness"

blessmail: Makefile src FRC
	cd lib-src && $(MAKE) maybe-blessmail $(MFLAGS) \
	  MAKE='${MAKE}' archlibdir='$(archlibdir)'

# We used to have one rule per */Makefile.in, but that leads to race
# conditions with parallel makes, so let's assume that the time stamp on
# ./Makefile is representative of the time stamp on all the other Makefiles.
#
# config.status overrides MAKEFILE_NAME with a bogus name when creating
# src/epaths.h, so that 'make epaths-force' does not recursively invoke
# config.status and overwrite config.status while executing it (Bug#11214).
#
# 'make bootstrap' overrides MAKEFILE_NAME to a nonexistent file but
# then attempts to build that file.  This forces 'Makefile', 'lib/Makefile',
# etc. to be built without running into similar recursion problems.
MAKEFILE_NAME = Makefile
$(MAKEFILE_NAME): config.status $(srcdir)/src/config.in \
          $(srcdir)/Makefile.in $(SUBDIR_MAKEFILES_IN) $(srcdir)/src/lisp.mk
	MAKE='$(MAKE)' ./config.status

# Don't erase these files if make is interrupted while refreshing them.
.PRECIOUS: Makefile config.status

config.status: ${srcdir}/configure ${srcdir}/lisp/version.el
	if [ -x ./config.status ]; then	\
	    $(CFG) ./config.status --recheck;	\
	else				\
	    $(CFG) $(srcdir)/configure $(CONFIGURE_FLAGS); \
	fi

AUTOCONF_INPUTS = $(srcdir)/configure.ac $(srcdir)/aclocal.m4

$(srcdir)/configure: $(AUTOCONF_INPUTS)
	cd ${srcdir} && autoconf

ACLOCAL_INPUTS = $(srcdir)/configure.ac $(srcdir)/m4/gnulib-comp.m4
$(srcdir)/aclocal.m4: $(ACLOCAL_INPUTS)
	cd $(srcdir) && aclocal -I m4

AUTOMAKE_INPUTS = $(srcdir)/aclocal.m4 $(srcdir)/lib/Makefile.am \
  $(srcdir)/lib/gnulib.mk
$(srcdir)/lib/Makefile.in: $(AUTOMAKE_INPUTS)
	cd $(srcdir) && automake --gnu -a -c lib/Makefile

# Regenerate files that this makefile would have made, if this makefile
# had been built by Automake.  The name 'am--refresh' is for
# compatibility with subsidiary Automake-generated makefiles.
am--refresh: $(srcdir)/aclocal.m4 $(srcdir)/configure $(srcdir)/src/config.in
.PHONY: am--refresh

$(srcdir)/src/config.in: $(srcdir)/src/stamp-h.in
	@ # Usually, there's no need to rebuild src/config.in just
	@ # because stamp-h.in has changed (since building stamp-h.in
	@ # refreshes config.in as well), but if config.in is missing
	@ # then we really need to do something more.
	[ -r "$@" ] || ( cd ${srcdir} && autoheader )
$(srcdir)/src/stamp-h.in: $(AUTOCONF_INPUTS)
	cd ${srcdir} && autoheader
	rm -f $(srcdir)/src/stamp-h.in
	echo timestamp > $(srcdir)/src/stamp-h.in

# ==================== Installation ====================

.PHONY: install install-arch-dep install-arch-indep install-etcdoc install-info
.PHONY: install-man install-etc install-strip install-$(NTDIR)
.PHONY: uninstall uninstall-$(NTDIR)

## If we let lib-src do its own installation, that means we
## don't have to duplicate the list of utilities to install in
## this Makefile as well.

install: all install-arch-indep install-etcdoc install-arch-dep install-$(NTDIR) blessmail
	@true

## Ensure that $subdir contains a subdirs.el file.
## Here and elsewhere, we set the umask so that any created files are
## world-readable.
## TODO it might be good to warn about non-standard permissions of
## pre-existing directories, but that does not seem easy.
write_subdir=if [ -f "$${subdir}/subdirs.el" ]; \
	then true; \
	else \
	  umask 022; \
	  ${MKDIR_P} "$${subdir}"; \
	  (echo "(if (fboundp 'normal-top-level-add-subdirs-to-load-path)"; \
	   echo "    (normal-top-level-add-subdirs-to-load-path))") \
	    > "$${subdir}/subdirs.el"; \
	fi

### Install the executables that were compiled specifically for this machine.
### We do install-arch-indep first because the executable needs the
### Lisp files and DOC file to work properly.
install-arch-dep: src install-arch-indep install-etcdoc install-$(NTDIR)
	umask 022; ${MKDIR_P} "$(DESTDIR)${bindir}"
	cd lib-src && \
	  $(MAKE) install $(MFLAGS) prefix="${prefix}" \
	    exec_prefix="${exec_prefix}" bindir="${bindir}" \
	    libexecdir="${libexecdir}" archlibdir="${archlibdir}" \
	    INSTALL_STRIP=${INSTALL_STRIP}
	if test "${ns_self_contained}" = "no"; then \
	  ${INSTALL_PROGRAM} $(INSTALL_STRIP) src/emacs${EXEEXT} "$(DESTDIR)${bindir}/$(EMACSFULL)" || exit 1 ; \
	  chmod 1755 "$(DESTDIR)${bindir}/$(EMACSFULL)" || true; \
	  if test "x${NO_BIN_LINK}" = x; then \
	    rm -f "$(DESTDIR)${bindir}/$(EMACS)" ; \
	    cd "$(DESTDIR)${bindir}" && $(LN_S_FILEONLY) $(EMACSFULL) $(EMACS); \
	  fi; \
	else \
	  subdir=${ns_appresdir}/site-lisp; \
	  ${write_subdir} || exit 1; \
	  rm -rf ${ns_appresdir}/share; \
	fi

### Windows-specific install target for installing programs produced
### in nt/, and its Posix do-nothing shadow.
install-:
install-nt:
	cd $(NTDIR) && \
	  $(MAKE) install $(MFLAGS) prefix="${prefix}" \
	    exec_prefix="${exec_prefix}" bindir="${bindir}" \
	    libexecdir="${libexecdir}" archlibdir="${archlibdir}" \
	    INSTALL_STRIP=${INSTALL_STRIP}

## In the share directory, we are deleting:
## applications (with emacs.desktop, also found in etc/)
## emacs (basically empty except for unneeded site-lisp directories)
## icons (duplicates etc/images/icons/hicolor)

## This is install-etc for everything except self-contained-ns builds.
## For them, it is empty.
INSTALL_ARCH_INDEP_EXTRA = install-etc

## http://lists.gnu.org/archive/html/emacs-devel/2007-10/msg01672.html
## Needs to be the user running install, so configure can't set it.
set_installuser=for installuser in $${LOGNAME} $${USERNAME} $${USER} \
	  `id -un 2> /dev/null`; do \
	  [ -n "$${installuser}" ] && break ; \
	done

### Install the files that are machine-independent.
### Most of them come straight from the distribution; the exception is
### the DOC file, which is copied from the build directory.

## We delete each directory in ${COPYDESTS} before we copy into it;
## that way, we can reinstall over directories that have been put in
## place with their files read-only (perhaps because they are checked
## into RCS).  In order to make this safe, we make sure that the
## source exists and is distinct from the destination.

## We delete etc/DOC* because there may be irrelevant DOC files from
## other builds in the source directory.  This is ok because we just
## deleted the entire installed etc/ directory and recreated it.
## install-etcdoc installs the relevant DOC.

## Note that we install etc/refcards/*.ps if present.
## TODO we should compress these if GZIP_PROG is set.
## It would be simpler to have a separate install rule for etc/refcards
## (maybe move it to doc/refcards?).

## Note that the Makefiles in the etc directory are potentially useful
## in an installed Emacs, so should not be excluded.

## We always create the _default_ locallisppath directories, and
## ensure that they contain a subdirs.el file (via write_subdir).
## This is true even if locallisppath has a non-default value.
## In case of non-default value, we used to create the specified directories,
## but not add subdirs.el to them.  This was a strange halfway house.
## Nowadays we do not create non-default directories.

## Note that we use tar instead of plain old cp -R/-r because the latter
## is apparently not portable (even in 2012!).
## http://lists.gnu.org/archive/html/emacs-devel/2012-05/msg00278.html
## I have no idea which platforms Emacs supports where cp -R does not
## work correctly, and therefore no idea when tar can be replaced.
## See also these comments from 2004 about cp -r working fine:
## http://lists.gnu.org/archive/html/autoconf-patches/2004-11/msg00005.html
install-arch-indep: lisp install-info install-man ${INSTALL_ARCH_INDEP_EXTRA}
	-set ${COPYDESTS} ; \
	unset CDPATH; \
	$(set_installuser); \
	for dir in ${COPYDIR} ; do \
	  [ -d $${dir} ] || exit 1 ; \
	  dest="$$1" ; shift ; \
	  if [ -d "$${dest}" ]; then \
	    exp_dest=`cd "$${dest}" && /bin/pwd`; \
	    [ "$$exp_dest" = "`cd $${dir} && /bin/pwd`" ] && continue ; \
	  else true; \
	  fi; \
	  rm -rf "$${dest}" ; \
	  umask 022; ${MKDIR_P} "$${dest}" ; \
	  echo "Copying $${dir} to $${dest}..." ; \
	  (cd $${dir}; tar -chf - . ) \
	    | (cd "$${dest}"; umask 022; \
	       tar -xvf - && cat > /dev/null) || exit 1; \
	  if [ "$${dir}" = "${srcdir}/etc" ]; then \
	      rm -f "$${dest}/DOC"* ; \
	      rm -f "$${dest}/refcards"/*.aux "$${dest}/refcards"/*.dvi; \
	      rm -f "$${dest}/refcards"/*.log; \
	  else true; \
	  fi; \
	  (cd "$${dest}" || exit 1; \
	    for subdir in `find . -type d -print` ; do \
	      chmod a+rx $${subdir} ; \
	      rm -f $${subdir}/.gitignore ; \
	      rm -f $${subdir}/.arch-inventory ; \
	      rm -f $${subdir}/.DS_Store ; \
	      rm -f $${subdir}/\#* ; \
	      rm -f $${subdir}/.\#* ; \
	      rm -f $${subdir}/*~ ; \
	      rm -f $${subdir}/*.orig ; \
	      rm -f $${subdir}/ChangeLog* ; \
	      [ "$${dir}" != "${srcdir}/etc" ] && \
	        rm -f $${subdir}/[mM]akefile*[.-]in $${subdir}/[mM]akefile ; \
	    done ); \
	  find "$${dest}" -exec chown $${installuser} {} ';' ;\
	done
	-rm -f "$(DESTDIR)${lispdir}/subdirs.el"
	umask 022; $(srcdir)/build-aux/update-subdirs "$(DESTDIR)${lispdir}"
	subdir="$(DESTDIR)${datadir}/emacs/${version}/site-lisp" ; \
	  ${write_subdir}
	subdir="$(DESTDIR)${datadir}/emacs/site-lisp" ; \
	  ${write_subdir} || true
	[ -z "${GZIP_PROG}" ] || \
	  ( echo "Compressing *.el ..." ; \
	    unset CDPATH; \
	    thisdir=`/bin/pwd`; \
	    for dir in "$(DESTDIR)${lispdir}"; do \
	      cd "$${thisdir}" ; \
	      cd "$${dir}" || exit 1 ; \
	      for f in `find . -name "*.elc" -print`; do \
	        f_el=`echo "$$f" | sed 's/.elc$$/.el/'`; \
	        ${GZIP_PROG} -9n "$$f_el" ; \
	      done ; \
	    done )
	-chmod -R a+r "$(DESTDIR)${datadir}/emacs/${version}" ${COPYDESTS}

## The above chmods are needed because "umask 022; tar ..." is not
## guaranteed to do the right thing; eg if we are root and tar is
## preserving source permissions.

## Note that install-arch-indep deletes and recreates the entire
## installed etc/ directory, so we need it to run before this does.
install-etcdoc: src install-arch-indep
	-unset CDPATH; \
	umask 022; ${MKDIR_P} "$(DESTDIR)${etcdocdir}" ; \
	exp_etcdocdir=`cd "$(DESTDIR)${etcdocdir}"; /bin/pwd`; \
	if [ "`cd ./etc; /bin/pwd`" != "$$exp_etcdocdir" ]; \
	then \
	   docfile="DOC"; \
	   echo "Copying etc/$${docfile} to $(DESTDIR)${etcdocdir} ..." ; \
	   ${INSTALL_DATA} etc/$${docfile} "$(DESTDIR)${etcdocdir}/$${docfile}"; \
	   $(set_installuser); \
	     chown $${installuser} "$(DESTDIR)${etcdocdir}/$${docfile}" || true ; \
	else true; fi

## FIXME:
## If info/dir is missing, but we have install-info, we should let
## that handle it.  If info/dir is present and we do not have install-info,
## we should check for missing entries and add them by hand.
##
## FIXME:
## If HAVE_MAKEINFO = no and there are no info files, do not install info/dir.
install-info: info
	umask 022; ${MKDIR_P} "$(DESTDIR)${infodir}"
	-unset CDPATH; \
	thisdir=`/bin/pwd`; \
	exp_infodir=`cd "$(DESTDIR)${infodir}" && /bin/pwd`; \
	if [ "`cd ${srcdir}/info && /bin/pwd`" = "$$exp_infodir" ]; then \
	  true; \
	else \
	   [ -f "$(DESTDIR)${infodir}/dir" ] || \
	      [ ! -f ${srcdir}/info/dir ] || \
	      ${INSTALL_DATA} ${srcdir}/info/dir "$(DESTDIR)${infodir}/dir"; \
	   info_misc=`cd doc/misc && $(QUIET_SUBMAKE) $(MAKE) -s echo-info`; \
	   cd ${srcdir}/info ; \
	   for elt in ${INFO_NONMISC} $${info_misc}; do \
	      test "$(HAVE_MAKEINFO)" = "no" && test ! -f $$elt && continue; \
	      for f in `ls $$elt $$elt-[1-9] $$elt-[1-9][0-9] 2>/dev/null`; do \
	       (cd "$${thisdir}"; \
	        ${INSTALL_DATA} ${srcdir}/info/$$f "$(DESTDIR)${infodir}/$$f"); \
	        [ -n "${GZIP_PROG}" ] || continue ; \
	        rm -f "$(DESTDIR)${infodir}/$$f.gz"; \
	        ${GZIP_PROG} -9n "$(DESTDIR)${infodir}/$$f"; \
	      done; \
	     (cd "$${thisdir}"; \
	      ${INSTALL_INFO} --info-dir="$(DESTDIR)${infodir}" "$(DESTDIR)${infodir}/$$elt"); \
	   done; \
	fi

## "gzip || true" is because some gzips exit with non-zero status
## if compression would not reduce the file size.  Eg, the gzip in
## OpenBSD 4.9 seems to do this (2013/03).  In Emacs, this can
## only happen with the tiny ctags.1 manpage.  We don't really care if
## ctags.1 is compressed or not.  "gzip -f" is another option here,
## but not sure if portable.
install-man:
	umask 022; ${MKDIR_P} "$(DESTDIR)${man1dir}"
	thisdir=`/bin/pwd`; \
	cd ${mansrcdir}; \
	for page in *.1; do \
	  dest=`echo "$${page}" | sed -e 's/\.1$$//' -e '$(TRANSFORM)'`.1; \
	  (cd "$${thisdir}"; \
	   ${INSTALL_DATA} ${mansrcdir}/$${page} "$(DESTDIR)${man1dir}/$${dest}"); \
	  [ -n "${GZIP_PROG}" ] || continue ; \
	  rm -f "$(DESTDIR)${man1dir}/$${dest}.gz"; \
	  ${GZIP_PROG} -9n "$(DESTDIR)${man1dir}/$${dest}" || true; \
	done

## Install those items from etc/ that need to end up elsewhere.

## If you prefer, choose "emacs22" at installation time.
## Note: emacs22 does not have all the resolutions.
EMACS_ICON=emacs

install-etc:
	umask 022; ${MKDIR_P} "$(DESTDIR)${desktopdir}"
	tmp=etc/emacs.tmpdesktop; rm -f $${tmp}; \
	emacs_name=`echo emacs | sed '$(TRANSFORM)'`; \
	sed -e "/^Exec=emacs/ s/emacs/$${emacs_name}/" \
	  -e "/^Icon=emacs/ s/emacs/$${emacs_name}/" \
	  ${srcdir}/etc/emacs.desktop > $${tmp}; \
	${INSTALL_DATA} $${tmp} "$(DESTDIR)${desktopdir}/${EMACS_NAME}.desktop"; \
	rm -f $${tmp}
	thisdir=`/bin/pwd`; \
	cd ${iconsrcdir} || exit 1; umask 022 ; \
	for dir in */*/apps */*/mimetypes; do \
	  [ -d $${dir} ] || continue ; \
	  ( cd "$${thisdir}"; ${MKDIR_P} "$(DESTDIR)${icondir}/$${dir}" ) ; \
	  for icon in $${dir}/${EMACS_ICON}[.-]*; do \
	    [ -r $${icon} ] || continue ; \
	    ext=`echo "$${icon}" | sed -e 's|.*\.||'`; \
	    dest=`echo "$${icon}" | sed -e 's|.*/||' -e "s|\.$${ext}$$||" -e 's/$(EMACS_ICON)/emacs/' -e '$(TRANSFORM)'`.$${ext} ; \
	    ( cd "$${thisdir}"; \
	      ${INSTALL_DATA} ${iconsrcdir}/$${icon} "$(DESTDIR)${icondir}/$${dir}/$${dest}" ) \
	    || exit 1; \
	  done ; \
	done

### Build Emacs and install it, stripping binaries while installing them.
install-strip:
	$(MAKE) $(MFLAGS) INSTALL_STRIP=-s install

### Delete all the installed files that the `install' target would
### create (but not the noninstalled files such as `make all' would create).
###
### Don't delete the lisp and etc directories if they're in the source tree.
uninstall: uninstall-$(NTDIR) uninstall-doc
	cd lib-src && 					\
	 $(MAKE) $(MFLAGS) uninstall			\
	    prefix="${prefix}" exec_prefix="${exec_prefix}" \
	    bindir="${bindir}" libexecdir="${libexecdir}" \
	    archlibdir="${archlibdir}"

	-unset CDPATH; \
	for dir in "$(DESTDIR)${lispdir}" "$(DESTDIR)${etcdir}" ; do 	\
	  if [ -d "$${dir}" ]; then			\
	    case `cd "$${dir}" ; /bin/pwd` in		\
	      "`cd ${srcdir} ; /bin/pwd`"* ) ;;		\
	      * ) rm -rf "$${dir}" ;;			\
	    esac ;					\
	    case "$${dir}" in				\
	      "$(DESTDIR)${datadir}/emacs/${version}"/* )		\
	        rm -rf "$(DESTDIR)${datadir}/emacs/${version}"	\
	      ;;					\
	    esac ;					\
	  fi ;						\
	done
	-rm -rf "$(DESTDIR)${libexecdir}/emacs/${version}"
	thisdir=`/bin/pwd`; \
	(info_misc=`cd doc/misc && $(QUIET_SUBMAKE) $(MAKE) -s echo-info`; \
	 if cd "$(DESTDIR)${infodir}"; then \
	   for elt in ${INFO_NONMISC} $${info_misc}; do \
	     (cd "$${thisdir}"; \
	      $(INSTALL_INFO) --remove --info-dir="$(DESTDIR)${infodir}" "$(DESTDIR)${infodir}/$$elt"); \
	     if [ -n "${GZIP_PROG}" ]; then \
	        ext=.gz; else ext=; fi; \
	     rm -f $$elt$$ext $$elt-[1-9]$$ext $$elt-[1-9][0-9]$$ext; \
	   done; \
	 fi)
	(if [ -n "${GZIP_PROG}" ]; then \
	    ext=.gz; else ext=; fi; \
	 if cd ${mansrcdir}; then \
	   for page in *.1; do \
	     rm -f "$(DESTDIR)${man1dir}"/`echo "$${page}" | sed -e 's/\.1$$//' -e '$(TRANSFORM)'`.1$$ext; done; \
	 fi)
	(cd "$(DESTDIR)${bindir}" && rm -f $(EMACSFULL) $(EMACS) || true)
	(if cd "$(DESTDIR)${icondir}"; then \
	   rm -f hicolor/*x*/apps/${EMACS_NAME}.png \
	     hicolor/scalable/apps/${EMACS_NAME}.svg \
	     hicolor/scalable/mimetypes/`echo emacs-document | sed '$(TRANSFORM)'`.svg; \
	fi)
	-rm -f "$(DESTDIR)${desktopdir}/${EMACS_NAME}.desktop"
	for file in snake-scores tetris-scores; do \
	  file="$(DESTDIR)${gamedir}/$${file}"; \
	  [ -s "$${file}" ] || rm -f "$$file"; \
	done

### Windows-specific uninstall target for removing programs produced
### in nt/, and its Posix do-nothing shadow.
uninstall-:
uninstall-nt:
	cd $(NTDIR) && 					\
	 $(MAKE) $(MFLAGS) uninstall			\
	    prefix="${prefix}" exec_prefix="${exec_prefix}" \
	    bindir="${bindir}" libexecdir="${libexecdir}" \
	    archlibdir="${archlibdir}"

FRC:

# ==================== Cleaning up and miscellanea ====================

.PHONY: mostlyclean clean distclean bootstrap-clean maintainer-clean extraclean

### `mostlyclean'
###      Like `clean', but may refrain from deleting a few files that people
###      normally don't want to recompile.  For example, the `mostlyclean'
###      target for GCC does not delete `libgcc.a', because recompiling it
###      is rarely necessary and takes a lot of time.
mostlyclean: FRC
	cd src      && $(MAKE) $(MFLAGS) mostlyclean
	cd oldXMenu && $(MAKE) $(MFLAGS) mostlyclean
	cd lwlib    && $(MAKE) $(MFLAGS) mostlyclean
	cd lib      && $(MAKE) $(MFLAGS) mostlyclean
	cd lib-src  && $(MAKE) $(MFLAGS) mostlyclean
	cd nt       && $(MAKE) $(MFLAGS) mostlyclean
	-cd doc/emacs     && $(MAKE) $(MFLAGS) mostlyclean
	-cd doc/misc      && $(MAKE) $(MFLAGS) mostlyclean
	-cd doc/lispref   && $(MAKE) $(MFLAGS) mostlyclean
	-cd doc/lispintro && $(MAKE) $(MFLAGS) mostlyclean

### `clean'
###      Delete all files from the current directory that are normally
###      created by building the program.  Don't delete the files that
###      record the configuration.  Also preserve files that could be made
###      by building, but normally aren't because the distribution comes
###      with them.
###
###      Delete `.dvi' files here if they are not part of the distribution.
clean: FRC
	-rm -f etc/emacs.tmpdesktop
	cd src      && $(MAKE) $(MFLAGS) clean
	cd oldXMenu && $(MAKE) $(MFLAGS) clean
	cd lwlib    && $(MAKE) $(MFLAGS) clean
	cd lib      && $(MAKE) $(MFLAGS) clean
	cd lib-src  && $(MAKE) $(MFLAGS) clean
	cd nt       && $(MAKE) $(MFLAGS) clean
	-cd doc/emacs     && $(MAKE) $(MFLAGS) clean
	-cd doc/misc      && $(MAKE) $(MFLAGS) clean
	-cd doc/lispref   && $(MAKE) $(MFLAGS) clean
	-cd doc/lispintro && $(MAKE) $(MFLAGS) clean
	cd nextstep && $(MAKE) $(MFLAGS) clean

### `bootclean'
###      Delete all files that need to be remade for a clean bootstrap.
top_bootclean=\
	rm -f config.cache config.log
### `distclean'
###      Delete all files from the current directory that are created by
###      configuring or building the program.  If you have unpacked the
###      source and built the program without creating any other files,
###      `make distclean' should leave only the files that were in the
###      distribution.
top_distclean=\
	${top_bootclean}; \
	rm -f config.status config.log~ Makefile stamp-h1 ${SUBDIR_MAKEFILES}
distclean: FRC
	cd src      && $(MAKE) $(MFLAGS) distclean
	cd oldXMenu && $(MAKE) $(MFLAGS) distclean
	cd lwlib    && $(MAKE) $(MFLAGS) distclean
	cd lib      && $(MAKE) $(MFLAGS) distclean
	cd lib-src  && $(MAKE) $(MFLAGS) distclean
	cd nt       && $(MAKE) $(MFLAGS) distclean
	cd doc/emacs     && $(MAKE) $(MFLAGS) distclean
	cd doc/misc      && $(MAKE) $(MFLAGS) distclean
	cd doc/lispref   && $(MAKE) $(MFLAGS) distclean
	cd doc/lispintro && $(MAKE) $(MFLAGS) distclean
	cd leim     && $(MAKE) $(MFLAGS) distclean
	cd lisp     && $(MAKE) $(MFLAGS) distclean
	cd nextstep && $(MAKE) $(MFLAGS) distclean
	for dir in test/automated admin/grammars admin/unidata; do \
	  [ ! -d $$dir ] || (cd $$dir && $(MAKE) $(MFLAGS) distclean); \
	done
	${top_distclean}

### `bootstrap-clean'
###      Delete everything that can be reconstructed by `make' and that
###      needs to be deleted in order to force a bootstrap from a clean state.
bootstrap-clean: FRC
	cd src      && $(MAKE) $(MFLAGS) bootstrap-clean
	cd oldXMenu && $(MAKE) $(MFLAGS) maintainer-clean
	cd lwlib    && $(MAKE) $(MFLAGS) maintainer-clean
	cd lib      && $(MAKE) $(MFLAGS) maintainer-clean
	cd lib-src  && $(MAKE) $(MFLAGS) maintainer-clean
	cd nt       && $(MAKE) $(MFLAGS) maintainer-clean
	-cd doc/emacs     && $(MAKE) $(MFLAGS) maintainer-clean
	-cd doc/misc      && $(MAKE) $(MFLAGS) maintainer-clean
	-cd doc/lispref   && $(MAKE) $(MFLAGS) maintainer-clean
	-cd doc/lispintro && $(MAKE) $(MFLAGS) maintainer-clean
	cd leim     && $(MAKE) $(MFLAGS) bootstrap-clean
	cd lisp     && $(MAKE) $(MFLAGS) bootstrap-clean
	cd nextstep && $(MAKE) $(MFLAGS) maintainer-clean
	for dir in test/automated admin/grammars admin/unidata; do \
	  [ ! -d $$dir ] || (cd $$dir && $(MAKE) $(MFLAGS) bootstrap-clean); \
	done
	[ ! -f config.log ] || mv -f config.log config.log~
	rm -rf ${srcdir}/info
	${top_bootclean}

### `maintainer-clean'
###      Delete everything from the current directory that can be
###      reconstructed with this Makefile.  This typically includes
###      everything deleted by distclean, plus more: C source files
###      produced by Bison, tags tables, info files, and so on.
###
###      One exception, however: `make maintainer-clean' should not delete
###      `configure' even if `configure' can be remade using a rule in the
###      Makefile.  More generally, `make maintainer-clean' should not delete
###      anything that needs to exist in order to run `configure' and then
###      begin to build the program.
top_maintainer_clean=\
	${top_distclean}; \
	rm -fr autom4te.cache
maintainer-clean: bootstrap-clean FRC
	cd src  && $(MAKE) $(MFLAGS) maintainer-clean
	cd leim && $(MAKE) $(MFLAGS) maintainer-clean
	cd lisp && $(MAKE) $(MFLAGS) maintainer-clean
	for dir in test/automated admin/grammars admin/unidata; do \
	  [ ! -d $$dir ] || (cd $$dir && $(MAKE) $(MFLAGS) maintainer-clean); \
	done
	${top_maintainer_clean}

### This doesn't actually appear in the coding standards, but Karl
### says GCC supports it, and that's where the configuration part of
### the coding standards seem to come from.  It's like distclean, but
### it deletes backup and autosave files too.
extraclean:
	for i in ${SUBDIR}; do (cd $$i; $(MAKE) $(MFLAGS) extraclean); done
	${top_maintainer_clean}
	-rm -f config-tmp-*
	-rm -f *~ \#*

# The src subdir knows how to do the right thing
# even when the build directory and source dir are different.
.PHONY: TAGS tags
TAGS tags: lib lib-src src
	cd src; $(MAKE) $(MFLAGS) tags

check: all
	@if test ! -d test/automated; then \
	  echo "You do not seem to have the test/ directory."; \
	  echo "Maybe you are using a release tarfile, rather than a repository checkout."; \
	else \
	  cd test/automated && $(MAKE) $(MFLAGS) check; \
	fi

dist:
	cd ${srcdir}; ./make-dist

DVIS  = lispref-dvi  lispintro-dvi  emacs-dvi  misc-dvi
HTMLS = lispref-html lispintro-html emacs-html misc-html
INFOS = lispref-info lispintro-info emacs-info misc-info
PDFS  = lispref-pdf  lispintro-pdf  emacs-pdf  misc-pdf
PSS   = lispref-ps   lispintro-ps   emacs-ps   misc-ps

DOCS = $(DVIS) $(HTMLS) $(INFOS) $(PDFS) $(PSS)
$(DOCS):
	t=$@; IFS=-; set $$t; IFS=; cd doc/$$1 && $(MAKE) $(MFLAGS) $$2

.PHONY: $(DOCS) docs pdf ps
.PHONY: info dvi dist check html info-real info-dir force-info check-info

## TODO add etc/refcards.
docs: $(DOCS)
dvi: $(DVIS)
html: $(HTMLS)
info-real: $(INFOS)
pdf: $(PDFS)
ps: $(PSS)

info-dir: ${srcdir}/info/dir

## Not strictly necessary, but speeds things up a bit by stopping
## the info-dir rule from running when not needed.
## Hopefully doc/misc/*.texi is not too long for some systems?
info_dir_deps = ${srcdir}/build-aux/dir_top \
	${srcdir}/doc/emacs/emacs.texi \
	${srcdir}/doc/lispintro/emacs-lisp-intro.texi \
	${srcdir}/doc/lispref/elisp.texi ${srcdir}/doc/misc/*.texi

## It would be much simpler if info/dir was only created in the
## installation location by the install-info rule, but we also
## need one in the source directory for people running uninstalled.
## FIXME it would be faster to use the install-info program if we have it,
## but then we would need to depend on info-real, which would
## slow down parallelization.
${srcdir}/info/dir: ${info_dir_deps}
	tempfile=info-dir.$$$$; \
	rm -f $${tempfile}; \
	thisdir=`pwd`; \
	(cd ${srcdir} && ./build-aux/make-info-dir $${thisdir}/$${tempfile}); \
	${srcdir}/build-aux/move-if-change $${tempfile} ${srcdir}/info/dir

INSTALL_DVI = install-emacs-dvi install-lispref-dvi \
	install-lispintro-dvi install-misc-dvi
INSTALL_HTML = install-emacs-html install-lispref-html \
	install-lispintro-html install-misc-html
INSTALL_PDF = install-emacs-pdf install-lispref-pdf \
	install-lispintro-pdf install-misc-pdf
INSTALL_PS = install-emacs-ps install-lispref-ps \
	install-lispintro-ps install-misc-ps
INSTALL_DOC = $(INSTALL_DVI) $(INSTALL_HTML) $(INSTALL_PDF) $(INSTALL_PS)

## Install non .info forms of the documentation.
## TODO add etc/refcards.
$(INSTALL_DOC):
	t=$@; IFS=-; set $$t; IFS=; cd doc/$$2 && $(MAKE) $(MFLAGS) $$1-$$3

.PHONY: $(INSTALL_DOC) install-doc
.PHONY: install-dvi install-html install-pdf install-ps

install-doc: $(INSTALL_DOC)
install-dvi: $(INSTALL_DVI)
install-html: $(INSTALL_HTML)
install-pdf: $(INSTALL_PDF)
install-ps: $(INSTALL_PS)


UNINSTALL_DVI = uninstall-emacs-dvi uninstall-lispref-dvi \
	uninstall-lispintro-dvi uninstall-misc-dvi
UNINSTALL_HTML = uninstall-emacs-html uninstall-lispref-html \
	uninstall-lispintro-html uninstall-misc-html
UNINSTALL_PDF = uninstall-emacs-pdf uninstall-lispref-pdf \
	uninstall-lispintro-pdf uninstall-misc-pdf
UNINSTALL_PS = uninstall-emacs-ps uninstall-lispref-ps \
	uninstall-lispintro-ps uninstall-misc-ps
UNINSTALL_DOC = $(UNINSTALL_DVI) $(UNINSTALL_HTML) $(UNINSTALL_PDF) $(UNINSTALL_PS)

$(UNINSTALL_DOC):
	t=$@; IFS=-; set $$t; IFS=; cd doc/$$2 && $(MAKE) $(MFLAGS) $$1-$$3

.PHONY: $(UNINSTALL_DOC) uninstall-doc
.PHONY: uninstall-dvi uninstall-html uninstall-pdf uninstall-ps

uninstall-doc: $(UNINSTALL_DOC)
uninstall-dvi: $(UNINSTALL_DVI)
uninstall-html: $(UNINSTALL_HTML)
uninstall-pdf: $(UNINSTALL_PDF)
uninstall-ps: $(UNINSTALL_PS)


force-info:
# Note that man/Makefile knows how to put the info files in $(srcdir),
# so we can do ok running make in the build dir.
# This used to have a clause that exited with an error if MAKEINFO = no.
# But it is inappropriate to do so without checking if makeinfo is
# actually needed - it is not if the info files are up-to-date.  (Bug#3982)
# Only the doc/*/Makefiles can decide that, so we let those rules run
# and give a standard error if makeinfo is needed but missing.
# While it would be nice to give a more detailed error message, that
# would require changing every rule in doc/ that builds an info file,
# and it's not worth it.  This case is only relevant if you download a
# release, then change the .texi files.
info: force-info
	@if test "$(HAVE_MAKEINFO)" = "no"; then \
	  echo "Configured --without-makeinfo, not building manuals" ; \
	else \
	  $(MAKE) $(MFLAGS) info-real info-dir; \
	fi

## build-aux/make-info-dir expects only certain dircategories.
check-info: info
	cd info ; \
	bad= ; \
	for file in *; do \
	  test -f "$${file}" || continue ; \
	  case $${file} in \
	    *-[0-9]*|COPYING|dir) continue ;; \
	  esac ; \
	  cat=`sed -n 's/^INFO-DIR-SECTION //p' $${file}`; \
	  case $${cat} in \
	   "Texinfo documentation system" | "Emacs"| "Emacs lisp" | \
           "Emacs editing modes" | "Emacs network features" | \
	   "Emacs misc features" | "Emacs lisp libraries" ) : ;; \
	   *)  bad="$${bad} $${file}" ;; \
	  esac; \
	done ; \
	if test -n "$${bad}"; then \
	  echo "Unexpected dircategory in: $${bad}" ; \
	  exit 1 ; \
	fi ; \
	echo "info files are OK"

#### Bootstrapping.

### This first cleans the lisp subdirectory, removing all compiled
### Lisp files.  Then re-run make to build all the files anew.

.PHONY: bootstrap

# Bootstrapping does the following:
#  * Remove files to start from a bootstrap-clean slate.
#  * Run autogen.sh.
#  * Rebuild Makefile, to update the build procedure itself.
#  * Do the actual build.
bootstrap: bootstrap-clean FRC
	cd $(srcdir) && ./autogen.sh
	$(MAKE) $(MFLAGS) MAKEFILE_NAME=force-Makefile force-Makefile
	$(MAKE) $(MFLAGS) info all

.PHONY: check-declare

check-declare:
	@if [ ! -f $(srcdir)/src/emacs ]; then \
	  echo "You must build Emacs to use this command"; \
	  exit 1; \
	fi
	cd lisp && $(MAKE) $(MFLAGS) $@
