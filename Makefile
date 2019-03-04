.PHONY: all preformat dissertation dissertation-draft pdflatex \
synopsis synopsis-draft draft talk dissertation-preformat \
dissertation-formated synopsis-preformat synopsis-formated \
spell-check indent compress examples clean distclean release

all: synopsis dissertation

preformat: synopsis-preformat dissertation-preformat

dissertation:
	$(MAKE) -C dissertation
	cp -t . dissertation/*.pdf

dissertation-draft:
	$(MAKE) draft -C dissertation
	cp -t . dissertation/*.pdf

pdflatex:
	$(MAKE) BACKEND=-pdf -C dissertation
	cp -t . dissertation/*.pdf

synopsis:
	$(MAKE) -C synopsis
	cp -t . synopsis/*.pdf

synopsis-draft:
	$(MAKE) draft -C synopsis
	cp -t . synopsis/*.pdf

draft:
	$(MAKE) draft -C dissertation
	cp -t . dissertation/*.pdf
	$(MAKE) draft -C synopsis
	cp -t . synopsis/*.pdf

talk:
	$(MAKE) -C presentation
	cp -t . presentation/*.pdf

dissertation-preformat:
	$(MAKE) preformat -C dissertation
	$(MAKE) -C dissertation
	cp -t . dissertation/*.pdf

dissertation-formated:
	$(MAKE) -C dissertation
	cp -t . dissertation/*.pdf

synopsis-preformat:
	$(MAKE) preformat -C synopsis
	$(MAKE) -C synopsis
	cp -t . synopsis/*.pdf

synopsis-formated:
	$(MAKE) -C synopsis
	cp -t . synopsis/*.pdf

spell-check:
	$(MAKE) spell-check -C dissertation
	$(MAKE) spell-check -C synopsis
	$(MAKE) spell-check -C presentation

indent:
	$(MAKE) indent -C dissertation
	$(MAKE) indent -C synopsis
	$(MAKE) indent -C presentation

compress:
	$(MAKE) compress -C dissertation
	$(MAKE) compress -C synopsis
	$(MAKE) compress -C presentation

examples:
	$(foreach backend,'-pdf' '-pdfxe' '-pdflua',\
	$(foreach draft,0 1,\
	$(foreach font,0 1 2, \
	$(foreach bib,0 1, \
	$(foreach comp,0 1, \
	$(foreach type,"synopsis" "dissertation", \
	$(eval job="$(type)_backend=$(backend)_draft=$(draft)_font=$(font)_bib=$(bib)_img_compile=$(comp)")\
	echo Building $(job);\
	$(MAKE) JOBNAME=$(job)\
	BACKEND=$(backend) DRAFTON=$(draft)\
	ALTFONT=$(font) USEBIBER=$(bib)\
	IMGCOMPILE=$(comp) $(type) -C .;\
	$(MAKE) distclean -C $(type);\
	))))))



clean:
	$(MAKE) clean -C dissertation
	$(MAKE) clean -C synopsis
	$(MAKE) clean -C presentation

distclean:
	$(MAKE) distclean -C dissertation
	$(MAKE) distclean -C synopsis
	$(MAKE) distclean -C presentation

	# pdf files
	rm -f *.pdf

release: all
	git add dissertation.pdf
	git add synopsis.pdf
