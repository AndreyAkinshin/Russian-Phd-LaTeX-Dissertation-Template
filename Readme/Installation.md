# Установка и сборка

* [Быстрый старт](#Быстрый-старт)
* Установка
  * [В Ubuntu](#В-ubuntu)
  * [В Fedora](#В-fedora)
  * [TeXLive на Linux в обход привязанных к конкретному линуксу пакетам](#texlive-на-linux-в-обход-привязанных-к-конкретному-линуксу-пакетам)
  * [Установка шрифтов PSCyr](#Установка-шрифтов-pscyr)
    * [Рабочий способ установки в Ubuntu 15.10](#Рабочий-способ-установки-в-ubuntu-1510)
* [Сборка PDF](#Сборка-pdf-из-командной-строки)
* Разное
  * [Пакеты и версии LaTeX](#Пакеты-и-версии-latex)

## Быстрый старт
1. Скачать шаблон в архиве или клонировать этот репозиторий.
2. Установить в вашей среде компиляции (например, в редакторе TeXStudio) движок библиографии `Biber`.
3. Скомпилировать `dissertation.tex` для получения диссертации и `synopsis.tex` для получения автореферата.
4. Убедиться, что всё успешно компилируется на вашем компьютере (`Warning` в `*.log` файле компиляции допустимы).
5. Если что-то не устраивает в оформлении - проверьте закомментированые возможности в файлах шаблона, много тонкостей в ГОСТ не определены. Например, в файле `biblatex.tex` можно отключить отображение в списке литературы полей DOI и ISBN, а в `styles.tex` строчкой `\linespread{1.42}` можно сделать полуторный интервал между строчками "как в Ворде" (несколько шире, чем общепринятый "типографский", поэтому на страницу влезет меньше текста)

## Компиляция черновика

В файле `setup.tex` можно поменять значение параметра `draft` на 1,
чтобы переключить шаблон в режим черновика. При этом шаблон будет
собираться с некими отклонениями от ГОСТ, но в несколько раз быстрее
(в основном отличия касаются оформления списка литературы).  Этот
режим удобен при промежуточных сборках, например, во время набора
формул. Пользователи Linux могут применять команды `make
dissertation-preformat` для первой сборки и `make
dissertation-formated` для последующих, чтобы использовать
предварительное форматирование преамбулы диссертации. Это позволяет
ускорить сборку ещё приблизительно в 1.5 раза (на
повторную сборку черновика диссертации на компьютере с процессором
Intel i5 требуется около двух секунд). Еще доступна команда `make
draft`, которая будет собирать в режиме черновика, даже если этот
режим отключён в файле `setup.tex`.

## Простые ошибки

Если не собирается библиография, ссылки на литературу отображаются вопросами или жирными названиями:

1. Попробовать поменять параметр `bibliosel` в соответствующем файле `setup.tex`, подробнее читать [«в случае проблем с библиографией»](Bibliography.md#В-случае-проблем).
2. Очистить папки проекта от прошлых временных файлов (`*.aux`, `*.toc`, `*.bbl`, `*.bcf`, `*.synctex.gz` и прочие подобные).
3. Убедиться, что в вашей среде компиляции (например, в редакторе TeXStudio) правильно выбран движок библиографии (в соответствии с параметром `bibliosel` в каждом из файлов `setup.tex`).
4. Провести несколько компиляций проекта.
5. Если ничего из предыдущих пунктов не помогло, запустить `latexmk` на главном файле автореферата или диссертации, или выполнить [соответствующий `make`](#Сборка-pdf-из-командной-строки).

Если компилируется с ошибками, то изучение соответствующего `*.log` файла может помочь определить причину (как правило, ошибки вызваны отсутствием необходимых пакетов или их версий). Часто первая ошибка в `*.log` файле является первопричиной остальных.

## Установка

### В Ubuntu

> Протестировано на Ubuntu 15.04.

Для установки XeTeX в Ubuntu и необходимых дополнительных пакетов можно использовать команду:

```
$ sudo apt-get install texlive-xetex texlive-generic-extra texlive-lang-cyrillic latexmk biber
```

### В Fedora

> Протестировано на Fedora 27.

Для установки XeTeX необходимо установить следующие пакеты:

```
$ sudo dnf install texlive-xetex latexmk texlive-hyphen-russian biber \
                    texlive-extsizes texlive-cm texlive-amscls texlive-nag \
                    texlive-polyglossia texlive-euenc texlive-multirow \
                    texlive-makecell texlive-ec texlive-was texlive-zapfding \
                    texlive-totcount texlive-totpages texlive-interfaces \
                    texlive-tocloft texlive-tabulary texlive-floatrow \
                    texlive-biblatex texlive-biblatex-gost texlive-cite \
                    texlive-bibtex texlive-impnattypo texlive-cleveref \
                    texlive-tabu texlive-mwe
```

> В Fedora 23 есть проблема ([#84](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/issues/84)) с компиляцией библиографии с помощью `biblatex` и `biber`, поэтому необходимо переключиться на использование `bibtex`. Для этого в файле `Dissertation/setup.tex` переключите `\setcounter{bibliosel}{1}` в `0`, чтобы получилось `\setcounter{bibliosel}{0}`. Туже самую операцию повторите в файле `Synopsis/setup.tex`.

### TeXLive на Linux в обход привязанных к конкретному линуксу пакетам
[How to install “vanilla” TeXLive on Debian or Ubuntu?](http://tex.stackexchange.com/a/95373/79756) — инструкция на английском языке, как ставить TeXLive на Linux в обход привязанных к конкретному линуксу пакетам (на примере Debian и Ubuntu).

### В MacOS 10.10 и выше
Для установки в среде MacOS достаточно установить пакет MacTeX [отсюда](https://tug.org/mactex/mactex-download.html). После установки необходимо добавить пути к установленным файлам в переменную окружения `PATH`, например, так:

```
export PATH=$PATH:export PATH=$PATH:/Library/TeX/texbin
```

Чтобы сделать эффект постоянным можно добавить эту строку в `.bash_profile`:

```
echo "export PATH=$PATH:export PATH=$PATH:/Library/TeX/texbin" >>~/.bash_profile
```

Теперь при следующем логине, вам будут доступны утилиты из пакета, необходимые для работы `make`-скриптов.

### Установка шрифтов PSCyr
PSCyr — это пакет красивых русских шрифтов для LaTeX. К сожалению, его нужно устанавливать отдельно. Если он у вас не установлен, то ничего страшного — шаблон заработает и без него. Ну лучше бы его всё-таки поставить. Инструкции по установке PSCyr для различных конфигураций приведены [тут](../PSCyr/README.md). Если вы не нашли подходящую вам инструкцию, но смогли выполнить установку самостоятельно, то большая просьба [поделиться](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/pulls) вашими наработками.

#### Рабочий способ установки в Ubuntu 15.10
(компиляция из [инструкции на welinux](http://welinux.ru/post/3200/) и файлов, которые есть в шаблоне)

Нужно скачать шаблон, найти в папке PSCyr файл pscyr0.4d.zip и распаковать его содержимое куда угодно. Чтобы не переписывать пути, папка с содержимым должна называться PSCyr, а не pscyr, как в архиве. Затем надо зайти в
терминал, перейти к тому каталогу, где лежит папка PSCyr с содержимым, и выполнить команды из вышеупомянутого руководства:
```
$ mkdir ./PSCyr/fonts/map ./PSCyr/fonts/enc
$ cp ./PSCyr/dvips/pscyr/*.map ./PSCyr/fonts/map/
$ cp ./PSCyr/dvips/pscyr/*.enc ./PSCyr/fonts/enc/
$ echo "fadr6t AdvertisementPSCyr \"T2AEncoding ReEncodeFont\"" > ./PSCyr/fonts/map/pscyr.map
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

#### Установка в MacOS 10.x
1. Скачать файлы со шрифтами и распаковать их в одну папку.
2. Создать/отредактировать файл `install.sh`, чтобы он содержал следующее:

```
#!/bin/sh

INSTALLDIR=`kpsewhich -expand-var='$TEXMFLOCAL'`
mkdir -p $INSTALLDIR/{tex/latex,fonts/tfm/public,fonts/vf/public,fonts/type1/public,fonts/map/dvips,fonts/afm/public,doc/fonts}/pscyr
mv dvips/pscyr/* $INSTALLDIR/fonts/map/dvips/pscyr
mv tex/latex/pscyr/* $INSTALLDIR/tex/latex/pscyr
mv fonts/tfm/public/pscyr/* $INSTALLDIR/fonts/tfm/public/pscyr
mv fonts/vf/public/pscyr/* $INSTALLDIR/fonts/vf/public/pscyr
mv fonts/type1/public/pscyr/* $INSTALLDIR/fonts/type1/public/pscyr
mv fonts/afm/public/pscyr/* $INSTALLDIR/fonts/afm/public/pscyr
mv LICENSE doc/README.koi doc/PROBLEMS ChangeLog $INSTALLDIR/doc/fonts/pscyr

mktexlsr

echo "Map pscyr.map\n" >> $INSTALLDIR/web2c/updmap.cfg
updmap-sys
```

3. Запустить полученный скрипт с помощью `sudo`:

```
sudo bash ./install.sh
```

## Сборка PDF из командной строки

Сборку можно производить следующими командами:

* диссертация: `latexmk -pdf -pdflatex="xelatex %O %S" dissertation`
* автореферат: `latexmk -pdf -pdflatex="xelatex %O %S" synopsis`

Либо можно использовать make-файлы (движок `xelatex`): из корневого
каталога выполнять

* `make` для сборки всего
* `make dissertation` для сборки диссертации,
* `make synopsis` для сборки автореферата,
* `make draft` для быстрой сборки диссертации и автореферата в режиме черновика
* `make talk` для сборки презентации для доклада
* `make release` для сборки всего и внесения финальных *.pdf файлов в
  систему контроля версий git

либо в соответствующем каталоге (`Dissertation` или `Synopsis`) просто
выполнять `make`.  Аналогично есть возможность вызвать `make clean`
(деликатно) и `make distclean` (безоговорочно, полезно если сборка
прошла с ошибками) в указанных каталогах для удаления в них
результатов сборки и промежуточных файлов.


* `make pdflatex` сборка полной версии с движком `pdflatex` (несколько
  быстрее для автореферата, чем `xelatex`, движок для библиографии в
  соответствии с настройками
  [`setup.tex`](Bibliography.md#В-случае-проблем)).

Презентация должна собираться движком `xelatex` или `lualatex`

## Разное

### Пакеты и версии LaTeX
* Шаблон по умолчанию включает ряд распространённых пакетов, чтобы вы могли сразу ими пользоваться. Однако, на вашей машине какие-то пакеты могут быть не установлены. Если вам они не нужны, то вы можете их просто удалить (команда *\usepackage{<имя пакета>}*).
* Лучше всего использовать актуальные и полные версии LaTeX-дистрибутивов, это поможет избежать многих проблем. Например, [MikTeX](http://miktex.org/download) 2.9.4503+ для Windows или [TeXLive](http://www.tug.org/texlive/acquire.html) 2015+ для множества ОС.
* Если у вас ещё не сформировались предпочтения по LaTeX-редактору, то обратите внимание на [TeXStudio](http://texstudio.sourceforge.net/#download), существующий для всех основных платформ.

### Проверка правописания
Проверку правописания можно осуществлять при помощи программы `aspell`.
Для этого в командной строке надо набрать

```
make spell-check
```

Проверка будет осуществлена с использованием русского словаря в файлах папок `dissertation`, `presentation` и `synopsis`.

При переходе в папку `dissertation`, `presentation` или `synopsis`, возможно использование дополнительных функций.

Для проверки всех файлов с расширением `.tex` в папке `MYDIR` можно использовать команду:

```
make spell-check SPELLCHECK_DIRS=MYDIR
```
Для проверки орфографии в файле `MyFile.txt` с использованием английского словаря надо набрать:

```
make spell-check SPELLCHECK_FILES=MyFile.txt SPELLCHECK_LANG=en
```

### Форматирование исходного кода
Программа [`latexindent`](https://www.ctan.org/pkg/latexindent) позволяет форматировать исходный код `.tex` файлов.
Это делает код более читаемым и единообразным.

Для форматирования всех документов можно использовать команду:

```
make indent
```

При переходе в папку `dissertation`, `presentation` или `synopsis`, возможно использование дополнительных функций.

Для форматирования файлов в папке `MYDIR`:

```
make indent INDENT_DIRS=MYDIR
```

Для форматирования только файла `MyFILE.tex`:

```
make indent INDENT_FILES=MyFILE.tex
```

По умолчанию настройки форматирования считываются из файла `indent.yaml`.
Для использования другого файла настроек, наберите в командной строке:
```
make indent INDENT_SETTINGS=mysettings.yaml
```

### Сжатие файлов
Размер выходных `.pdf` файлов может быть большим.
Особенно, если в тексте присутствует много рисунков с большим разрешением.
Программа [`gs`](https://ghostscript.com/) позволяет значительно уменьшить размер `.pdf` файлов.

Для сжатия файла, после перехода в папку `dissertation`, `presentation` или `synopsis`, можно использовать команду:

```
make compress
```

Сжатый файл будет создан с суффиксом `*_compressed.pdf`

Возможен выбор степени сжатия файла.
Например, команда

```
make compress COMPRESSION_LEVEL=screen
```
создаст файл с минимально возможным размером.
Возможные уровни сжатия: `screen`, `default`, `ebook`, `printer`, `prepress`. По умолчанию используется значение `default`.

Сжать другой `.pdf` файл можно командой:

```
make compress COMPRESSION_FILE=alt_synopsis.pdf
```

### Проверка структуры файлов библиографии
В случае ошибок, связанных с форматированием
`.bib` файлов, можно использовать программу [`biber`](http://biblatex-biber.sourceforge.net/) для их проверки.

Для этого, из папки `dissertation` следует выполнить команду:

```
make bibcheck
```

При этом отчёт о проверке файлов библиографии будет записан в файл `bibcheck.log`
