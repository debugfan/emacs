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
# Copyright (C) 2011-2013 Free Software Foundation, Inc.

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

ALL = gnulib

.PHONY: $(ALL)

LOCAL_FLAGS	= -I. -I../nt/inc -I../src
LIBS 		=

GNULIBOBJS = $(BLD)/c-ctype.$(O) \
	     $(BLD)/c-strcasecmp.$(O) \
	     $(BLD)/c-strncasecmp.$(O) \
	     $(BLD)/dtoastr.$(O) \
	     $(BLD)/dtotimespec.$(O)  \
	     $(BLD)/execinfo.$(O)  \
	     $(BLD)/getopt.$(O)  \
	     $(BLD)/getopt1.$(O) \
	     $(BLD)/gettime.$(O) \
	     $(BLD)/strftime.$(O) \
	     $(BLD)/time_r.$(O) \
	     $(BLD)/timespec-add.$(O) \
	     $(BLD)/timespec-sub.$(O) \
	     $(BLD)/md5.$(O) \
	     $(BLD)/sha1.$(O) \
	     $(BLD)/sha256.$(O) \
	     $(BLD)/sha512.$(O) \
	     $(BLD)/stat-time.$(O) \
	     $(BLD)/timespec.$(O) \
	     $(BLD)/u64.$(O) \
	     $(BLD)/filemode.$(O)

#
# Build the library
#
$(BLD)/libgnu.$(A):	$(GNULIBOBJS)
	- $(DEL) $@
	$(AR) $(AR_OUT)$@ $(ALL_DEPS)

gnulib:		$(BLD)/libgnu.$(A)

#
# Build everything
#
all:		$(ALL)

### TAGS ###

FRC:

TAGS: FRC
	 ../lib-src/$(BLD)/etags.exe *.c *.h

### DEPENDENCIES ###

EMACS_ROOT	= ..
GNU_LIB		= .
SRC		= $(EMACS_ROOT)/src
NT_INC		= $(EMACS_ROOT)/nt/inc

C_CTYPE_H      = $(GNU_LIB)/c-ctype.h \
		 $(NT_INC)/stdbool.h
MS_W32_H       = $(NT_INC)/ms-w32.h \
		 $(NT_INC)/sys/stat.h
CONF_POST_H    = $(SRC)/conf_post.h \
		 $(MS_W32_H)
CONFIG_H       = $(SRC)/config.h \
		 $(CONF_POST_H)
FILEMODE_H     = $(GNU_LIB)/filemode.h \
		 $(NT_INC)/sys/stat.h
FTOASTR_H      = $(GNU_LIB)/ftoastr.h \
		 $(GNU_LIB)/intprops.h
FTOASTR_C      = $(GNU_LIB)/ftoastr.c \
		 $(CONFIG_H) \
		 $(FTOASTR_H)
GETOPT_INT_H   = $(GNU_LIB)/getopt_int.h \
		 $(GNU_LIB)/getopt.h
MD5_H          = $(GNU_LIB)/md5.h \
		 $(NT_INC)/stdint.h
SHA1_H         = $(GNU_LIB)/sha1.h \
		 $(NT_INC)/stdint.h
SHA256_H       = $(GNU_LIB)/sha256.h \
		 $(NT_INC)/stdint.h
U64_H          = $(GNU_LIB)/u64.h \
		 $(NT_INC)/stdint.h
SHA512_H       = $(GNU_LIB)/sha512.h \
		 $(U64_H)
STAT_TIME_H    = $(GNU_LIB)/stat-time.h \
		 $(NT_INC)/sys/stat.h

$(BLD)/c-ctype.$(O) : \
	$(GNU_LIB)/c-ctype.c \
	$(CONFIG_H) \
	$(C_CTYPE_H)

$(BLD)/c-strcasecmp.$(O) : \
	$(GNU_LIB)/c-strcasecmp.c \
	$(GNU_LIB)/c-strcase.h \
	$(CONFIG_H) \
	$(C_CTYPE_H)

$(BLD)/c-strncasecmp.$(O) : \
	$(GNU_LIB)/c-strncasecmp.c \
	$(GNU_LIB)/c-strcase.h \
	$(CONFIG_H) \
	$(C_CTYPE_H)

$(BLD)/dtoastr.$(O) : \
	$(GNU_LIB)/dtoastr.c \
	$(FTOASTR_C)

$(BLD)/dtotimespec.$(O) : \
	$(GNU_LIB)/dtotimespec.c \
	$(GNU_LIB)/intprops.h \
	$(GNU_LIB)/timespec.h \
	$(CONFIG_H)

$(BLD)/execinfo.$(O) : \
	$(GNU_LIB)/execinfo.c \
	$(GNU_LIB)/execinfo.h \
	$(CONFIG_H)

$(BLD)/getopt.$(O) : \
	$(GNU_LIB)/getopt.c \
	$(GNU_LIB)/getopt.h \
	$(GNU_LIB)/gettext.h \
	$(NT_INC)/unistd.h \
	$(CONFIG_H) \
	$(GETOPT_INT_H)

$(BLD)/getopt1.$(O) : \
	$(GNU_LIB)/getopt1.c \
	$(GNU_LIB)/getopt.h \
	$(CONFIG_H) \
	$(GETOPT_INT_H)

$(BLD)/gettime.$(O) : \
	$(GNU_LIB)/gettime.c \
	$(GNU_LIB)/timespec.h \
	$(NT_INC)/sys/time.h \
	$(CONFIG_H)

$(BLD)/strftime.$(O) : \
	$(GNU_LIB)/strftime.c \
	$(GNU_LIB)/strftime.h \
	$(NT_INC)/stdbool.h \
	$(CONFIG_H)

$(BLD)/time_r.$(O) : \
	$(GNU_LIB)/time_r.c \
	$(CONFIG_H)

$(BLD)/timespec-add.$(O) : \
	$(GNU_LIB)/timespec-add.c \
	$(GNU_LIB)/intprops.h \
	$(GNU_LIB)/timespec.h \
	$(CONFIG_H)

$(BLD)/timespec-sub.$(O) : \
	$(GNU_LIB)/timespec-sub.c \
	$(GNU_LIB)/intprops.h \
	$(GNU_LIB)/timespec.h \
	$(CONFIG_H)

$(BLD)/md5.$(O) : \
	$(GNU_LIB)/md5.c \
	$(NT_INC)/stdalign.h \
	$(NT_INC)/stdint.h \
	$(CONFIG_H) \
	$(MD5_H)

$(BLD)/sha1.$(O) : \
	$(GNU_LIB)/sha1.c \
	$(NT_INC)/stdalign.h \
	$(NT_INC)/stdint.h \
	$(CONFIG_H) \
	$(SHA1_H)

$(BLD)/sha256.$(O) : \
	$(GNU_LIB)/sha256.c \
	$(NT_INC)/stdalign.h \
	$(NT_INC)/stdint.h \
	$(CONFIG_H) \
	$(SHA256_H)

$(BLD)/sha512.$(O) : \
	$(GNU_LIB)/sha512.c \
	$(NT_INC)/stdalign.h \
	$(NT_INC)/stdint.h \
	$(CONFIG_H) \
	$(SHA512_H)

$(BLD)/stat-time.$(O) : \
	$(GNU_LIB)/stat-time.c \
	$(CONFIG_H) \
	$(STAT_TIME_H)

$(BLD)/timespec.$(O) : \
	$(GNU_LIB)/timespec.c \
	$(GNU_LIB)/timespec.h \
	$(CONFIG_H)

$(BLD)/u64.$(O) : \
	$(GNU_LIB)/u64.c \
	$(CONFIG_H) \
	$(U64_H)

$(BLD)/filemode.$(O) : \
	$(GNU_LIB)/filemode.c \
	$(CONFIG_H) \
	$(FILEMODE_H)

# The following dependencies are for supporting parallel builds, where
# we must make sure $(BLD) exists before any compilation starts.
#
$(GNULIBOBJS): stamp_BLD

#
# Headers we would preprocess if we could.
#
getopt.h:	getopt_.h
	$(CP) $(ALL_DEPS) $@

#
# Maintenance
#
clean:
	- $(DEL) $(COMPILER_TEMP_FILES)
	- $(DEL) getopt.h
	- $(DEL_TREE) $(OBJDIR)
	- $(DEL) stamp_BLD

distclean:	cleanall
	- $(DEL) TAGS
	- $(DEL) Makefile

maintainer-clean: distclean
	- $(DEL) getopt_.h

cleanall:	clean
	- $(DEL_TREE) obj
	- $(DEL_TREE) obj-spd
	- $(DEL_TREE) oo
	- $(DEL_TREE) oo-spd

# A dummy target to force other targets to be evaluated.
doit:

getopt_.h: getopt.in.h $(ARG_NONNULL_H)
	$(MAKE) $(MFLAGS) getopt_.h-$(SHELLTYPE)

getopt_.h-CMD: doit
	@echo getopt.in.h or $(ARG_NONNULL_H) is newer than getopt_.h.
	@echo Run "$(MAKETYPE) getopt_h" in the lib/ subdirectory.
	@echo You will need GNU Sed to be installed.
	exit -1

getopt_.h-SH: doit
	@echo getopt.in.h or $(ARG_NONNULL_H) is newer than getopt_.h.
	@echo Run '"$(MAKETYPE) getopt_h"' in the lib/ subdirectory.
	@echo You will need GNU Sed to be installed.
	exit -1

# Generating getopt_.h from getopt.in.h.
#
# To avoid requiring all end users to install Sed, we have below
# a maintainer-only target that produces getopt_.h from getopt.in.h.
# For easier maintenance, all the strings that replace the @FOO@
# placeholder are defined as Make macros below.

HAVE_GETOPT_H = HAVE_GETOPT_H
INCLUDE_NEXT = include_next
PRAGMA_COLUMNS =
NEXT_GETOPT_H = <getopt.h>
ARG_NONNULL_H = ../build-aux/snippet/arg-nonnull.h

getopt_h:
	- $(DEL) getopt_.h-t getopt_.h
	sed -e "s!@GUARD_PREFIX@!GL!g" \
	    -e "s!@HAVE_GETOPT_H@!$(HAVE_GETOPT_H)!g" \
	    -e "s!@INCLUDE_NEXT@!$(INCLUDE_NEXT)!g" \
	    -e "s!@PRAGMA_SYSTEM_HEADER@!$(PRAGMA_SYSTEM_HEADER)!g" \
	    -e "s!@PRAGMA_COLUMNS@!$(PRAGMA_COLUMNS)!g" \
	    -e "s!@NEXT_GETOPT_H@!$(NEXT_GETOPT_H)!g" \
	    -e "/definition of _GL_ARG_NONNULL/r $(ARG_NONNULL_H)" \
	    -e "/^\# include_next/i # ifndef __GNUC__" \
	    -e "/^\# include_next/i # include <next_getopt.h>" \
	    -e "/^\# include_next/i # else" \
	    -e "/^\# include_next/a # endif" \
	      < getopt.in.h > getopt_.h-t
	$(CP) getopt_.h-t getopt_.h
	- $(DEL) getopt_.h-t

execinfo.h: execinfo.in.h
	$(CP) execinfo.in.h $@

