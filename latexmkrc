$DRAFTON = $ENV{DRAFTON};
$FONTFAMILY = $ENV{FONTFAMILY};
$ALTFONT = $ENV{ALTFONT};
$USEBIBER = $ENV{USEBIBER};
$IMGCOMPILE = $ENV{IMGCOMPILE};
$LATEXFLAGS = $ENV{LATEXFLAGS};
$BIBERFLAGS = $ENV{BIBERFLAGS};
$REGEXDIRS = $ENV{REGEXDIRS} || ". Dissertation Synopsis Presentation";

$counters = ' %O "';
if ($DRAFTON ne "") {
    $counters = $counters . '\newcounter{draft}' .
        '\setcounter{draft}' . '{' . $DRAFTON . "}";
}
if ($FONTFAMILY ne "") {
    $counters = $counters . '\newcounter{fontfamily}' .
        '\setcounter{fontfamily}' . '{' . $FONTFAMILY . "}";
}
if ($ALTFONT ne "") {
    $counters = $counters . '\newcounter{usealtfont}' .
        '\setcounter{usealtfont}' . '{' . $ALTFONT . "}";
}
if ($USEBIBER ne "") {
    $counters = $counters . '\newcounter{bibliosel}' .
        '\setcounter{bibliosel}' . '{' . $USEBIBER . "}";
}
if ($IMGCOMPILE ne "") {
    $counters = $counters . '\newcounter{imgprecompile}' .
        '\setcounter{imgprecompile}' . '{' . $IMGCOMPILE . "}";
}
$counters = $counters . '\input{%T}"';

# set options for all *latex
set_tex_cmds($counters);
$biber = 'biber ' . $BIBERFLAGS . ' %O %S';
$bibtex = 'bibtex8 -B -c utf8cyrillic.csf %B';

# set to 1 to count CPU time
$show_time = 0;

# record access files
$recorder = 1;

# delete bibtex generated files
$bibtex_use = 2;

# extensions to clean with -c flag
$clean_ext = "%R.bbl %R.aux %R.lof %R.log %R.lot %R.fls %R.out %R.toc %R.run.xml %R.xdv";

# extensions to clean with -C flag
$clean_full_ext = "%R.bbl %R.aux %R.lof %R.log %R.lot %R.fls %R.out %R.toc %R.run.xml %R.xdv";

# this option is for debugging
# 0 to silently delete files, 1 to show what would be deleted
$remove_dryrun = 0;

# literal file strings to delete with -c flag
@clean_literal = ("mylatexformat.fmt", "mylatexformat.log");

## Core latex/pdflatex auxiliary files:
@clean_regexp = ("*.aux",
                 "*.lof",
                 "*.log",
                 "*.lot",
                 "*.fls",
                 "*.out",
                 "*.toc");

## Intermediate documents:
# these rules might exclude image files for figures etc.
# *.ps
# *.eps
# *.pdf
push(@clean_regexp,
     "*.dvi",
     "*-converted-to.*",
     "*xdv"
    );

## Bibliography auxiliary files (bibtex/biblatex/biber):
push(@clean_regexp,
     "*.bbl",
     "*.bcf",
     "*.blg",
     "*-blx.aux",
     "*-blx.bib",
     "*.brf",
     "*.run.xml"
    );

## Build tool auxiliary files:
push(@clean_regexp,
     "*.fdb_latexmk",
     "*.synctex",
     "*.synctex.gz",
     "*.synctex.gz\(busy\)",
     "*.pdfsync",
    );


## Auxiliary and intermediate files from other packages:

# algorithms
push(@clean_regexp,
     "*.alg",
     "*.loa",
    );

# achemso
push(@clean_regexp,
     "acs-*.bib",
    );

# amsthm
push(@clean_regexp,
     "*.thm",
    );

# beamer
push(@clean_regexp,
     "*.nav",
     "*.snm",
     "*.vrb",
    );

#(e)ledmac/(e)ledpar
push(@clean_regexp,
     "*.end",
     "*.[1-9]",
     "*.[1-9][0-9]",
     "*.[1-9][0-9][0-9]",
     "*.[1-9]R",
     "*.[1-9][0-9]R",
     "*.[1-9][0-9][0-9]R",
     "*.eledsec[1-9]",
     "*.eledsec[1-9]R",
     "*.eledsec[1-9][0-9]",
     "*.eledsec[1-9][0-9]R",
     "*.eledsec[1-9][0-9][0-9]",
     "*.eledsec[1-9][0-9][0-9]R",
    );

# glossaries
push(@clean_regexp,
     "*.acn",
     "*.acr",
     "*.glg",
     "*.glo",
     "*.gls",
    );

# gnuplottex
push(@clean_regexp,
     "*-gnuplottex-*",
    );

# hyperref
push(@clean_regexp,
     "*.brf",
    );

# knitr
push(@clean_regexp,
     "*-concordance.tex",
     "*-tikzDictionary",
    );
# "*.tikz",

# listings
push(@clean_regexp,
     "*.lol",
    );

# makeidx
push(@clean_regexp,
     "*.idx",
     "*.ilg",
     "*.ind",
     "*.ist",
    );

# minitoc
push(@clean_regexp,
     "*.maf",
     "*.mtc",
     "*.mtc[0-9]",
     "*.mtc[1-9][0-9]",
    );

# minted
push(@clean_regexp,
     "_minted*",
     "*.pyg",
    );

# morewrites
push(@clean_regexp,
     "*.mw",
    );

# mylatexformat
push(@clean_regexp,
     "*.fmt",
    );

# nomencl
push(@clean_regexp,
     "*.nlo",
    );

# sagetex
push(@clean_regexp,
     "*.sagetex.sage",
     "*.sagetex.py",
     "*.sagetex.scmd",
    );

# sympy
push(@clean_regexp,
     "*.sout",
     "*.sympy",
    );
# sympy-plots-for-*.tex/

# pdfcomment
push(@clean_regexp,
     "*.upa",
     "*.upb",
    );

# pythontex
push(@clean_regexp,
     "*.pytxcode",
    );
# pythontex-files-*/

# Texpad
push(@clean_regexp,
     ".texpadtmp",
    );

# TikZ & PGF
push(@clean_regexp,
     "*.dpth",
     "*.md5",
     "*.auxlock",
    );

# todonotes
push(@clean_regexp,
     "*.tdo",
    );

# xindy
push(@clean_regexp,
     "*.xdy",
    );

# WinEdt
push(@clean_regexp,
     "*.bak",
     "*.sav",
    );

# GnuEmacs
push(@clean_regexp,
     "*~",
    );

# endfloat
push(@clean_regexp,
     "*.ttt",
     "*.fff",
     "*.aux",
     "*.bbl",
     "*.blg",
     "*.dvi",
     "*.fdb_latexmk",
     "*.fls",
     "*.glg",
     "*.glo",
     "*.gls",
     "*.idx",
     "*.ilg",
     "*.ind",
     "*.ist",
     "*.lof",
     "*.log",
     "*.lot",
     "*.nav",
     "*.nlo",
     "*.out",
     "*.pdfsync",
     "*.ps",
     "*.snm",
     "*.synctex.gz",
     "*.toc",
     "*.vrb",
     "*.maf",
     "*.mtc",
     "*.mtc0",
     "*.bak",
     "*.bcf",
     "*.run.xml",
    );

# latexindent backup
push(@clean_regexp,
     "*.bak[0-9]",
    );

# compressed pdf file
push(@clean_regexp,
     "*_compressed.pdf",
    );

# biber tool
push(@clean_regexp,
     "bibcheck.log",
     "*_bibertool.bib",
    );

########################################################
# functions

sub regexp_cleanup {
    my @clean_regexp_dirs = split /(?<=\s)/, $REGEXDIRS;
    foreach my $dir (@clean_regexp_dirs) {
        $dir =~ s/^\s*(.*?)\s*$/$1/;
        foreach my $pattern (@clean_regexp)
        {
            my @files = glob "$dir/$pattern";
            foreach my $file (@files) {
                if ($remove_dryrun == 0) {
                    unlink_or_move( glob( "$file" ) );
                } else {
                    print "Would be removed: $file\n";
                }
            }
        }
    }
}

sub literal_cleanup {
    foreach my $file (@clean_literal)
    {
        if ($remove_dryrun == 0) {
            unlink_or_move( glob( "$file" ) );
        } else {
            print "Would be removed: $file\n";
        }
    }
}

sub cleanup1 {
    # Usage: cleanup1( directory, exts_without_period, ... )
    #
    # The directory and the root file name are fixed names, so I must escape
    #   any glob metacharacters in them:
    my $dir = fix_pattern( shift );
    my $root_fixed = fix_pattern( $root_filename );
    foreach (@_) {
        my $name = /%R/ ? $_ : "%R.$_";
	$name =~ s/%R/${root_fixed}/;
	$name = $dir.$name;
        if ($remove_dryrun == 0) {
            unlink_or_move( glob( "$name" ) );
        } else {
            print "Would be removed: $name\n";
        }
    }
    if ($cleanup_mode == 1) {
        literal_cleanup();
        regexp_cleanup();
    }
} #END cleanup1
