# Установка и сборка

## Установка

### В Ubuntu

> Протестировано на Ubuntu 15.04.

Для установки XeTeX в Ubuntu и необходимых дополнительных пакетов можно использовать команду:

```
$ sudo apt-get install texlive-xetex texlive-generic-extra latexmk biber
```

Для нормальной работы в системе должны быть установлены нужные шрифты. Например, для Ubuntu это можно сделать так:

```
$ sudo apt-get install ttf-mscorefonts-installer
$ sudo fc-cache -fv
```

### В Fedora

> Протестировано на Fedora 23.

Для установка XeTeX необходимо установить следующие пакеты:

```
$ sudo dnf install texlive-xetex latexmk texlive-hyphen-russian biber \
                    texlive-extsizes texlive-cm texlive-amscls texlive-mh \
                    texlive-polyglossia texlive-euenc texlive-multirow \
                    texlive-makecell texlive-ec texlive-was texlive-zapfding \
                    texlive-totcount texlive-totpages texlive-interfaces \
                    texlive-tocloft texlive-tabulary texlive-floatrow \
                    texlive-biblatex texlive-biblatex-gost texlive-cite texlive-bibtex
```

Далее необходимо установить необходимые шрифты из набора [Microsoft's Core Fonts](http://mscorefonts2.sourceforge.net/). Например, так:

```
$ sudo dnf install http://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
$ sudo fc-cache -fv
```

> В Fedora 23 есть проблема (#84) с компиляцией библиографии с помощью `biblatex` и `biber`, поэтому необходимо переключиться на использование `bibtex`. Для этого в файле `Dissertation/setup.tex` переключите `\setcounter{bibliosel}{1}` в `0`, чтобы получилось `\setcounter{bibliosel}{0}`. Туже самую операцию повторите в файле `Synopsis/setup.tex`.

### Установка шрифтов PSCyr
PSCyr — это пакет красивых русских шрифтов для LaTeX. К сожалению, его нужно устанавливать отдельно. Если он у вас не установлен, то ничего страшного — шаблон заработает и без него. Ну лучше бы его всё-таки поставить. Инструкции по установке PSCyr для различных конфигураций приведены [тут](PSCyr/README.md). Если вы не нашли подходящую вам инструкцию, но смогли выполнить установку самостоятельно, то большая просьба [поделиться](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/pulls) вашими наработками.

## Сборка

Сборку можно производить следующими командами:

* диссертация: `latexmk -pdf -pdflatex="xelatex %O %S" dissertation`
* автореферат: `latexmk -pdf -pdflatex="xelatex %O %S" synopsis`

Либо можно использовать make-файлы: из корневого каталога выполнять

* `make` для сборки всего
* `make dissertation` для сборки диссертации,
* `make synopsis` для сборки автореферата,
* `make release` для сборки всего и внесения финальных *.pdf файлов в
  систему контроля версий git

либо в соответствующем каталоге (`Dissertation` или `Synopsis`) просто
выполнять `make`.  Аналогично есть возможность вызвать `make clean`
(деликатно) и `make distclean` (безоговорочно, полезно если сборка
прошла с ошибками) в указанных каталогах для удаления в них
результатов сборки и промежуточных файлов.

## Разное

### Пакеты и версии LaTeX
* Шаблон по умолчанию включает ряд распространённых пакетов, чтобы вы могли сразу ими пользоваться. Однако, на вашей машине какие-то пакеты могут быть не установлены. Если вам они не нужны, то вы можете их просто удалить (команда *\usepackage{<имя пакета>}*).
* Лучше всего использовать актуальные и полные версии LaTeX-дистрибутивов, это поможет избежать многих проблем. Например, [MikTeX](http://miktex.org/download) 2.9.4503+ для Windows или [TeXLive](http://www.tug.org/texlive/acquire.html) 2015+ для множества ОС.
* Если у вас ещё не сформировались предпочтения по LaTeX-редактору, то обратите внимание на [TeXStudio](http://texstudio.sourceforge.net/#download), существующий для всех основных платформ.
