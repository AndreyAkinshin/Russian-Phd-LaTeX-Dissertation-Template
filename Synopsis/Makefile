all:
	latexmk -pdf -pdflatex="xelatex %O %S" synopsis
clean:
	latexmk -C synopsis
	rm -f synopsis.bbl
