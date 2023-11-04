# Данный файл будет добавлен к рабочему Makefile,
# если операционная система определится как система семейства UNIX

### Пользовательские настройки

FONTFAMILY ?= 2 # Используются шрифты семейства Liberation

### Пользовательские правила

INDENT_SETTINGS ?= indent.yaml
ifeq ($(INDENT_FILES),)
INDENT_FILES += $(wildcard Dissertation/part*.tex)
INDENT_FILES += Synopsis/content.tex
INDENT_FILES += Presentation/content.tex
endif
##! форматирование файлов *.tex
indent:
	@$(foreach file, $(INDENT_FILES),\
	latexindent -l=$(INDENT_SETTINGS) -s -w $(file);)

##! форматирование файлов *.tex с разбиением длинных строк
indent-wrap: INDENT_SETTINGS+=-m
indent-wrap: indent

##! предкомпиляция диссертации и автореферата
preformat: synopsis-preformat dissertation-preformat \
presentation-preformat

%.fmt: %.tex
	etex -ini -halt-on-error -file-line-error \
	-shell-escape -jobname=$(TARGET) \
	"&latex" mylatexformat.ltx """$^"""

##! предкомпиляция диссертации
dissertation-preformat: TARGET=dissertation
dissertation-preformat: dissertation.fmt dissertation

##! предкомпиляция автореферата
synopsis-preformat: TARGET=synopsis
synopsis-preformat: synopsis.fmt synopsis

##! предкомпиляция презентации
presentation-preformat: TARGET=presentation
presentation-preformat: presentation.fmt presentation

# https://gist.github.com/klmr/575726c7e05d8780505a
##! это сообщение
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^##! / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^##! //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n##! /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')

.PHONY: indent indent-wrap preformat dissertation-preformat \
synopsis-preformat presentation-preformat help
