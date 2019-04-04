# Данный файл будет добавлен к рабочему Makefile,
# если операционная система определится как Windows

### Пользовательские настройки

FONTFAMILY ?= 1 # Используются шрифты семейства MS

### Пользовательские правила

INDENT_SETTINGS ?= indent.yaml
ifeq ($(INDENT_FILES),)
INDENT_FILES += $(wildcard Dissertation/part*.tex)
INDENT_FILES += Synopsis/content.tex
INDENT_FILES += Presentation/prescontent.tex
endif
##! форматирование файлов *.tex
indent:
	@$(foreach file, $(INDENT_FILES),\
	latexindent -l=$(INDENT_SETTINGS) -s -w $(file) &&)\
	echo "done"

.PHONY: indent
