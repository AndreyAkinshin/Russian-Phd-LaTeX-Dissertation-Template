all: synopsis dissertation

dissertation:
	#	$(MAKE) -C Dissertation
	latexmk -pdf -pdflatex="xelatex %O %S" dissertation

synopsis:
	#	$(MAKE) -C Synopsis
	latexmk -pdf -pdflatex="xelatex %O %S" synopsis

draft:
	$(MAKE) draft -C Synopsis
	$(MAKE) draft -C Dissertation

clean:
	#	$(MAKE) clean -C Dissertation
	latexmk -C dissertation
	rm -f dissertation.bbl
	#	$(MAKE) clean -C Synopsis
	latexmk -C synopsis
	rm -f synopsis.bbl

distclean:
	$(MAKE) distclean -C Dissertation
	$(MAKE) distclean -C Synopsis
	## Core latex/pdflatex auxiliary files:
	rm -f *.aux
	rm -f *.lof
	rm -f *.log
	rm -f *.lot
	rm -f *.fls
	rm -f *.out
	rm -f *.toc

	## Intermediate documents:
	rm -f *.dvi
	rm -f *-converted-to.*
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

	#pythontex
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

release: all
	git add dissertation.pdf
	git add synopsis.pdf
