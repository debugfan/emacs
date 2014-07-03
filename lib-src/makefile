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
#  -*- Makefile -*- for GNU Emacs on the Microsoft Windows API.
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


ALL = $(BLD)/test-distrib.exe $(BLD)/make-docfile.exe $(BLD)/hexl.exe\
 $(BLD)/ctags.exe $(BLD)/etags.exe $(BLD)/movemail.exe $(BLD)/ebrowse.exe\
 $(BLD)/emacsclient.exe $(BLD)/emacsclientw.exe $(BLD)/profile.exe

.PHONY: make-docfile

LOCAL_FLAGS	= -DNO_LDAV=1 -DNO_ARCHIVES=1 -I../lib \
		  -I../nt/inc -I../src $(EMACS_EXTRA_C_FLAGS)

LIBS 		= $(BASE_LIBS) $(ADVAPI32)

# The following target is used by makefile.w32-in files in other directories.
make-docfile:	$(BLD)/make-docfile.exe

$(BLD)/make-docfile.exe: 	$(BLD)/make-docfile.$(O) $(BLD)/ntlib.$(O)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(BLD)/make-docfile.$(O) $(BLD)/ntlib.$(O) $(LIBS)
$(BLD)/hexl.exe:		$(BLD)/hexl.$(O)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(BLD)/hexl.$(O) $(LIBS)
$(BLD)/test-distrib.exe: $(BLD)/test-distrib.$(O)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(BLD)/test-distrib.$(O) $(LIBS)
		"$(BLD)/test-distrib.exe" "$(LIB_SRC)/testfile"

MOVEMAILOBJS =  $(BLD)/movemail.$(O) \
		$(BLD)/pop.$(O) \
		../lib/$(BLD)/libgnu.$(A) \
		$(BLD)/ntlib.$(O)

$(BLD)/movemail.exe:	$(MOVEMAILOBJS) ../lib/getopt.h
# put wsock32.lib before $(LIBS) to ensure we don't link to ws2_32.lib
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(MOVEMAILOBJS) $(WSOCK32) $(LIBS)

ECLIENT_CFLAGS = -DHAVE_GETCWD -DHAVE_STRERROR
ECLIENTOBJS =	$(BLD)/emacsclient.$(O) \
		$(BLD)/ntlib.$(O) \
		../lib/$(BLD)/libgnu.$(A)
CLIENTRES =	../nt/$(BLD)/emacsclient.res

$(CLIENTRES):	../nt/emacsclient.rc
	@echo Emacsclient resource file must be built from nt directory
	@exit -1

$(BLD)/emacsclient.exe:		$(ECLIENTOBJS)
# put wsock32.lib before $(LIBS) to ensure we don't link to ws2_32.lib
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(ECLIENTOBJS) $(WSOCK32) $(USER32) $(COMCTL32) $(LIBS)

$(BLD)/emacsclientw.exe:	$(ECLIENTOBJS) $(CLIENTRES)
# put wsock32.lib before $(LIBS) to ensure we don't link to ws2_32.lib
		$(LINK) $(LINK_OUT)$@ $(CLIENTRES) $(MWINDOWS) $(LINK_FLAGS) $(ECLIENTOBJS) $(WSOCK32) $(USER32) $(COMCTL32) $(LIBS)

$(BLD)/emacsclient.$(O):	emacsclient.c
		$(CC) $(CFLAGS) $(ECLIENT_CFLAGS) $(CC_OUT)$@ emacsclient.c

ETAGSOBJ      = $(BLD)/etags.$(O) \
		../lib/$(BLD)/libgnu.$(A) \
		$(BLD)/ntlib.$(O) \
		$(BLD)/regex.$(O)

$(BLD)/etags.exe: 	$(ETAGSOBJ)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(ETAGSOBJ) $(LIBS)


EBROWSEOBJ    = $(BLD)/ebrowse.$(O) \
		../lib/$(BLD)/libgnu.$(A) \
		$(BLD)/ntlib.$(O)

$(BLD)/ebrowse.exe:     $(EBROWSEOBJ)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(EBROWSEOBJ) $(LIBS)

$(BLD)/regex.$(O): ../src/regex.c ../src/regex.h ../src/config.h
		$(CC)  $(CFLAGS) -DCONFIG_BROKETS -DINHIBIT_STRING_HEADER \
		../src/regex.c $(CC_OUT)$@

ETAGS_CFLAGS  = -DHAVE_GETCWD -DEMACS_NAME="\"GNU Emacs\""
$(BLD)/etags.$(O): etags.c
		$(CC) $(CFLAGS) $(ETAGS_CFLAGS) $(CC_OUT)$@ etags.c

CTAGSOBJ      = $(BLD)/ctags.$(O) \
		../lib/$(BLD)/libgnu.$(A) \
		$(BLD)/ntlib.$(O) \
		$(BLD)/regex.$(O)

$(BLD)/ctags.exe:  $(CTAGSOBJ)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(CTAGSOBJ) $(LIBS)

ctags.c:	etags.c
		- $(DEL) ctags.c
		$(CP) etags.c ctags.c

CTAGS_CFLAGS  = -DCTAGS $(ETAGS_CFLAGS)
$(BLD)/ctags.$(O): ctags.c
		$(CC) $(CFLAGS) $(CTAGS_CFLAGS) $(CC_OUT)$@ ctags.c

PROFILEOBJS	= $(BLD)/profile.$(O) \
		  ../lib/$(BLD)/libgnu.$(A) \
		  $(BLD)/ntlib.$(O)
$(BLD)/profile.exe:	$(PROFILEOBJS)
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $(PROFILEOBJS) $(LIBS)

#
# From ..\src\Makefile.in
# It doesn't matter if the real name is *.obj for the files in this list,
# make-docfile blindly replaces .o with .c anyway.  Keep .o in this list
# as it is required by code in doc.c.
#
obj =   dosfns.o msdos.o \
	xterm.o xfns.o xmenu.o xselect.o xrdb.o xsmfns.o fringe.o image.o \
	fontset.o menu.o \
	w32.o w32console.o w32fns.o w32heap.o w32inevt.o cygw32.o \
	w32menu.o w32proc.o w32reg.o w32select.o w32term.o w32xfns.o \
	font.o w32font.o w32uniscribe.o \
	dispnew.o frame.o scroll.o xdisp.o window.o bidi.o \
	charset.o coding.o category.o ccl.o character.o chartab.o \
	cm.o term.o terminal.o xfaces.o \
	emacs.o keyboard.o macros.o keymap.o sysdep.o \
	buffer.o filelock.o insdel.o marker.o \
	minibuf.o fileio.o dired.o \
	cmds.o casetab.o casefiddle.o indent.o search.o regex.o undo.o \
	alloc.o data.o doc.o editfns.o callint.o \
	eval.o floatfns.o fns.o print.o lread.o \
	syntax.o bytecode.o \
	process.o callproc.o unexw32.o \
	region-cache.o sound.o atimer.o \
	doprnt.o intervals.o textprop.o composite.o \
	gnutls.o xml.o profiler.o

#
# These are the lisp files that are loaded up in loadup.el
#
lispsource = ../lisp/

MOUSE_SUPPORT = \
	$(lispsource)select.elc \
	$(lispsource)scroll-bar.elc \
	$(lispsource)mouse.elc
WINNT_SUPPORT = \
	$(lispsource)ls-lisp.elc \
	$(lispsource)disp-table.elc \
	$(lispsource)w32-fns.elc \
	$(lispsource)dos-w32.elc \
	$(lispsource)w32-vars.elc \
	$(lispsource)term/common-win.elc \
	$(lispsource)term/w32-win.elc
TOOLTIP_SUPPORT = $(lispsource)tooltip.elc
WINDOW_SUPPORT = \
	$(lispsource)fringe.elc \
	$(lispsource)image.elc \
	$(lispsource)international/fontset.elc \
	$(lispsource)dnd.elc \
	$(lispsource)tool-bar.elc \
	$(lispsource)mwheel.elc

# lisp files that are loaded up on other platforms
OTHER_PLATFORM_SUPPORT = \
	$(lispsource)dos-fns.elc \
	$(lispsource)dos-vars.elc \
	$(lispsource)term/internal.elc \
	$(lispsource)term/pc-win.elc \
	$(lispsource)x-dnd.elc \
	$(lispsource)term/x-win.elc \
	$(lispsource)term/ns-win.elc


lisp1= \
	$(lispsource)abbrev.elc \
	$(lispsource)buff-menu.elc \
	$(lispsource)button.elc \
	$(lispsource)emacs-lisp/byte-run.elc \
	$(lispsource)composite.elc \
	$(lispsource)cus-face.elc \
	$(lispsource)cus-start.elc \
	$(lispsource)custom.elc \
	$(lispsource)emacs-lisp/backquote.elc \
	$(lispsource)emacs-lisp/lisp-mode.elc \
	$(lispsource)emacs-lisp/lisp.elc \
	$(lispsource)env.elc \
	$(lispsource)faces.elc \
	$(lispsource)files.elc \
	$(lispsource)format.elc \
	$(lispsource)facemenu.elc \
	$(MOUSE_SUPPORT) \
	$(lispsource)emacs-lisp/float-sup.elc \
	$(lispsource)frame.elc \
	$(lispsource)help.elc \
	$(lispsource)indent.elc \
	$(lispsource)isearch.elc \
	$(lispsource)rfn-eshadow.elc \
	$(lispsource)loadup.el \
	$(lispsource)loaddefs.el \
	$(lispsource)bindings.elc \
	$(lispsource)emacs-lisp/map-ynp.elc \
	$(lispsource)menu-bar.elc \
	$(lispsource)international/mule.elc \
	$(lispsource)international/mule-conf.elc \
	$(lispsource)international/mule-cmds.elc \
	$(lispsource)international/characters.elc \
	$(lispsource)international/charprop.el \
	$(lispsource)case-table.elc

lisp2 = \
	$(lispsource)language/chinese.elc \
	$(lispsource)language/cyrillic.elc \
	$(lispsource)language/indian.elc \
	$(lispsource)language/sinhala.elc \
	$(lispsource)language/english.elc \
	$(lispsource)language/ethiopic.elc \
	$(lispsource)language/european.elc \
	$(lispsource)language/czech.elc \
	$(lispsource)language/slovak.elc \
	$(lispsource)language/romanian.elc \
	$(lispsource)language/greek.elc \
	$(lispsource)language/hebrew.elc \
	$(lispsource)language/japanese.elc \
	$(lispsource)international/cp51932.el \
	$(lispsource)international/eucjp-ms.el \
	$(lispsource)language/korean.elc \
	$(lispsource)language/lao.elc \
	$(lispsource)language/cham.elc \
	$(lispsource)language/tai-viet.elc \
	$(lispsource)language/thai.elc \
	$(lispsource)language/tibetan.elc \
	$(lispsource)language/vietnamese.elc \
	$(lispsource)language/misc-lang.elc \
	$(lispsource)language/utf-8-lang.elc \
	$(lispsource)language/georgian.elc \
	$(lispsource)language/khmer.elc \
	$(lispsource)language/burmese.elc \
	$(lispsource)register.elc \
	$(lispsource)replace.elc \
	$(lispsource)simple.elc \
	$(lispsource)minibuffer.elc \
	$(lispsource)startup.elc \
	$(lispsource)subr.elc \
	$(lispsource)term/tty-colors.elc \
	$(lispsource)font-core.elc \
	$(lispsource)emacs-lisp/syntax.elc \
	$(lispsource)font-lock.elc \
	$(lispsource)jit-lock.elc \
	$(lispsource)textmodes/fill.elc \
	$(lispsource)textmodes/page.elc \
	$(lispsource)textmodes/paragraphs.elc \
	$(lispsource)textmodes/text-mode.elc \
	$(lispsource)emacs-lisp/timer.elc \
	$(lispsource)jka-cmpr-hook.elc \
	$(lispsource)vc/vc-hooks.elc \
	$(lispsource)vc/ediff-hook.elc \
	$(lispsource)epa-hook.elc \
	$(TOOLTIP_SUPPORT) \
	$(WINNT_SUPPORT) \
	$(WINDOW_SUPPORT) \
	$(lispsource)widget.elc \
	$(lispsource)window.elc \
	$(lispsource)version.elc

# This is needed the first time we build the tree, since temacs.exe
# does not exist yet, and the DOC rule needs it to rebuild DOC whenever
# Emacs is rebuilt.
../src/$(BLD)/temacs.exe:
	- mkdir "../src/$(OBJDIR)"
	- mkdir "../src/$(BLD)"
	@echo temacs > temacs.exe
	$(CP) temacs.exe ../src/$(BLD)
	- $(DEL) temacs.exe

DOC	      = DOC
$(DOC):		stamp_BLD $(BLD)/make-docfile.exe ../src/$(BLD)/temacs.exe $(lisp1) $(lisp2) $(OTHER_PLATFORM_SUPPORT)
		- $(DEL) $(DOC)
		"$(THISDIR)/$(BLD)/make-docfile" -o $(DOC) -d ../src $(obj)
		"$(THISDIR)/$(BLD)/make-docfile" -a $(DOC) -d ../src $(lisp1)
		"$(THISDIR)/$(BLD)/make-docfile" -a $(DOC) -d ../src $(lisp2)
		"$(THISDIR)/$(BLD)/make-docfile" -a $(DOC) -d ../src $(OTHER_PLATFORM_SUPPORT)
		$(CP) $(DOC) ../etc/DOC-X
		- mkdir "../src/$(OBJDIR)"
		- mkdir "../src/$(OBJDIR)/etc"
		$(CP) $(DOC) ../src/$(OBJDIR)/etc/DOC-X

{$(BLD)}.$(O){$(BLD)}.exe:
		$(LINK) $(LINK_OUT)$@ $(LINK_FLAGS) $*.$(O) $(LIBS)

#
# Build the executables
#
all:		$(ALL) $(DOC)

#
# Assuming INSTALL_DIR is defined, build and install emacs in it.
#
INSTALL_FILES = $(ALL)
install:	$(INSTALL_FILES)
		- mkdir "$(INSTALL_DIR)/bin"
		$(CP) $(BLD)/etags.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/ebrowse.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/ctags.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/hexl.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/movemail.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/emacsclient.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/emacsclientw.exe $(INSTALL_DIR)/bin
		$(CP) $(BLD)/profile.exe $(INSTALL_DIR)/bin
		- mkdir "$(INSTALL_DIR)/etc"
		$(CP) $(DOC) $(INSTALL_DIR)/etc

#
# Maintenance
#
# We used to delete *~ here, but that might inadvertently remove
# precious files if it happens to match their short 8+3 aliases.
clean:
		- $(DEL) DOC* $(COMPILER_TEMP_FILES)
		- $(DEL) ctags.c
		- $(DEL_TREE) $(OBJDIR)
		- $(DEL) stamp_BLD

distclean: cleanall
	- $(DEL) TAGS
	- $(DEL) Makefile

maintainer-clean: distclean

cleanall:	clean
		- $(DEL_TREE) obj
		- $(DEL_TREE) obj-spd
		- $(DEL_TREE) oo
		- $(DEL_TREE) oo-spd

#
# Headers we would preprocess if we could.
#
../src/config.h:	../nt/$(CONFIG_H)
			$(DEL) $@
			echo $(CONFIG_H) has changed.  Re-run configure.bat.
			exit -1

### TAGS ###

TAGS: $(BLD)/etags.exe *.c *.h
	$(BLD)/etags.exe *.c *.h

### DEPENDENCIES ###

EMACS_ROOT	= ..
LIB_SRC		= .
SRC		= $(EMACS_ROOT)/src
NT_INC		= $(EMACS_ROOT)/nt/inc
GNU_LIB		= $(EMACS_ROOT)/lib

MS_W32_H       = $(NT_INC)/ms-w32.h \
		 $(NT_INC)/sys/stat.h
CONF_POST_H    = $(SRC)/conf_post.h \
		 $(MS_W32_H)
CONFIG_H       = $(SRC)/config.h \
		 $(CONF_POST_H)
INTTYPES_H     = $(NT_INC)/inttypes.h \
		 $(NT_INC)/stdint.h
NTLIB_H        = $(LIB_SRC)/ntlib.h \
		 $(NT_INC)/pwd.h
SYSTIME_H      = $(SRC)/systime.h \
		 $(NT_INC)/sys/time.h \
		 $(GNU_LIB)/timespec.h

$(BLD)/ctags.$(O) : \
	$(LIB_SRC)/ctags.c \
	$(SRC)/regex.h \
	$(NT_INC)/sys/stat.h \
	$(NT_INC)/unistd.h \
	$(GNU_LIB)/c-strcase.h \
	$(GNU_LIB)/getopt.h \
	$(CONFIG_H)

$(BLD)/ebrowse.$(O) : \
	$(LIB_SRC)/ebrowse.c \
	$(GNU_LIB)/getopt.h \
	$(GNU_LIB)/min-max.h \
	$(CONFIG_H)

$(BLD)/emacsclient.$(O) : \
	$(LIB_SRC)/emacsclient.c \
	$(NT_INC)/pwd.h \
	$(NT_INC)/sys/stat.h \
	$(NT_INC)/unistd.h \
	$(GNU_LIB)/getopt.h \
	$(CONFIG_H)

$(BLD)/etags.$(O) : \
	$(LIB_SRC)/etags.c \
	$(SRC)/regex.h \
	$(NT_INC)/sys/stat.h \
	$(NT_INC)/unistd.h \
	$(GNU_LIB)/c-strcase.h \
	$(GNU_LIB)/getopt.h \
	$(CONFIG_H)

$(BLD)/hexl.$(O) : \
	$(LIB_SRC)/hexl.c \
	$(CONFIG_H)

$(BLD)/make-docfile.$(O) : \
	$(LIB_SRC)/make-docfile.c \
	$(NT_INC)/unistd.h \
	$(CONFIG_H)

$(BLD)/movemail.$(O) : \
	$(LIB_SRC)/movemail.c \
	$(LIB_SRC)/pop.h \
	$(SRC)/syswait.h \
	$(NT_INC)/pwd.h \
	$(NT_INC)/sys/file.h \
	$(NT_INC)/sys/stat.h \
	$(NT_INC)/unistd.h \
	$(GNU_LIB)/getopt.h \
	$(CONFIG_H) \
	$(NTLIB_H)

$(BLD)/ntlib.$(O) : \
	$(LIB_SRC)/ntlib.c \
	$(NT_INC)/sys/stat.h \
	$(NTLIB_H)

$(BLD)/pop.$(O) : \
	$(LIB_SRC)/pop.c \
	$(LIB_SRC)/pop.h \
	$(NT_INC)/netdb.h \
	$(NT_INC)/pwd.h \
	$(NT_INC)/unistd.h \
	$(GNU_LIB)/min-max.h \
	$(CONFIG_H) \
	$(NTLIB_H)

$(BLD)/profile.$(O) : \
	$(LIB_SRC)/profile.c \
	$(GNU_LIB)/intprops.h \
	$(CONFIG_H) \
	$(INTTYPES_H) \
	$(SYSTIME_H)

$(BLD)/regex.$(O) : \
	$(SRC)/regex.c \
	$(SRC)/regex.h \
	$(NT_INC)/stdbool.h \
	$(NT_INC)/unistd.h \
	$(CONFIG_H)

$(BLD)/test-distrib.$(O) : \
	$(LIB_SRC)/test-distrib.c \
	$(NT_INC)/unistd.h \
	$(CONFIG_H)

# The following dependencies are for supporting parallel builds, where
# we must make sure $(BLD) exists before any compilation starts.
#
$(BLD)/make-docfile.$(O) $(BLD)/hexl.$(O): stamp_BLD

$(BLD)/test-distrib.$(O) $(MOVEMAILOBJS): stamp_BLD

$(BLD)/emacsclient.$(O) $(BLD)/etags.$(O) $(BLD)/regex.$(O): stamp_BLD

$(BLD)/ebrowse.$(O) $(BLD)/ctags.$(O) $(BLD)/profile.$(O): stamp_BLD
