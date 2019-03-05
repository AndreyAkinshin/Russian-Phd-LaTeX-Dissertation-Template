.PHONY: all preformat dissertation dissertation-draft pdflatex \
synopsis synopsis-draft draft talk dissertation-preformat \
dissertation-formated synopsis-preformat synopsis-formated \
spell-check indent compress examples clean distclean release

ifneq ($(SystemDrive),)
    include windows.mk
else
    include unix.mk
endif

MKRC ?= latexmkrc
TARGET ?= dissertation
BACKEND ?= -pdfxe # -pdf=pdflatex;-pdfxe=xelatex;-pdflua=lualatex
JOBNAME = $(TARGET)

export DRAFTON ?= 0 # 1=on;0=off
export ALTFONT ?= 0 # 0=CMU;1=MS fonts;2=Liberation fonts
export USEBIBER ?= 1 # 0=bibtex8;1=biber
export IMGCOMPILE ?= 0 # 1=on;0=off
export LATEXFLAXS := -halt-on-error -file-line-error

all: synopsis dissertation

preformat: synopsis-preformat
#dissertation-preformat

%.pdf: %.tex
	latexmk $(BACKEND) -jobname=$(JOBNAME) --shell-escape -r $(MKRC) $<

%.ltx: %.tex
	etex -ini "&latex" $< $@

dissertation: TARGET=dissertation
dissertation: dissertation.pdf

synopsis: TARGET=synopsis
synopsis: synopsis.pdf

presentation: TARGET=presentation
presentation: presentation.pdf

dissertation-draft: DRAFTON=1
dissertation-draft: dissertation

synopsis-draft: DRAFTON=1
synopsis-draft: synopsis

pdflatex: BACKEND=-pdf
pdflatex: dissertation sinopsys

draft: dissertation-draft synopsis-draft

dissertation-preformat: dissertation.ltx dissertation

dissertation-formated: dissertation

synopsis-preformat: synopsis.ltx synopsis

synopsis-formated: synopsis

release: all
	git add dissertation.pdf
	git add synopsis.pdf

clean:
	latexmk -C
	rm -f $(JOBNAME).bbl

distclean: clean
	## Core latex/pdflatex auxiliary files:
	rm -f *.aux
	rm -f *.lof
	rm -f *.log
	rm -f *.lot
	rm -f *.fls
	rm -f *.out
	rm -f *.toc

	## Files from subfolders
	rm -f part*/*.aux

	## Intermediate documents:
	rm -f *.dvi
	rm -f *-converted-to.*
	rm -f *xdv
	# these rules might exclude image files for figures etc.
	# *.ps
	# *.eps
	# *.pdf

	## Bibliography auxiliary files (bibtex/biblatex/biber):
	rm -f *.bbl
	rm -f *.bcf
	rm -f *.blg
	rm -f *-blx.aux
	rm -f *-blx.bib
	rm -f *.brf
	rm -f *.run.xml

	## Build tool auxiliary files:
	rm -f *.fdb_latexmk
	rm -f *.synctex
	rm -f *.synctex.gz
	rm -f *.synctex.gz\(busy\)
	rm -f *.pdfsync

	## Auxiliary and intermediate files from other packages:

	# algorithms
	rm -f *.alg
	rm -f *.loa

	# achemso
	rm -f acs-*.bib

	# amsthm
	rm -f *.thm

	# beamer
	rm -f *.nav
	rm -f *.snm
	rm -f *.vrb

	#(e)ledmac/(e)ledpar
	rm -f *.end
	rm -f *.[1-9]
	rm -f *.[1-9][0-9]
	rm -f *.[1-9][0-9][0-9]
	rm -f *.[1-9]R
	rm -f *.[1-9][0-9]R
	rm -f *.[1-9][0-9][0-9]R
	rm -f *.eledsec[1-9]
	rm -f *.eledsec[1-9]R
	rm -f *.eledsec[1-9][0-9]
	rm -f *.eledsec[1-9][0-9]R
	rm -f *.eledsec[1-9][0-9][0-9]
	rm -f *.eledsec[1-9][0-9][0-9]R

	# glossaries
	rm -f *.acn
	rm -f *.acr
	rm -f *.glg
	rm -f *.glo
	rm -f *.gls

	# gnuplottex
	rm -f *-gnuplottex-*

	# hyperref
	rm -f *.brf

	# knitr
	rm -f *-concordance.tex
	rm -f *.tikz
	rm -f *-tikzDictionary

	# listings
	rm -f *.lol

	# makeidx
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.ist

	# minitoc
	rm -f *.maf
	rm -f *.mtc
	rm -f *.mtc[0-9]
	rm -f *.mtc[1-9][0-9]

	# minted
	rm -f _minted*
	rm -f *.pyg

	# morewrites
	rm -f *.mw

	# mylatexformat
	rm -f *.fmt

	# nomencl
	rm -f *.nlo

	# sagetex
	rm -f *.sagetex.sage
	rm -f *.sagetex.py
	rm -f *.sagetex.scmd

	# sympy
	rm -f *.sout
	rm -f *.sympy
	rm -f sympy-plots-for-*.tex/

	# pdfcomment
	rm -f *.upa
	rm -f *.upb

	# pythontex
	rm -f *.pytxcode
	rm -f pythontex-files-*/

	# Texpad
	rm -f .texpadtmp

	# TikZ & PGF
	rm -f *.dpth
	rm -f *.md5
	rm -f *.auxlock

	# todonotes
	rm -f *.tdo

	# xindy
	rm -f *.xdy

	# WinEdt
	rm -f *.bak
	rm -f *.sav

	# GnuEmacs
	rm -f *~

	# endfloat
	rm -f *.ttt
	rm -f *.fff
	rm -f *.aux
	rm -f *.bbl
	rm -f *.blg
	rm -f *.dvi
	rm -f *.fdb_latexmk
	rm -f *.fls
	rm -f *.glg
	rm -f *.glo
	rm -f *.gls
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.ist
	rm -f *.lof
	rm -f *.log
	rm -f *.lot
	rm -f *.nav
	rm -f *.nlo
	rm -f *.out
	rm -f *.pdfsync
	rm -f *.ps
	rm -f *.snm
	rm -f *.synctex.gz
	rm -f *.toc
	rm -f *.vrb
	rm -f *.maf
	rm -f *.mtc
	rm -f *.mtc0
	rm -f *.bak
	rm -f *.bcf
	rm -f *.run.xml

	# latexindent backup
	rm -f *.bak[0-9]

	# compressed pdf file
	rm -f *_compressed.pdf

	# biber tool
	rm -f bibcheck.log
	rm -f _bibertool.bib

