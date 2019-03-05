# example rules

.PHONY: examples examples-lualatex-liberation

examples: examples-lualatex-liberation

examples-lualatex-liberation:
	#
	"$(MAKE)" dissertation \
		JOBNAME=dissertation_lualatex_liberation_nodraft_bibtex \
		BACKEND=-pdflua \
		DRAFTON=0 \
		FONTFAMILY=2 \
		USEBIBER=0 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	"$(MAKE)" synopsis \
		JOBNAME=synopsis_lualatex_liberation_nodraft_bibtex \
		BACKEND=-pdflua \
		DRAFTON=0 \
		FONTFAMILY=2 \
		USEBIBER=0 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	#
	"$(MAKE)" dissertation \
		JOBNAME=dissertation_lualatex_liberation_draft_bibtex \
		BACKEND=-pdflua \
		DRAFTON=1 \
		FONTFAMILY=2 \
		USEBIBER=0 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	"$(MAKE)" synopsis \
		JOBNAME=synopsis_lualatex_liberation_draft_bibtex \
		BACKEND=-pdflua \
		DRAFTON=1 \
		FONTFAMILY=2 \
		USEBIBER=0 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	#
	"$(MAKE)" dissertation \
		JOBNAME=dissertation_lualatex_liberation_nodraft_biber \
		BACKEND=-pdflua \
		DRAFTON=0 \
		FONTFAMILY=2 \
		USEBIBER=1 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	"$(MAKE)" synopsis \
		JOBNAME=synopsis_lualatex_liberation_nodraft_biber \
		BACKEND=-pdflua \
		DRAFTON=0 \
		FONTFAMILY=2 \
		USEBIBER=1 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	#
	"$(MAKE)" dissertation \
		JOBNAME=dissertation_lualatex_liberation_draft_biber \
		BACKEND=-pdflua \
		DRAFTON=1 \
		FONTFAMILY=2 \
		USEBIBER=1 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	"$(MAKE)" synopsis \
		JOBNAME=synopsis_lualatex_liberation_draft_biber \
		BACKEND=-pdflua \
		DRAFTON=1 \
		FONTFAMILY=2 \
		USEBIBER=1 \
		IMGCOMPILE=0
	"$(MAKE)" distclean
	#
