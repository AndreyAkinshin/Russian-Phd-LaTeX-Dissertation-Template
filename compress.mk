### Пережатие pdf с помощью Ghostscript.
#
# Описание команд gs: https://www.ghostscript.com/doc/current/VectorDevices.htm
# (!) Ghostscript молча игнорирует неизвестные параметры.


# Фикс для make из MSYS2, отключающий Automatic path mangling. См:
#  * https://stackoverflow.com/a/34386471/1032586
#  * https://github.com/msys2/msys2/wiki/Porting#user-content-filesystem-namespaces
FULL_MAKE_VERSION_INFO := $(shell $(MAKE) --version)   # e.g. "GNU Make 4.2.1 Built for x86_64-pc-msys ... "
ISMSYS_MAKE := $(findstring msys,$(FULL_MAKE_VERSION_INFO))
MSYS_FIX := MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL="*"
MSYS_FIX := $(if $(ISMSYS_MAKE),$(MSYS_FIX),)

# Пересобираемый файл
COMPRESS_FILE ?= $(TARGET)

# Не останавливаться после каждой страницы
COMPRESSION_FLAGS_COMMON += -P- -dSAFER -dBATCH -dNOPAUSE

# Устройство
COMPRESSION_FLAGS_COMMON += -sDEVICE=pdfwrite

# Вложить шрифты внутрь pdf
COMPRESSION_FLAGS_COMMON += -dEmbedAllFonts=true -dSubsetFonts=true

# Разработчики gs не рекомендуют использовать пресеты `-dPDFSETTINGS` если нет чёткого понимания всех
# нюансов ( https://stackoverflow.com/a/30860751/1032586 ) - безопаснее явно задавать необходимые значения.
# COMPRESSION_FLAGS_COMMON += -dPDFSETTINGS=/default

# Не показывать счётчик страниц
COMPRESSION_QUIET ?= no
ifneq ($(COMPRESSION_QUIET),no)
COMPRESSION_FLAGS_COMMON += -q
endif

### (1) Пересборка pdf для уменьшения размера, за счёт снижения качества картинок --------------------------
# (крутить `COMPRESSION_IMAGE_DPI` до достижения приемлемого размера)
COMPRESSION_IMAGE_DPI ?= 144
COMPRESSION_FLAGS_1 = $(COMPRESSION_FLAGS_COMMON)

COMPRESSION_FLAGS_1 += -dDownsampleColorImages=true
COMPRESSION_FLAGS_1 += -dColorImageDownsampleThreshold=1.5
COMPRESSION_FLAGS_1 += -dColorImageDownsampleType=/Average  # Bicubic может давать цветные артефакты
COMPRESSION_FLAGS_1 += -dColorImageFilter=/DCTEncode        # /DCTEncode = jpg, lossy
COMPRESSION_FLAGS_1 += -dColorImageResolution=$(COMPRESSION_IMAGE_DPI)

COMPRESSION_FLAGS_1 += -dDownsampleGrayImages=true
COMPRESSION_FLAGS_1 += -dGrayImageDownsampleThreshold=1.5
COMPRESSION_FLAGS_1 += -dGrayImageDownsampleType=/Bicubic
COMPRESSION_FLAGS_1 += -dGrayImageFilter=/DCTEncode
COMPRESSION_FLAGS_1 += -dGrayImageResolution=$(COMPRESSION_IMAGE_DPI)

COMPRESSION_FLAGS_1 += -dDownsampleMonoImages=true
COMPRESSION_FLAGS_1 += -dMonoImageDownsampleThreshold=1.5
COMPRESSION_FLAGS_1 += -dMonoImageDownsampleType=/Subsample
COMPRESSION_FLAGS_1 += -dMonoImageFilter=/CCITTFaxEncode
COMPRESSION_FLAGS_1 += -dMonoImageResolution=$(COMPRESSION_IMAGE_DPI)


##! сжатие файла с потерей данных
compress-lowdpi:
	$(MSYS_FIX) gs $(COMPRESSION_FLAGS_1) \
		-sOutputFile=$(basename $(COMPRESS_FILE))_lowdpi.pdf \
		$(basename $(COMPRESS_FILE)).pdf



### (2) Пересборка pdf для передачи в типографию -----------------------------------------------------------
COMPRESSION_FLAGS_2 = $(COMPRESSION_FLAGS_COMMON)

# Прозрачность
# Типография может требовать файл "без прозрачности" или пугать, что она напечатается непредсказуемым
# образом. Требование файла в формате "PDF 1.3" или "PDF/X-1a" тоже означает отсутствие прозрачности.
# Для исключения прозрачности gs растеризует всю страницу.
# Пример растеризуемой страницы - титульный лист шаблона. Хотя фактически логотип прозрачности не содержит,
# формально она есть и соответствующая проверка проваливается.
COMPRESSION_FLAGS_2 += -dHaveTransparency=false
COMPRESSION_FLAGS_2 += -dCompatibilityLevel=1.3

# Разрешение растеризации
# Рекомендуемое разрешение чёрно-белых изображений обычно состовляет 1000..1200dpi. Чтобы обычный текст
# (вероятно, также присутствующий на странице) пострадал минимально - используем аналогичное разрешение,
# несмотря на то, что изображение, получится цветным (раз уж на странице есть иллюстрация).
# Потенциальная проблема: некоторые типографии пугают, что все цветные изображения с разрешением выше
# некоторого будут ресемплированы к более низкому разрешению.
COMPRESSION_FLAGS_2 += -r1200

# Замена всех шрифтов на кривые
# Если установлено true - весь текст перестанет выделяться, размер файла увеличивается. Может быть решением,
# если какой-либо шрифт невозможно вложить из-за ограничений лицензии. Но и без этого может быть
# рекомендованным вариантом для некоторых типографий. Не то же самое, что растеризация.
COMPRESSION_FLAGS_2 += -dNoOutputFonts=false

# RGB -> CMYK
# Типография может требовать файл "в CMYK", или пугать что RGB напечатается непредсказуемым образом.
# Кроме палитры DeviceCMYK в выходном pdf остаётся также палитра DeviceGRAY.
COMPRESSION_FLAGS_2 += -dProcessColorModel=/DeviceCMYK
COMPRESSION_FLAGS_2 += -sColorConversionStrategy=CMYK

# Из-за преобразования цвета к CMYK, изображения требуется пережать. Для типографии представляется логичным
# cжимать изображения без потерь и снижения разрешения, если файл получается не слишком большой.
COMPRESSION_FLAGS_2 += -dDownsampleColorImages=false
# COMPRESSION_FLAGS_2 += -dColorImageResolution=300
# COMPRESSION_FLAGS_2 += -dColorImageDownsampleThreshold=1.5
# COMPRESSION_FLAGS_2 += -dColorImageDownsampleType=/Average
COMPRESSION_FLAGS_2 += -dAutoFilterColorImages=false
COMPRESSION_FLAGS_2 += -dColorImageFilter=/FlateEncode   # /FlateEncode = zip, lossless

COMPRESSION_FLAGS_2 += -dDownsampleGrayImages=false
# COMPRESSION_FLAGS_2 += -dGrayImageResolution=300
# COMPRESSION_FLAGS_2 += -dGrayImageDownsampleThreshold=1.5
# COMPRESSION_FLAGS_2 += -dGrayImageDownsampleType=/Bicubic
COMPRESSION_FLAGS_2 += -dAutoFilterGrayImages=false
COMPRESSION_FLAGS_2 += -dGrayImageFilter=/FlateEncode

COMPRESSION_FLAGS_2 += -dDownsampleMonoImages=false
# COMPRESSION_FLAGS_2 += -dMonoImageResolution=1200
# COMPRESSION_FLAGS_2 += -dMonoImageDownsampleThreshold=1.5
# COMPRESSION_FLAGS_2 += -dMonoImageDownsampleType=/Subsample
COMPRESSION_FLAGS_2 += -dAutoFilterMonoImages=false
COMPRESSION_FLAGS_2 += -dMonoImageFilter=/FlateEncode

# Для pdf вывода Ghostscript поддерживает лишь достаточно ограниченный функционал управления цветом.
#  * Из всего, что описано в https://www.ghostscript.com/doc/9.26/GS9_Color_Management.pdf ,
#    фактически на преобразование значений цветов влияет только sDefaultRGBProfile. Плюс, при сборке
#    PDF/X-3 есть возможность вложить Output Intent ICC профиль (но это уже следующее преобразование).
#  * DefaultGrayProfile, sDefaultCMYKProfile не влияют, т.к. соответствующие цвета не преобразуются.
#    sOutputICCProfile, dRenderIntent, dUseFastColor и т.п. тоже не работают.
#
# Печатное пространство цвета почти всегда уже sRGB (в котором, вероятно, хранятся ваши изображения).
# Используемое gs "по умолчанию" преобразование к CMYK приводит к "обрезанию" наиболее насыщенных цветов.
# Например, как RGB(255,0,0), так и RGB(240,0,0) переходят в CMYK(0,1,1,0). Различимость цветов может
# ухудшаться/теряться - имеет смысл перепроверить сложные места после конвертации. В среднем случае ничего
# критичного происходить не должно.
#
# Если необходимо аккуратное управление цветом - остаётся вариант растеризации в tiff `-sDEVICE=tiff32nc`,
# или использования ICCBased цветов `-sColorConversionStrategy=UseDeviceIndependentColor`. И тот и другой
# вариант следует заранее согласовать с типографией (если Вы понимаете зачем оно Вам - наверное Вы знаете
# что делаете).
#
# COMPRESSION_FLAGS_2 += -I.  # разрешает подгружать файлы профилей из текущей папки
# COMPRESSION_FLAGS_2 += -sDefaultRGBProfile="default_rgb.icc"


##! сжатие файла с конвертацией в CMYK
compress-cmyk:
	$(MSYS_FIX) gs $(COMPRESSION_FLAGS_2) \
		-sOutputFile=$(basename $(COMPRESS_FILE))_cmyk.pdf \
		$(basename $(COMPRESS_FILE)).pdf

.PHONY: compress-lowdpi compress-cmyk
