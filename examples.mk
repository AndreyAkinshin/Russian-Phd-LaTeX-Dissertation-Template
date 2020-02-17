# example rules

.PHONY: examples examples-pdf examples-xe examples-lua \
examples-pdflatex-cm examples-pdflatex-pscyr\
examples-pdflatex-xcharter examples-xelatex-cmu examples-xelatex-msf\
examples-xelatex-liberation examples-lualatex-cmu examples-lualatex-msf\
examples-lualatex-liberation examples-presentation

examples-pdf: examples-pdflatex-cm examples-pdflatex-pscyr \
examples-pdflatex-xcharter

examples-xe: examples-xelatex-cmu examples-xelatex-msf\
examples-xelatex-liberation

examples-lua: examples-lualatex-cmu examples-lualatex-msf\
examples-lualatex-liberation

examples: examples-pdf examples-xe examples-lua examples-presentation

.DISSEXAMPLENAME = dissertation_$(subst -,_,$(subst examples-,,$(TARGET)))$(subst 0,_bibtex,$(subst 1,_biber,$(BIB)))$(subst 0,,$(subst 1,_draft,$(DRF)))

.SYNEXAMPLENAME = synopsis_$(subst -,_,$(subst examples-,,$(TARGET)))$(subst 0,_bibtex,$(subst 1,_biber,$(BIB)))$(subst 0,,$(subst 1,_draft,$(DRF)))$(subst 0,,$(subst 1,_footnote,$(FOOT)))$(subst 0,,$(subst 1,_bibgrouped,$(GRP)))

.PRESEXAMPLENAME = $(subst -,_,presentation$(BKND)$(subst 0,-bibtex,$(subst 1,-biber,$(BIB)))-notes-$(subst 0,off,$(subst 1,separate,$(subst 2,same,$(NOTES)))))

define dissertation-example #Canned Recipe
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	"$(MAKE)" dissertation \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		TARGET=$(.DISSEXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB); \
	"$(MAKE)" BACKEND=$(BACKEND) TARGET=$(.DISSEXAMPLENAME) \
		SOURCE=dissertation clean-target; \
	))
endef

define synopsis-example #Canned Recipe
	$(foreach DRF,0 1, \
	$(eval FOOT:=0) \
	$(eval GRP:=0) \
	$(foreach BIB,0 1, \
	"$(MAKE)" synopsis \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		TARGET=$(.SYNEXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		BIBGROUPED=$(GRP) \
		USEFOOTCITE=$(FOOT); \
	"$(MAKE)" BACKEND=$(BACKEND) TARGET=$(.SYNEXAMPLENAME) \
		SOURCE=synopsis clean-target; \
		) \
	$(eval BIB:=1) \
	$(foreach FOOT,0 1, \
	$(foreach GRP,0 1, \
	"$(MAKE)" synopsis \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		TARGET=$(.SYNEXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB) \
		BIBGROUPED=$(GRP) \
		USEFOOTCITE=$(FOOT); \
	"$(MAKE)" BACKEND=$(BACKEND) TARGET=$(.SYNEXAMPLENAME) \
		SOURCE=synopsis clean-target; \
	)))
endef

define presentation-example #Canned Recipe
	$(foreach BKND,-pdf -pdfxe -pdflua, \
	$(foreach BIB,0 1, \
	$(foreach NOTES,0 1 2, \
	"$(MAKE)" presentation \
		NOTESON=$(NOTES) \
		USEBIBER=$(BIB) \
		BACKEND=$(BKND) \
		TARGET=$(.PRESEXAMPLENAME); \
	"$(MAKE)" TARGET=$(.PRESEXAMPLENAME) clean-target; \
	)))
endef


examples-pdflatex-cm: TARGET=$@
examples-pdflatex-cm: BACKEND=-pdf
examples-pdflatex-cm: ALTFONT=0
examples-pdflatex-cm:
	$(dissertation-example)
	$(synopsis-example)

examples-pdflatex-pscyr: TARGET=$@
examples-pdflatex-pscyr: BACKEND=-pdf
examples-pdflatex-pscyr: ALTFONT=1
examples-pdflatex-pscyr:
	$(dissertation-example)
	$(synopsis-example)

examples-pdflatex-xcharter: TARGET=$@
examples-pdflatex-xcharter: BACKEND=-pdf
examples-pdflatex-xcharter: ALTFONT=2
examples-pdflatex-xcharter:
	$(dissertation-example)
	$(synopsis-example)

examples-xelatex-cmu: TARGET=$@
examples-xelatex-cmu: BACKEND=-pdfxe
examples-xelatex-cmu: FONTFAMILY=0
examples-xelatex-cmu:
	$(dissertation-example)
	$(synopsis-example)

examples-xelatex-msf: TARGET=$@
examples-xelatex-msf: BACKEND=-pdfxe
examples-xelatex-msf: FONTFAMILY=1
examples-xelatex-msf:
	$(dissertation-example)
	$(synopsis-example)

examples-xelatex-liberation: TARGET=$@
examples-xelatex-liberation: BACKEND=-pdfxe
examples-xelatex-liberation: FONTFAMILY=2
examples-xelatex-liberation:
	$(dissertation-example)
	$(synopsis-example)

examples-lualatex-cmu: TARGET=$@
examples-lualatex-cmu: BACKEND=-pdflua
examples-lualatex-cmu: FONTFAMILY=0
examples-lualatex-cmu:
	$(dissertation-example)
	$(synopsis-example)

examples-lualatex-msf: TARGET=$@
examples-lualatex-msf: BACKEND=-pdflua
examples-lualatex-msf: FONTFAMILY=1
examples-lualatex-msf:
	$(dissertation-example)
	$(synopsis-example)

examples-lualatex-liberation: TARGET=$@
examples-lualatex-liberation: BACKEND=-pdflua
examples-lualatex-liberation: FONTFAMILY=2
examples-lualatex-liberation:
	$(dissertation-example)
	$(synopsis-example)

examples-presentation:
	$(presentation-example)
