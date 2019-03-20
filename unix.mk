# Данный файл будет добавлен к рабочему Makefile,
# если операционная система определится как система симейства UNIX

### Пользовательские настройки

FONTFAMILY ?= 2 # Используются шрифты семейства Liberation

### Пользовательские правила

INDENT_SETTINGS ?= indent.yaml
INDENT_DIRS ?= Dissertation Presentation Synopsis
INDENT_FILES ?= $(foreach dir,$(INDENT_DIRS),$(wildcard $(dir)/*.tex))
indent:
	@$(foreach file, $(INDENT_FILES),\
	latexindent -l=$(INDENT_SETTINGS) -s -w $(file);)

preformat: synopsis-preformat dissertation-preformat

%.fmt: %.tex
	$(eval BK :='&latex' ) # catch all
ifeq ($(BACKEND),-pdfxe)
	$(eval BK:="&xelatex")
endif
ifeq ($(BACKEND),-xelatex)
	$(eval BK:="&xelatex")
endif
ifeq ($(BACKEND),-pdflua)
	$(eval BK:="&lualatex")
endif
ifeq ($(BACKEND),-lualatex)
	$(eval BK:="&lualatex")
endif
	etex -ini -halt-on-error -file-line-error \
	-shell-escape -jobname=$(JOBNAME) \
	$(BK) mylatexformat.ltx """$^"""

dissertation-preformat: TARGET=dissertation
dissertation-preformat: dissertation.fmt dissertation

synopsis-preformat: TARGET=synopsis
synopsis-preformat: synopsis.fmt synopsis

.PHONY: indent preformat dissertation-preformat \
synopsis-preformat
