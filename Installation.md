# Установка и сборка

* [Быстрый старт](#Быстрый-старт)
* Установка
  * [В Ubuntu](#В-ubuntu)
  * [В Fedora](#В-fedora)
  * [TeXLive на Linux в обход привязанных к конкретному линуксу пакетам](#texlive-на-linux-в-обход-привязанных-к-конкретному-линуксу-пакетам)
  * [Установка шрифтов PSCyr](#Установка-шрифтов-pscyr)
    * [Рабочий способ установки в Ubuntu 15.10](#Рабочий-способ-установки-в-ubuntu-1510)
* [Сборка PDF](#Сборка-pdf)
* Разное
  * [Пакеты и версии LaTeX](#Пакеты-и-версии-latex)

## Быстрый старт
1. Скачать шаблон в архиве или клонировать этот репозиторий.
2. Установить в вашей среде компиляции (например, в редакторе TeXStudio) движок библиографии `Biber`.
3. Скомпилировать `dissertation.tex` для получения диссертации и `synopsis.tex` для получения автореферата.
4. Убедиться, что всё успешно компилируется на вашем компьютере (`Warning` в `*.log` файле компиляции допустимы).

Если не собирается библиография, ссылки на литературу отображаются вопросами или жирными названиями:

1. Попробовать поменять параметр `bibliosel` в соответствующем файле `setup.tex`, подробнее читать [«в случае проблем с библиографией»](Bibliography.md#В-случае-проблем).
2. Очистить папки проекта от прошлых временных файлов (`*.aux`, `*.toc`, `*.bbl`, `*.bcf`, `*.synctex.gz` и прочие подобные).
3. Убедиться, что в вашей среде компиляции (например, в редакторе TeXStudio) правильно выбран движок библиографии (в соответствии с параметром `bibliosel` в каждом из файлов `setup.tex`).
4. Провести несколько компиляций проекта.
5. Если ничего из предыдущих пунктов не помогло, запустить `latexmk` на главном файле автореферата или диссертации, или выполнить [соответствующий `make`](#Сборка-pdf).

Если компилируется с ошибками, то изучение соответствующего `*.log` файла может помочь определить причину (как правило, ошибки вызваны отсутствием необходимых пакетов или их версий). Часто первая ошибка в `*.log` файле является первопричиной остальных.

## Установка

### В Ubuntu

> Протестировано на Ubuntu 15.04.

Для установки XeTeX в Ubuntu и необходимых дополнительных пакетов можно использовать команду:

```
$ sudo apt-get install texlive-xetex texlive-generic-extra texlive-lang-cyrillic latexmk biber
```

Для нормальной работы в системе должны быть установлены нужные шрифты. Например, для Ubuntu это можно сделать так:

```
$ sudo apt-get install ttf-mscorefonts-installer
$ sudo fc-cache -fv
```

### В Fedora

> Протестировано на Fedora 23.

Для установки XeTeX необходимо установить следующие пакеты:

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

> В Fedora 23 есть проблема ([#84](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/issues/84)) с компиляцией библиографии с помощью `biblatex` и `biber`, поэтому необходимо переключиться на использование `bibtex`. Для этого в файле `Dissertation/setup.tex` переключите `\setcounter{bibliosel}{1}` в `0`, чтобы получилось `\setcounter{bibliosel}{0}`. Туже самую операцию повторите в файле `Synopsis/setup.tex`.

### TeXLive на Linux в обход привязанных к конкретному линуксу пакетам
[How to install “vanilla” TeXLive on Debian or Ubuntu?](http://tex.stackexchange.com/a/95373/79756) — инструкция на английском языке, как ставить TeXLive на Linux в обход привязанных к конкретному линуксу пакетам (на примере Debian и Ubuntu).

### Установка шрифтов PSCyr
PSCyr — это пакет красивых русских шрифтов для LaTeX. К сожалению, его нужно устанавливать отдельно. Если он у вас не установлен, то ничего страшного — шаблон заработает и без него. Ну лучше бы его всё-таки поставить. Инструкции по установке PSCyr для различных конфигураций приведены [тут](PSCyr/README.md). Если вы не нашли подходящую вам инструкцию, но смогли выполнить установку самостоятельно, то большая просьба [поделиться](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/pulls) вашими наработками.

#### Рабочий способ установки в Ubuntu 15.10
(компиляция из [инструкции на welinux](http://welinux.ru/post/3200/) и файлов, которые есть в шаблоне)

Нужно скачать шаблон, найти в папке PSCyr файл pscyr0.4d.zip и распаковать его содержимое куда угодно. Чтобы не переписывать пути, папка с содержимым должна называться PSCyr, а не pscyr, как в архиве. Затем надо зайти в 
терминал, перейти к тому каталогу, где лежит папка PSCyr с содержимым, и выполнить команды из вышеупомянутого руководства:
```
$ mkdir ./PSCyr/fonts/map ./PSCyr/fonts/enc
$ cp ./PSCyr/dvips/pscyr/*.map ./PSCyr/fonts/map/
$ cp ./PSCyr/dvips/pscyr/*.enc ./PSCyr/fonts/enc/
$ echo "fadr6t AdvertisementPSCyr \"T2AEncoding ReEncodeFont\" > ./PSCyr/fonts/map/pscyr.map
```
Дальше надо узнать, где у вас локальный каталог texmf. Для этого выполняем
```
$ kpsewhich -expand-var='$TEXMFLOCAL'
```
С вероятностью около единицы результат будет /usr/local/share/texmf/. Копируем всё туда:
```
$ sudo cp -R ./PSCyr/* /usr/local/share/texmf/
```
Ну и подключаем:
```
$ sudo texhash
$ updmap --enable Map=pscyr.map
$ sudo mktexlsr
```

## Сборка PDF

Сборку можно производить следующими командами:

* диссертация: `latexmk -pdf -pdflatex="xelatex %O %S" dissertation`
* автореферат: `latexmk -pdf -pdflatex="xelatex %O %S" synopsis`

Либо можно использовать make-файлы (движок `xelatex`): из корневого
каталога выполнять

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

 Упрощённый вариант шаблона (черновик) в файле `draft.tex` требует в
несколько раз меньше времени для сборки по сравнению с полной
версией. Его можно использовать, например, для промежуточной сборки
при наборе формул. Для него доступны следующие команды:

* `make draft` самая быстрая сборка с помощью `pdflatex+biber`
* `make pdf` сборка полной версии с движком `pdflatex` (несколько
  быстрее для автореферата, чем `xelatex`, движок для библиографии в
  соответствии с настройками
  [`setup.tex`](Bibliography.md#В-случае-проблем)).

## Разное

### Пакеты и версии LaTeX
* Шаблон по умолчанию включает ряд распространённых пакетов, чтобы вы могли сразу ими пользоваться. Однако, на вашей машине какие-то пакеты могут быть не установлены. Если вам они не нужны, то вы можете их просто удалить (команда *\usepackage{<имя пакета>}*).
* Лучше всего использовать актуальные и полные версии LaTeX-дистрибутивов, это поможет избежать многих проблем. Например, [MikTeX](http://miktex.org/download) 2.9.4503+ для Windows или [TeXLive](http://www.tug.org/texlive/acquire.html) 2015+ для множества ОС.
* Если у вас ещё не сформировались предпочтения по LaTeX-редактору, то обратите внимание на [TeXStudio](http://texstudio.sourceforge.net/#download), существующий для всех основных платформ.
