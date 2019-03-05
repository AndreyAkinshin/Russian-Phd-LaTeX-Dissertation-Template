# example rules

.PHONY: examples examples-pdflatex-modern examples-pdflatex-pscyr \
examples-pdflatex-xcharter examples-xelatex-cmu examples-xelatex-ms\
examples-xelatex-liberation examples-lualatex-cmu examples-lualatex-ms\
examples-lualatex-liberation

examples: examples-pdflatex-modern examples-pdflatex-pscyr \
examples-pdflatex-xcharter examples-xelatex-cmu examples-xelatex-ms\
examples-xelatex-liberation examples-lualatex-cmu examples-lualatex-ms\
examples-lualatex-liberation

EXAMPLENAME = $(JOBNAME)_$(TYPE)_draft-$(DRF)_biber-$(BIB)

examples-pdflatex-modern: JOBNAME=$@
examples-pdflatex-modern: BACKEND=-pdf
examples-pdflatex-modern: ALTFONT=0
examples-pdflatex-modern:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-pdflatex-pscyr: JOBNAME=$@
examples-pdflatex-pscyr: BACKEND=-pdf
examples-pdflatex-pscyr: ALTFONT=1
examples-pdflatex-pscyr:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=0;\
	"$(MAKE)" distclean; \
	)))

examples-pdflatex-xcharter: JOBNAME=$@
examples-pdflatex-xcharter: BACKEND=-pdf
examples-pdflatex-xcharter: ALTFONT=1
examples-pdflatex-xcharter:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-xelatex-cmu: JOBNAME=$@
examples-xelatex-cmu: BACKEND=-pdfxe
examples-xelatex-cmu: FONTFAMILY=0
examples-xelatex-cmu:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-xelatex-ms: JOBNAME=$@
examples-xelatex-ms: BACKEND=-pdfxe
examples-xelatex-ms: FONTFAMILY=1
examples-xelatex-ms:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-xelatex-liberation: JOBNAME=$@
examples-xelatex-liberation: BACKEND=-pdfxe
examples-xelatex-liberation: FONTFAMILY=2
examples-xelatex-liberation:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-lualatex-cmu: JOBNAME=$@
examples-lualatex-cmu: BACKEND=-pdflua
examples-lualatex-cmu: FONTFAMILY=0
examples-lualatex-cmu:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-lualatex-ms: JOBNAME=$@
examples-lualatex-ms: BACKEND=-pdflua
examples-lualatex-ms: FONTFAMILY=1
examples-lualatex-ms:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))

examples-lualatex-liberation: JOBNAME=$@
examples-lualatex-liberation: BACKEND=-pdflua
examples-lualatex-liberation: FONTFAMILY=2
examples-lualatex-liberation:
	#
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	"$(MAKE)" distclean; \
	)))
