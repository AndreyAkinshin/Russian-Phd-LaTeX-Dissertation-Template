LaTeX-шаблон для русской кандидатской диссертации и её автореферата.

## Особенности
* Кодировка: UTF-8
* Стандарт: ГОСТ Р 7.0.11-2011
* Поддерживаемые движки: pdfTeX, XeTeX, LuaTeX

## Online
* Шаблон [выставлен](https://www.sharelatex.com/templates/thesis/russian-phd-latex-dissertation-template) в галерее шаблонов ShareLaTeX.

## Структура
* **Dissertation:** Структурированная система файлов с шаблоном диссертации
* **Synopsis**: Структурированная система файлов с шаблоном автореферата
* **Presentation:** Шаблон презентации
* **Documents:** Полезные документы (ГОСТ-ы и постановления)
* **PSCyr:** Пакет PSCyr + инструкции по установке
* **BibTeX-Styles:** Подборка русских стилевых пакетов BibTeX под UTF-8
* **Links.md:** Полезные ссылки

## Шрифты

### LaTeX + PSCyr
PSCyr — это пакет красивых русских шрифтов для LaTeX. К сожалению, его нужно устанавливать отдельно. Если он у вас не установлен, то ничего страшного — шаблон заработает и без него. Ну лучше бы его всё-таки поставить. Инструкции по установке PSCyr для различных конфигураций приведены [тут](PSCyr/README.md). Если вы не нашли подходящую вам инструкцию, но смогли выполнить установку самостоятельно, то большая просьба [поделиться](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/pulls) вашими наработками.

### Linux + XeTeX
Для нормальной работы в системе должны быть установлены нужные шрифты. Например, для Ubuntu это можно сделать так:

```
$ sudo apt-get install ttf-mscorefonts-installer
$ sudo fc-cache -fv
```

Сборку можно производить следующими командами:

* диссертация: `latexmk -pdf -pdflatex="xelatex %O %S" dissertation`
* автореферат: `latexmk -pdf -pdflatex="xelatex %O %S" synopsis`

Либо можно использовать make-файлы: из корневого каталога
выполнять

* `make` для сборки диссертации,
* `make synopsis` для сборки автореферата,

либо в соответствующем каталоге (`Dissertation` или `Synopsis`) просто выполнять `make`.

## [Библиография](Bibliography.md)


## Пакеты и версии LaTeX
* Шаблон по умолчанию включает ряд распространённых пакетов, чтобы вы могли сразу ими пользоваться. Однако, на вашей машине какие-то пакеты могут быть не установлены. Если вам они не нужны, то вы можете их просто удалить (команда *\usepackage{<имя пакета>}*).
* Лучше всего использовать актуальные и полные версии LaTeX-дистрибутивов, это поможет избежать многих проблем. Например, [MikTeX](http://miktex.org/download) 2.9.4503+ для Windows.

## Благодарности
* Большое спасибо Юлии Мартыновой за [оригинальный вариант шаблона](http://alessia-lano.livejournal.com/4267.html).
* Большое спасибо [dustalov](https://github.com/dustalov), [Lenchik](https://github.com/Lenchik), [tonkonogov](https://github.com/tonkonogov) за значительный вклад и обсуждения.
* Спасибо [storkvist](https://github.com/storkvist), [kshmirko](https://github.com/kshmirko), [ZoomRmc](https://github.com/ZoomRmc), [tonytonov](https://github.com/tonytonov), [Thibak](https://github.com/Thibak), [eximius8](https://github.com/eximius8), [Nizky](https://github.com/Nizky) за полезные правки и замечания.
