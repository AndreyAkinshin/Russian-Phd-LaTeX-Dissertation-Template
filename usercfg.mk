### Пользовательские настройки
# Откомментируйте настройки, чтобы использовать их по умолчанию

# MKRC ?= latexmkrc # config file
# TARGET ?= dissertation # target .tex file
# BACKEND ?= -pdfxe
## -pdf=pdflatex
## -pdfdvi=pdflatex with dvi
## -pdfps=pdflatex with ps
## -pdfxe=xelatex with dvi (faster than -xelatex)
## -xelatex=xelatex without dvi
## -pdflua=lualatex with dvi  (faster than -lualatex)
## -lualatex=lualatex without dvi

# DRAFTON ?= # 1=on;0=off
# FONTFAMILY ?= # 0=CMU;1=MS fonts;2=Liberation fonts
# ALTFONT ?= # 0=Computer Modern;1=pscyr;2=XCharter
# USEBIBER ?= # 0=bibtex8;1=biber
# IMGCOMPILE ?= # 1=on;0=off
# NOTESON ?= # 0=off;1=on, separate slide;2=on, same slide
# LATEXFLAGS ?= -halt-on-error -file-line-error
# LATEXMKFLAGS ?= -silent
# BIBERFLAGS ?= # --fixinits
# REGEXDIRS ?= . Dissertation Synopsis Presentation # distclean dirs
# TIMERON ?= # show CPU usage

### Пользовательские правила

### Откоментируйте и измените эти строки, чтобы задать файлы для форматирования
# INDENT_FILES += $(wildcard Dissertation/part1/*.tex)
# INDENT_FILES += $(wildcard Dissertation/part2/*.tex)
# INDENT_FILES += $(wildcard Dissertation/part3/*.tex)
# INDENT_FILES += $(wildcard Dissertation/part4/*.tex)
# INDENT_FILES += Synopsis/content.tex
# INDENT_FILES += Presentation/prescontent.tex


COMPRESS_FILE ?= dissertation.pdf
COMPRESSION_LEVEL ?= default # Possible values: screen, default, ebook, printer, prepress
COMPRESSION_FLAGS += -dBATCH -dNOPAUSE # no stops
COMPRESSION_FLAGS += -dEmbedAllFonts=true -dSubsetFonts=true # font settings

# image compression control
COMPRESSION_FLAGS += -dColorImageDownsampleType=/Average -dColorImageResolution=144
COMPRESSION_FLAGS += -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144
COMPRESSION_FLAGS += -dMonoImageDownsampleType=/Subsample -dMonoImageResolution=144

##! сжатие файла .pdf
compress: $(COMPRESS_FILE)
	ps2pdf14 $(COMPRESSION_FLAGS) -dPDFSETTINGS=/$(COMPRESSION_LEVEL) \
	$^ $(patsubst %.pdf,%_compressed.pdf,$^)

.PHONY: compress
