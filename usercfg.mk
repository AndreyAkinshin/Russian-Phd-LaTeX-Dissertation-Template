### user settings and recipes may be placed in this file

INDENT_SETTINGS ?= indent.yaml
INDENT_DIRS ?= Dissertation Presentation Synopsis
INDENT_FILES ?= $(foreach dir,$(INDENT_DIRS),$(wildcard $(dir)/*.tex))
indent:
	@$(foreach file, $(INDENT_FILES),\
	latexindent -l=$(INDENT_SETTINGS) -s -w $(file);)

COMPRESS_FILES ?= $(wildcard *.pdf)
COMPRESSION_LEVEL ?= default # Possible values: screen, default, ebook, printer, prepress
compress:
	@$(foreach file, $(COMPRESS_FILES),\
	ps2pdf14 -dBATCH -dNOPAUSE -dPDFSETTINGS=/$(COMPRESSION_LEVEL) \
	-sOutputFile=$(patsubst %.pdf,%_compressed.pdf,$(file)) $(file);)
