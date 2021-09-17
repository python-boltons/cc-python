# {{ cookiecutter.package_name }}

**{{ cookiecutter.package_description }}**

[![CI Workflow](https://github.com/bbugyi200/{{ cookiecutter.git_repo_name }}/actions/workflows/ci.yml/badge.svg)](https://github.com/bbugyi200/{{ cookiecutter.git_repo_name }}/actions/workflows/ci.yml)
[![Coverage](https://codecov.io/gh/bbugyi200/{{ cookiecutter.git_repo_name }}/branch/master/graph/badge.svg)](https://codecov.io/gh/bbugyi200/{{ cookiecutter.git_repo_name }})
[![Documentation](https://img.shields.io/badge/documentation-RTD-ffa500)](https://{{ cookiecutter.package_name }}.readthedocs.io/en/latest/)
[![Project Version](https://img.shields.io/pypi/v/{{ cookiecutter.package_name }})](https://pypi.org/project/{{ cookiecutter.package_name }}/)
[![Python Versions](https://img.shields.io/pypi/pyversions/{{ cookiecutter.package_name }})](https://pypi.org/project/{{ cookiecutter.package_name }}/)
[![Package Health](https://snyk.io/advisor/python/{{ cookiecutter.package_name }}/badge.svg)](https://snyk.io/advisor/python/{{ cookiecutter.package_name }})

tools / frameworks used by test suite:

[![Framework: pytest](https://img.shields.io/badge/framework-pytest-28ce4a)](https://github.com/pytest-dev/pytest)
[![Framework: doctest](https://img.shields.io/badge/framework-doctest-28ce4a)](https://docs.python.org/3/library/doctest.html)
[![Runner: tox](https://img.shields.io/badge/runner-tox-ffffff)](https://github.com/tox-dev/tox)
[![Types: typeguard](https://img.shields.io/badge/types-typeguard-800080)](https://github.com/agronholm/typeguard)

linters used by CI:

[![Linter: pylint](https://img.shields.io/badge/linter-pylint-ffff00)](https://github.com/PyCQA/pylint)
[![Linter: flake8](https://img.shields.io/badge/linter-flake8-008080)](https://github.com/PyCQA/flake8)
[![Types: mypy](https://img.shields.io/badge/types-mypy-cd00cd)](https://github.com/python/mypy)
[![Docstrings: pydocstyle](https://img.shields.io/badge/docstrings-pydocstyle-AFD3E6)](https://github.com/PyCQA/pydocstyle)
[![Code Style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Imports: isort](https://img.shields.io/badge/imports-isort-ef8336)](https://github.com/PyCQA/isort)

## Generic [cc-python](https://github.com/bbugyi200/cc-python) Documentation

### 🔢 Basic Usage

Before making a PR please run the following

* Optional one time setup: run `make use-docker` if you need to build/test this with docker
* `make lint` to check for any format or convention issues
* `make test` to run all tests

### ❓ How do I ...?

<details><summary>🔧 See available make targets</summary>

To see available make targets, simply run `make`.

</details>

<details><summary>🐳 Switch to and from using Docker</summary>

To start using Docker, run `make use-docker`. Every subsequent make command you run will then be run inside the associated container whenever appropriate.

To stop using Docker, run `make remove-docker`. Every subsequent make command you run will then be run inside your native virtual environment whenever appropriate.

</details>

<details><summary>🛠 Add a new pip dependency</summary>

New dependencies need to be added to `requirements.in`. Your `requirements.txt` will then automatically be updated to reflect those changes the next time a relevant make target is run. Alternatively, you can run `make update-requirements`.

Note:
* Before any make command is run, requirements are synced so that the development environment matches your `requirements.txt` exactly i.e. extra packages that are not present in the `requirements.txt` are removed and any missing packages are installed. This helps providing a consistent environment across platforms, and ensures that whenever requirements change, only minimal updates are performed.
* Check out [pip-tools](https://github.com/jazzband/pip-tools#pip-tools--pip-compile--pip-sync) for more information.

</details>

<details><summary>🙈 Ignore linting violations</summary>

For [flake8](https://flake8.pycqa.org/en/latest/user/configuration.html#configuration-locations) [violations](https://wemake-python-stylegui.de/en/latest/pages/usage/violations/index.html), you can:
* ignore a rule for a single line of code using a `#noqa` comment e.g.
```python
x = 1 # noqa: WPS111
```
* [ignore](https://flake8.pycqa.org/en/latest/user/violations.html#in-line-ignoring-errors) a rule for an entire file by adding it to `flake8.per-file-ignores` inside `setup.cfg`.
* [exclude](https://flake8.pycqa.org/en/latest/user/violations.html#ignoring-entire-files) an entire file from flake8 checks by adding it to `flake8.exclude` inside `setup.cfg`.
* ignore a rule for all files by adding it to the `flake8.ignore` list inside `setup.cfg`.

For [mypy](https://mypy.readthedocs.io/en/stable/config_file.html#the-mypy-configuration-file) violations, you can:
* [ignore](https://mypy.readthedocs.io/en/stable/common_issues.html#spurious-errors-and-locally-silencing-the-checker) type checking for a single line of code using a `# type: ignore` comment.
* [ignore](https://mypy.readthedocs.io/en/stable/common_issues.html#ignoring-a-whole-file) type checking for an entire file by putting a `# type: ignore` comment at the top of a module (before any statements, including imports or docstrings).

For [pydocstyle](http://www.pydocstyle.org/en/5.0.1/usage.html#configuration-files) violations, you can:
* [ignore](http://www.pydocstyle.org/en/5.0.1/usage.html#in-file-configuration) a rule for a single line of code using a `# noqa` comment (this can be combined with flake8 exclusions).
* exclude an entire file from pydocstyle checks by excluding it from `pydocstyle.match` inside `setup.cfg`.
* ignore a rule for all files by adding it to the `pydocstyle.ignore` list inside `setup.cfg`.

For [coverage](https://coverage.readthedocs.io/en/v4.5.x/config.html#) violations, you can:
* [exclude](http://www.pydocstyle.org/en/5.0.1/usage.html#in-file-configuration) a single line of code using a `# pragma: no cover` comment.
* [exclude](https://coverage.readthedocs.io/en/v4.5.x/source.html#specifying-source-files) an entire file from coverage checks by adding it to the `coverage:run.omit` list inside `setup.cfg`.
* [exclude](https://coverage.readthedocs.io/en/v4.5.x/excluding.html#advanced-exclusion) all lines matching a given pattern by adding it to the `coverage:report.exclude_lines` list inside `setup.cfg`.

</details>

<details><summary>🧪 Run specific tests</summary>

First, get a shell inside your development environment by running `make dev-shell`.

You can then use the pytest `-k` option to select tests based on their names, e.g.
```bash
python -m pytest -k "included_test"
```
You can also use "and", "or" and "not" keywords e.g.
```bash
python -m pytest -k "included_test or not excluded"
```

</details>

<details><summary>📄 Build and view docs from a local version</summary>

You can generate docs locally by running `make build-docs`.
You can then see the generated docs by running
```bash
cd docs/build
python -m http.server
```
and going to http://localhost:8000/

</details>

<details><summary>🍪 Update my project to match the cookiecutter which generated it</summary>

This project is enabled with `cruft` to be able to update the template with any improvements made in the cc-python cookie cutter which generated it.

* `make check-cc` will report if this project is up to date or out of sync with the cookiecutter.
* `make update-cc` will update this project to be in sync with the cc-python-project cookiecutter. This can give improvements or new features which are added to the template after this project was created. Note one should do this on a clean branch. After running this it is a good idea to run `make all` to rebuild everything and ensure things still work after the update.

</details>
