import re
import pytest

"""
Configuration for PDF test cases module.
"""


def pytest_addoption(parser):
    """
    We add the --pdf and --type options to be able to
    specify the PDF filename and type.
    """
    parser.addoption("--pdf", action="store", default=None, help="filename")
    parser.addoption(
        "--type", action="store", default=None, help="type of file"
    )


@pytest.fixture(scope="session")
def pdf(request):
    """
    Make sure that the PDF filename is available.
    """
    return request.config.getoption("--pdf")


@pytest.fixture(scope="session")
def pdf_type(request):
    """
    PDF type. dissertation or synopsis
    """
    file_type = request.config.getoption("--type")
    if file_type is None:
        file_name = request.config.getoption("--pdf")
        file_type = re.search(r"^([a-z]+)", file_name).groups()[0]
    return file_type
