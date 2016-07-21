LaTeX-шаблон для русской кандидатской диссертации и её автореферата.

## Особенности
* Кодировка: UTF-8.
* Стандарт: ГОСТ Р 7.0.11-2011.
* Поддерживаемые движки: pdfTeX, XeTeX, LuaTeX.
* Поддерживаемые реализации библиографии: встроенная на движке BibTeX, BibLaTeX на движке Biber.

[**Примеры компиляции шаблона**](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/releases/latest).

[**Установка программного обеспечения и сборка диссертации в файлы PDF**](Readme/Installation.md).

[**Как писать диссертацию на GitHub?**](Readme/github.md)

## Обсуждение
Общие вопросы лучше всего писать в gitter-канал:
[![Join the chat at https://gitter.im/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Для отчётов об ошибках и для конкретных пожеланий/предложений лучше всего использовать раздел [Issues](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/issues).

## Структура
* [dissertation.tex](dissertation.tex): главный файл диссертации.
* **[папка Dissertation](Dissertation/):** Структурированная система файлов с шаблоном диссертации.
  * **папка images:** Папка для размещения файлов изображений, относящихся только к диссертации.
  * [setup.tex](Dissertation/setup.tex): Файл упрощённой настройки оформления диссертации. В нём же настраивается выбор реализации библиографии.
* [synopsis.tex](synopsis.tex): главный файл автореферата диссертации.
* **[папка Synopsis](Synopsis/):** Структурированная система файлов с шаблоном автореферата.
  * **папка images:** Папка для размещения файлов изображений, относящихся только к автореферату диссертации.
  * [setup.tex](Synopsis/setup.tex): Файл упрощённой настройки оформления автореферата. В нём же настраивается выбор реализации библиографии.
* **[папка Presentation](Presentation/):** Шаблон презентации.
* **[папка Documents](Documents/):** Полезные документы (ГОСТ-ы и постановления).
* **[папка PSCyr](PSCyr/):** Пакет PSCyr + инструкции по установке.
* **[папка BibTeX-Styles](BibTeX-Styles/):** Подборка русских стилевых пакетов BibTeX под UTF-8.
* **папка common:** Общие файлы настроек и управления содержанием шаблонов.
  * [characteristic.tex](common/characteristic.tex): Часть общей характеристики работы, повторяющаяся в диссертации и автореферате.
  * [concl.tex](common/concl.tex): Заключение. Является общим для автореферата и диссертации (согласно [ГОСТ Р 7.0.11-2011](Documents/GOST%20R%207.0.11-2011.pdf), пункты 5.3.3 и 9.2.3).
  * [data.tex](common/data.tex): Общие данные (название работы, руководитель, оппоненты, ключевые слова и т. п.).
  * [packages.tex](common/packages.tex) и [styles.tex](common/styles.tex): Общие пакеты и стили оформления автореферата и диссертации.
* **папка biblio:** Файлы с библиографией.
* **папка images:** Общие файлы изображений шаблонов.
* **папка listings:** Общие файлы листингов.

## Дополнительная полезная информация

* [Оформление библиографии](Readme/Bibliography.md)
* [Как вносить правки в проект](CONTRIBUTING.md)
* [Полезные ссылки](Readme/Links.md)
* [Шаблон в галерее шаблонов ShareLaTeX](https://www.sharelatex.com/templates/thesis/russian-phd-latex-dissertation-template).

## Благодарности
* Большое спасибо Юлии Мартыновой за [оригинальный вариант шаблона](http://alessia-lano.livejournal.com/4267.html).
* Большое спасибо [dustalov](https://github.com/dustalov), [Lenchik](https://github.com/Lenchik), [tonkonogov](https://github.com/tonkonogov) за значительный вклад и обсуждения.
* Спасибо [storkvist](https://github.com/storkvist), [kshmirko](https://github.com/kshmirko), [ZoomRmc](https://github.com/ZoomRmc), [tonytonov](https://github.com/tonytonov), [Thibak](https://github.com/Thibak), [eximius8](https://github.com/eximius8), [Nizky](https://github.com/Nizky) за полезные правки и замечания.

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
