## Как писать диссертацию на GitHub?

### Без обновления шаблона

Описанную ниже схему можно использовать для того, чтобы писать свою
диссертацию на GitHub используя шаблон
*Russian-Phd-LaTeX-Dissertation-Template*

0) Создаём учётную запись на GitHub.

1) Логинимся, жмём значок Fork на главной странице шаблона. После
этого шаблон появится в списке репозиториев уже вашей учётной
записи.

2) Открываем свою копию шаблона. Жмём кнопку Branch:master, в поле
"Find or create a branch" пишем имя для ветки ропозитория под свой
дисер. У меня это "disser-Ladutenko". Если после нажатия на кнопку в
поле ввода вы видите надпись "Filter branches/tags" - вы в чужой копии
репозитория.

3) Дальше можно клонировать шаблон к себе на компьютер. Делать это
надо из **СВОЕЙ** копии шаблона!

4) Пишем диссер в своей ветке, радуемся возможностям системы контроля
версии, например можно утром посмотреть, а что именно ты менял по
тексту вчера в 3 часа ночи...

Или научник наделал правок по всему тексту, делаем новую ветку,
заменяем свой файл на исправленный, на сайте делаем compare,
смотрим что поменялось. Продвинутый научник сделает вам pull request с
предлагаемыми изменениями.

### С обновлением

Остальные инструкции выполняются из командной строки в Linux, а для
Winodows\Mac есть программы для работы с git... в которых тоже можно
выполнять указанные ниже команды! Нужны они для того, чтобы улучшения
в основном шаблоне можно было наложить поверх уже начатого дисера.

1) Указываем в своей локальной копии (на компьютере), что откуда она
должна получать обновления. Это делается один раз для каждой локальной
копии.

`git remote add upstream https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template`

2) Теперь в любой момент можно обновить свою локальную копию и свою
копию на сайте GitHub следующим набором команд.

Переключаемся в master ветку: `git checkout master`

Синхронизируем локальную копию с своей копией на сайте: `git pull`

Получаем актуальные обновления: `git fetch upstream`

Смотрим что поменялось: `git diff upstream/master`

Сливаем изменения в свою локальную копию: `git merge upstream/master`

Отправляем их в свою копию на сайте: `git push`

Для Linux пользователей есть скрипт merge-with-upstream.sh, который
это всё делает скопом. Если вы свои master копии не трогали - никакого
ручного вмешательства не потребуется.

3) Не сложно подтянуть обновления уже непосредственно в свой дисер. Для этого

`git checkout disser-Ladutenko`

по желанию: `git diff master`

`git merge master`

Если изменения были не очень конфликтующие (кто-то подправил файлы
шаблона, которые вы и не трогали, например Readme или какие-то
внутренние опции) всё тоже пройдёт без дополнительных вопросов, а
состояние репозиторие сразу перематается вперёд через все новые комиты
(fast-forward). 

```
Updating 22ca047..112b54a
Fast-forward
 Dissertation/disstyles.tex                |  16 +++++++++-
 README.md                                 |   8 +++--
 Bibliography.md => Readme/Bibliography.md |   0
 Installation.md => Readme/Installation.md |   6 ++--
 Links.md => Readme/Links.md               |   0
 Readme/github.md                          | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Synopsis/synstyles.tex                    |  19 ++++++++---
 Synopsis/title.tex                        |  77 ++++++++++++++++++++++-----------------------
 Synopsis/userstyles.tex                   |   1 +
 biblio/biblatex.tex                       |   8 ++---
 common/data.tex                           |  18 ++++++-----
 common/styles.tex                         |   6 ----
 synopsis.tex                              |  33 ++++++++++++++++++--
 13 files changed, 284 insertions(+), 71 deletions(-)
 rename Bibliography.md => Readme/Bibliography.md (100%)
 rename Installation.md => Readme/Installation.md (96%)
 rename Links.md => Readme/Links.md (100%)
 create mode 100644 Readme/github.md
```

4) В противном случае может потребоваться ручное разрешение конфликтов. Например,

```
$ git merge master
Auto-merging dissertation.tex
Auto-merging common/styles.tex
CONFLICT (content): Merge conflict in common/styles.tex
Auto-merging common/packages.tex
CONFLICT (content): Merge conflict in common/packages.tex
Auto-merging Dissertation/userstyles.tex
Auto-merging Dissertation/userpackages.tex
Auto-merging Dissertation/part3.tex
CONFLICT (content): Merge conflict in Dissertation/part3.tex
Auto-merging Dissertation/part2.tex
CONFLICT (content): Merge conflict in Dissertation/part2.tex
Auto-merging Dissertation/appendix.tex
CONFLICT (content): Merge conflict in Dissertation/appendix.tex
Automatic merge failed; fix conflicts and then commit the result.
```

Тогда надо каждый файл с конфликтом открыть и исправить конфликт вручную.

Для файлов partX.txt это, как правило, означает, что надо удалить строчку

``` tex
<<<<<<< HEAD
```
в начале файла, найти строчку
``` tex
=======
```
и удалить от неё до строчки
``` tex
>>>>>>> master
```

Чаще всего хочется оставить HEAD, но могут быть варианты. Например:

``` tex
<<<<<<< HEAD
%%% Макет страницы %%%
% Выставляем значения полей (ГОСТ 7.0.11-2011, 5.3.7)
\geometry{a4paper,top=2cm,bottom=2cm,left=2.5cm,right=1cm}

=======
>>>>>>> master
```

Описание к геометрии уехало в другой файл, так что его удаляем, а от master останется пустое место.

Ещё пример:

``` tex
<<<<<<< HEAD
%%% Интервалы %%%
\usepackage[onehalfspacing]{setspace} % Опция запуска пакета правит не только интервалы в обычном тексте, но и формульные
\usepackage{needspace}

%%% Разрывы страниц %%%
% \needspace{2\baselineskip} располагает две последующие строчки на
% одной странице. Тут используется, чтобы слово "задачи" и "положения"
% оказались на одной странице со списком из задач и положений
%\usepackage{needspace}
\makeatletter
\newcommand\mynobreakpar{\par\nobreak\@afterheading}
\makeatother

=======
>>>>>>> master
```

Объявления \usepackage переехали в другой файл, их тут удаляем, блок про разрыв страниц оставляем. Служебные

``` tex
<<<<<<< HEAD
=======
>>>>>>> master
``` 

разумеется, удаляем.

После того как все конфликты разрешены - не забудьте сделать финальный
коммит, который я обычно называю merge.

Собственно всё, ничего другого, чтобы поддерживать уже частично написанный диссер в соответствии с усилиями авторов шаблона достичь идеала не требуется.

### Если что-то пошло не так

Ничего страшного, всегда есть возможность откатиться к коммиту прямо
перед тем, как вы начали делать merge!


