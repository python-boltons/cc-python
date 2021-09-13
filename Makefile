MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.SUFFIXES:

VENV := .venv
VENV_ACTIVATE := $(VENV)/bin/activate

PYTHON ?= source $(VENV)/bin/activate; python
PIP := source $(VENV)/bin/activate; python -m pip
ALL_TEST_CONFIGS := $(shell ls test-configs | xargs -I '{}'  basename '{}' .yml)

.PHONY: help
help:  ## Print this message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: test
test: $(foreach TEST_CONFIG,$(ALL_TEST_CONFIGS),test-$(TEST_CONFIG))  ## Runs tests by generating projects using this cookiecutter.

test-%: $(VENV_ACTIVATE)
	$(PYTHON) -m cruft create --config-file test-configs/$*.yml --output-dir build --no-input --overwrite-if-exists .
	cd build/$* && make all

$(VENV_ACTIVATE):
	python3 -m venv $(VENV)
	$(PIP) install -U -r requirements-dev.in

.PHONY: clean
clean:  ## Remove all build, test, coverage and Python artifacts.
	rm -rf build $(VENV)
