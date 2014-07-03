# Start of settings from configure.bat 
COMPILER=gcc
MCPU_FLAG=-mtune=pentium4
DEBUG_INFO=-gdwarf-2 -g3
# End of settings from configure.bat
 
#  -*- Makefile -*- definition file for building GNU Emacs on Windows NT.
# Copyright (C) 2000-2013 Free Software Foundation, Inc.

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

# Ensure 'all' is the default target
all:

# NOTES
#
# I tried to force gmake to use the native shell for simplicity, by
# setting SHELL as below, but this didn't work reliably because of
# various case sensitivity niggles.  Specifically, COMSPEC (which is in
# fact usually spelled ComSpec on NT, to make life difficult) typically
# references "cmd.exe" (on NT) when the file is actually called
# "CMD.EXE" on disk for hysterical raisons.  As a result, GNU make
# thinks it doesn't exist (unless compiled with a switch to ignore
# case), and so doesn't change which shell it will invoke to execute
# commands.
#
# It would be possible, though very tedious using just gmake facilities,
# to convert the COMSPEC value to uppercase to solve this problem, but
# it isn't worth it.  That is partly because, even when using the native
# shell, gmake tends to not be happy with backslashes in command
# strings.  The obvious solution is to use forward slashes as much as
# possible, which can be made to work most of the time (putting
# filenames in quotes often helps), but there are still some internal
# cmd.exe commands like `del' and `copy' that won't work with them.
# Although it is possible to convert slashes to backslashes when
# necessary, gmake requires explicitly calling its subst function, which
# nmake does not understand).  For this reason, it is simplest to
# mandate that rm and cp be available, so we can use Unix-format file
# names everywhere.  (Fortunately both MS and GNU make, and the
# respective compilers, are happy with Unix-format names.)
#
# Since we cannot easily force the choice of a particular shell, we must
# make the effort to cope with whichever shell is being used.
# Fortunately, the only command we need to use that is shell specific is
# the testing of a file's existence for the purpose of working out when
# we are copying files to their original location.  That particular
# requirement is abstracted easily enough.
#
# The only other problem area was the change of directory when running
# temacs to dump emacs.exe (where gmake doesn't support cd foo in any
# useful way), but that has been resolved by modifying the Windows
# unexec function slightly to not require the directory change while
# still allowing objects and binaries to be in subdirectories.

# This doesn't work.
#SHELL:=$(COMSPEC)

# Determine whether make is using sh or cmd/command as shell; cmd.exe
# will output "ECHO is on" when echo is given by itself, while sh will
# not produce any output.
sh_output := $(shell echo)
ifeq "$(findstring ECHO, $(sh_output))" "ECHO"
THE_SHELL = $(COMSPEC)$(ComSpec)
SHELLTYPE=CMD
else
USING_SH = 1
THE_SHELL = $(SHELL)
SHELLTYPE=SH
endif

MAKETYPE=gmake

# The following "ifeq" does not appear to DTRT, and therefore breaks
# the build on mingw32. Also the -m option does not exist in many
# (reasonably recent even) versions of Cygwin. These issues need to be
# remedied before putting this cygpath kludge back in.

# Convert CURDIR to native file name, if in Cygwin format
#ifeq "$(shell cygpath $(CURDIR))" "$(CURDIR)"
#CURDIR	        := $(shell cygpath -m $(CURDIR))
#endif

THISDIR		= .

# Cygwin has changed quoting rules somewhat since b20, in a way that
# affects makefiles using sh as the command processor, so we need to
# detect which rules to use.
ifdef USING_SH
sh_output := $(shell echo [Please ignore a syntax error on the next line - it is intentional] 1>&2)
sh_output := $(shell echo foo")
# This single quote " is to fix fontification due to previous line
ifeq "$(sh_output)" ""
NEW_CYGWIN = 1
endif

# By default, newer versions of Cygwin mess with NTFS ACLs in an
# attempt to emulate traditional posix file permissions. This can
# cause bad effects, such as .exe files that are missing the
# FILE_EXECUTE/FILE_GENERIC_EXECUTE permissions when they are created
# with Cygwin commands that don't expect to be creating executable
# files. Then when we later use a non-Cygwin program to create the
# real .exe, the previous Cygwin defined ACL sticks.
CYGWIN=nontsec
export CYGWIN
endif

ALL_DEPS	= $^
EMPTY =
SPACE = $(EMPTY) $(EMPTY)

SUBSYSTEM_WINDOWS=-Wl,-subsystem,windows
SUBSYSTEM_CONSOLE=-Wl,-subsystem,console

# INSTALL_DIR is the directory into which emacs will be installed.
#
ifndef INSTALL_DIR
INSTALL_DIR     = $(CURDIR)/..
endif

export EMACSLOADPATH

# Determine the architecture we're running on.
# Define ARCH for our purposes;
# Define CPU for use by ntwin32.mak;
# Define CONFIG_H to the appropriate config.h for the system;
#
ifdef PROCESSOR_ARCHITECTURE
# We're on Windows NT
CPU		= $(PROCESSOR_ARCHITECTURE)
CONFIG_H	= config.nt
OS_TYPE		= windowsnt
 ifeq "$(PROCESSOR_ARCHITECTURE)" "x86"
ARCH		= i386
CPU		= i386
EMACS_HEAPSIZE	= 27
EMACS_PURESIZE	= 5000000
EMACS_MANIFEST	= emacs-x86.manifest
 else
  ifeq "$(PROCESSOR_ARCHITECTURE)" "MIPS"
ARCH		= mips
EMACS_HEAPSIZE	= 27
EMACS_PURESIZE	= 5000000
EMACS_MANIFEST	= emacs-mips.manifest
  else
   ifeq "$(PROCESSOR_ARCHITECTURE)" "ALPHA"
ARCH		= alpha
EMACS_HEAPSIZE	= 27
EMACS_PURESIZE	= 5000000
EMACS_MANIFEST	= emacs-alpha.manifest
   else
    ifeq "$(PROCESSOR_ARCHITECTURE)" "PPC"
ARCH		= ppc
EMACS_HEAPSIZE	= 27
EMACS_PURESIZE	= 5000000
EMACS_MANIFEST	= emacs-ppc.manifest
    else
     $(error Unknown architecture type "$(PROCESSOR_ARCHITECTURE)")
    endif
   endif
  endif
 endif
else
# We're on Windows 95
ARCH		= i386
CPU		= i386
CONFIG_H	= config.nt
OS_TYPE		= windows95
endif

AR		= ar -rsc
AR_OUT		=
CC		= gcc
CC_OUT		= -o$(SPACE)
LINK		= gcc
LINK_OUT	= -o$(SPACE)
RC		= windres -O coff
RC_OUT		= -o$(SPACE)
RC_INCLUDE	= --include-dir$(SPACE)

libc		=
baselibs	=
O		= o
A		= a

BASE_LIBS	= $(libc) $(baselibs)

ADVAPI32	= -ladvapi32
COMCTL32	= -lcomctl32
COMDLG32	= -lcomdlg32
GDI32		= -lgdi32
MPR		= -lmpr
SHELL32		= -lshell32
USER32		= -luser32
WSOCK32		= -lwsock32
WINMM		= -lwinmm
WINSPOOL	= -lwinspool
OLE32		= -lole32
UNISCRIBE	= -lusp10
UUID		= -luuid

# Used by src/makefile.w32-in, since Nmake barfs on $(func SOMETHING)
OBJ0_c		= $(patsubst $(BLD)%.$(O),$(CURDIR)%.c,$(OBJ0))
OBJ1_c		= $(patsubst $(BLD)%.$(O),$(CURDIR)%.c,$(OBJ1))
OBJ2_c		= $(patsubst $(BLD)%.$(O),$(CURDIR)%.c,$(OBJ2))

ifdef NOOPT
DEBUG_CFLAGS	= -DEMACSDEBUG -fno-crossjumping -std=gnu99
else
DEBUG_CFLAGS	=
endif

MWINDOWS        = -mwindows

CFLAGS          = -I. $(ARCH_CFLAGS) $(DEBUG_CFLAGS) $(PROFILE_CFLAGS) $(USER_CFLAGS) $(LOCAL_FLAGS)
ESC_CFLAGS      = -I. $(ARCH_CFLAGS) $(DEBUG_CFLAGS) $(PROFILE_CFLAGS) $(ESC_USER_CFLAGS) $(LOCAL_FLAGS)
EMACS_EXTRA_C_FLAGS = -DUSE_CRT_DLL=1

ifdef PROFILE
PROFILE_CFLAGS  = -pg
PROFILE_LDFLAGS  = -pg
else
PROFILE_CFLAGS  =
PROFILE_LDFLAGS =
endif


# see comments in allocate_heap in w32heap.c before changing any of the
# -stack, -heap, or -image-base settings.
TEMACS_EXTRA_LINK = -Wl,-stack,0x00800000 -Wl,-heap,0x00100000 -Wl,-image-base,0x01000000 $(SUBSYSTEM_CONSOLE) -Wl,-entry,__start -Wl,-Map,$(BLD)/temacs.map

ifdef NOOPT
OBJDIR          = oo
else
OBJDIR          = oo-spd
endif
$(OBJDIR):;	-mkdir "$(OBJDIR)"
BLD             = $(OBJDIR)/$(ARCH)
stamp_BLD:      $(OBJDIR)
		-mkdir "$(BLD)"
		echo $(BLD) > $@

COMPILER_TEMP_FILES =

CP		= cp -f
CP_DIR		= cp -rf
DEL		= rm
DEL_TREE	= rm -r

DIRNAME		= $(notdir $(CURDIR))

ifdef USING_SH

IFNOTSAMEDIR	= if [ ! -s ../$(DIRNAME)_same-dir.tst ] ; then
FOREACH		= for f in
FORVAR		= $${f}
FORDO		= ; do
ENDFOR		= ; done
ENDIF		= ; fi
ARGQUOTE	= '
ifdef NEW_CYGWIN
DQUOTE		= "
else
DQUOTE		= ""
endif

else

IFNOTSAMEDIR	= if not exist ../$(DIRNAME)_same-dir.tst
FOREACH		= for %%f in (
FORVAR		= %%f
FORDO		= ) do
ENDFOR		=
ENDIF		=
ARGQUOTE	= "
DQUOTE		= \"

endif

ifdef NODEBUG
DEBUG_FLAG =
DEBUG_LINK =
else
DEBUG_FLAG = $(DEBUG_INFO)
DEBUG_LINK = $(DEBUG_INFO)
endif

ifdef NOCYGWIN
NOCYGWIN = -mno-cygwin
endif

ifdef USER_LIBS
USER_LIBS := $(patsubst %,-l%,$(USER_LIBS))
endif

PRAGMA_SYSTEM_HEADER = \#pragma GCC system_header

ifeq "$(ARCH)" "i386"
ifdef NOOPT
ARCH_CFLAGS     = -c $(DEBUG_FLAG) $(NOCYGWIN)
else
ARCH_CFLAGS     = -c $(DEBUG_FLAG) $(NOCYGWIN) $(MCPU_FLAG) -O2 \
		  # -fbuiltin \
		  # -finline-functions \
		  # -fomit-frame-pointer
endif
ARCH_LDFLAGS	= $(SYS_LDFLAGS)
else
ERROR Unknown architecture type "$(ARCH)".
endif

LINK_FLAGS	= $(ARCH_LDFLAGS) $(DEBUG_LINK) $(PROFILE_LDFLAGS) $(NOCYGWIN) $(USER_LDFLAGS)

export XMFLAGS

.DEFAULT:

$(BLD)/%.o: %.c
		$(CC) $(CFLAGS) $(CC_OUT)$@ $<
# -*- Makefile -*- for GNU Emacs on the Microsoft Windows API.
# Copyright (C) 2000-2013 Free Software Foundation, Inc.
#
# Top level makefile for building GNU Emacs on Windows NT
#
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


# FIXME: This file uses DOS EOLs.  Convert to Unix after 22.1 is out
#        (and remove or replace this comment).

VERSION		= 24.3

TMP_DIST_DIR 	= emacs-$(VERSION)

TRES		= $(BLD)/emacs.res
CLIENTRES	= $(BLD)/emacsclient.res

XMFLAGS		=

ALL		= addpm ddeclient runemacs cmdproxy addsection preprep

.PHONY: $(ALL)


addpm:		  stamp_BLD $(BLD)/addpm.exe
$(BLD)/addpm.exe: $(BLD)/addpm.$(O)
		  $(LINK) $(LINK_OUT)$@ \
		  $(LINK_FLAGS) $(ALL_DEPS) $(BASE_LIBS) $(ADVAPI32) \
		  $(USER32) $(OLE32) $(UUID) $(SHELL32)

ddeclient:	  stamp_BLD $(BLD)/ddeclient.exe
$(BLD)/ddeclient.exe: $(BLD)/ddeclient.$(O)
		  $(LINK) $(LINK_OUT)$@ \
		  $(LINK_FLAGS) $(ALL_DEPS) $(BASE_LIBS) $(ADVAPI32) $(USER32)

cmdproxy:	  stamp_BLD $(BLD)/cmdproxy.exe
$(BLD)/cmdproxy.exe: $(BLD)/cmdproxy.$(O)
		  $(LINK) $(LINK_OUT)$@ \
		  $(LINK_FLAGS) $(ALL_DEPS) $(BASE_LIBS) $(USER32)

addsection:	  stamp_BLD $(BLD)/addsection.exe
$(BLD)/addsection.exe: $(BLD)/addsection.$(O)
		  $(LINK) $(LINK_OUT)$@ \
		  $(LINK_FLAGS) $(ALL_DEPS) $(BASE_LIBS) $(USER32)

preprep:	  stamp_BLD $(BLD)/preprep.exe
$(BLD)/preprep.exe: $(BLD)/preprep.$(O)
		  $(LINK) $(LINK_OUT)$@ \
		  $(LINK_FLAGS) $(ALL_DEPS) $(BASE_LIBS)

#
# The resource file.  NT 3.10 requires the use of cvtres; even though
# it is not necessary on later versions, it is still ok to use it.
#
$(TRES):	emacs.rc icons/emacs.ico $(EMACS_MANIFEST) stamp_BLD
		$(RC) $(RC_OUT)$(TRES) emacs.rc

$(CLIENTRES):	emacsclient.rc stamp_BLD
		$(RC) $(RC_OUT)$(CLIENTRES) emacsclient.rc

runemacs:	  stamp_BLD $(BLD)/runemacs.exe
$(BLD)/runemacs.exe: $(BLD)/runemacs.$(O) $(TRES)
		  $(LINK) $(LINK_OUT)$@ $(SUBSYSTEM_WINDOWS) \
		  $(LINK_FLAGS) $(ALL_DEPS) $(BASE_LIBS) $(ADVAPI32) $(USER32)

which-sh:
	@echo Using $(THE_SHELL) as shell.

# These depend on stamp_BLD to make sure the $(BLD) directory is created
# before the compilation begins, even if Make runs several commands
# in parallel under "make -j".
#
$(BLD)/addpm.$(O) $(BLD)/ddeclient.$(O) $(BLD)/runemacs.$(O) $(BLD)/cmdproxy.$(O) $(BLD)/addsection.$(O) $(BLD)/preprep.$(O): stamp_BLD

#
# Build emacs
#
all:	which-sh $(ALL) $(CLIENTRES) all-other-dirs-$(MAKETYPE)

all-other-dirs-$(MAKETYPE): maybe-bootstrap

all-other-dirs-nmake: addsection
	cd ..\lib
	$(MAKE) $(MFLAGS) all
	cd ..\lib-src
	$(MAKE) $(MFLAGS) all
	cd ..\src
	$(MAKE) $(MFLAGS) all
	cd ..\lisp
	$(MAKE) $(MFLAGS) all
	cd ..\leim
	$(MAKE) $(MFLAGS) all
	cd ..\nt

all-other-dirs-gmake: addsection
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib all
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src all
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src all
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp all
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../leim all

recompile:	recompile-$(MAKETYPE)

recompile-nmake:
	cd ..\lisp
	$(MAKE) $(MFLAGS) recompile
	cd ..\nt

recompile-gmake:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp recompile

#### Bootstrapping.

### This is meant for Emacs maintainers only.  It first cleans the
### lisp subdirectory, removing all compiled Lisp files.  Then a
### special emacs executable is built from Lisp sources, which is then
### used to compile Lisp files.  The last step is a "normal" make.

maybe-bootstrap: maybe-bootstrap-$(SHELLTYPE)

# dummy target to force other targets to be evaluated.
doit:

maybe-bootstrap-CMD:	doit
	@echo .
	@if not EXIST ..\lisp\abbrev.elc echo Essential Lisp files seem to be missing.  You should either
	@if not EXIST ..\lisp\abbrev.elc echo do 'make bootstrap' or create 'lisp/abbrev.elc' somehow
	@echo .
	@if not EXIST ..\lisp\abbrev.elc exit -1

maybe-bootstrap-SH: doit
	@if [ ! -f ../lisp/abbrev.elc ] ; then \
	  echo; \
	  echo "Essential Lisp files seem to be missing.  You should either"; \
	  echo "do \`make bootstrap' or create \`lisp/abbrev.elc' somehow.";  \
	  echo; \
	  exit -1; \
	fi

# Bootstrap depends on cmdproxy because some Lisp functions
# loaded during bootstrap may need to run shell commands.
bootstrap:	addsection cmdproxy bootstrap-$(MAKETYPE)
	$(MAKE) $(MFLAGS) $(XMFLAGS) all

bootstrap-nmake: addsection cmdproxy
	cd ..\lisp
	$(MAKE) $(MFLAGS) bootstrap-clean
	cd ..\src
	$(MAKE) $(MFLAGS) clean
	cd ..\lib-src
	$(MAKE) $(MFLAGS) clean make-docfile
	cd ..\lib
	$(MAKE) $(MFLAGS) clean all
	cd ..\src
	$(MAKE) $(MFLAGS) bootstrap
	$(MAKE) $(MFLAGS) bootstrap-clean
	cd ..\nt
	$(CP) $(BLD)/cmdproxy.exe ../bin
	cd ..\lisp
	$(MAKE) $(MFLAGS) SHELL=$(SHELLTYPE) bootstrap
	cd ..\lib-src
	$(MAKE) $(MFLAGS) DOC
	cd ..\nt

bootstrap-gmake: addsection cmdproxy
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp bootstrap-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src make-docfile
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib all
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src bootstrap
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src bootstrap-clean
	$(CP) $(BLD)/cmdproxy.exe ../bin
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp bootstrap
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src DOC

bootstrap-clean: bootstrap-clean-$(MAKETYPE)

bootstrap-clean-nmake:
	cd ..\src
	$(MAKE) $(MFLAGS) bootstrap-clean
	cd ..\lib
	$(MAKE) $(MFLAGS) clean
	cd ..\lisp
	$(MAKE) $(MFLAGS) bootstrap-clean

bootstrap-clean-gmake:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src bootstrap-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp bootstrap-clean

$(INSTALL_DIR):
	- mkdir "$(INSTALL_DIR)"

$(INSTALL_DIR)/bin: $(INSTALL_DIR)
	- mkdir "$(INSTALL_DIR)/bin"

#
# Build and install emacs in INSTALL_DIR
#
.PHONY: install-bin install-shortcuts

install: install-bin install-shortcuts

install-bin: all $(INSTALL_DIR)/bin install-other-dirs-$(MAKETYPE)
	- $(CP) $(BLD)/ddeclient.exe $(INSTALL_DIR)/bin
	- $(CP) $(BLD)/cmdproxy.exe $(INSTALL_DIR)/bin
	- $(CP) $(BLD)/runemacs.exe $(INSTALL_DIR)/bin
	- $(CP) README.W32 $(INSTALL_DIR)
	- $(DEL) ../$(DIRNAME)_same-dir.tst
	- $(DEL) $(INSTALL_DIR)/$(DIRNAME)_same-dir.tst
	echo SameDirTest > "$(INSTALL_DIR)/$(DIRNAME)_same-dir.tst"
	- mkdir "$(INSTALL_DIR)/etc"
	- mkdir "$(INSTALL_DIR)/info"
	- mkdir "$(INSTALL_DIR)/lock"
	- mkdir "$(INSTALL_DIR)/data"
	- mkdir "$(INSTALL_DIR)/site-lisp"
	- mkdir "$(INSTALL_DIR)/etc/icons"
	$(IFNOTSAMEDIR) $(CP) ../site-lisp/subdirs.el $(INSTALL_DIR)/site-lisp $(ENDIF)
	$(IFNOTSAMEDIR) $(CP_DIR) ../etc $(INSTALL_DIR) $(ENDIF)
	- $(CP_DIR) icons $(INSTALL_DIR)/etc
	$(IFNOTSAMEDIR) $(CP_DIR) ../info $(INSTALL_DIR) $(ENDIF)
	$(IFNOTSAMEDIR) $(CP) ../COPYING $(INSTALL_DIR) $(ENDIF)
	- $(CP) ../COPYING $(INSTALL_DIR)/bin
	- $(DEL) ../$(DIRNAME)_same-dir.tst
	- $(DEL) $(INSTALL_DIR)/$(DIRNAME)_same-dir.tst

install-other-dirs-nmake: all
	cd ..\lib-src
	$(MAKE) $(MFLAGS) install
	cd ..\src
	$(MAKE) $(MFLAGS) install
	cd ..\lisp
	$(MAKE) $(MFLAGS) install
	cd ..\leim
	$(MAKE) $(MFLAGS) install
	cd ..\nt

install-other-dirs-gmake: all
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src install
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src install
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp install
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../leim install

install-addpm: $(INSTALL_DIR)/bin addpm
	- $(CP) $(BLD)/addpm.exe $(INSTALL_DIR)/bin

install-shortcuts: install-addpm
	"$(INSTALL_DIR)/bin/addpm" -q

maybe-copy-distfiles: maybe-copy-distfiles-$(SHELLTYPE)

maybe-copy-distfiles-CMD: create-tmp-dist-dir doit
	@if not $(ARGQUOTE)$(DIST_FILES)$(ARGQUOTE) == "" $(CP_DIR) $(DIST_FILES) $(TMP_DIST_DIR)/bin

maybe-copy-distfiles-SH: create-tmp-dist-dir doit
	@if [ ! $(ARGQUOTE)$(DIST_FILES)$(ARGQUOTE) == "" ] ; then \
	  $(CP_DIR) $(DIST_FILES) $(TMP_DIST_DIR)/bin ; \
	fi

create-tmp-dist-dir:
	mkdir "$(TMP_DIST_DIR)"
# Also create bin directory for dist files.
	mkdir "$(TMP_DIST_DIR)/bin"

dist: install-bin install-addpm maybe-copy-distfiles
	$(CP) "$(INSTALL_DIR)/BUGS" $(TMP_DIST_DIR)
	$(CP) "$(INSTALL_DIR)/COPYING" $(TMP_DIST_DIR)
	$(CP) "$(INSTALL_DIR)/README" $(TMP_DIST_DIR)
	$(CP) "$(INSTALL_DIR)/README.W32" $(TMP_DIST_DIR)
	$(CP_DIR) "$(INSTALL_DIR)/bin" $(TMP_DIST_DIR)
	$(CP_DIR) "$(INSTALL_DIR)/etc" $(TMP_DIST_DIR)
	$(CP_DIR) "$(INSTALL_DIR)/info" $(TMP_DIST_DIR)
	$(CP_DIR) "$(INSTALL_DIR)/lisp" $(TMP_DIST_DIR)
	$(CP_DIR) "$(INSTALL_DIR)/leim" $(TMP_DIST_DIR)
	$(CP_DIR) "$(INSTALL_DIR)/site-lisp" $(TMP_DIST_DIR)
	$(COMSPEC)$(ComSpec) /c $(ARGQUOTE)zipdist.bat $(VERSION)$(ARGQUOTE)
	$(DEL_TREE) $(TMP_DIST_DIR)

force-info:
# Note that doc/emacs/makefile knows how to
# put the info files in $(infodir),
# so we can do ok running make in the build dir.
info: force-info info-$(MAKETYPE)

info-nmake:
	cd ..\doc\emacs
	$(MAKE) $(MFLAGS) info
	cd ..\misc
	$(MAKE) $(MFLAGS) info
	cd ..\lispref
	$(MAKE) $(MFLAGS) info
	cd ..\lispintro
	$(MAKE) $(MFLAGS) info
	cd $(MAKEDIR)

info-gmake: emacs misc lispref lispintro

emacs misc lispref lispintro:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/$@ info

#
# Maintenance
#
clean:	clean-other-dirs-$(MAKETYPE)
	- $(DEL) $(COMPILER_TEMP_FILES)
	- $(DEL_TREE) $(OBJDIR)
	- $(DEL) stamp_BLD
	- $(DEL) ../etc/DOC ../etc/DOC-X

clean-other-dirs-nmake:
	cd ..\lib
	$(MAKE) $(MFLAGS) clean
	cd ..\lib-src
	$(MAKE) $(MFLAGS) clean
	cd ..\src
	$(MAKE) $(MFLAGS) clean
	cd ..\doc\lispintro
	$(MAKE) $(MFLAGS) clean
	cd ..\lispref
	$(MAKE) $(MFLAGS) clean
	cd ..\..\leim
	$(MAKE) $(MFLAGS) clean
	cd ..\doc\emacs
	$(MAKE) $(MFLAGS) clean
	cd ..\misc
	$(MAKE) $(MFLAGS) clean
	cd ..\..\nt

clean-other-dirs-gmake:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../leim clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/emacs clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/misc clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/lispintro clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/lispref clean

cleanall-other-dirs-nmake:
	cd ..\lib
	$(MAKE) $(MFLAGS) cleanall
	cd ..\lib-src
	$(MAKE) $(MFLAGS) cleanall
	cd ..\src
	$(MAKE) $(MFLAGS) cleanall
	cd ..\nt

cleanall-other-dirs-gmake:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib cleanall
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src cleanall
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src cleanall

# We used to delete *~ here, but that might inadvertently remove
# precious files if it happens to match their short 8+3 aliases.
cleanall: clean cleanall-other-dirs-$(MAKETYPE)
	 - $(DEL_TREE) obj
	 - $(DEL_TREE) obj-spd
	 - $(DEL_TREE) oo
	 - $(DEL_TREE) oo-spd

top-distclean:
	- $(DEL) $(COMPILER_TEMP_FILES)
	- $(DEL_TREE) obj
	- $(DEL_TREE) obj-spd
	- $(DEL_TREE) oo
	- $(DEL_TREE) oo-spd
	- $(DEL) stamp_BLD
	- $(DEL) ../etc/DOC ../etc/DOC-X
	- $(DEL) config.log Makefile
	- $(DEL) ../README.W32

distclean: distclean-other-dirs-$(MAKETYPE) top-distclean

distclean-other-dirs-nmake:
	cd ..\lib
	$(MAKE) $(MFLAGS) distclean
	cd ..\lib-src
	$(MAKE) $(MFLAGS) distclean
	cd ..\src
	$(MAKE) $(MFLAGS) distclean
	cd ..\lisp
	$(MAKE) $(MFLAGS) distclean
	cd ..\leim
	$(MAKE) $(MFLAGS) distclean
	cd ..\doc\emacs
	$(MAKE) $(MFLAGS) distclean
	cd ..\misc
	$(MAKE) $(MFLAGS) distclean
	cd ..\lispintro
	$(MAKE) $(MFLAGS) distclean
	cd ..\lispref
	$(MAKE) $(MFLAGS) distclean
	cd ..\..\nt

distclean-other-dirs-gmake:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../leim distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/emacs distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/misc distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/lispintro distclean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/lispref distclean

maintainer-clean: maintainer-clean-other-dirs-$(MAKETYPE) top-distclean

maintainer-clean-other-dirs-nmake:
	cd ..\lib
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\lib-src
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\src
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\lisp
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\leim
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\doc\emacs
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\misc
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\lispintro
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\lispref
	$(MAKE) $(MFLAGS) maintainer-clean
	cd ..\..\nt

maintainer-clean-other-dirs-gmake:
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lib-src maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../src maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../lisp maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../leim maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/emacs maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/misc maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/lispintro maintainer-clean
	$(MAKE) $(MFLAGS) $(XMFLAGS) -C ../doc/lispref maintainer-clean

realclean: cleanall
	- $(DEL_TREE) ../bin

TAGS: TAGS-$(MAKETYPE)

frc:
TAGS-gmake: frc
	../lib-src/$(BLD)/etags $(CURDIR)/*.c
	$(MAKE) $(MFLAGS) -C ../src TAGS TAGS-LISP
	$(MAKE) $(MFLAGS) -C ../lib-src TAGS
	$(MAKE) $(MFLAGS) -C ../lib TAGS

TAGS-nmake:
	echo This target is not supported with NMake

.PHONY: frc
