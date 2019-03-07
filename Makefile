.PHONY: all preformat dissertation dissertation-draft pdflatex \
synopsis synopsis-draft draft talk dissertation-preformat \
dissertation-formated synopsis-preformat synopsis-formated \
_clean _distclean _compile spell-check indent compress clean \
distclean release

# settings precedence: command line>usercfg.mk>{windows,unix}.mk

# user settings
# include before variable definitions
ifneq ($(wildcard usercfg.mk),)
	include usercfg.mk
endif

# platform specific settings
# include before variable definitions
ifneq ($(SystemDrive),)
    include windows.mk
else
    include unix.mk
endif

MKRC ?= latexmkrc
TARGET ?= dissertation
BACKEND ?= -pdfxe # -pdf=pdflatex;-pdfxe=xelatex;-pdflua=lualatex
JOBNAME ?= $(TARGET)

DRAFTON ?= 0 # 1=on;0=off
FONTFAMILY ?= 0 # 0=CMU;1=MS fonts;2=Liberation fonts
ALTFONT ?= 0 # 0=Computer Modern;1=pscyr;2=XCharter
USEBIBER ?= 1 # 0=bibtex8;1=biber
IMGCOMPILE ?= 0 # 1=on;0=off
LATEXFLAGS ?= -halt-on-error -file-line-error
BIBERFLAGS ?=
LATEXMKFLAGS ?=
REGEXDIRS ?= . Dissertation Synopsis Presentation

export DRAFTON
export FONTFAMILY
export ALTFONT
export USEBIBER
export IMGCOMPILE
export LATEXFLAGS
export BIBERFLAGS
export REGEXREMOVE
export REGEXDIRS

all: synopsis dissertation

# include after "all" rule
include examples.mk

preformat: synopsis-preformat dissertation-preformat

_compile:
	latexmk $(LATEXMKFLAGS) $(BACKEND) -jobname=$(JOBNAME) --shell-escape -r $(MKRC) $(TARGET)

mylatexformat.ltx:
	etex -ini "&latex" $@ """$(TARGET)"""

dissertation:
	"$(MAKE)" TARGET=dissertation _compile

synopsis:
	"$(MAKE)" TARGET=synopsis _compile

presentation:
	"$(MAKE)" TARGET=presentation _compile

dissertation-draft: DRAFTON=1
dissertation-draft: dissertation

synopsis-draft: DRAFTON=1
synopsis-draft: synopsis

pdflatex: BACKEND=-pdf
pdflatex: dissertation sinopsys

draft: dissertation-draft synopsis-draft

dissertation-preformat: TARGET=dissertation
dissertation-preformat: mylatexformat.ltx dissertation

dissertation-formated: dissertation

synopsis-preformat: TARGET=synopsis
synopsis-preformat: mylatexformat.ltx synopsis

synopsis-formated: synopsis

release: all
	git add dissertation.pdf
	git add synopsis.pdf

_clean:
	latexmk $(LATEXMKFLAGS) -f -r $(MKRC) -jobname=$(JOBNAME) -c $(TARGET)

_distclean:
	latexmk $(LATEXMKFLAGS) -f -r $(MKRC) -jobname=$(JOBNAME) -C $(TARGET)

clean:
	"$(MAKE)" TARGET=dissertation JOBNAME=dissertation _clean
	"$(MAKE)" TARGET=synopsis JOBNAME=synopsis _clean
	"$(MAKE)" TARGET=presentation JOBNAME=presentation _clean

distclean:
	"$(MAKE)" TARGET=dissertation JOBNAME=dissertation _distclean
	"$(MAKE)" TARGET=synopsis JOBNAME=synopsis _distclean
	"$(MAKE)" TARGET=presentation JOBNAME=presentation _distclean
