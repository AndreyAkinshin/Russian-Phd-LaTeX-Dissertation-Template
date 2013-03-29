%%
%% This is file `ugost2008n.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% gost.dtx  (with options: `bst,utf8,modern,natbib,eprint')
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This file has the LPPL maintenance status "maintained".
%% Maintained by Igor A. Kotelnikov.
%% Current version: 2012.02.02
%% 
%% Please, send bug report via e-mail:
%%   kia999 at mail dot ru <Igor Kotelnikov>
%% or
%%   polyama at yahoo dot com <Maksym Polyakov>
%% 



%%
%% This bibstyle attempts to format bibliography according to
%% GOST 7.0.5-2008 for bibliographic reference.
%%-------------------------------------------------------------------
%% This is an author-year citation style bibliography.
%% It requires a special package file to function properly
%% such as natbib.sty by Patrick W. Daly.
%% The form of the \bibitem entries is
%%   \bibitem[Jones et al.(1990)]{key}...
%%   \bibitem[Jones et al.(1990)Jones, Baker, and Smith]{key}...
%% where the label part (in brackets) consists of the author names,
%% as they should appear in the citation, with the year in parentheses following.
%% There must be no space before the opening parenthesis!
%% A full list of authors may also follow the year.
%% In natbib.sty, it is possible to define the type of enclosures that is
%% really wanted (brackets or parentheses), but in either case, there must
%% be parentheses in the label.
%% The \cite command functions as follows:
%%   \citet{key}              => Jones et al. (1990)
%%   \citet*{key}             => Jones, Baker, and Smith (1990)
%%   \citep{key}              => (Jones et al., 1990)
%%   \citep*{key}             => (Jones, Baker, and Smith, 1990)
%%   \citep[chap. 2]{key}     => (Jones et al., 1990, chap. 2)
%%   \citep[e.g.][]{key}      => (e.g. Jones et al., 1990)
%%   \citep[e.g.][p. 32]{key} => (e.g. Jones et al., p. 32)
%%   \citeauthor{key}         => Jones et al.
%%   \citeauthor*{key}        => Jones, Baker, and Smith
%%   \citeyear{key}           => 1990
%%---------------------------------------------------------------------

ENTRY
  { address
    annote
    author
    booktitle
    bookauthor
    chapter
    edition
    editor
    compiler
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    medium % new in v.2.
    type
    volume
    year
    language
    booklanguage
    numpages
    url
    urldate
    isbn
    doi
    eprinttype   % = archivePrefix
    eprintclass  % = primaryClass
    eprint
  }
  {}
  { label extra.label sort.label short.list }

INTEGERS { output.state before.all mid.sentence after.sentence after.block
after.dblslash after.slash after.column after.semicolumn }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #4 'after.dblslash :=
  #5 'after.slash :=
  #6 'after.column :=
  #7 'after.semicolumn :=
}

STRINGS { s t }

STRINGS { curlanguage }

FUNCTION {change.language}
{ booklanguage empty$
    { "" }
    { booklanguage  'curlanguage :=
      "\selectlanguageifdefined{"
      curlanguage *
      "}" *
    }
  if$
}

FUNCTION {output.nonnull}
{
  swap$
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          " \BibDash " write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { output.state after.dblslash =
                { "~//" * change.language * " " * write$ }
                { output.state after.slash =
                    { "~/ " * write$ }
                    { output.state after.column =
                        { "~: " * write$ }
                        { output.state after.semicolumn =
                            { "~; " * write$ }
                        { add.period$ " " * write$ }
                       if$
                        }
                      if$
                    }
                  if$
                }
              if$
            }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.dblslash}
{ output.state before.all =
    'skip$
    { after.dblslash 'output.state := }
  if$
}

FUNCTION {new.slash}
{ output.state before.all =
    'skip$
    { after.slash 'output.state := }
  if$
}

FUNCTION {new.column}
{ output.state before.all =
    'skip$
    { after.column 'output.state := }
  if$
}

FUNCTION {new.semicolumn}
{ output.state before.all =
    'skip$
    { after.semicolumn 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {add.blank}
{ " " * before.all 'output.state :=
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {non.stop}
{ duplicate$
   "}" * add.period$
   #-1 #1 substring$ "." =
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.dblslash.checka}
{ empty$
    'skip$
    'new.dblslash
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\BibEmph{" swap$ * "}" * }
  if$
}

FUNCTION {enclose.square.brackets} { }

FUNCTION {bracify}
{ duplicate$ empty$
    { pop$ "{}" }
    { "{" swap$ * "}" * }
  if$
}
FUNCTION {bracketise}
{ duplicate$ empty$
    { pop$ "[]" }
    { "[" swap$ * "]" * }
  if$
}
FUNCTION {parenthesify}
{ duplicate$ empty$
    { pop$ "()" }
    { "(" swap$ * ")" * }
  if$
}

FUNCTION {space.word}
{ " " swap$ * " " * }

FUNCTION {bbl.edby}    %  { "\bbledby{}" }
{ curlanguage "english" =
   {"Ed.\ by"}
   { curlanguage "ukrainian" =
      {"Під ред."}
      { curlanguage "russian" =
         {"Под ред."}
         { curlanguage "german" =
            { "ed." }
            {"language is not defined: " language "edby" * * warning$ "Ed.\ by"}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.cmplr}
{ curlanguage "english" =
   { "Compiler"}
   { curlanguage "german" =
      { "Hrsg." }
      { curlanguage "ukrainian" =
         {"{Укл.}"}
         { curlanguage "russian" =
            {"{Сост.}"}
            {"language is not defined: " language  "cmplr" * * warning$ "Compiler"}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.edition} %  { "\bbledition{}" }
{ curlanguage "english" =
   {"edition"}
   { curlanguage "ukrainian" =
      {"{вид.}"}
      { curlanguage "russian" =
         {"{изд.}"}
         { curlanguage "german" =
            {" {aus.}" } %%%% { "Aufl." } ??
            { curlanguage "italian" =
               {"edizione"}
               { curlanguage "french" =
                  {"\'{e}dition"}
                  {"language is not defined: " language  "edition" * * warning$ "edition"}
               if$}
            if$}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.vvolume} %  { "\bblVolume{}" }
{ curlanguage "english" = curlanguage "french" = or curlanguage "italian" = or
   {"Volume"}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      { "Том" }
      { curlanguage "german" =
         {"{Band}"} %%%% { "Volumen" }
         {"language is not defined: " language  "vvolume" * * warning$ "Volume"}
      if$}
   if$}
if$}

FUNCTION {bbl.vvol}    %  { "\bblVol{}" }
{ curlanguage "english" = curlanguage "french" = or curlanguage "italian" = or
   {"Vol."}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      {"Т."}
      { curlanguage "german" =
         {"{Bd.}"} %%%% { "Vol." }
         {"language is not defined: " language  "vvol" * * warning$ "Vol."}
      if$}
   if$}
if$}

FUNCTION {bbl.iissue}  %  { "\bblIssue{}" }
{ curlanguage "english" =
   {"Issue"}
   { curlanguage "ukrainian" =
      {"Випуск"}
      { curlanguage "russian" =
         {"Выпуск"}
         { curlanguage "german" =
            {"{Heft}"} %%%% { "Ausgabe" }
            {"language is not defined: " language "iissue" * * warning$ "Issue"}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.iiss}  %  { "\bblIss{}" }
{ curlanguage "english" =
   {"Iss."}
   { curlanguage "ukrainian" =
      {"Вип."}
      { curlanguage "russian" =
         {"Вып."}
         { curlanguage "german" =
            {"{H.}"}
            {"language is not defined: " language "iiss" * * warning$ "Iss."}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.of}      %  { "\bblof{}" }
{ curlanguage "english" =
   {"of"}
   { curlanguage "german" =
      { "von" }
      { curlanguage "ukrainian" =
         { "{із}" }
         { curlanguage "russian" =
            { "{из}" }
            {"language is not defined: " language "of" * * warning$ "of"}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.etal}      %  { "\bblof{}" }
{ curlanguage "english" =
   {"et~al."}
   { curlanguage "german" =
      { "u.~a." }
      { curlanguage "ukrainian" =
         {"{та~ін.}"}
         { curlanguage "russian" =
            {"и~др."}
            {"language is not defined: " language  "et~al" * * warning$ "et~al."}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.and}      %  { "\bbland{}" }
{ curlanguage "english" =
   {"and"}
   { curlanguage "german" =
      { "und" }
      { curlanguage "ukrainian" =
         {"і"}
         { curlanguage "russian" =
            {"и"}
            {"language is not defined: " language  "and" * * warning$ "and"}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.nnumber} %  { "\bblNumber{}" }
{ curlanguage "english" =
   {"Number"}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      { "{Номер}" }
      { curlanguage "german" =
         {"{Heft}"} %%% { "Anzahl" }
         {"language is not defined: " language  "nnumber" * * warning$ "Number"}
      if$}
   if$}
if$}

FUNCTION {bbl.number}  %  { "\bblnumber{}" }
{ curlanguage "english" =
   {"number"}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      {"{номер}"}
      { curlanguage "german" =
         {"{Heft}"} %%% { "anzahl" }???
         {"language is not defined: " language  "number" * * warning$ "number"}
      if$}
   if$}
if$}

FUNCTION {bbl.nr}     %   { "\bblno{}" }
{ curlanguage "english" =
   {"no."}
   { curlanguage "italian" =
      { "no" }
      { curlanguage "ukrainian" = curlanguage "russian" = or
         { "{№}" }
         { curlanguage "german" =
            {"{H.}"} %%% { "an." }
            {"language is not defined: " language "nr" * * warning$ "no."}
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.nnr}     %   { "\bblno{}" }
{ curlanguage "english" =
   {"No."}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      { "{№}" }
      { curlanguage "german" =
         {"{H.}"} %%% { "an." }
         {"language is not defined: " language  "nnr" * * warning$ "No."}
      if$}
   if$}
if$}

FUNCTION {bbl.in}    %    { "\bblin{}" }
{ curlanguage "english" = curlanguage "german" = or
   {"in"}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      { "{в}" }
      {"language is not defined: " language  "in" * * warning$ "in"}
   if$}
if$}

FUNCTION {bbl.iin}  %     { "\bblIn{}" }
{ curlanguage "english" = curlanguage "german" = or
   {"In"}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      { "{В}" }
      {"language is not defined: " language  "iin" * * warning$ "In"}
   if$}
if$}

FUNCTION {bbl.pages}    % { "\bblpp." }
{ curlanguage "english" = curlanguage "french" = or curlanguage "italian" = or
   {"p."} %%% {"pp."}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      {"{с.}"}
      { curlanguage "german" =
         {"S."} %%%% { "s." }
         {"language is not defined: " language  "pages" * * warning$ "p."}
      if$}
   if$}
if$}

FUNCTION {bbl.page}   %   { "\bblp."
{ curlanguage "english" = curlanguage "french" = or curlanguage "italian" = or
   {"p."}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      {"{с.}"}
      { curlanguage "german" =
         {"S."} %%%% { "s." }
         {"language is not defined: " language  "page" * * warning$ "p."}
      if$}
   if$}
if$}

FUNCTION {bbl.ppages}%    { "\bblPp." }
{ curlanguage "english" = curlanguage "french" = or curlanguage "italian" = or
   {"P."} %%%% { "Pp." }
   { curlanguage "ukrainian" = curlanguage "russian" = or
      {"{С.}"}
      { curlanguage "german" =
         {"S."}
         {"language is not defined: " language "ppages" * * warning$ "P."}
      if$}
   if$}
if$}

FUNCTION {bbl.ppage}  %   { "\bblP." }
{ curlanguage "english" = curlanguage "french" = or curlanguage "italian" = or
   {"P."}
   { curlanguage "ukrainian" = curlanguage "russian" = or
      {"{С.}"}
      { curlanguage "german" =
         {"S."}
         {"language is not defined: " language  "ppage" * * warning$ "P."}
      if$}
   if$}
if$}

FUNCTION {bbl.urldate}
{ curlanguage "english" =
   {"online; accessed"}
   { curlanguage "ukrainian" =
      { "{дата звернення}" }
      { curlanguage "russian" =
         { "{дата обращения}" }
         { curlanguage "german" =
            { "{online; abgerufen}" }
            { "language is not defined: " language "urldate" * * warning$ "online; accessed" }
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.techreport} % rename to bbl.techreport
{ curlanguage "english" =
   { "Rep." }
   { curlanguage "german" =
      { "Bericht" }
      { curlanguage "russian" =
         { "{Отчет}" }
         { "language is not defined: " language "techrep" * * warning$ "Rep." }
      if$}
   if$}
if$}

FUNCTION {bbl.mthesis}
{ curlanguage "english" =
   { "Master's thesis" }
   { curlanguage "german" =
      { "Diss.~Mag." }
      { curlanguage "russian" =
         { "{Квалификационная работа магистра}" }
         { "language is not defined: " language "mthesis" * * warning$ "Master's thesis" }
      if$}
   if$}
if$}

FUNCTION {bbl.phdthesis}
{ curlanguage "english" =
   { "Ph.\,D. thesis" }
   { curlanguage "german" =
      { "Diss.~Ph.\,D." }
      { curlanguage "russian" =
         { "{Дисс\ldots\ кандидата наук}" }
         { curlanguage "french" =
           { "Th\`{e}se de doctorat" }
           { "language is not defined: " language "phdthesis" * * warning$ "Ph.\,D. thesis" }
         if$}
      if$}
   if$}
if$}

FUNCTION {bbl.dscithesis}
{ curlanguage "english" =
   { "Dr.\,Sci. dissertation" }
   { curlanguage "german" =
      { "Diss.~Dr." }
      { curlanguage "russian" =
         { "{Дисс\ldots\ доктора наук}" }
         { "language is not defined: " language "dscithesis" * * warning$ "Dr.\,Sci. dissertation" }
      if$}
   if$}
if$}

FUNCTION {bbl.nnoaddress}
{ curlanguage "english" =
   { "S.\ l." }
   { curlanguage "russian" =
      { "{Б.\ м.}" }
      { "language is not defined: " language "nnoaddress" * * warning$ "S.\ l." }
   if$}
if$}

FUNCTION {bbl.nopublisher}
{ curlanguage "english" =
   { "s.\ n." }
   { curlanguage "russian" =
      { "{б.\ и.}" }
      { "language is not defined: " language "nnopublisher" * * warning$ "s.\ n." }
   if$}
if$}

FUNCTION {bbl.nnopublisher}
{ curlanguage "english" =
   { "S.\ n." }
   { curlanguage "russian" =
      { "{Б.\ и.}" }
      { "language is not defined: " language "nnopublisher" * * warning$ "S.\ n." }
   if$}
if$}

FUNCTION {bbl.medium.text}
{ curlanguage "english" =
   { "Text" }
   { curlanguage "russian" = curlanguage "ukrainian" = or
      { "{Текст}" }
      { "language is not defined: " language "medium" * * warning$ "Text" }
   if$}
if$}

FUNCTION {bbl.medium.elres}
{ curlanguage "english" =
   { "Electronic resource" }
   { curlanguage "russian" =
      { "{Электронный ресурс}" }
      { curlanguage "ukrainian" =
        { "{Електронний ресурс}" }
        { "language is not defined: " language "medium" * * warning$ "Electronic resource" }
      if$}
   if$}
if$}

FUNCTION {bbl.chief}
{ curlanguage "english" =
   { "chief" }
   { curlanguage "russian" =
      { "{рук.}" }
      { curlanguage "ukrainian" =
        { "{рук.}" }
        { "language is not defined: " language "chief" * * warning$ "chief" }
      if$}
   if$}
if$}

FUNCTION {bbl.executor}
{ curlanguage "english" =
   { "Executor" }
   { curlanguage "russian" =
      { "{исполн.}" }
      { curlanguage "ukrainian" =
        { "{виконавець}" }
        { "language is not defined: " language "medium" * * warning$ "Executor" }
      if$}
   if$}
if$}

FUNCTION {bbl.medium}
{ type$ "online" =
   { bbl.medium.elres }
   { bbl.medium.text  }
if$}

INTEGERS { nameptr namesleft numnames }


FUNCTION {format.names}
{
  's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}{~jj}{~ff}" format.name$ 't :=
      nameptr #1 >
        { nameptr #4 =
          numnames #4 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            { t "others" =
          t "~others" =
          or
                { " " * bbl.etal * }
                { ", " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.lab.names}
{ 's :=
  language empty$
    { "english" 'curlanguage := }
    { language  'curlanguage := }
  if$
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    %{ pop$ " et~al." * }
    { pop$ " " bbl.etal * * }
    { #2 <
        'skip$
        { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            %{ " et~al." * }
            { " " bbl.etal * * }
            %{ " and " * s #2 "{vv~}{ll}" format.name$ * }
            { " " bbl.and " " * * * s #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {format.names.rev}
{
  's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{ff}{~vv}{~ll}{, jj}" format.name$ 't :=
      nameptr #1 >
        { nameptr #4 =
          numnames #4 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            { t "others" =
          t "~others" =
          or
                { " " * bbl.etal * }
                { ", " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.key}
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names emphasize}
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            %'key          %% causes lost of year
            { "{}" key * } %% Bug in bibtex8 ??
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        'key
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.short.authors}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.organization.label
        { type$ "manual" =
            'author.key.organization.label
            'author.key.label
          if$
        }
      if$
    }
  if$
  'short.list :=
}

FUNCTION {calc.label}
{ calc.short.authors
  short.list
  "("
  *
  year duplicate$ empty$
  short.list key field.or.null = or
     { pop$ "" }
     'skip$
  if$
  *
  'label :=
}


FUNCTION {format.bookauthors}
{ bookauthor empty$
    { "" }
    { bookauthor format.names}
  if$
}

FUNCTION {format.authors.after}
{ author empty$
    { "" }
    { author format.names.rev}
  if$
}

FUNCTION {format.bookauthors.after}
{ bookauthor empty$
    { "" }
    { bookauthor format.names.rev}% always cuts to 4 persons
  if$
}

FUNCTION {format.editors.after}
{ editor empty$
    { "" }
    { bbl.edby "\ " * editor format.names.rev * }
  if$
}

FUNCTION {format.chief.after}
{ editor empty$
    { "" }
    { bbl.chief "\ " * editor format.names.rev * }
  if$
}

FUNCTION {format.executor.after}
{ author empty$
    { "" }
    { bbl.executor ": " * author format.names.rev * }
  if$
}

FUNCTION {format.compiler.after}
{ compiler empty$
    { "" }
    { bbl.cmplr "\ " * compiler format.names.rev * }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title }
  if$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          month
        }
      if$
    }
    { month empty$
        'year
        { year ". \BibDash " month * * }
      if$
    }
  if$
  extra.label * % new in v.1.2
}

FUNCTION {output.address.publisher}
{
  address empty$
    'skip$
    { address output
      publisher empty$
        'skip$
        { new.column }
      if$
    }
  if$
  publisher output
}


FUNCTION {format.full.names}
{'s :=
  language empty$
    { "english" 'curlanguage := }
    { language  'curlanguage := }
  if$
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}" format.name$ 't :=
      nameptr #1 >
        {
          namesleft #1 >
            { ", " * t * }
            {
              numnames #2 >
              curlanguage "english" =
              and
                { "," * }
                'skip$
              if$
              t "others" =
          %t "~others" =
          %or
                %{ " et~al." * }
                { " " bbl.etal * * }
                %{ " and " * t * }
                { " " bbl.and " " * * * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {author.full}
{ author empty$
    { "" }
    { author format.full.names }
  if$
}

FUNCTION {editor.full}
{ editor empty$
    { "" }
    { editor format.full.names }
  if$
}

FUNCTION {author.editor.full}
{ author empty$
    { editor empty$
        { "" }
        { editor format.full.names }
      if$
    }
    { author format.full.names }
  if$
}

FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.full
    { type$ "proceedings" =
        'editor.full
        'author.full
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  ")" make.full.names duplicate$ short.list =
     { pop$ }
     { * }
   if$
  "]{" * write$
  cite$ write$
  "}" write$
  language empty$
    { "english" 'curlanguage := }
    {language  'curlanguage := }
  if$
  "\selectlanguageifdefined" curlanguage bracify * write$
  newline$
  ""
  before.all 'output.state :=
}
%%  author.key.label
%%  year parenthesify *
%%  "; lbl:" label * *
%%  "; mfn:"  make.full.names * *

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in}
{ bbl.iin
  " " * }

FUNCTION {format.btitle}
{ title
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {tie.connect}
 {"~"
  swap$ * *
 }

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { bbl.vvol volume tie.connect
      series empty$
        'skip$
        { bbl.of space.word * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { series empty$
            { "there's a number but no series in " cite$ * warning$
              bbl.nnr }
            {
              %new.dblslash
              new.sentence
              series
              bbl.nr
              tie.or.space.connect}
          if$
          number tie.or.space.connect
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {is.num}
{ chr.to.int$
  duplicate$ "0" chr.to.int$ < not
  swap$ "9" chr.to.int$ > not and
}

FUNCTION {extract.num}
{ duplicate$ 't :=
  "" 's :=
  { t empty$ not }
  { t #1 #1 substring$
    t #2 global.max$ substring$ 't :=
    duplicate$ is.num
      { s swap$ * 's := }
      { pop$ "" 't := }
    if$
  }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}


FUNCTION {convert.edition}
{ edition
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { convert.edition " " * bbl.edition * }
        { convert.edition " " * bbl.edition * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { bbl.ppages pages n.dashify tie.connect }
        { bbl.ppage pages tie.connect }
      if$
    }
  if$
}

FUNCTION {format.pages.page}
{ pages empty$
    { numpages empty$
      { "" }
      { numpages bbl.pages tie.connect }
    if$}
    { format.pages}
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    {
      ", no." number tie.or.space.connect *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ": " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.volume}
{ volume empty$
    { "" }
    { bbl.vvol volume tie.or.space.connect }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { bbl.nr number tie.or.space.connect }
  if$
}


FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type
    }
  if$
}

%%<!utf8>    { "t" change.case$ }
%%<utf8>    { "" }

FUNCTION {format.techreport.type}
{ type empty$
   { bbl.techreport }
   'type
  if$
}

FUNCTION {author.before}
{
  author empty$
    'skip$
    {author num.names$ #4 <
      {format.authors output
       new.sentence}
      'skip$
    if$}
  if$
}

%%<*!long>
%%FUNCTION {bookauthor.before}
%%{
%%  bookauthor empty$
%%    'skip$
%%    {bookauthor num.names$ #4 <
%%      {format.bookauthors output
%%       new.sentence}
%%      'skip$
%%    if$}
%%  if$
%%}
%%</!long>
%%<*long>
%%FUNCTION {bookauthor.before}
%%{
%%  bookauthor empty$
%%    'skip$
%%    { format.bookauthors output
%%      new.sentence
%%    }
%%  if$
%%}
%%</long>

FUNCTION {author.after}
{
  author empty$
    'skip$
    {author num.names$ #3 >
      {format.authors.after output
       new.semicolumn }
      'skip$
    if$}
  if$
}

FUNCTION {bookauthor.after}
{
  bookauthor empty$
    'skip$
    {format.bookauthors.after output
       new.semicolumn }
  if$
}

FUNCTION {editor.organization.after}
{
  compiler empty$
    {}
    { format.compiler.after  output
    new.semicolumn
    }
  if$
  editor empty$
    {}
    { format.editors.after  output
    new.semicolumn
    }
  if$
  organization empty$
    {}
    {organization output
    new.semicolumn
    }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    {
      "URL: \BibUrl{" url * "}" *
      urldate empty$
        { "" }
        { " (" bbl.urldate * ": " * urldate * ")" * }
      if$ *
    }
  if$
}

FUNCTION {format.annote}
{ annote empty$
    { "" }
{ after.sentence 'output.state :=
  "\BibAnnote{" annote add.period$ * "}" *
}
  if$
}

FUNCTION {format.isbn}
{
  isbn empty$
    { "" }
    { "ISBN:~\href{http://isbndb.com/search-all.html?kw=" isbn *
      "}{" * isbn * "}" *
    }
  if$
}

FUNCTION {add.doi}
{ duplicate$ empty$
    'skip$
    { doi empty$
        'skip$
        { "\href{http://dx.doi.org/" doi * "}{" * swap$ * "}" * }
      if$
    }
  if$
}

FUNCTION {add.medium} { }



FUNCTION {format.eprint}
{ eprint empty$
   { "" }
   { eprinttype empty$
       { "" }
       { eprinttype "~: " *}
     if$
     eprintclass empty$
       { }
       { eprintclass * "/" *}
     if$
     url empty$
      { eprint * }
      { "\href{" * url * "}{" * eprint * "}" *}
    if$
   }
  if$
}

FUNCTION {output.eprint.url}
{
  eprint empty$
    { format.url output }
    { format.eprint output }
  if$
}



FUNCTION {article}
{
  output.bibitem
  author.before
  author format.key output
  format.title add.medium "title" output.check
  new.slash
  author.after
  new.dblslash
  journal emphasize add.doi "journal" output.check % new in v.2
  new.block
  format.date "year" output.check
  new.block
  format.volume output
  format.number output
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {book}
{
  output.bibitem
  author.before
  author format.key output
  format.btitle add.doi add.medium "title" output.check
  new.slash
  author.after
  editor.organization.after
  new.sentence
  format.number.series output
  new.block
  format.edition output
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.bvolume output
  new.block
  format.pages.page output
  new.block
  format.isbn output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {booklet}
{
  output.bibitem
  author.before
  author format.key output
  format.title add.doi add.medium "title" output.check
  new.slash
  author.after
  editor.organization.after
  new.block
  howpublished output
  address output
  format.date "year" output.check
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {inbook}
{
  output.bibitem
  author.before
  author format.key output
  format.btitle add.doi add.medium "title" output.check
  new.slash
  author.after
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  bookauthor.after
  editor.organization.after
  new.block
  format.edition output
  new.block
  format.number.series output
  new.sentence
  output.address.publisher
  format.date "year" output.check
  new.block
  format.bvolume output
  new.block
  format.pages.page output
  new.block
  format.isbn output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {incollection}
{
  output.bibitem
  author.before
  author format.key output
  new.sentence
  format.title add.doi add.medium "title" output.check
  new.slash
  author.after
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  editor.organization.after
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.bvolume output
  format.number.series output
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {proceedings}
{
  output.bibitem
  editor format.key output
  format.btitle add.doi add.medium "title" output.check
  new.slash
  editor.organization.after
  new.block
  format.bvolume output
  format.number.series output
  output.address.publisher
  format.date "year" output.check
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  author.before
  author format.key output
  new.sentence
  format.title add.doi add.medium "title" output.check
  new.slash
  author.after
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  editor.organization.after
  new.block
  format.bvolume output
  format.number.series output
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output.nonnull
          address output
        }
      if$
    }
    { format.authors output.nonnull }
  if$
  author format.key output
  new.block
  format.btitle add.doi add.medium "title" output.check
  author empty$
    { organization empty$
    {
          address new.block.checka
          address output
        }
        'skip$
      if$
    }
    {
      organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  author format.key output
  title howpublished new.sentence.checkb
  format.title add.medium output
  howpublished new.block.checka
  howpublished output
  new.block
  format.date "year" output.check
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  author.before
  author format.key output
  format.btitle "title" output.check
  new.slash
  author.after
  editor.organization.after
  new.block
  format.date "year" output.check
  new.block
  note "note" output.check
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {online}
{ output.bibitem
  format.authors output
  author format.key output
  title howpublished new.sentence.checkb
  format.title add.doi add.medium "title" output.check
  howpublished new.dblslash.checka
  howpublished enclose.square.brackets output
  editor.organization.after
  new.sentence
  new.block
  output.address.publisher
  format.date output
  new.block
  output.eprint.url
  new.sentence
  note output
  format.annote output
  fin.entry
}

FUNCTION {internet}   {online}
FUNCTION {www}        {online}
FUNCTION {webpage}    {online}
FUNCTION {electronic} {online}
FUNCTION {thesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  new.sentence
  format.btitle add.doi add.medium "title" output.check
  new.column
  type "type" output.check
  new.column
  number output
  new.slash
  format.authors.after output
  new.semicolumn
  school "school" output.check
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

%%  format.techrep.type.number output.nonnull
%%  format.url output
FUNCTION {report}
{
  output.bibitem
  format.title add.doi add.medium "title" output.check
  title format.key output
  new.column
  type "type" output.check
  new.column
  number output
  new.slash
  institution "institution" output.check
  new.semicolumn
  format.chief.after output % from editor field
  new.semicolumn
  format.executor.after output % from author field
  new.block
  address output
  new.column
  organization output
  format.date "year" output.check
  new.block                % v.2
  format.pages.page output % v.2
  new.sentence % или new.block ?
  output.eprint.url
  new.block
  note output
  format.annote output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  new.sentence
  format.btitle add.doi add.medium "title" output.check
  new.column
  bbl.phdthesis format.thesis.type output.nonnull
  new.column
  number output
  new.slash
  format.authors.after output
  new.semicolumn
  school "school" output.check
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {masterthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  new.sentence
  format.btitle add.doi add.medium "title" output.check
  new.column
  bbl.mthesis format.thesis.type output.nonnull
  new.column
  number output
  new.slash
  format.authors.after output
  new.semicolumn
  school "school" output.check
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {dscithesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  new.sentence
  format.btitle add.doi add.medium "title" output.check
  new.column
  bbl.dscithesis format.thesis.type output.nonnull
  new.column
  number output
  new.slash
  format.authors.after output
  new.semicolumn
  school "school" output.check
  new.block
  output.address.publisher
  format.date "year" output.check
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  output.eprint.url
  format.annote output
  fin.entry
}

FUNCTION {conference} { inproceedings }

%%  format.url output

FUNCTION {techreport}
{
  output.bibitem
  format.title add.doi add.medium "title" output.check
  title format.key output
  new.column
  format.techreport.type output
  new.column
  number output
  new.slash
  institution "institution" output.check
  new.semicolumn
  format.chief.after output % from editor field
  new.semicolumn
  format.executor.after output % from author field
  new.block
  address output
  new.column
  organization output
  format.date "year" output.check
  new.block                % v.2
  format.pages.page output % v.2
  new.sentence % или new.block ?
  output.eprint.url
  new.block
  note output
  format.annote output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"\bbljan{}"}
MACRO {feb} {"\bblfeb{}"}
MACRO {mar} {"\bblmar{}"}
MACRO {apr} {"\bblapr{}"}
MACRO {may} {"\bblmay{}"}
MACRO {jun} {"\bbljun{}"}
MACRO {jul} {"\bbljul{}"}
MACRO {aug} {"\bblaug{}"}
MACRO {sep} {"\bblsep{}"}
MACRO {oct} {"\bbloct{}"}
MACRO {nov} {"\bblnov{}"}
MACRO {dec} {"\bbldec{}"}


MACRO {aa}{"Astron. \& Astrophys."}
MACRO {aasup}{"Astron. \& Astrophys. Suppl. Ser."}
MACRO {aj} {"Astron. J."}
MACRO {aph} {"Acta Phys."}
MACRO {advp} {"Adv. Phys."}
MACRO {ajp} {"Amer. J. Phys."}
MACRO {ajm} {"Amer. J. Math."}
MACRO {amsci} {"Amer. Sci."}
MACRO {anofd} {"Ann. Fluid Dyn."}
MACRO {am} {"Ann. Math."}
MACRO {ap} {"Ann. Phys. (NY)"}
MACRO {adp} {"Ann. Phys. (Leipzig)"}
MACRO {ao} {"Appl. Opt."}
MACRO {apl} {"Appl. Phys. Lett."}
MACRO {app} {"Astroparticle Phys."}
MACRO {apj} {"Astrophys. J."}
MACRO {apjsup} {"Astrophys. J. Suppl."}
MACRO {apss} {"Astrophys. Space Sci."}
MACRO {araa} {"Ann. Rev. Astron. Astrophys."}
MACRO {baas} {"Bull. Amer. Astron. Soc."}
MACRO {baps} {"Bull. Amer. Phys. Soc."}
MACRO {cmp} {"Comm. Math. Phys."}
MACRO {cpam} {"Commun. Pure Appl. Math."}
MACRO {cppcf} {"Comm. Plasma Phys. \& Controlled Fusion"}
MACRO {cpc} {"Comp. Phys. Comm."}
MACRO {cqg} {"Class. Quant. Grav."}
MACRO {cra} {"C. R. Acad. Sci. A"}
MACRO {fed} {"Fusion Eng. \& Design"}
MACRO {ft} {"Fusion Tech."}
MACRO {grg} {"Gen. Relativ. Gravit."}
MACRO {ieeens} {"IEEE Trans. Nucl. Sci."}
MACRO {ieeeps} {"IEEE Trans. Plasma Sci."}
MACRO {ijimw} {"Interntl. J. Infrared \& Millimeter Waves"}
MACRO {ip} {"Infrared Phys."}
MACRO {irp} {"Infrared Phys."}
MACRO {jap} {"J. Appl. Phys."}
MACRO {jasa} {"J. Acoust. Soc. America"}
MACRO {jcp} {"J. Comp. Phys."}
MACRO {jchp} {"J. Chem. Phys."}
MACRO {jetp} {"Sov. Phys.--JETP"}
MACRO {jfe} {"J. Fusion Energy"}
MACRO {jfm} {"J. Fluid Mech."}
MACRO {jmp} {"J. Math. Phys."}
MACRO {jne} {"J. Nucl. Energy"}
MACRO {jnec} {"J. Nucl. Energy, C: Plasma Phys., Accelerators, Thermonucl. Res."}
MACRO {jnm} {"J. Nucl. Mat."}
MACRO {jpc} {"J. Phys. Chem."}
MACRO {jpp} {"J. Plasma Phys."}
MACRO {jpsj} {"J. Phys. Soc. Japan"}
MACRO {jsi} {"J. Sci. Instrum."}
MACRO {jvst} {"J. Vac. Sci. \& Tech."}
MACRO {nat} {"Nature"}
MACRO {nature} {"Nature"}
MACRO {nedf} {"Nucl. Eng. \& Design/Fusion"}
MACRO {nf} {"Nucl. Fusion"}
MACRO {nim} {"Nucl. Inst. \& Meth."}
MACRO {nimpr} {"Nucl. Inst. \& Meth. in Phys. Res."}
MACRO {np} {"Nucl. Phys."}
MACRO {npb} {"Nucl. Phys. B"}
MACRO {nt/f} {"Nucl. Tech./Fusion"}
MACRO {npbpc} {"Nucl. Phys. B (Proc. Suppl.)"}
MACRO {inc} {"Nuovo Cimento"}
MACRO {nc} {"Nuovo Cimento"}
MACRO {pf} {"Phys. Fluids"}
MACRO {pfa} {"Phys. Fluids A: Fluid Dyn."}
MACRO {pfb} {"Phys. Fluids B: Plasma Phys."}
MACRO {pl} {"Phys. Lett."}
MACRO {pla} {"Phys. Lett. A"}
MACRO {plb} {"Phys. Lett. B"}
MACRO {prep} {"Phys. Rep."}
MACRO {pnas} {"Proc. Nat. Acad. Sci. USA"}
MACRO {pp} {"Phys. Plasmas"}
MACRO {ppcf} {"Plasma Phys. \& Controlled Fusion"}
MACRO {phitrsl} {"Philos. Trans. Roy. Soc. London"}
MACRO {prl} {"Phys. Rev. Lett."}
MACRO {pr} {"Phys. Rev."}
MACRO {physrev} {"Phys. Rev."}
MACRO {pra} {"Phys. Rev. A"}
MACRO {prb} {"Phys. Rev. B"}
MACRO {prc} {"Phys. Rev. C"}
MACRO {prd} {"Phys. Rev. D"}
MACRO {pre} {"Phys. Rev. E"}
MACRO {ps} {"Phys. Scripta"}
MACRO {procrsl} {"Proc. Roy. Soc. London"}
MACRO {rmp} {"Rev. Mod. Phys."}
MACRO {rsi} {"Rev. Sci. Inst."}
MACRO {science} {"Science"}
MACRO {sciam} {"Sci. Am."}
MACRO {sam} {"Stud. Appl. Math."}
MACRO {sjpp} {"Sov. J. Plasma Phys."}
MACRO {spd} {"Sov. Phys.--Doklady"}
MACRO {sptp} {"Sov. Phys.--Tech. Phys."}
MACRO {spu} {"Sov. Phys.--Uspekhi"}
MACRO {st} {"Sky and Telesc."}

MACRO {appopt} {"Appl. Opt."}
MACRO {bell}   {"Bell Syst. Tech. J."}
MACRO {ell}    {"Electron. Lett."}
MACRO {jasp}   {"J. Appl. Spectr."}
MACRO {jqe}    {"IEEE J. Quantum Electron."}
MACRO {jlwt}   {"J. Lightwave Technol."}
MACRO {jmo}    {"J. Mod. Opt."}
MACRO {josa}   {"J. Opt. Soc. America"}
MACRO {josaa}  {"J. Opt. Soc. Amer.~A"}
MACRO {josab}  {"J. Opt. Soc. Amer.~B"}
MACRO {jdp}    {"J. Phys. (Paris)"}
MACRO {oc}     {"Opt. Commun."}
MACRO {ol}     {"Opt. Lett."}
MACRO {os}     {"Opt. Spectrosc."}
MACRO {phtl}   {"IEEE Photon. Technol. Lett."}
MACRO {pspie}  {"Proc. Soc. Photo-Opt. Instrum. Eng."}
MACRO {sjot}   {"Sov. J. Opt. Technol."}
MACRO {sjqe}   {"Sov. J. Quantum Electron."}
MACRO {sleb}   {"Sov. Phys.--Leb. Inst. Rep."}
MACRO {stph}   {"Sov. Phys.--Techn. Phys."}
MACRO {stphl}  {"Sov. Techn. Phys. Lett."}
MACRO {vr}     {"Vision Res."}
MACRO {zph}    {"Z. f. Physik"}
MACRO {zphb}   {"Z. f. Physik~B"}
MACRO {zphd}   {"Z. f. Physik~D"}
MACRO {sse} {"Solid-State Electron."}
MACRO {pss} {"Phys. Sol. State"}
MACRO {sst} {"Semicond. Sci. Tech."}
MACRO {nl}  {"Nano Lett."}

READ


FUNCTION {sortify}
{ purify$
}


INTEGERS { seq.num }

FUNCTION {init.seq}
{ #0 'seq.num :=}

EXECUTE {init.seq}

FUNCTION {int.to.fix}
{ "000000000" swap$ int.to.str$ *
  #-1 #10 substring$
}

FUNCTION {presort}%#3
{
  calc.label               % computes label
  label sortify            % initiates sort.label
  "    "
  *
  seq.num #1 + 'seq.num := % advance seq.num
  seq.num  int.to.fix      % prepend seq.num with 0s
  'sort.label :=           % set sort.label to seq.num
  sort.label *             % append seq.num to label
  #1 entry.max$ substring$ % cut if too long
  'sort.key$ :=            % set sort.key$
}

ITERATE {presort}

SORT


STRINGS { longest.label last.label next.extra }

INTEGERS { number.label longest.label.width last.extra.num  }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

EXECUTE {initialize.longest.label}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

ITERATE {forward.pass}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

REVERSE {reverse.pass}

FUNCTION {bib.sort.order}
{ sort.label  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT

FUNCTION {begin.bib}
{ "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
  "\def\selectlanguageifdefined#1{"                  write$ newline$
  "\expandafter\ifx\csname date#1\endcsname\relax"   write$ newline$
  "\else\selectlanguage{#1}\fi}"                     write$ newline$
  "\providecommand*{\href}[2]{{\small #2}}"          write$ newline$
  "\providecommand*{\url}[1]{{\small #1}}"           write$ newline$
  "\providecommand*{\BibUrl}[1]{\url{#1}}"           write$ newline$
  "\providecommand{\BibAnnote}[1]{}"                 write$ newline$
  "\providecommand*{\BibEmph}[1]{#1}"                write$ newline$
  "\ProvideTextCommandDefault{\cyrdash}{\hbox to.8em{--\hss--}}" write$ newline$
  "\providecommand*{\BibDash}{\ifdim\lastskip>0pt\unskip\nobreak\hskip.2em\fi" write$ newline$
  "\cyrdash\hskip.2em\ignorespaces}" write$ newline$
  "\providecommand{\natexlab}[1]{#1}" write$ newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}

%%
%% End of file `ugost2008n.bst'.
