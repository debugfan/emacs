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
#### -*- Makefile -*- for documentation other than the Emacs manual.

# Copyright (C) 2003-2013 Free Software Foundation, Inc.

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


# Where to find the source code.  The source code for Emacs's C kernel is
# expected to be in $(srcdir)/src, and the source code for Emacs's
# utility programs is expected to be in $(srcdir)/lib-src.  This is
# set by the configure script's `--srcdir' option.
srcdir=.

infodir = $(srcdir)/../../info

## Directory with emacsver.texi.
## Currently only used by efaq; could be added to MAKEINFO.
emacsdir = $(srcdir)/../emacs

INFO_EXT=.info
INFO_OPTS=--no-split

# The makeinfo program is part of the Texinfo distribution.
MAKEINFO = makeinfo
MAKEINFO_OPTS = --force -I$(emacsdir)
MULTI_INSTALL_INFO = $(srcdir)\..\..\nt\multi-install-info.bat
INFO_TARGETS = $(infodir)/ccmode$(INFO_EXT) \
		$(infodir)/cl$(INFO_EXT) $(infodir)/dbus$(INFO_EXT) $(infodir)/dired-x$(INFO_EXT) \
		$(infodir)/ediff$(INFO_EXT) $(infodir)/forms$(INFO_EXT) $(infodir)/gnus$(INFO_EXT) \
		$(infodir)/message$(INFO_EXT) $(infodir)/sieve$(INFO_EXT) $(infodir)/pgg$(INFO_EXT) \
		$(infodir)/emacs-mime$(INFO_EXT) $(infodir)/info$(INFO_EXT) $(infodir)/mh-e$(INFO_EXT) \
		$(infodir)/reftex$(INFO_EXT) $(infodir)/sc$(INFO_EXT) $(infodir)/vip$(INFO_EXT) \
		$(infodir)/viper$(INFO_EXT) $(infodir)/widget$(INFO_EXT) $(infodir)/efaq$(INFO_EXT) \
		$(infodir)/ada-mode$(INFO_EXT) $(infodir)/autotype$(INFO_EXT) $(infodir)/calc$(INFO_EXT) \
		$(infodir)/idlwave$(INFO_EXT) $(infodir)/eudc$(INFO_EXT) $(infodir)/ebrowse$(INFO_EXT) \
		$(infodir)/pcl-cvs$(INFO_EXT) $(infodir)/woman$(INFO_EXT) $(infodir)/eshell$(INFO_EXT) \
		$(infodir)/org$(INFO_EXT) $(infodir)/url$(INFO_EXT) $(infodir)/speedbar$(INFO_EXT) \
		$(infodir)/tramp$(INFO_EXT) $(infodir)/ses$(INFO_EXT) $(infodir)/smtpmail$(INFO_EXT) \
		$(infodir)/flymake$(INFO_EXT) $(infodir)/newsticker$(INFO_EXT) $(infodir)/rcirc$(INFO_EXT) \
		$(infodir)/erc$(INFO_EXT) $(infodir)/ert$(INFO_EXT) \
		$(infodir)/remember$(INFO_EXT) $(infodir)/nxml-mode$(INFO_EXT) \
		$(infodir)/epa$(INFO_EXT) $(infodir)/mairix-el$(INFO_EXT) $(infodir)/sasl$(INFO_EXT) \
		$(infodir)/auth$(INFO_EXT) $(infodir)/eieio$(INFO_EXT) $(infodir)/ede$(INFO_EXT) \
		$(infodir)/semantic$(INFO_EXT) $(infodir)/edt$(INFO_EXT) $(infodir)/emacs-gnutls$(INFO_EXT) \
		$(infodir)/srecode$(INFO_EXT) $(infodir)/bovine$(INFO_EXT) \
		$(infodir)/wisent$(INFO_EXT) $(infodir)/htmlfontify$(INFO_EXT)
DVI_TARGETS = calc.dvi cc-mode.dvi cl.dvi dbus.dvi dired-x.dvi \
		ediff.dvi forms.dvi gnus.dvi message.dvi emacs-mime.dvi \
		sieve.dvi pgg.dvi mh-e.dvi \
		reftex.dvi sc.dvi vip.dvi viper.dvi widget.dvi faq.dvi \
		ada-mode.dvi autotype.dvi idlwave.dvi eudc.dvi ebrowse.dvi \
		pcl-cvs.dvi woman.dvi eshell.dvi org.dvi url.dvi \
		speedbar.dvi tramp.dvi ses.dvi smtpmail.dvi flymake.dvi \
		newsticker.dvi rcirc.dvi erc.dvi ert.dvi \
		remember.dvi nxml-mode.dvi \
		epa.dvi mairix-el.dvi sasl.dvi auth.dvi eieio.dvi ede.dvi \
		semantic.dvi edt.dvi emacs-gnutls.dvi srecode.dvi bovine.dvi \
		wisent.dvi htmlfontify.dvi
INFOSOURCES = info.texi

# The following rule does not work with all versions of `make'.
.SUFFIXES: .texi .dvi
.texi.dvi:
	texi2dvi $<

TEXI2DVI = texi2dvi
ENVADD = $(srcdir)\..\..\nt\envadd.bat "TEXINPUTS=$(srcdir);$(TEXINPUTS)" \
	 "MAKEINFO=$(MAKEINFO) $(MAKEINFO_OPTS)" /C


info: $(INFO_TARGETS)

dvi: $(DVI_TARGETS)

# Note that all the Info targets build the Info files
# in srcdir.  There is no provision for Info files
# to exist in the build directory.
# In a distribution of Emacs, the Info files should be up to date.

$(infodir)/dir:
	$(MULTI_INSTALL_INFO) --info-dir=$(infodir) $(INFO_TARGETS)

# The following target uses an explicit -o switch to work around
# the @setfilename directive in info.texi, which is required for
# the Texinfo distribution.
# Some Windows ports of makeinfo seem to require -o to come before the
# texi filename, contrary to GNU standards.

$(infodir)/info$(INFO_EXT): $(INFOSOURCES)
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ info.texi

info.dvi: $(INFOSOURCES)
	$(ENVADD) $(TEXI2DVI) $(srcdir)/info.texi


$(infodir)/ccmode$(INFO_EXT): cc-mode.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ cc-mode.texi
cc-mode.dvi: cc-mode.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/cc-mode.texi

$(infodir)/ada-mode$(INFO_EXT): ada-mode.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ ada-mode.texi
ada-mode.dvi: ada-mode.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/ada-mode.texi

$(infodir)/pcl-cvs$(INFO_EXT): pcl-cvs.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ pcl-cvs.texi
pcl-cvs.dvi: pcl-cvs.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/pcl-cvs.texi

$(infodir)/eshell$(INFO_EXT): eshell.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ eshell.texi
eshell.dvi: eshell.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/eshell.texi

$(infodir)/cl$(INFO_EXT): cl.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ cl.texi
cl.dvi: cl.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/cl.texi

$(infodir)/dbus$(INFO_EXT): dbus.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ dbus.texi
dbus.dvi: dbus.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/dbus.texi

$(infodir)/dired-x$(INFO_EXT): dired-x.texi $(emacsdir)/emacsver.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ dired-x.texi
dired-x.dvi: dired-x.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/dired-x.texi

$(infodir)/ediff$(INFO_EXT): ediff.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ ediff.texi
ediff.dvi: ediff.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/ediff.texi

$(infodir)/flymake$(INFO_EXT): flymake.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ flymake.texi
flymake.dvi: flymake.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/flymake.texi

$(infodir)/forms$(INFO_EXT): forms.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ forms.texi
forms.dvi: forms.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/forms.texi

# gnus/message/emacs-mime/sieve/pgg are part of Gnus:
$(infodir)/gnus$(INFO_EXT): gnus.texi gnus-overrides.texi message.texi emacs-mime.texi \
		 sieve.texi pgg.texi sasl.texi gnus-news.texi gnus-faq.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ gnus.texi
gnus.dvi: gnus.texi gnus-overrides.texi message.texi emacs-mime.texi \
	  sieve.texi pgg.texi sasl.texi gnus-news.texi gnus-faq.texi
	sed -e "/@iflatex/,/@end iflatex/d" $(srcdir)/gnus.texi > gnustmp.texi
	$(ENVADD) $(TEXI2DVI) gnustmp.texi
	cp gnustmp.dvi $*.dvi
	rm gnustmp.*
#
$(infodir)/message$(INFO_EXT): message.texi gnus-overrides.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ message.texi
message.dvi: message.texi gnus-overrides.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/message.texi
#
$(infodir)/emacs-mime$(INFO_EXT): emacs-mime.texi gnus-overrides.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ --enable-encoding emacs-mime.texi
emacs-mime.dvi: emacs-mime.texi gnus-overrides.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/emacs-mime.texi
#
$(infodir)/sieve$(INFO_EXT): sieve.texi gnus-overrides.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ sieve.texi
sieve.dvi: sieve.texi gnus-overrides.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/sieve.texi
#
$(infodir)/pgg$(INFO_EXT): pgg.texi gnus-overrides.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ pgg.texi
pgg.dvi: pgg.texi gnus-overrides.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/pgg.texi

$(infodir)/mh-e$(INFO_EXT): mh-e.texi gpl.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ mh-e.texi
mh-e.dvi: mh-e.texi gpl.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/mh-e.texi

$(infodir)/reftex$(INFO_EXT): reftex.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ reftex.texi
reftex.dvi: reftex.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/reftex.texi

$(infodir)/remember$(INFO_EXT): remember.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ remember.texi
remember.dvi: remember.texix
	$(ENVADD) $(TEXI2DVI) $(srcdir)/remember.texi

$(infodir)/sasl$(INFO_EXT): sasl.texi gnus-overrides.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ sasl.texi
sasl.dvi: sasl.texi gnus-overrides.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/sasl.texi

$(infodir)/sc$(INFO_EXT): sc.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ sc.texi
sc.dvi: sc.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/sc.texi

$(infodir)/vip$(INFO_EXT): vip.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ vip.texi
vip.dvi: vip.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/vip.texi

$(infodir)/viper$(INFO_EXT): viper.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ viper.texi
viper.dvi: viper.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/viper.texi

$(infodir)/widget$(INFO_EXT): widget.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ widget.texi
widget.dvi: widget.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/widget.texi

$(infodir)/efaq$(INFO_EXT): faq.texi $(emacsdir)/emacsver.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ faq.texi
faq.dvi: faq.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/faq.texi

$(infodir)/autotype$(INFO_EXT): autotype.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ autotype.texi
autotype.dvi: autotype.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/autotype.texi

$(infodir)/calc$(INFO_EXT): calc.texi $(emacsdir)/emacsver.texi gpl.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ calc.texi
calc.dvi: calc.texi $(emacsdir)/emacsver.texi gpl.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/calc.texi

# This is produced with --no-split to avoid making files whose
# names clash on DOS 8+3 filesystems
$(infodir)/idlwave$(INFO_EXT): idlwave.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ idlwave.texi
idlwave.dvi: idlwave.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/idlwave.texi

$(infodir)/eudc$(INFO_EXT): eudc.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ eudc.texi
eudc.dvi: eudc.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/eudc.texi

$(infodir)/ebrowse$(INFO_EXT): ebrowse.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ ebrowse.texi
ebrowse.dvi: ebrowse.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/ebrowse.texi

$(infodir)/woman$(INFO_EXT): woman.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ woman.texi
woman.dvi: woman.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/woman.texi

$(infodir)/speedbar$(INFO_EXT): speedbar.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ speedbar.texi
speedbar.dvi: speedbar.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/speedbar.texi

$(infodir)/tramp$(INFO_EXT): tramp.texi trampver.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ tramp.texi
tramp.dvi: tramp.texi trampver.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/tramp.texi

$(infodir)/ses$(INFO_EXT): ses.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ ses.texi
ses.dvi: ses.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/ses.texi

$(infodir)/smtpmail$(INFO_EXT): smtpmail.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ smtpmail.texi
smtpmail.dvi: smtpmail.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/smtpmail.texi

$(infodir)/org$(INFO_EXT): org.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ org.texi
org.dvi: org.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/org.texi

$(infodir)/url$(INFO_EXT): url.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ url.texi
url.dvi: url.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/url.texi

$(infodir)/newsticker$(INFO_EXT): newsticker.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ newsticker.texi
newsticker.dvi: newsticker.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/newsticker.texi

$(infodir)/nxml-mode$(INFO_EXT): nxml-mode.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ nxml-mode.texi
nxml-mod.dvi: nxml-mode.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/nxml-mode.texi

$(infodir)/rcirc$(INFO_EXT): rcirc.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ rcirc.texi
rcirc.dvi: rcirc.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/rcirc.texi

$(infodir)/erc$(INFO_EXT): erc.texi gpl.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ erc.texi
erc.dvi: erc.texi gpl.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/erc.texi

$(infodir)/ert$(INFO_EXT): ert.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ ert.texi
ert.dvi: ert.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/ert.texi

$(infodir)/epa$(INFO_EXT): epa.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ epa.texi
epa.dvi: epa.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/epa.texi

$(infodir)/mairix-el$(INFO_EXT): mairix-el.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ mairix-el.texi
mairix-el.dvi: mairix-el.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/mairix-el.texi

$(infodir)/auth$(INFO_EXT): auth.texi gnus-overrides.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ auth.texi
auth.dvi: auth.texi gnus-overrides.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/auth.texi

$(infodir)/eieio$(INFO_EXT): eieio.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ eieio.texi
eieio.dvi: eieio.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/eieio.texi

$(infodir)/ede$(INFO_EXT): ede.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ ede.texi
ede.dvi: ede.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/ede.texi

$(infodir)/semantic$(INFO_EXT): semantic.texi sem-user.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ semantic.texi
semantic.dvi: semantic.texi sem-user.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/semantic.texi

$(infodir)/edt$(INFO_EXT): edt.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ edt.texi
edt.dvi: edt.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/edt.texi

$(infodir)/emacs-gnutls$(INFO_EXT): emacs-gnutls.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ emacs-gnutls.texi
emacs-gnutls.dvi: emacs-gnutls.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/emacs-gnutls.texi

$(infodir)/srecode$(INFO_EXT): srecode.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ srecode.texi
srecode.dvi: srecode.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/srecode.texi

$(infodir)/bovine$(INFO_EXT): bovine.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ bovine.texi
bovine.dvi: bovine.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/bovine.texi

$(infodir)/wisent$(INFO_EXT): wisent.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ wisent.texi
wisent.dvi: wisent.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/wisent.texi

$(infodir)/htmlfontify$(INFO_EXT): htmlfontify.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) $(INFO_OPTS) -o $@ htmlfontify.texi
htmlfontify.dvi: htmlfontify.texi
	$(ENVADD) $(TEXI2DVI) $(srcdir)/htmlfontify.texi


$(INFO_TARGETS): doclicense.texi
$(DVI_TARGETS): doclicense.texi

mostlyclean:
	- $(DEL) *.log *.cp *.fn *.ky *.pg *.vr core *.tp *.core gnustmp.*

clean: mostlyclean
	- $(DEL) *.dvi
	- $(DEL) $(infodir)/ccmode* $(infodir)/cl* \
		 $(infodir)/dbus* $(infodir)/dired-x* \
		 $(infodir)/ediff* $(infodir)/forms* \
		 $(infodir)/gnus* $(infodir)/info* \
		 $(infodir)/message* $(infodir)/mh-e* \
		 $(infodir)/reftex* $(infodir)/sc* \
		 $(infodir)/vip* $(infodir)/widget* \
		 $(infodir)/efaq* $(infodir)/ada-mode* \
		 $(infodir)/autotype* $(infodir)/calc* \
		 $(infodir)/idlwave* $(infodir)/eudc* \
		 $(infodir)/ebrowse* $(infodir)/pcl-cvs* \
		 $(infodir)/woman* $(infodir)/eshell* \
		 $(infodir)/speedbar* $(infodir)/tramp* \
		 $(infodir)/ses* $(infodir)/smtpmail* \
		 $(infodir)/url* $(infodir)/org* \
		 $(infodir)/flymake* $(infodir)/newsticker* \
		 $(infodir)/sieve* $(infodir)/pgg* \
		 $(infodir)/erc* $(infodir)/ert* $(infodir)/rcirc* \
		 $(infodir)/remember* $(infodir)/nxml-mode* \
		 $(infodir)/epa* $(infodir)/sasl* \
		 $(infodir)/mairix-el* $(infodir)/auth* \
		 $(infodir)/eieio* $(infodir)/ede* \
		 $(infodir)/semantic* $(infodir)edt* \
		 $(infodir)/emacs-gnutls* $(infodir)/srecode* \
		 $(infodir)/bovine* $(infodir)/wisent* \
		 $(infodir)/htmlfontify*

distclean: clean
	- $(DEL) makefile

maintainer-clean: distclean
	- $(DEL) *.aux *.cps *.fns *.kys *.pgs *.vrs *.toc
# Don't delete these, because they are outside the current directory.
#	for file in $(INFO_TARGETS); do rm -f $${file}*; done


# Formerly this directory had texindex.c and getopt.c in it
# and this makefile built them to make texindex.
# That caused trouble because this is run entirely in the source directory.
# Since we expect to get texi2dvi from elsewhere,
# it is ok to expect texindex from elsewhere also.
