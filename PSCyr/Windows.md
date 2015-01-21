Инструкция по установке (Windows + MiKTeX):

* Разархивировать pscyr0.4d.zip
* Cкопировать содержимое в корень основной директории MiKTeX-а (например, "C:\Program Files\MiKTeX 2.9\") -- произойдет слияние папок
* Перейти в bin-директорию MiKTeX-а (например, "C:\Program Files\MiKTeX 2.9\miktex\bin\x64\")
* Выполнить команду initexmf --edit-config-file dvips и ввести в открывшийся блокнот p +pscyr.map
* Выполнить команду initexmf --edit-config-file pdftex и ввести в открывшийся блокнот +pscyr.map
* Выполнить команду initexmf --edit-config-file updmap и ввести в открывшийся блокнот Map pscyr.map
* Выполнить команду updmap
* Выполнить команду initexmf --edit-config-file dvipdfm и ввести в открывшийся блокнот f pscyr2.map
* Выполнить команду initexmf -u
* Запустить из меню Пуск программу "Settings (Admin)" и на вкладке General нажать кнопку Refresh FNDB
* Выполнить команду mkfntmap

Протестировано: Windows 7, Windows 8, Windows 8.1.