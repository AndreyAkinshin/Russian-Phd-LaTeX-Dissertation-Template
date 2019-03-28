# example rules

.PHONY: examples examples-pdflatex-cm examples-pdflatex-pscyr \
examples-pdflatex-xcharter examples-xelatex-cmu examples-xelatex-msf\
examples-xelatex-liberation examples-lualatex-cmu examples-lualatex-msf\
examples-lualatex-liberation examples-presentation

examples: examples-pdflatex-cm examples-pdflatex-pscyr \
examples-pdflatex-xcharter examples-xelatex-cmu examples-xelatex-msf\
examples-xelatex-liberation examples-lualatex-cmu examples-lualatex-msf\
examples-lualatex-liberation examples-presentation

.EXAMPLENAME = $(TYPE)_$(subst -,_,$(subst examples-,,$(JOBNAME)))$(subst 0,_bibtex,$(subst 1,_biber,$(BIB)))$(subst 0,,$(subst 1,_draft,$(DRF)))

.PRESEXAMPLENAME = presentation$(BKND)-notes-$(subst 0,off,$(subst 1,separate,$(subst 2,same,$(NOTES))))

define basic-example #Canned Recipe
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" $(TYPE) \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		JOBNAME=$(.EXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		IMGCOMPILE=$(IMGCOMPILE);\
	) \
	$(foreach TYPE,dissertation synopsis, \
	"$(MAKE)" BACKEND=$(BACKEND) JOBNAME=$(.EXAMPLENAME) \
		TARGET=$(TYPE) _clean;\
	)))
endef

examples-pdflatex-cm: JOBNAME=$@
examples-pdflatex-cm: BACKEND=-pdf
examples-pdflatex-cm: ALTFONT=0
examples-pdflatex-cm:
	$(basic-example)

examples-pdflatex-pscyr: JOBNAME=$@
examples-pdflatex-pscyr: BACKEND=-pdf
examples-pdflatex-pscyr: ALTFONT=1
examples-pdflatex-pscyr:
	$(basic-example)

examples-pdflatex-xcharter: JOBNAME=$@
examples-pdflatex-xcharter: BACKEND=-pdf
examples-pdflatex-xcharter: ALTFONT=2
examples-pdflatex-xcharter:
	$(basic-example)

examples-xelatex-cmu: JOBNAME=$@
examples-xelatex-cmu: BACKEND=-pdfxe
examples-xelatex-cmu: FONTFAMILY=0
examples-xelatex-cmu:
	$(basic-example)

examples-xelatex-msf: JOBNAME=$@
examples-xelatex-msf: BACKEND=-pdfxe
examples-xelatex-msf: FONTFAMILY=1
examples-xelatex-msf:
	$(basic-example)

examples-xelatex-liberation: JOBNAME=$@
examples-xelatex-liberation: BACKEND=-pdfxe
examples-xelatex-liberation: FONTFAMILY=2
examples-xelatex-liberation:
	$(basic-example)

examples-lualatex-cmu: JOBNAME=$@
examples-lualatex-cmu: BACKEND=-pdflua
examples-lualatex-cmu: FONTFAMILY=0
examples-lualatex-cmu:
	$(basic-example)

examples-lualatex-msf: JOBNAME=$@
examples-lualatex-msf: BACKEND=-pdflua
examples-lualatex-msf: FONTFAMILY=1
examples-lualatex-msf:
	$(basic-example)

examples-lualatex-liberation: JOBNAME=$@
examples-lualatex-liberation: BACKEND=-pdflua
examples-lualatex-liberation: FONTFAMILY=2
examples-lualatex-liberation:
	$(basic-example)

examples-presentation:
	$(foreach BKND,-pdf -pdfxe -pdflua, \
	$(foreach NOTES,0 1 2, \
	"$(MAKE)" presentation \
		NOTESON=$(NOTES) \
		BACKEND=$(BKND) \
		JOBNAME=$(.PRESEXAMPLENAME);\
	"$(MAKE)" JOBNAME=$(.PRESEXAMPLENAME) _clean;\
	))
