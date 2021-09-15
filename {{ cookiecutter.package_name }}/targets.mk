PIP = $(PYTHON) -m pip
PIP_COMPILE = $(PYTHON) -m piptools compile --allow-unsafe --no-emit-index-url -q --no-emit-trusted-host
PIP_SYNC = $(PYTHON) -m piptools sync
PYTHON = $(SOURCE_VENV) PYTHONPATH=$(PWD)/src:$(PYTHONPATH) python
PYTHONPATH ?=
SOURCE_VENV = source $(VENV_ACTIVATE);
TOX = $(SOURCE_VENV) tox
VENV := .venv
VENV_ACTIVATE = $(VENV)/bin/activate

.PHONY: all
all: lint test  ## Run all tests and linters.

.PHONY: lint
lint: black isort pydocstyle flake8 mypy pylint ## Run all linting checks.

.PHONY: black
black: sync-dev-requirements  ## Run black checks.
	$(PYTHON) -m black --check src
	$(PYTHON) -m black --check tests

.PHONY: isort
isort: sync-dev-requirements  ## Run isort checks. 
	$(PYTHON) -m isort --check-only src
	$(PYTHON) -m isort --check-only tests

.PHONY: pydocstyle
pydocstyle:  sync-dev-requirements  ## Run pydocstyle checks.
	$(PYTHON) -m pydocstyle src
	$(PYTHON) -m pydocstyle tests

.PHONY: flake8
flake8: sync-dev-requirements  ## Run flake8 checks.
	$(PYTHON) -m flake8 src
	$(PYTHON) -m flake8 tests

.PHONY: mypy
mypy: sync-dev-requirements  ## Run mypy checks.
	$(PYTHON) -m mypy src
	$(PYTHON) -m mypy tests

.PHONY: pylint
pylint: sync-dev-requirements  ## Run pylint checks.
	$(PYTHON) -m pylint src
	$(PYTHON) -m pylint tests

.PHONY: test
test:  sync-dev-requirements  ## Run this project's test suite.
	$(TOX) -e py -- \
		-vv \
		--cov \
		--cov-fail-under=80 \
		--cov-branch \
		--doctest-modules \
		--doctest-report ndiff

$(VENV_ACTIVATE):
	python3 -m venv $(VENV)
	$(PIP) install -U pip pip-tools

requirements%.txt: export CUSTOM_COMPILE_COMMAND="make update-requirements"
requirements%.txt: $(VENV_ACTIVATE)
	$(PIP_COMPILE) --output-file=requirements-dev.txt requirements.in requirements-dev.in
	$(PIP_COMPILE) --output-file=requirements.txt requirements.in

.PHONY: sync-dev-requirements
sync-dev-requirements: requirements-dev.txt
	$(PIP_SYNC) requirements-dev.txt

.PHONY: update-requirements
update-requirements: export CUSTOM_COMPILE_COMMAND="make update-requirements"
update-requirements: ## Update all requirements to latest versions.
update-requirements: $(VENV_ACTIVATE)
	$(PIP_COMPILE) --upgrade --output-file=requirements-dev.txt requirements.in requirements-dev.in
	$(PIP_COMPILE) --upgrade --output-file=requirements.txt requirements.in
	make sync-dev-requirements
