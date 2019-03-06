$DRAFTON = $ENV{DRAFTON};
$FONTFAMILY = $ENV{FONTFAMILY};
$ALTFONT = $ENV{ALTFONT};
$USEBIBER = $ENV{USEBIBER};
$IMGCOMPILE = $ENV{IMGCOMPILE};
$LATEXFLAGS = $ENV{LATEXFLAGS};
$BIBERFLAGS = $ENV{BIBERFLAGS};

$pdflatex = 'pdflatex '.$LATEXFLAGS.' %O "\newcounter{draft}\setcounter{draft}{ '.$DRAFTON.'}\newcounter{fontfamily}\setcounter{fontfamily}{'.$FONTFAMILY.'}\newcounter{usealtfont}\setcounter{usealtfont}{'.$ALTFONT.'}\newcounter{bibliosel}\setcounter{bibliosel}{'.$USEBIBER.'}\newcounter{imgprecompile}\setcounter{imgprecompile}{'.$IMGCOMPILE.'}\input{%T}"';
$xelatex = 'xelatex '.$LATEXFLAGS.' -no-pdf %O "\newcounter{draft}\setcounter{draft}{'.$DRAFTON.'}\newcounter{fontfamily}\setcounter{fontfamily}{'.$FONTFAMILY.'}\newcounter{usealtfont}\setcounter{usealtfont}{'.$ALTFONT.'}\newcounter{bibliosel}\setcounter{bibliosel}{'.$USEBIBER.'}\newcounter{imgprecompile}\setcounter{imgprecompile}{'.$IMGCOMPILE.'}\input{%T}"';
$lualatex = 'lualatex '.$LATEXFLAGS.' %O "\newcounter{draft}\setcounter{draft}{'.$DRAFTON.'}\newcounter{fontfamily}\setcounter{fontfamily}{'.$FONTFAMILY.'}\newcounter{usealtfont}\setcounter{usealtfont}{'.$ALTFONT.'}\newcounter{bibliosel}\setcounter{bibliosel}{'.$USEBIBER.'}\newcounter{imgprecompile}\setcounter{imgprecompile}{'.$IMGCOMPILE.'}\input{%T}"';
$biber = 'biber '.$BIBERFLAGS.' %O %S';
$bibtex = 'bibtex8 -B -c utf8cyrillic.csf %B';

$clean_ext = '%R.bbl %R.aux %R.lof %R.log %R.lot %R.fls %R.out %R.toc %R.run.xml %R.xdv'

$clean_full_ext = '*.bbl *.aux *.lof *.log *.lot *.fls *.out *.toc *.run.xml *.xdv *.dvi *-converted-to.* *.bbl *.bcf *.blg *-blx.aux *-blx.bib *.brf *.run.xml *.fdb_latexmk *.synctex *.synctex.gz *.synctex.gz\(busy\) *.pdfsync *.alg *.loa acs-*.bib *.thm *.nav *.snm *.vrb *.end *.[1-9] *.[1-9][0-9] *.[1-9][0-9][0-9] *.[1-9]R *.[1-9][0-9]R *.[1-9][0-9][0-9]R *.eledsec[1-9] *.eledsec[1-9]R *.eledsec[1-9][0-9] *.eledsec[1-9][0-9]R *.eledsec[1-9][0-9][0-9] *.eledsec[1-9][0-9][0-9]R *.acn *.acr *.glg *.glo *.gls *-gnuplottex-* *.brf *-concordance.tex *.tikz *-tikzDictionary *.lol *.idx *.ilg *.ind *.ist *.maf *.mtc *.mtc[0-9] *.mtc[1-9][0-9] _minted* *.pyg *.mw *.fmt *.nlo *.sagetex.sage *.sagetex.py *.sagetex.scmd *.sout *.sympy sympy-plots-for-*.tex/ *.upa *.upb *.pytxcode pythontex-files-*/ .texpadtmp *.dpth *.md5 *.auxlock *.tdo *.xdy *.bak *.sav *~ *.ttt *.fff *.aux *.bbl *.blg *.dvi *.fdb_latexmk *.fls *.glg *.glo *.gls *.idx *.ilg *.ind *.ist *.lof *.log *.lot *.nav *.nlo *.out *.pdfsync *.ps *.snm *.synctex.gz *.toc *.vrb *.maf *.mtc *.mtc0 *.bak *.bcf *.run.xml *.bak[0-9] *_compressed.pdf bibcheck.log *_bibertool.bib '
