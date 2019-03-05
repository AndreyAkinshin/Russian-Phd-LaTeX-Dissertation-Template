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
