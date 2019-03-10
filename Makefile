# settings precedence: command line>usercfg.mk>{windows,unix}.mk

# user settings
# include before variable definitions
ifneq ($(wildcard usercfg.mk),)
	include usercfg.mk
endif

# platform specific settings
# include before variable definitions
ifdef WINDIR
    include windows.mk
else
    include unix.mk
endif

MKRC ?= latexmkrc # config file
TARGET ?= dissertation # target .tex file
JOBNAME ?= $(TARGET) # project basename
BACKEND ?= -pdfxe
# -pdf=pdflatex
# -pdfdvi=pdflatex with dvi
# -pdfps=pdflatex with ps
# -pdfxe=xelatex with dvi (faster than -xelatex)
# -xelatex=xelatex without dvi
# -pdflua=lualatex with dvi  (faster than -lualatex)
# -lualatex=lualatex without dvi

DRAFTON ?= # 1=on;0=off
FONTFAMILY ?= # 0=CMU;1=MS fonts;2=Liberation fonts
ALTFONT ?= # 0=Computer Modern;1=pscyr;2=XCharter
USEBIBER ?= # 0=bibtex8;1=biber
IMGCOMPILE ?= # 1=on;0=off
LATEXFLAGS ?= -halt-on-error -file-line-error
LATEXMKFLAGS ?= -silent
BIBERFLAGS ?= # --fixinits
REGEXDIRS ?= . Dissertation Synopsis Presentation # distclean dirs
MAKEFLAGS := -s

export DRAFTON
export FONTFAMILY
export ALTFONT
export USEBIBER
export IMGCOMPILE
export LATEXFLAGS
export BIBERFLAGS
export REGEXDIRS

all: synopsis dissertation presentation

preformat: synopsis-preformat dissertation-preformat

_compile:
	latexmk $(LATEXMKFLAGS) $(BACKEND) -jobname=$(JOBNAME) -r $(MKRC) $(TARGET)

mylatexformat.ltx:
	etex -ini "&latex" $@ """$(TARGET)"""

dissertation: JOBNAME=dissertation
dissertation: TARGET=dissertation
dissertation: _compile

synopsis: JOBNAME=synopsis
synopsis: TARGET=synopsis
synopsis: _compile

presentation: JOBNAME=presentation
presentation: TARGET=presentation
presentation: _compile

dissertation-draft: DRAFTON=1
dissertation-draft: dissertation

synopsis-draft: DRAFTON=1
synopsis-draft: synopsis

pdflatex: BACKEND=-pdf
pdflatex: dissertation synopsis presentation

draft: dissertation-draft synopsis-draft

dissertation-preformat: TARGET=dissertation
dissertation-preformat: mylatexformat.ltx dissertation

dissertation-formated: dissertation

synopsis-preformat: TARGET=synopsis
synopsis-preformat: mylatexformat.ltx synopsis

synopsis-formated: synopsis

synopsis-booklet: synopsis
synopsis-booklet: TARGET=synopsis_booklet _compile
synopsis-booklet: JOBNAME=synopsis_booklet _compile
synopsis-booklet: _compile

release: all
	git add dissertation.pdf
	git add synopsis.pdf

_clean:
	latexmk $(LATEXMKFLAGS) $(BACKEND) -f -r $(MKRC) -jobname=$(JOBNAME) -c $(TARGET)

_distclean:
	latexmk $(LATEXMKFLAGS) $(BACKEND) -f -r $(MKRC) -jobname=$(JOBNAME) -C $(TARGET)

clean:
	"$(MAKE)" TARGET=dissertation JOBNAME=dissertation _clean
	"$(MAKE)" TARGET=synopsis JOBNAME=synopsis _clean
	"$(MAKE)" TARGET=presentation JOBNAME=presentation _clean

distclean:
	"$(MAKE)" TARGET=dissertation JOBNAME=dissertation _distclean
	"$(MAKE)" TARGET=synopsis JOBNAME=synopsis _distclean
	"$(MAKE)" TARGET=presentation JOBNAME=presentation _distclean

# include after "all" rule
include examples.mk

# disable parallel build
.NOTPARALLEL:

.PHONY: all preformat _compile dissertation synopsis \
presentation dissertation-draft synopsis-draft pdflatex \
draft dissertation-preformat dissertation-formated \
synopsis-preformat synopsis-formated synopsis-booklet \
release _clean _distclean clean distclean

