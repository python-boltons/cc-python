import glob
from pathlib import Path
from typing import Iterator, List

from setuptools import find_namespace_packages, setup


DESCRIPTION = "{{ cookiecutter.package_description }}"
SUPPORTED_PYTHON_VERSIONS = [(3,), (3, 7), (3, 8), (3, 9)]


def long_description() -> str:
    return Path("README.md").read_text()


def install_requires() -> List[str]:
    return list(_requires("requirements.in"))


def tests_require() -> List[str]:
    return list(_requires("requirements-dev.in"))


def _requires(reqtxt_basename: str) -> Iterator[str]:
    reqtxt = Path(__file__).parent / reqtxt_basename
    reqs = reqtxt.read_text().split("\n")
    for req in reqs:
        if not req or req.lstrip().startswith(("#", "-")):
            continue
        yield req


setup(
    author="{{ cookiecutter.author }}",
    author_email="{{ cookiecutter.email }}",
    python_requires=">=3.7",
    install_requires=install_requires(),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English",
    ]
    + [
        f"Programming Language :: Python :: {pyver_string}"
        for pyver_string in [
            f"{'.'.join(str(version_part) for version_part in pyver_tuple)}"
            for pyver_tuple in SUPPORTED_PYTHON_VERSIONS
        ]
    ],
    description=DESCRIPTION,
    {%- if cookiecutter.package_type == "application" %}
    entry_points={
        "console_scripts": [
            "{{ cookiecutter.package_name }} = {{ cookiecutter.package_name }}.cli:main",
        ]
    },
    {%- endif %}
    scripts=glob.glob("scripts/*"),
    license="MIT license",
    long_description=long_description(),
    long_description_content_type="text/markdown",
    include_package_data=True,
    name="{{ cookiecutter.pypi_package_name }}",
    package_dir={"": "src"},
    packages=find_namespace_packages(where="src"),
    test_suite="tests",
    tests_require=tests_require(),
    url="https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}",
    use_scm_version={"fallback_version": "0.0.1"},
    zip_safe=False,
)
