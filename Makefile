# settings precedence: command line>usercfg.mk>{windows,unix}.mk

# user settings
# include before variable definitions
ifneq ($(wildcard usercfg.mk),)
	include usercfg.mk
endif

# platform specific settings
# include before variable definitions
ifeq ($(OS),Windows_NT)
	include windows.mk
else
	include unix.mk
endif

# Ghostscript-based pdf postprocessing
include compress.mk

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

# Do not modify the section below. Edit usercfg.mk instead.
DRAFTON ?= # 1=on;0=off
FONTFAMILY ?= # 0=CMU;1=MS fonts;2=Liberation fonts
ALTFONT ?= # 0=Computer Modern;1=pscyr;2=XCharter
USEBIBER ?= # 0=bibtex8;1=biber
IMGCOMPILE ?= # 1=on;0=off
NOTESON ?= # 0=off;1=on, separate slide;2=on, same slide
LATEXFLAGS ?= -halt-on-error -file-line-error
LATEXMKFLAGS ?= -silent
BIBERFLAGS ?= # --fixinits
REGEXDIRS ?= . Dissertation Synopsis Presentation # distclean dirs
TIMERON ?= # show CPU usage

# Makefile options
MAKEFLAGS := -s
.DEFAULT_GOAL := all
.NOTPARALLEL:

export DRAFTON
export FONTFAMILY
export ALTFONT
export USEBIBER
export IMGCOMPILE
export NOTESON
export LATEXFLAGS
export BIBERFLAGS
export REGEXDIRS
export TIMERON

##! компиляция всех файлов
all: synopsis dissertation presentation

define compile
	latexmk -norc -r $(MKRC) $(LATEXMKFLAGS) $(BACKEND) -jobname=$(JOBNAME) $(TARGET)
endef

##! компиляция диссертации
dissertation: JOBNAME=dissertation
dissertation: TARGET=dissertation
dissertation:
	$(compile)

##! компиляция автореферата
synopsis: JOBNAME=synopsis
synopsis: TARGET=synopsis
synopsis:
	$(compile)

##! компиляция презентации
presentation: JOBNAME=presentation
presentation: TARGET=presentation
presentation:
	$(compile)

##! компиляция черновика диссертации
dissertation-draft: DRAFTON=1
dissertation-draft: dissertation

##! компиляция черновика автореферата
synopsis-draft: DRAFTON=1
synopsis-draft: synopsis

##! компиляция диссертации, автореферата, и презентации при помощи pdflatex
pdflatex: BACKEND=-pdf
pdflatex: dissertation synopsis presentation

##! компиляция черновиков всех файлов
draft: dissertation-draft synopsis-draft

##! компиляция автореферата в формате А4 для печати
synopsis-booklet: synopsis
synopsis-booklet: TARGET=synopsis_booklet
synopsis-booklet: JOBNAME=synopsis_booklet
synopsis-booklet:
	$(compile)

##! добавление .pdf автореферата и диссертации в систему контроля версий
release: all
	git add dissertation.pdf
	git add synopsis.pdf

_clean:
	latexmk -norc -r $(MKRC) -f $(LATEXMKFLAGS) $(BACKEND) -jobname=$(JOBNAME) -c $(TARGET)

_distclean:
	latexmk -norc -r $(MKRC) -f $(LATEXMKFLAGS) $(BACKEND) -jobname=$(JOBNAME) -C $(TARGET)

##! очистка проекта от временных файлов
clean:
	"$(MAKE)" TARGET=dissertation JOBNAME=dissertation _clean
	"$(MAKE)" TARGET=synopsis JOBNAME=synopsis _clean
	"$(MAKE)" TARGET=presentation JOBNAME=presentation _clean

##! полная очистка проекта от временных файлов
distclean:
	"$(MAKE)" TARGET=dissertation JOBNAME=dissertation _distclean
	"$(MAKE)" TARGET=synopsis JOBNAME=synopsis _distclean
	"$(MAKE)" TARGET=presentation JOBNAME=presentation _distclean

# include after "all" rule
include examples.mk

.PHONY: all dissertation synopsis presentation dissertation-draft \
synopsis-draft pdflatex draft synopsis-booklet release _clean \
_distclean clean distclean
