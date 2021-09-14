.DELETE_ON_ERROR:
.SHELLFLAGS := -eu -o pipefail -c
.SUFFIXES:
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

PIP = $(PYTHON) -m pip
PYTHON = $(SOURCE_VENV) PYTHONPATH=$(PWD)/src:$(PYTHONPATH) python
PYTHONPATH ?=
SOURCE_VENV = source $(VENV_ACTIVATE);
TOX = $(SOURCE_VENV) tox
VENV := .venv
VENV_ACTIVATE = $(VENV)/bin/activate

.PHONY: help
help:  ## Print this message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: all
all: lint test  ## Run all tests and linters.

.PHONY: lint
lint: black isort pydocstyle flake8 mypy pylint ## Run all linting checks.

.PHONY: black
black: $(VENV_ACTIVATE)  ## Run black checks.
	$(PYTHON) -m black --check src
	$(PYTHON) -m black --check tests

.PHONY: isort
isort: $(VENV_ACTIVATE)  ## Run isort checks. 
	$(PYTHON) -m isort --check-only src
	$(PYTHON) -m isort --check-only tests

.PHONY: pydocstyle
pydocstyle:  $(VENV_ACTIVATE)  ## Run pydocstyle checks.
	$(PYTHON) -m pydocstyle src
	$(PYTHON) -m pydocstyle tests

.PHONY: flake8
flake8: $(VENV_ACTIVATE)  ## Run flake8 checks.
	$(PYTHON) -m flake8 src
	$(PYTHON) -m flake8 tests

.PHONY: mypy
mypy: $(VENV_ACTIVATE)  ## Run mypy checks.
	$(PYTHON) -m mypy src
	$(PYTHON) -m mypy tests

.PHONY: pylint
pylint: $(VENV_ACTIVATE)  ## Run pylint checks.
	$(PYTHON) -m pylint src
	$(PYTHON) -m pylint tests

.PHONY: test
test:  $(VENV_ACTIVATE)  ## Run this project's test suite.
	$(TOX) -e py -- \
		-vv \
		--cov \
		--cov-fail-under=80 \
		--cov-branch \
		--doctest-modules \
		--doctest-report ndiff

$(VENV_ACTIVATE):
	python3 -m venv $(VENV)
	$(PIP) install -U -r requirements-dev.in
