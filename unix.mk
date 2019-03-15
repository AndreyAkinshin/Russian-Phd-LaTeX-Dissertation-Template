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

mylatexformat.ltx:
	etex -ini "&latex" $@ """$(TARGET)"""

dissertation-preformat: TARGET=dissertation
dissertation-preformat: mylatexformat.ltx dissertation

dissertation-formated: dissertation

synopsis-preformat: TARGET=synopsis
synopsis-preformat: mylatexformat.ltx synopsis

synopsis-formated: synopsis

.PHONY: indent preformat dissertation-preformat \
dissertation-formated synopsis-preformat synopsis-formated
