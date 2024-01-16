# {{ cookiecutter.package_name }}

**{{ cookiecutter.package_description }}**

_project status badges:_

[![CI Workflow](https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/actions/workflows/ci.yml)
[![Coverage](https://codecov.io/gh/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/branch/master/graph/badge.svg)](https://codecov.io/gh/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }})
[![Documentation Status](https://readthedocs.org/projects/{{ cookiecutter.read_the_docs_domain }}/badge/?version=latest)](https://{{ cookiecutter.read_the_docs_domain }}.readthedocs.io/en/latest/?badge=latest)
[![Package Health](https://snyk.io/advisor/python/{{ cookiecutter.pypi_package_name }}/badge.svg)](https://snyk.io/advisor/python/{{ cookiecutter.pypi_package_name }})

_version badges:_

[![Project Version](https://img.shields.io/pypi/v/{{ cookiecutter.pypi_package_name }})](https://pypi.org/project/{{ cookiecutter.pypi_package_name }}/)
[![Python Versions](https://img.shields.io/pypi/pyversions/{{ cookiecutter.pypi_package_name }})](https://pypi.org/project/{{ cookiecutter.pypi_package_name }}/)
[![Cookiecutter: cc-python](https://img.shields.io/static/v1?label=cc-python&message=2024.01.15&color=d4aa00&logo=cookiecutter&logoColor=d4aa00)](https://github.com/python-boltons/cc-python)
[![Docker: pythonboltons/main](https://img.shields.io/static/v1?label=pythonboltons%20%2F%20main&message=2021.12.22&color=8ec4ad&logo=docker&logoColor=8ec4ad)](https://github.com/python-boltons/docker-python)


## Installation 🗹
{%- if cookiecutter.package_type == "application" %}

### Using `pipx` to Install (preferred)

This package _could_ be installed using pip like any other Python package (in
fact, see the section below this one for instructions on how to do just that).
Given that we only need this package's entry points, however, we recommend that
[pipx][11] be used instead:

```shell
# install and setup pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# install {{ cookiecutter.package_name }}
pipx install {{ cookiecutter.pypi_package_name }}
```

### Using `pip` to Install
{%- endif %}

To install `{{ cookiecutter.package_name }}` using [pip][9], run the following
commands in your terminal:

``` shell
python3 -m pip install --user {{ cookiecutter.pypi_package_name }}  # install {{ cookiecutter.package_name }}
```

If you don't have pip installed, this [Python installation guide][10] can guide
you through the process.
{%- if cookiecutter.package_type == "application" %}


## Command-Line Interface (CLI)

The output from running `{{ cookiecutter.package_name }} --help` is shown below:

<!-- [[[[[kooky.cog
import subprocess

popen = subprocess.Popen(["{{ cookiecutter.package_name }}", "--help"], stdout=subprocess.PIPE)
stdout, _ = popen.communicate()
print("```", stdout.decode().strip(), "```", sep="\n")
]]]]] -->
<!-- [[[[[end]]]]] -->
{%- endif %}

<!-- [[[[[kooky.cog
from pathlib import Path

lines = Path("./docs/design/design.md").read_text().split("\n")
if any(L.strip() for L in lines):
    fixed_lines = [L.replace("(.", "(./docs/design") if L.startswith("![") else L for L in lines]
    print("## Design Diagrams\n")
    print("\n".join(fixed_lines))
]]]]] -->
<!-- [[[[[end]]]]] -->


## Useful Links 🔗

* [API Reference][3]: A developer's reference of the API exposed by this
  project.
* [cc-python][4]: The [cookiecutter][5] that was used to generate this project.
  Changes made to this cookiecutter are periodically synced with this project
  using [cruft][12].
* [CHANGELOG.md][2]: We use this file to document all notable changes made to
  this project.
* [CONTRIBUTING.md][7]: This document contains guidelines for developers
  interested in contributing to this project.
* [Create a New Issue][13]: Create a new GitHub issue for this project.
* [Documentation][1]: This project's full documentation.


[1]: https://{{ cookiecutter.read_the_docs_domain }}.readthedocs.io/en/latest
[2]: https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/blob/master/CHANGELOG.md
[3]: https://{{ cookiecutter.read_the_docs_domain }}.readthedocs.io/en/latest/modules.html
[4]: https://github.com/python-boltons/cc-python
[5]: https://github.com/cookiecutter/cookiecutter
[6]: https://docs.readthedocs.io/en/stable/
[7]: https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/blob/master/CONTRIBUTING.md
[8]: https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}
[9]: https://pip.pypa.io
[10]: http://docs.python-guide.org/en/latest/starting/installation/
[11]: https://github.com/pypa/pipx
[12]: https://github.com/cruft/cruft
[13]: https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/issues/new/choose
