LaTeX-шаблон для русской кандидатской диссертации и её автореферата.

## Особенности
* Кодировка: UTF-8.
* Стандарт: ГОСТ Р 7.0.11-2011.
* Поддерживаемые движки: pdfTeX, XeTeX, LuaTeX.
* Поддерживаемые реализации библиографии: встроенная на движке BibTeX, BibLaTeX
на движке Biber.

[**Примеры компиляции шаблона**](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/releases/latest).

[**Установка программного обеспечения и сборка диссертации в файлы PDF**](Readme/Installation.md).

[**Как писать диссертацию на GitHub?**](Readme/github.md)

## Обсуждение
Общие вопросы лучше всего писать в gitter-канал:
[![Join the chat at https://gitter.im/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Для отчётов об ошибках и для конкретных пожеланий/предложений лучше всего использовать раздел [Issues](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/issues).

## Структура
* [dissertation.tex](dissertation.tex): главный файл диссертации.
* **[папка Dissertation](Dissertation/):** Структурированная система файлов с
шаблоном диссертации.
  * **папка images:** Папка для размещения файлов изображений, относящихся только
  к диссертации.
  * [setup.tex](Dissertation/setup.tex): Файл упрощённой настройки оформления
  диссертации.
* [synopsis.tex](synopsis.tex): главный файл автореферата диссертации.
* **[папка Synopsis](Synopsis/):** Структурированная система файлов с шаблоном
автореферата.
  * **папка images:** Папка для размещения файлов изображений, относящихся
  только к автореферату диссертации.
  * [setup.tex](Synopsis/setup.tex): Файл упрощённой настройки оформления
  автореферата.
* [presentation.tex](presentation.tex): главный файл презентации.
* **[папка Presentation](Presentation/):** Структурированная система файлов с
шаблоном презентации.
  * **папка images:** Папка для размещения файлов изображений, относящихся
  только к презентации.
  * [setup.tex](Presentation/setup.tex): Файл упрощённой настройки оформления
  презентации.
* **[папка Documents](Documents/):** Полезные документы (ГОСТ-ы и постановления).
* **[папка PSCyr](PSCyr/):** Пакет PSCyr + инструкции по установке.
* **[папка BibTeX-Styles](BibTeX-Styles/):** Подборка русских стилевых пакетов
BibTeX под UTF-8.
* **[папка common](common/):** Общие файлы настроек и управления содержанием шаблонов.
  * [characteristic.tex](common/characteristic.tex): Часть общей характеристики
  работы, повторяющаяся в диссертации и автореферате.
  * [concl.tex](common/concl.tex): Заключение. Является общим для автореферата
  и диссертации (согласно [ГОСТ Р 7.0.11-2011](Documents/GOST%20R%207.0.11-2011.pdf),
  пункты 5.3.3 и 9.2.3).
  * [data.tex](common/data.tex): Общие данные (название работы, руководитель,
  оппоненты, ключевые слова и т. п.).
  * [packages.tex](common/packages.tex) и [styles.tex](common/styles.tex): Общие
  пакеты и стили оформления автореферата и диссертации.
  * [setup.tex](common/setup.tex): Общие настройки автореферата и диссертации.
  В нём же настраивается выбор реализации библиографии.
* **[папка biblio](biblio/):** Файлы с библиографией.
  * [author.bib](biblio/author.bib): Публикации автора по теме диссертации.
  * [external.bib](biblio/external.bib): Работы которые ссылается автор.
* **папка images:** Общие файлы изображений шаблонов.
  * **папка cache:** Папка прекомпелированных рисунков.
	* [placeholder.txt](images/cache/placeholder.txt): Файл, необходимый для прекомпиляции
      рисунков в [overleaf](https://www.overleaf.com/).
* **папка listings:** Общие файлы листингов.

Дополнительные файлы:

* [Makefile](Makefile), [compress.mk](compress.mk), [unix.mk](unix.mk),
  [windows.mk](windows.mk), [examples.mk](examples.mk), [latexmkrc](latexmkrc): Файлы системы сборки шаблона.
* [usercfg.mk](usercfg.mk): Пользовательские настройки системы сборки шаблона.
* [indent.yaml](indent.yaml): Файл настройки форматирования исходного кода для
  [latexindent](https://www.ctan.org/pkg/latexindent).
* [.editorconfig](.editorconfig): Файл настройки текстовых редакторов, поддерживающих стандарт
  [editorconfig](https://editorconfig.org/).
* [Dockerfile](Dockerfile), [install-dockertex.sh](install-dockertex.sh): Файлы генерации
  [Docker](https://www.docker.com/) образа для сборки шаблона.
* [siunitx.cfg](siunitx.cfg): Определения величин SI для библиотеки
  [siunitx](https://ctan.org/pkg/siunitx).
* [synopsis_booklet.tex](synopsis_booklet.tex),
 [presentation_booklet.tex](presentation_booklet.tex): Файлы генерации печатных версий
 автореферата и презентации.
* [tikz.tex](tikz.tex): Файл изолированной сборки векторной графики [tikz](https://www.ctan.org/pkg/pgf).

## Дополнительная полезная информация

* [Оформление библиографии](Readme/Bibliography.md)
* [Как вносить правки в проект](CONTRIBUTING.md)
* [Полезные ссылки](Readme/Links.md)
* [Шаблон в галерее шаблонов ShareLaTeX](https://www.sharelatex.com/templates/thesis/russian-phd-latex-dissertation-template) (очень старая версия).

## Благодарности
* Большое спасибо Юлии Мартыновой за [оригинальный вариант шаблона](http://alessia-lano.livejournal.com/4267.html).
* Большое спасибо [dustalov](https://github.com/dustalov),
[Lenchik](https://github.com/Lenchik), [tonkonogov](https://github.com/tonkonogov)
за значительный вклад и обсуждения.
* Спасибо [storkvist](https://github.com/storkvist), [kshmirko](https://github.com/kshmirko),
[ZoomRmc](https://github.com/ZoomRmc), [tonytonov](https://github.com/tonytonov),
[Thibak](https://github.com/Thibak), [eximius8](https://github.com/eximius8),
[Nizky](https://github.com/Nizky) за полезные правки и замечания.

## Лицензия

CC BY 4.0

Поэтому можно модифицировать и использовать шаблон любым образом, при
условии сохранения авторства на шаблон оформления диссертации в
формате LaTeX (в виде списка авторов в настоящем файле).  При этом не
накладывается никаких ограничений на текст диссертации, все права на
содержательную часть диссертации остаются за её автором.  В том числе,
если в тексте возникает раздел благодарностей (например, научному
руководителю за умелое руководство, коллегам за помощь в работе и
т.д.), то надо ли выносить авторам шаблона
*Russian-Phd-LaTeX-Dissertation-Template* благодарность за помощь в
оформлении диссертации или нет - решает сам диссертант. Использвание
шаблона не накладывает никаких ограничений на использование итоговых
файлов (например, PDF с готовой диссертацией или авторефератом),
т.е. никак не регулирует то, как они распространяются, копируются,
модифицируются и т.д.
