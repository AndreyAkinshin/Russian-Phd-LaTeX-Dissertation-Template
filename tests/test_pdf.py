from collections import Counter
import re
import fitz
import pytest
import yaml

"""
Тесты для шаблона диссертации.
See https://blog.martisak.se/2020/05/16/latex-test-cases/
"""

# {{{ Setup

@pytest.fixture
def config():
    return yaml.load(open("tests/config.yml"), Loader=yaml.FullLoader)

@pytest.fixture(scope="session")
def pdf(option_pdf):
    """
    Открытие файла для чтения и закрытие в конце работы.
    """
    assert option_pdf
    pdf_document = fitz.open(option_pdf)

    yield pdf_document
    pdf_document.close()

# }}}

# {{{ Helpers

def point_to_mm(point):
    """
    Конвертация point to mm.
    1pt=1/72in
    1in=2.54cm
    """
    return round(point / 72 * 25.4)

def toc_page_range(section, pdf):
    """
    Диапазон страниц для секции оглавления
    """
    pdf_toc = pdf.getToC()
    toc_index, page_from = [
        (i, e[2]) for (i, e) in enumerate(pdf_toc) if e[1].lower() == section.lower()
    ][0]
    page_to = (
        pdf_document.pageCount
        if toc_index == len(pdf_toc)
        else pdf_toc[toc_index + 1][2]
    )
    return range(page_from - 1, page_to - 1)

def _test_links(pdf, label, toc_name):
    """
    Проверка страницы со ссылками
    """
    for page_num in toc_page_range(toc_name, pdf):
        page = pdf.loadPage(page_num)
        for page_num, count in Counter([l["page"] for l in page.links()]).items():
            pg = pdf.loadPage(page_num)
            assert count <= len(pg.searchFor(label, flags=fitz.TEXT_INHIBIT_SPACES))

# }}}

# {{{ Tests

def test_annotations(pdf):
    """
    Проверка наличия аннотаций pdf.
    """
    for pg in pdf:
        annotations = list(pg.annots())
        assert not annotations

@pytest.mark.usefixtures("check_not_presentation", "check_not_draft")
def test_toc(pdf, option_type, config):
    """
    Проверка оглавления.
    """
    assert len(pdf.getToC()) == config[option_type]["toc"]["size"]


@pytest.mark.usefixtures("check_not_presentation")
def test_paper_size(pdf, option_type, config):
    """
    Проверка размера страницы.
    """
    for pg in pdf:
        assert point_to_mm(pg.rect.width) == config[option_type]["paper_size"]["width"]
        assert point_to_mm(pg.rect.height) == config[option_type]["paper_size"]["height"]


@pytest.mark.usefixtures("check_not_presentation")
def test_margin_size(pdf, option_type, config):
    """
    Проверка полей.
    """
    page_width = config[option_type]["paper_size"]["width"]
    page_height = config[option_type]["paper_size"]["height"]
    for pg in pdf:
        block = None
        for b in pg.getText("blocks"):
            rect = fitz.Rect(b[0], b[1], b[2], b[3])
            block = rect if block is None else block.includeRect(rect)
            if block is not None:  # empty page
                assert (
                    point_to_mm(block.top_left.x) >= config[option_type]["margins"]["min_left"]
                )
                assert (
                    point_to_mm(block.top_left.y) >= config[option_type]["margins"]["min_top"]
                )
                assert (page_width - point_to_mm(block.bottom_right.x)) >= config[option_type][
                    "margins"
                ]["min_right"]
                assert (page_height - point_to_mm(block.bottom_right.y)) >= config[
                    option_type
                ]["margins"]["min_top"]


def test_required_text(pdf, option_type, config):
    """
    Проверка наличия ключевых слов в документе.
    """

    for text in config[option_type]["required_text"]:
        hits = 0
        print(f"text = {text}")
        for pg in pdf:
            hits += len(pg.searchFor(text, flags=fitz.TEXT_INHIBIT_SPACES))

        assert hits > 0


def test_page_number(pdf, option_type, config):
    """
    Проверка количества страниц.
    """

    assert (
        config[option_type]["pages"]["min_pages"]
        <= pdf.pageCount
        <= config[option_type]["pages"]["max_pages"]
    )


@pytest.mark.usefixtures("check_not_presentation")
def test_metadata(pdf, option_type, config):
    """
    Проверка метаданных pdf документа.
    """

    metadata_fields = ["author", "title", "subject"]

    for field in metadata_fields:
        assert (
            pdf.metadata.get(field, "").strip()
            == config[option_type]["metadata"].get(field, "").strip()
        )


@pytest.mark.skip("проверка шрифтов не реализована")
def test_fonts():
    """
    Проверка шрифтов.
    """
    assert True  # TODO: добавить тесты


@pytest.mark.usefixtures("check_dissertation")
def test_figure_links(pdf):
    """
    Проверка ссылок на рисунки.
    """
    _test_links(pdf, "Рисунок", "список рисунков")


@pytest.mark.usefixtures("check_dissertation")
def test_table_links(pdf, option_type):
    """
    Проверка ссылок на таблицы.
    """
    _test_links(pdf, "Таблица", "список таблиц")


@pytest.mark.usefixtures("check_dissertation")
def test_bibliography(pdf):
    """
    Проверка нумерации литературы.
    """
    bib_index = 1
    for page_num in toc_page_range("список литературы", pdf):
        page = pdf.loadPage(page_num)
        for block in page.getText("blocks"):
            search = re.search(r"^(\d+)\.", block[4])
            if search is not None:  # page number and section name
                assert bib_index == int(search.groups()[0])
                bib_index += 1

# }}}
