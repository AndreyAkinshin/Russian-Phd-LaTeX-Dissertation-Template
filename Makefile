.PHONY: synopsis dissertation preformat pdflatex talk dissertation-preformat\
dissertation-formated synopsis-preformat pdflatex-examples xcharter-examples\
pscyr-examples xelatex-examples xelatex-msfonts-examples xelatex-liberation-examples\
lualatex-examples lualatex-msfonts-examples lualatex-liberation-examples examples\
spell-check indent clean distclean release draft

all: synopsis dissertation

preformat: synopsis-preformat dissertation-preformat

ifneq ($(SystemDrive),)
    FONT_FAMILY?=1
else
    FONT_FAMILY?=2
endif

TEXFLAGS?=-halt-on-error -file-line-error

dissertation:
	#	$(MAKE) -C Dissertation
	latexmk -pdf -pdflatex="xelatex $(TEXFLAGS) %O '\newcounter{fontfamily}\setcounter{fontfamily}\
{$(FONT_FAMILY)}\input{%S}'" dissertation

pdflatex:
	latexmk -pdf -pdflatex="pdflatex $(TEXFLAGS) %O %S" dissertation

synopsis:
	#	$(MAKE) -C Synopsis
	latexmk -pdf -pdflatex="xelatex $(TEXFLAGS) %O '\newcounter{fontfamily}\setcounter{fontfamily}\
{$(FONT_FAMILY)}\input{%S}'" synopsis

draft:
	latexmk -pdf -pdflatex="xelatex $(TEXFLAGS) %O '\newcounter{fontfamily}\setcounter{fontfamily}\
{$(FONT_FAMILY)}\newcounter{draft}\setcounter{draft}{1}\input{%S}'" dissertation
	latexmk -pdf -pdflatex="xelatex $(TEXFLAGS) %O '\newcounter{fontfamily}\setcounter{fontfamily}\
{$(FONT_FAMILY)}\newcounter{draft}\setcounter{draft}{1}\input{%S}'" synopsis

talk:
	$(MAKE) talk -C Presentation

dissertation-preformat:
	etex -ini "&latex" mylatexformat.ltx """dissertation.tex"""
	latexmk -pdf -jobname=dissertation -silent --shell-escape dissertation.tex

dissertation-formated:
	latexmk -pdf -jobname=dissertation -silent --shell-escape dissertation.tex

synopsis-preformat:
	etex -ini "&latex" mylatexformat.ltx """synopsis.tex"""
	latexmk -pdf -jobname=synopsis -silent --shell-escape synopsis.tex

pdflatex-examples:
	#
	$(eval RCFILE = nodraft_cm_bibtex_latexmkrc)
	$(eval DESCR = pdflatex_bibtex)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = draft_cm_bibtex_latexmkrc)
	$(eval DESCR = pdflatex_bibtex_draft)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = nodraft_cm_latexmkrc)
	$(eval DESCR = pdflatex)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_cm_latexmkrc)
	$(eval DESCR = pdflatex_draft)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

pscyr-examples:
	#
	$(eval RCFILE = nodraft_msfonts_bibtex_latexmkrc)
	$(eval DESCR = pdflatex_pscyr_bibtex)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = draft_msfonts_bibtex_latexmkrc)
	$(eval DESCR = pdflatex_pscyr_bibtex_draft)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = nodraft_msfonts_latexmkrc)
	$(eval DESCR = pdflatex_pscyr)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_msfonts_latexmkrc)
	$(eval DESCR = pdflatex_pscyr_draft)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

xcharter-examples:
	#
	$(eval RCFILE = nodraft_altfont2_bibtex_latexmkrc)
	$(eval DESCR = pdflatex_xcharter_bibtex)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = draft_altfont2_bibtex_latexmkrc)
	$(eval DESCR = pdflatex_xcharter_bibtex_draft)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = nodraft_altfont2_latexmkrc)
	$(eval DESCR = pdflatex_xcharter)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_altfont2_latexmkrc)
	$(eval DESCR = pdflatex_xcharter_draft)
	latexmk -pdf -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -pdf -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -pdf -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -pdf -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

xelatex-examples:
	#
	$(eval RCFILE = nodraft_cm_bibtex_latexmkrc)
	$(eval DESCR = xelatex_bibtex)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	#
	$(eval RCFILE = draft_cm_bibtex_latexmkrc)
	$(eval DESCR = xelatex_bibtex_draft)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	#
	$(eval RCFILE = nodraft_cm_latexmkrc)
	$(eval DESCR = xelatex)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_cm_latexmkrc)
	$(eval DESCR = xelatex_draft)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

xelatex-msfonts-examples:
	#
	$(eval RCFILE = nodraft_msfonts_bibtex_latexmkrc)
	$(eval DESCR = xelatex_msfonts_bibtex)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	#
	$(eval RCFILE = draft_msfonts_bibtex_latexmkrc)
	$(eval DESCR = xelatex_msfonts_bibtex_draft)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	#
	$(eval RCFILE = nodraft_msfonts_latexmkrc)
	$(eval DESCR = xelatex_msfonts)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_msfonts_latexmkrc)
	$(eval DESCR = xelatex_msfonts_draft)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

xelatex-liberation-examples:
	#
	$(eval RCFILE = nodraft_altfont2_bibtex_latexmkrc)
	$(eval DESCR = xelatex_liberation_bibtex)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	#
	$(eval RCFILE = draft_altfont2_bibtex_latexmkrc)
	$(eval DESCR = xelatex_liberation_bibtex_draft)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	#
	$(eval RCFILE = nodraft_altfont2_latexmkrc)
	$(eval DESCR = xelatex_liberation)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_altfont2_latexmkrc)
	$(eval DESCR = xelatex_liberation_draft)
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -xelatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	rm -f dissertation_$(DESCR).xdv
	latexmk -xelatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f synopsis_$(DESCR).xdv
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

lualatex-examples:
	#
	$(eval RCFILE = nodraft_cm_bibtex_latexmkrc)
	$(eval DESCR = lualatex_bibtex)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = draft_cm_bibtex_latexmkrc)
	$(eval DESCR = lualatex_bibtex_draft)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = nodraft_cm_latexmkrc)
	$(eval DESCR = lualatex)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_cm_latexmkrc)
	$(eval DESCR = lualatex_draft)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

lualatex-msfonts-examples:
	#
	$(eval RCFILE = nodraft_msfonts_bibtex_latexmkrc)
	$(eval DESCR = lualatex_msfonts_bibtex)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = draft_msfonts_bibtex_latexmkrc)
	$(eval DESCR = lualatex_msfonts_bibtex_draft)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = nodraft_msfonts_latexmkrc)
	$(eval DESCR = lualatex_msfonts)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_msfonts_latexmkrc)
	$(eval DESCR = lualatex_msfonts_draft)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

lualatex-liberation-examples:
	#
	$(eval RCFILE = nodraft_altfont2_bibtex_latexmkrc)
	$(eval DESCR = lualatex_liberation_bibtex)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = draft_altfont2_bibtex_latexmkrc)
	$(eval DESCR = lualatex_liberation_bibtex_draft)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	#
	$(eval RCFILE = nodraft_altfont2_latexmkrc)
	$(eval DESCR = lualatex_liberation)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml
	#
	$(eval RCFILE = draft_altfont2_latexmkrc)
	$(eval DESCR = lualatex_liberation_draft)
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -r $(RCFILE) -silent -shell-escape dissertation
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -r $(RCFILE) -silent -shell-escape synopsis
	latexmk -lualatex -jobname="dissertation_$(DESCR)" -c dissertation
	rm -f dissertation_$(DESCR).bbl
	latexmk -lualatex -jobname="synopsis_$(DESCR)" -c synopsis
	rm -f synopsis_$(DESCR).bbl
	rm -f dissertation_$(DESCR).run.xml
	rm -f synopsis_$(DESCR).run.xml

examples: pdflatex-examples pscyr-examples xcharter-examples xelatex-examples\
xelatex-msfonts-examples xelatex-liberation-examples lualatex-examples\
lualatex-msfonts-examples lualatex-liberation-examples

SPELLCHECK_DIRS ?= Dissertation Presentation Synopsis
SPELLCHECK_FILES ?= $(foreach dir,$(SPELLCHECK_DIRS),$(wildcard $(dir)/*.tex))
SPELLCHECK_LANG ?= ru
DICT_DIR ?=
DICT_MAIN ?=
DICT_EXTRA ?=

ifdef DICT_DIR
    SDICT_DIR := --dict-dir=$(DICT_DIR)
endif

ifdef DICT_MAIN
    SDICT_MAIN := --master=$(DICT_MAIN)
endif

ifdef DICT_EXTRA
    SDICT_EXTRA := --extra-dicts=$(DICT_EXTRA)
endif

spell-check:
	@$(foreach file, $(SPELLCHECK_FILES),\
	aspell --lang=$(SPELLCHECK_LANG) $(SDICT_DIR) $(SDICT_MAIN) $(SDICT_EXTRA) --mode=tex --ignore-case check $(file);)

INDENT_SETTINGS ?= indent.yaml
INDENT_DIRS ?= Dissertation Presentation Synopsis
INDENT_FILES ?= $(foreach dir,$(INDENT_DIRS),$(wildcard $(dir)/*.tex))
indent:
	@$(foreach file, $(INDENT_FILES),\
	latexindent -l=$(INDENT_SETTINGS) -s -w $(file);)

clean:
	#	$(MAKE) clean -C Dissertation
	latexmk -C dissertation
	rm -f dissertation.bbl
	#	$(MAKE) clean -C Synopsis
	latexmk -C synopsis
	rm -f synopsis.bbl
	$(MAKE) clean -C Presentation

distclean:
	$(MAKE) distclean -C Dissertation
	$(MAKE) distclean -C Synopsis
	$(MAKE) distclean -C Presentation
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

	# latexindent backup
	rm -f *.bak[0-9]

release: all
	git add dissertation.pdf
	git add synopsis.pdf
