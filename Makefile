.PHONY: all preformat dissertation dissertation-draft pdflatex \
synopsis synopsis-draft draft talk dissertation-preformat \
dissertation-formated synopsis-preformat synopsis-formated \
_compile spell-check indent compress clean distclean release

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
LATEXFLAGS += -halt-on-error -file-line-error
BIBERFLAGS ?=

export DRAFTON
export FONTFAMILY
export ALTFONT
export USEBIBER
export IMGCOMPILE
export LATEXFLAGS
export BIBERFLAGS

all: synopsis dissertation

# include after "all" rule
include examples.mk

preformat: synopsis-preformat dissertation-preformat

_compile:
	latexmk $(BACKEND) -jobname=$(JOBNAME) --shell-escape -r $(MKRC) $(TARGET)

mylatexformat.ltx:
	etex -ini "&latex" $@ """$(TARGET)"""

dissertation: TARGET=dissertation
dissertation:
	"$(MAKE)" _compile

synopsis: TARGET=synopsis
synopsis:
	"$(MAKE)" _compile

presentation: TARGET=presentation
presentation:
	"$(MAKE)" _compile

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

clean:
	latexmk -jobname=$(JOBNAME) -c $(TARGET)

distclean: clean
	latexmk -jobname=$(JOBNAME) -C $(TARGET)

# ## Core latex/pdflatex auxiliary files:
# *.aux
# *.lof
# *.log
# *.lot
# *.fls
# *.out
# *.toc

# ## Files from subfolders
# part*/*.aux

# ## Intermediate documents:
# *.dvi
# *-converted-to.*
# *xdv
# # these rules might exclude image files for figures etc.
# # *.ps
# # *.eps
# # *.pdf

# ## Bibliography auxiliary files (bibtex/biblatex/biber):
# *.bbl
# *.bcf
# *.blg
# *-blx.aux
# *-blx.bib
# *.brf
# *.run.xml

# ## Build tool auxiliary files:
# *.fdb_latexmk
# *.synctex
# *.synctex.gz
# *.synctex.gz\(busy\)
# *.pdfsync

# ## Auxiliary and intermediate files from other packages:

# # algorithms
# *.alg
# *.loa

# # achemso
# acs-*.bib

# # amsthm
# *.thm

# # beamer
# *.nav
# *.snm
# *.vrb

# #(e)ledmac/(e)ledpar
# *.end
# *.[1-9]
# *.[1-9][0-9]
# *.[1-9][0-9][0-9]
# *.[1-9]R
# *.[1-9][0-9]R
# *.[1-9][0-9][0-9]R
# *.eledsec[1-9]
# *.eledsec[1-9]R
# *.eledsec[1-9][0-9]
# *.eledsec[1-9][0-9]R
# *.eledsec[1-9][0-9][0-9]
# *.eledsec[1-9][0-9][0-9]R

# # glossaries
# *.acn
# *.acr
# *.glg
# *.glo
# *.gls

# # gnuplottex
# *-gnuplottex-*

# # hyperref
# *.brf

# # knitr
# *-concordance.tex
# *.tikz
# *-tikzDictionary

# # listings
# *.lol

# # makeidx
# *.idx
# *.ilg
# *.ind
# *.ist

# # minitoc
# *.maf
# *.mtc
# *.mtc[0-9]
# *.mtc[1-9][0-9]

# # minted
# _minted*
# *.pyg

# # morewrites
# *.mw

# # mylatexformat
# *.fmt

# # nomencl
# *.nlo

# # sagetex
# *.sagetex.sage
# *.sagetex.py
# *.sagetex.scmd

# # sympy
# *.sout
# *.sympy
# sympy-plots-for-*.tex/

# # pdfcomment
# *.upa
# *.upb

# # pythontex
# *.pytxcode
# pythontex-files-*/

# # Texpad
# .texpadtmp

# # TikZ & PGF
# *.dpth
# *.md5
# *.auxlock

# # todonotes
# *.tdo

# # xindy
# *.xdy

# # WinEdt
# *.bak
# *.sav

# # GnuEmacs
# *~

# # endfloat
# *.ttt
# *.fff
# *.aux
# *.bbl
# *.blg
# *.dvi
# *.fdb_latexmk
# *.fls
# *.glg
# *.glo
# *.gls
# *.idx
# *.ilg
# *.ind
# *.ist
# *.lof
# *.log
# *.lot
# *.nav
# *.nlo
# *.out
# *.pdfsync
# *.ps
# *.snm
# *.synctex.gz
# *.toc
# *.vrb
# *.maf
# *.mtc
# *.mtc0
# *.bak
# *.bcf
# *.run.xml

# # latexindent backup
# *.bak[0-9]

# # compressed pdf file
# *_compressed.pdf

# # biber tool
# bibcheck.log
# *_bibertool.bib
