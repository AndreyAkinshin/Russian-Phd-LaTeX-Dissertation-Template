from collections import Counter
import re
import fitz
import pytest
import yaml

"""
Test cases for dissertation template.
See https://blog.martisak.se/2020/05/16/latex-test-cases/
"""


@pytest.fixture
def config():
    return yaml.load(open("tests/config.yml"), Loader=yaml.FullLoader)


@pytest.fixture(scope="session")
def pdf_document(pdf):
    """
    This fixture opens the PDF document for reading,
    and closes the file when the fixture goes out of scope.
    """
    assert pdf
    pdf_document = fitz.open(pdf)

    yield pdf_document
    pdf_document.close()


def point_to_mm(point):
    """
    Convert point to mm.
    1pt=1/72in
    1in=2.54cm
    """
    return round(point / 72 * 25.4)


def toc_page_range(name, pdf_document):
    """
    Get toc section page range
    """
    pdf_toc = pdf_document.getToC()
    toc_index, page_from = [
        (i, e[2]) for (i, e) in enumerate(pdf_toc) if e[1].lower() == name.lower()
    ][0]
    page_to = (
        pdf_document.pageCount
        if toc_index == len(pdf_toc)
        else pdf_toc[toc_index + 1][2]
    )
    return range(page_from - 1, page_to - 1)


def test_annotations(pdf_document):
    """
    Test that there are no annotations.
    """
    for pg in pdf_document:
        annotations = list(pg.annots())
        assert not annotations


def test_toc(pdf_document, pdf_type, config):
    """
    Test that file has table of contents.
    """
    assert len(pdf_document.getToC()) == config[pdf_type]["toc"]["size"]


def test_paper_size(pdf_document, pdf_type, config):
    """
    Test pages paper size.
    """
    for pg in pdf_document:
        assert point_to_mm(pg.rect.width) == config[pdf_type]["paper_size"]["width"]
        assert point_to_mm(pg.rect.height) == config[pdf_type]["paper_size"]["height"]


def test_margin_size(pdf_document, pdf_type, config):
    """
    Test pages paper size.
    """
    page_width = config[pdf_type]["paper_size"]["width"]
    page_height = config[pdf_type]["paper_size"]["height"]
    for pg in pdf_document:
        block = None
        for b in pg.getText("blocks"):
            rect = fitz.Rect(b[0], b[1], b[2], b[3])
            block = rect if block is None else block.includeRect(rect)
        if block is not None:  # empty page
            assert (
                point_to_mm(block.top_left.x) >= config[pdf_type]["margins"]["min_left"]
            )
            assert (
                point_to_mm(block.top_left.y) >= config[pdf_type]["margins"]["min_top"]
            )
            assert (page_width - point_to_mm(block.bottom_right.x)) >= config[pdf_type][
                "margins"
            ]["min_right"]
            assert (page_height - point_to_mm(block.bottom_right.y)) >= config[
                pdf_type
            ]["margins"]["min_top"]


def test_required_text(pdf_document, pdf_type, config):
    """
    Test that each required text is found in the document.
    """

    for text in config[pdf_type]["required_text"]:
        hits = 0
        print(f"text = {text}")
        for pg in pdf_document:
            hits += len(pg.searchFor(text, flags=fitz.TEXT_INHIBIT_SPACES))

        assert hits > 0


def test_page_number(pdf_document, pdf_type, config):
    """
    Test that the number of pages is between
    the minimum and the maximum number of pages.
    """

    assert (
        config[pdf_type]["pages"]["min_pages"]
        <= pdf_document.pageCount
        <= config[pdf_type]["pages"]["max_pages"]
    )


def test_metadata(pdf_document, pdf_type, config):
    """
    For each of the specified fields, check that the result
    is as expected.
    """

    metadata_fields = ["author", "title", "subject"]

    for field in metadata_fields:
        assert (
            pdf_document.metadata.get(field, "").strip()
            == config[pdf_type]["metadata"].get(field, "").strip()
        )


def test_fonts(pdf_document):
    """
    Check that all fonts are extractable. This will at least loop through
    the embedded fonts and check their types.
    """
    assert True  # TODO: add test


def _test_links(pdf_document, label, toc_name):
    """
    Test page with links
    """
    for page_num in toc_page_range(toc_name, pdf_document):
        page = pdf_document.loadPage(page_num)
        for page_num, count in Counter([l["page"] for l in page.links()]).items():
            pg = pdf_document.loadPage(page_num)
            assert count <= len(pg.searchFor(label, flags=fitz.TEXT_INHIBIT_SPACES))


def test_figure_links(pdf_document, pdf_type):
    """
    Check that figure links point to the right locations.
    """
    if pdf_type == "dissertation":
        _test_links(pdf_document, "Рисунок", "список рисунков")


def test_table_links(pdf_document, pdf_type):
    """
    Check that table links point to the right locations.
    """
    if pdf_type == "dissertation":
        _test_links(pdf_document, "Таблица", "список таблиц")


def test_bibliography(pdf_document, pdf_type):
    """
    Check bibliography numeration.
    """
    if pdf_type == "dissertation":
        bib_index = 1
        for page_num in toc_page_range("список литературы", pdf_document):
            page = pdf_document.loadPage(page_num)
            for block in page.getText("blocks"):
                search = re.search(r"^(\d+)\.", block[4])
                if search is not None:  # page number and section name
                    assert bib_index == int(search.groups()[0])
                    bib_index += 1
