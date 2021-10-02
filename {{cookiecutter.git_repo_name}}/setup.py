"""setup.py

This project has been packaged and distributed using setuptools[1]. This
project's version is derived from git tags using setuptools-scm[2].

[1]: https://setuptools.pypa.io/en/latest/userguide/quickstart.html
[2]: https://github.com/pypa/setuptools_scm
"""

import glob
from pathlib import Path
from typing import Callable, Iterator, List, Tuple

from setuptools import find_namespace_packages, setup


# Configuration variables that are likely to need changing at some point.
DESCRIPTION = "{{ cookiecutter.package_description }}"
SUPPORTED_PYTHON_VERSIONS = [(3,), (3, 7), (3, 8), (3, 9)]
USE_SCM_VERSION = {"fallback_version": "0.0.1"}


def long_description() -> str:
    """Returns the body of this project's page on PyPI."""
    return Path("README.md").read_text()


def install_requires() -> List[str]:
    """Installation requirements.

    Returns:
        A list of this project's runtime Python dependencies.
    """
    return list(_requires("requirements.in"))


def tests_require() -> List[str]:
    """Test suite requirements.

    Returns:
        A list of the Python dependencies this project requires in order to run
        its test suite.
    """
    return list(_requires("requirements-dev.in"))


def _requires(reqtxt_basename: str) -> Iterator[str]:
    reqtxt = Path(__file__).parent / reqtxt_basename
    reqs = reqtxt.read_text().split("\n")
    for req in reqs:
        if not req or req.lstrip().startswith(("#", "-")):
            continue
        yield req


# Derived variables.
PRETTY_SUPPORTED_PYTHON_VERSIONS = [
    f"{'.'.join(str(v) for v in pyver)}"
    for pyver in sorted(SUPPORTED_PYTHON_VERSIONS)
]
_PYTHON_REQUIRES = PRETTY_SUPPORTED_PYTHON_VERSIONS[0]
PYTHON_REQUIRES = f">={_PYTHON_REQUIRES}"


# The main event...
setup(
    author="{{ cookiecutter.author }}",
    author_email="{{ cookiecutter.email }}",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English",
        "Programming Language :: Python :: 3",
    ]
    + [
        f"Programming Language :: Python :: {pretty_pyver}"
        for pretty_pyver in PRETTY_SUPPORTED_PYTHON_VERSIONS
    ],
    description=DESCRIPTION,
    {%- if cookiecutter.package_type == "application" %}
    entry_points={
        "console_scripts": [
            "{{ cookiecutter.package_name }} = {{ cookiecutter.package_name }}.cli:main",
        ]
    },
    {%- endif %}
    include_package_data=True,
    install_requires=install_requires(),
    license="MIT license",
    long_description=long_description(),
    long_description_content_type="text/markdown",
    name="{{ cookiecutter.pypi_package_name }}",
    package_dir={"": "src"},
    packages=find_namespace_packages(where="src"),
    python_requires=PYTHON_REQUIRES,
    scripts=glob.glob("scripts/*"),
    test_suite="tests",
    tests_require=tests_require(),
    url="https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}",
    use_scm_version=USE_SCM_VERSION,
    zip_safe=False,
)
