$DRAFTON = $ENV{DRAFTON};
$ALTFONT = $ENV{ALTFONT};
$USEBIBER = $ENV{USEBIBER};
$IMGCOMPILE = $ENV{IMGCOMPILE};
$LATEXFLAXS = $ENV{LATEXFLAXS};

$pdflatex = 'pdflatex $LATEXFLAXS %O "\newcounter{draft}\setcounter{draft}{$DRAFTON}\newcounter{usealtfont}\setcounter{usealtfont}{$ALTFONT}\newcounter{bibliosel}\setcounter{bibliosel}{$USEBIBER}\newcounter{imgprecompile}\setcounter{imgprecompile}{$IMGCOMPILE}\input{%T}"';
$xelatex = 'xelatex $LATEXFLAXS -no-pdf %O "\newcounter{draft}\setcounter{draft}{$DRAFTON}\newcounter{usealtfont}\setcounter{usealtfont}{$ALTFONT}\newcounter{bibliosel}\setcounter{bibliosel}{$USEBIBER}\newcounter{imgprecompile}\setcounter{imgprecompile}{$IMGCOMPILE}\input{%T}"';
$lualatex = 'lualatex $LATEXFLAXS %O "\newcounter{draft}\setcounter{draft}{$DRAFTON}\newcounter{usealtfont}\setcounter{usealtfont}{$ALTFONT}\newcounter{bibliosel}\setcounter{bibliosel}{$USEBIBER}\newcounter{imgprecompile}\setcounter{imgprecompile}{$IMGCOMPILE}\input{%T}"';
$biber = 'biber --fixinits %O %S';
$bibtex = 'bibtex8 -B -c utf8cyrillic.csf %B';
