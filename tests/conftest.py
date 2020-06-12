"""
CLI опции для pytest.
"""

import re
import pytest


def pytest_addoption(parser):
    """
    Добавление опций. Опция --pdf является обязательной.
    """
    parser.addoption("--pdf", action="store", default=None,
                     help="путь к pdf файлу (обязательно)")
    parser.addoption("--type", action="store", default=None,
                     help="""тип файла dissertation/synopsis/presentation""")
    parser.addoption("--engine", action="store", default=None,
                     help="""движок pdflatex/xelatex/lualatex""")
    parser.addoption("--drafton", action="store", default=None,
                     help="""файл в режиме черновика (yes|no)""")
    parser.addoption("--showmarkup", action="store", default=None,
                     help="""файл с командами рецензирования (yes|no)""")
    parser.addoption("--fontfamily", action="store", default=None,
                     help="""семейство шрифтов (cmu|liberation|msf|cm|pscyr|xcharter)""")
    parser.addoption("--usebiber", action="store", default=None,
                     help="""для сборки использовался biber (yes|no)""")
    parser.addoption("--usefootcite", action="store", default=None,
                     help="""подстрочные ссылки (yes|no)""")
    parser.addoption("--bibgrouped", action="store", default=None,
                     help="""группировка источников (yes|no)""")


@pytest.fixture(scope="session")
def option_pdf(request):
    """
    Файл pdf.
    """
    file_path = request.config.getoption("--pdf")
    assert(file_path)
    return file_path


@pytest.fixture(scope="session")
def option_type(request):
    """
    Тип файла. dissertation|synopsis|presentation
    """
    opt = request.config.getoption("--type")
    if opt is None:
        filename = request.config.getoption("--pdf")
        if re.search(r"diss?er", filename) is not None:
            opt = "dissertation"
        elif re.search(r"s[yi]nop", filename) is not None:
            opt = "synopsis"
        elif re.search(r"pr[ei]sent", filename) is not None:
            opt = "presentation"
    assert(opt)
    return opt


@pytest.fixture(scope="session")
def check_dissertation(option_type):
    if option_type != "dissertation":
        pytest.skip("файл не является диссертацией")


@pytest.fixture(scope="session")
def check_synopsis(option_type):
    if option_type != "synopsis":
        pytest.skip("файл не является авторефератом")


@pytest.fixture(scope="session")
def check_presentation(option_type):
    if option_type != "presentation":
        pytest.skip("файл не является презентацией")


@pytest.fixture(scope="session")
def check_not_presentation(option_type):
    if option_type == "presentation":
        pytest.skip("файл является презентацией")


@pytest.fixture(scope="session")
def option_engine(request):
    """
    Движок. pdflatex|xelatex|lualatex
    """
    file_engine = request.config.getoption("--engine")
    if file_engine is None:
        filename = request.config.getoption("--pdf")
        for name in [r"pdflatex", r"xelatex", r"lualatex"]:
            if re.search(name, filename) is not None:
                return name
    assert(file_engine)
    return file_engine


@pytest.fixture(scope="session")
def check_pdflatex(option_engine):
    if option_type != "pdflatex":
        pytest.skip("файл собран не при помощи pdflatex")


@pytest.fixture(scope="session")
def check_xelatex(option_engine):
    if option_type != "xelatex":
        pytest.skip("файл собран не при помощи xelatex")


@pytest.fixture(scope="session")
def check_lualatex(option_engine):
    if option_type != "lualatex":
        pytest.skip("файл собран не при помощи lualatex")


@pytest.fixture(scope="session")
def check_not_pdflatex(option_engine):
    if option_type == "pdflatex":
        pytest.skip("файл собран при помощи pdflatex")


@pytest.fixture(scope="session")
def option_drafton(request):
    """
    Опция drafton.
    """
    opt = request.config.getoption("--drafton")
    if opt is None:
        return re.search(r"draft",
                         request.config.getoption("--pdf")) is not None
    return opt == "yes"


@pytest.fixture(scope="session")
def check_draft(option_drafton):
    if not option_drafton:
        pytest.skip("файл не черновик")


@pytest.fixture(scope="session")
def check_not_draft(option_drafton):
    if option_drafton:
        pytest.skip("файл черновик")


@pytest.fixture(scope="session")
def option_showmarkup(request):
    """
    Опция showmarkup.
    """
    opt = request.config.getoption("--showmarkup")
    if opt is None:
        return re.search(r"markup",
                         request.config.getoption("--pdf")) is not None
    return opt == "yes"


@pytest.fixture(scope="session")
def check_showmarkup(option_showmarkup):
    if not option_showmarkup:
        pytest.skip("файл собран без команд рецензирования")


@pytest.fixture(scope="session")
def check_not_showmarkup(option_showmarkup):
    if option_showmarkup:
        pytest.skip("файл собран с командами рецензирования")


@pytest.fixture(scope="session")
def option_usebibier(request):
    """
    Опция usebibier.
    """
    opt = request.config.getoption("--usebibier")
    if opt is None:
        return re.search(r"bibier",
                         request.config.getoption("--pdf")) is not None
    return opt == "yes"


@pytest.fixture(scope="session")
def check_biber(option_usebiber):
    if not option_usebiber:
        pytest.skip("файл собран при помощи biber")


@pytest.fixture(scope="session")
def check_bibtex(option_usebiber):
    if option_usebiber:
        pytest.skip("файл собран при помощи bibtex")


@pytest.fixture(scope="session")
def option_usefootcite(request):
    """
    Опция usefootcite.
    """
    opt = request.config.getoption("--usefootcite")
    if opt is None:
        return re.search(r"footcite",
                         request.config.getoption("--pdf")) is not None
    return opt == "yes"


@pytest.fixture(scope="session")
def check_footcite(option_usefootcite):
    if not option_usefootcite:
        pytest.skip("в файле не используются подстрочные ссылки")


@pytest.fixture(scope="session")
def check_not_footcite(option_usefootcite):
    if option_usefootcite:
        pytest.skip("в файле используются подстрочные ссылки")


@pytest.fixture(scope="session")
def option_bibgrouped(request):
    """
    Опция bibgrouped.
    """
    opt = request.config.getoption("--bibgrouped")
    if opt is None:
        return re.search(r"bibgrouped",
                         request.config.getoption("--pdf")) is not None
    return opt == "yes"


@pytest.fixture(scope="session")
def check_bibgrouped(option_bibgrouped):
    if not option_bibgrouped:
        pytest.skip("в файле ссылки не сгруппированы")


@pytest.fixture(scope="session")
def check_not_bibgrouped(option_bibgrouped):
    if option_bibgrouped:
        pytest.skip("в файле ссылки сгруппированы")


@pytest.fixture(scope="session")
def option_fontfamily(request):
    """
    Опция fontfamily.
    """
    opt = request.config.getoption("--fontfamily")
    if opt is None:
        filename = request.config.getoption("--pdf")
        for name in [r"cmu", r"liberation", r"msf", r"cm", r"pscyr", r"xcharter"]:
            if re.search(name, filename) is not None:
                return name
    return "unknown"


@pytest.fixture(scope="session")
def check_font(option_fontfamily):
    if option_fontfamily == "unknown":
        pytest.skip("семейство шрифтов не указано")


@pytest.fixture(scope="session")
def check_font_cmu(option_fontfamily):
    if option_fontfamily != "cmu":
        pytest.skip("в файле используется не cmu")


@pytest.fixture(scope="session")
def check_font_liberation(option_fontfamily):
    if option_fontfamily != "liberation":
        pytest.skip("в файле используется не liberation")


@pytest.fixture(scope="session")
def check_font_msf(option_fontfamily):
    if option_fontfamily != "msf":
        pytest.skip("в файле используется не msf")


@pytest.fixture(scope="session")
def check_font_cm(option_fontfamily):
    if option_fontfamily != "cm":
        pytest.skip("в файле используется не cm")


@pytest.fixture(scope="session")
def check_font_pscyr(option_fontfamily):
    if option_fontfamily != "pscyr":
        pytest.skip("в файле используется не pscyr")


@pytest.fixture(scope="session")
def check_font_xcharter(option_fontfamily):
    if option_fontfamily != "xcharter":
        pytest.skip("в файле используется не xcharter")
