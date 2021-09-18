.DELETE_ON_ERROR:
.SHELLFLAGS := -eu -o pipefail -c
.SUFFIXES:
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

ALL_TEST_CONFIGS := $(shell ls test-configs | xargs -I '{}'  basename '{}' .yml)
GO := $(PWD)/build/go/bin/go
PIP = $(SOURCE_VENV) python -m pip
PYTHON = $(SOURCE_VENV) python
SOURCE_VENV = source $(VENV_ACTIVATE);
USER ?= test_user
VENV := .venv
VENV_ACTIVATE = $(VENV)/bin/activate

.PHONY: help
help:  ## Print this message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: test
test:  $(foreach TEST_CONFIG,$(ALL_TEST_CONFIGS),test-$(TEST_CONFIG))  ## Runs tests by generating projects using this cookiecutter.

test-%: export CC_REPO_URL=https://github.com/bbugyi200/cc-python
test-%: export TEST_USER=$(USER)
test-%: $(VENV_ACTIVATE)
	$(RM) -rf build/$*/requirements*.txt
	$(PYTHON) -m cruft create --config-file test-configs/$*.yml --output-dir build --no-input --overwrite-if-exists .
	cd build/$* && make use-docker && make all && make check-requirements && make check-cc

$(VENV_ACTIVATE):
	python3 -m venv $(VENV)
	$(PIP) install -U -r requirements-dev.in

.PHONY: clean
clean:  ## Remove all build, test, coverage and Python artifacts.
	ITEMS=(build $(VENV)); \
		  sudo -v && sudo rm -rf $$ITEMS[@] || rm -rf $$ITEMS[@]
