# Данный файл будет добавлен к рабочему Makefile,
# если операционная система определится как Windows

### Пользовательские настройки

FONTFAMILY ?= 1 # Используются шрифты семейства MS

### Пользовательские правила

# INDENT_SETTINGS ?= indent.yaml
# INDENT_DIRS ?= Dissertation Presentation Synopsis
# INDENT_FILES ?= $(foreach dir,$(INDENT_DIRS),$(wildcard $(dir)/*.tex))
# indent:
# 	@$(foreach file, $(INDENT_FILES),\
# 	latexindent -l=$(INDENT_SETTINGS) -s -w $(file) &&)\
# 	echo "done"

.PHONY: indent
