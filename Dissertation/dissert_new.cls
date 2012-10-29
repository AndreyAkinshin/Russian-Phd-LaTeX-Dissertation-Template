%%
%% This is file `dissert_new.cls',
%% maked from the files `report.cls' and `size14.clo'.
%% Need package `geometry'.
%%
%% Author: Andrew Martovlos <martin@meduniv.lviv.ua>, 2002
%%
%% Class: dissert
%% Options: a4paper+, draft, final+, leqno, fleqn, openbib ('+' default)
%% Paper size: A4
%% Margins: top 2cm, bottom 2cm, left 3cm, right 1cm
%% Type: portrait, oneside, onecolumn
%% Font size: 14pt
%% Font: Computer Modern Roman
%% With package `PSCyr' and writing in preamble lines:
%%          \usepackage{pscyr}
%%          \renewcommand{\rmdefault}{ftm}
%%       will be using font `Times New Roman'
%% Interval: 1.5
%% Page numbering: upper-right corner
%% Type numbering: all sheets, including with title page (no visible)
%% Structures:
%%   Section \chapter 1
%%   Subsection \section 1.1
%%   Subsubsection \subsection 1.1.1
%%   Subsubsubsection \subsubsection 1.1.1.1
%%
%% Environments:
%%   description (labels prints such italic)
%%   quotation
%%   quote
%%   titlepage (with no keywords like \author, etc.)
%%   appendix
%%   figure
%%   table
%%   tableofcontents
%%   listoffigures
%%   thebibliography
%%   theindex
%%
%% New commands:
%% \contentsdesc (Default value `Page', print above page list in contents
%%                Reappropriate how you want)
%%
%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dissert_new}
              [2002/06/22 v1.1
 Non standard LaTeX document class]
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{a4paper,final}
\ProcessOptions

%%
%% Fonts sizes and values
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xivpt{17}%
   \abovedisplayskip 14\p@ \@plus3\p@ \@minus7\p@
   \abovedisplayshortskip \z@ \@plus4\p@
   \belowdisplayshortskip 7\p@ \@plus4\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\newcommand\small{%
   \@setfontsize\small\@xiipt{14}%
   \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 2\p@ \@plus3\p@ \@minus5\p@
               \parsep 1.5\p@ \@plus2\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\footnotesize{%
   \@setfontsize\footnotesize\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 2\p@ \@plus2\p@ \@minus2\p@
               \parsep 1\p@ \@plus2\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\scriptsize{\@setfontsize\scriptsize\@viiipt{9.5}}
\newcommand\tiny{\@setfontsize\tiny\@vipt\@viipt}
\newcommand\large{\@setfontsize\large\@xviipt{22}}
\newcommand\Large{\@setfontsize\Large\@xxpt{25}}
\newcommand\LARGE{\@setfontsize\LARGE\@xxvpt{30}}
\newcommand\huge{\@setfontsize\huge{29.86}{35}}
\newcommand\Huge{\@setfontsize\Huge{35.83}{40}}
\if@twocolumn
  \setlength\parindent{1em}
\else
  \setlength\parindent{2.5em}
\fi
\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\headheight{14\p@}
\setlength\headsep   {25\p@}
\setlength\topskip   {14\p@}
\setlength\footskip{30\p@}
\setlength\maxdepth{.5\topskip}
  
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-2in}
  \setlength\@tempdimb{430\p@}
  \if@twocolumn
    \ifdim\@tempdima>2\@tempdimb\relax
      \setlength\textwidth{2\@tempdimb}
    \else
      \setlength\textwidth{\@tempdima}
    \fi
  \else
    \ifdim\@tempdima>\@tempdimb\relax
      \setlength\textwidth{\@tempdimb}
    \else
      \setlength\textwidth{\@tempdima}
    \fi
  \fi
  \@settopoint\textwidth

  \setlength\@tempdima{\paperheight}
  \addtolength\@tempdima{-2in}
  \addtolength\@tempdima{-1.5in}
  \divide\@tempdima\baselineskip
  \@tempcnta=\@tempdima
  \setlength\textheight{\@tempcnta\baselineskip}
\addtolength\textheight{\topskip}
\if@twocolumn
 \setlength\marginparsep {10\p@}
\else
  \setlength\marginparsep{10\p@}
\fi
\setlength\marginparpush{7\p@}
  \if@twoside
    \setlength\@tempdima        {\paperwidth}
    \addtolength\@tempdima      {-\textwidth}
    \setlength\oddsidemargin    {.4\@tempdima}
    \addtolength\oddsidemargin  {-1in}
    \setlength\marginparwidth   {.6\@tempdima}
    \addtolength\marginparwidth {-\marginparsep}
    \addtolength\marginparwidth {-0.4in}
  \else
    \setlength\@tempdima        {\paperwidth}
    \addtolength\@tempdima      {-\textwidth}
    \setlength\oddsidemargin    {.5\@tempdima}
    \addtolength\oddsidemargin  {-1in}
    \setlength\marginparwidth   {.5\@tempdima}
    \addtolength\marginparwidth {-\marginparsep}
    \addtolength\marginparwidth {-0.4in}
    \addtolength\marginparwidth {-.4in}
  \fi
  \ifdim \marginparwidth >2in
     \setlength\marginparwidth{2in}
  \fi
  \@settopoint\oddsidemargin
  \@settopoint\marginparwidth
  \setlength\evensidemargin  {\paperwidth}
  \addtolength\evensidemargin{-2in}
  \addtolength\evensidemargin{-\textwidth}
  \addtolength\evensidemargin{-\oddsidemargin}
  \@settopoint\evensidemargin
  \setlength\topmargin{\paperheight}
  \addtolength\topmargin{-2in}
  \addtolength\topmargin{-\headheight}
  \addtolength\topmargin{-\headsep}
  \addtolength\topmargin{-\textheight}
  \addtolength\topmargin{-\footskip}     % this might be wrong!
  \addtolength\topmargin{-.5\topmargin}
  \@settopoint\topmargin
\setlength\footnotesep{9.8\p@}
\setlength{\skip\footins}{12\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep    {14\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {15\p@ \@plus 5\p@ \@minus 5\p@}
\setlength\dblfloatsep    {14\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{11\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{11\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{2\p@ \@plus 2\p@ \@minus 2\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep 1\p@  \@plus2.5\p@ \@minus\p@
            \topsep 2\p@ \@plus5\p@   \@minus7\p@
            \itemsep1\p@  \@plus2.5\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    1\p@   \@plus3\p@ \@minus\p@
              \parsep    1\p@ \@plus\p@    \@minus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    1\p@\@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
%% End fonts sizes and values
%%

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{1.5}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\def\ps@headings{%
%    \let\@oddfoot\@empty
%    \def\@oddhead{\hfil \thepage \hfil}%
    \let\@oddfoot{\hfil \thepage \hfil}
    \def\@oddhead{\hfil}%
%%    \def\@oddhead{\hfil --- \thepage \ --- \hfil}%
    }
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section} %.
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection} %.
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection} %
\newcommand\@chapapp{\chaptername}
\newcommand\chapter{\clearpage
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                               {\normalfont
			       \MakeUppercase{%
			       \@chapapp}\space\thechapter. #1}%
                    \else
                      \addcontentsline{toc}{chapter}%
		               {\normalfont
			       \MakeUppercase{#1}}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \@makechapterhead{#2}%
                    \@afterheading}
\def\@makechapterhead#1{%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
%%	\centering
        \MakeUppercase{\normalfont\Large\bfseries \@chapapp\space \thechapter.}
%%        \par\nobreak
    \fi
%%    \centering
    \interlinepenalty\@M
    \MakeUppercase{\normalfont\Large \bfseries #1}\par\nobreak
    \vskip 20\p@
  }}
\def\@schapter#1{\@makeschapterhead{#1}%
                 \@afterheading}
\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedright
    \normalfont
%%    \centering
    \interlinepenalty\@M
    \MakeUppercase{\normalfont\Large \bfseries  #1}\par\nobreak
    \vskip 20\p@
  }}

\newcommand\section{%
                                   \renewcommand{\@seccntformat}[1]{%
                                   \csname thesection\endcsname.\hspace{0.5em}}%
                                   \@startsection {section}{1}{\z@}%
                                   {3.5ex \@plus 1ex \@minus .2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\bfseries}}
\newcommand\subsection{%
                                    \renewcommand{\@seccntformat}[1]{%
                                    \csname thesubsection\endcsname.\hspace{0.5em}}%
                                    \@startsection{subsection}{2}{\z@}% %{\parindent}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {2.3ex \@plus.2ex}%
                                    %%{-1em}%
                                    {\normalfont\bfseries}}
\newcommand\subsubsection{
                                    \renewcommand{\@seccntformat}[1]{%
                                    \csname thesubsubsection\endcsname.\hspace{0.5em}}%
                                    \@startsection{subsubsection}{3}{\parindent}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\bfseries}}


\setlength\leftmargini  {2.5em}
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\itshape #1}

\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}

\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}

\newenvironment{titlepage}
    {\newpage \thispagestyle{empty}}{\newpage}

\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Asbuk\c@chapter}}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{10\p@}
\def\captable{table}
\def\capfigure{figure}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \ifx\@captype\captable
%%%  \hfill \normalfont #1 \par \centering #2 \par
  \normalfont #1 \par #2 \par
%%  \hfill {\setlength{\baselineskip}{0.6\baselineskip}\normalfont #1 \par \centering #2 \par}
  \else
%%  \normalfont \centering #1. #2
  {\setlength{\baselineskip}{0.6\baselineskip}\normalfont \centering #1. #2}
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
     \chapter*{\contentsname}%
     \begin{flushright}\contentsdesc\end{flushright}%
     \@starttoc{toc}%
     }
%\newcommand*\l@chapter[2]{%
%  \ifnum \c@tocdepth >\m@ne
%    \addpenalty{-\@highpenalty}%
%    \vskip 1.0em \@plus\p@
%    \setlength\@tempdima{2.3em}%
%    \begingroup
%      \parindent \z@ \rightskip \@pnumwidth
%      \parfillskip -\@pnumwidth
%      \leavevmode \bfseries
%      \advance\leftskip\@tempdima
%      \hskip -\leftskip
%      \normalfont #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%      \penalty\@highpenalty
%    \endgroup
%  \fi}

\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    %\addvspace{1.5em \@plus\p@}%
    \setlength\@tempdima{1.0em}%
    \begingroup
      \@tempdima 1.0cm \relax
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode %\bfseries
      \advance\leftskip 2.0cm \null\nobreak\hskip -\leftskip  %% вместо 2.0cm было написано \@tempdima и при этом получались выпирающие строки
      {\hspace{1cm}{#1}\nobreak }%
      \leaders\hbox{%
      $\m@th
      \mkern \@dotsep mu\hbox{.}\mkern \@dotsep%
      mu$}\hfill%
      \nobreak%
      \hb@xt@\@pnumwidth{\hfil\normalsize \normalcolor #2}% 
      \par%
    \endgroup
  \fi}

\newcommand*\l@subsection[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty%
    \setlength\@tempdima{1.5em}%    
    \begingroup
      \@tempdima 1.5cm \relax
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode %\bfseries      
      \advance\leftskip 3.5cm \null\nobreak %% вместо 3.5cm было написано \@tempdima и при этом получались выпирающие строки
      \hskip -\leftskip
      {\hspace{2.0cm}{#1}\nobreak }%
      \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
      \hfill%
      \nobreak%
      \hb@xt@\@pnumwidth{\hfil\normalsize \normalcolor #2}%
      \par%
    \endgroup
  \fi}

\newcommand*\l@chapter{\@dottedtocline{0}{2.0em}{0em}}
%\newcommand*\l@section{\@dottedtocline{1}{0em}{2.3em}}
%\newcommand*\l@subsection{\@dottedtocline{2}{0em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{0em}{4.1em}}

\newcommand\listoffigures{%
    \chapter*{\listfigurename}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \chapter*{\listtablename}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1.}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\clearpage}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\contentsdesc{Page}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
%\pagestyle{headings}
\pagenumbering{arabic}
\sloppy
\raggedbottom
\onecolumn
\usepackage{geometry}
\geometry{a4paper,top=2cm,bottom=2cm,left=3cm,right=1cm}
\renewcommand{\@biblabel}[1]{#1.}
\endinput
%%
%% End of file `dissert_new.cls'.
