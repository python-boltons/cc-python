MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.SUFFIXES:

ACT := build/go/work/bin/act
ALL_TEST_CONFIGS := $(shell ls test-configs | xargs -I '{}'  basename '{}' .yml)
GO := build/go/bin/go
PIP := source $(VENV)/bin/activate; python -m pip
PYTHON ?= source $(VENV)/bin/activate; python
VENV := .venv
VENV_ACTIVATE := $(VENV)/bin/activate

.PHONY: help
help:  ## Print this message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: test
test: test-make test-act  ## Runs tests by generating projects using this cookiecutter.

.PHONY: test-make
test-make:  $(foreach TEST_CONFIG,$(ALL_TEST_CONFIGS),test-make-$(TEST_CONFIG))  ## Run all tests using 'make'.

test-make-%: $(VENV_ACTIVATE)
	$(PYTHON) -m cruft create --config-file test-configs/$*.yml --output-dir build --no-input --overwrite-if-exists .
	cd build/$* && make all

.PHONY: test-make
test-act:  $(foreach TEST_CONFIG,$(ALL_TEST_CONFIGS),test-act-$(TEST_CONFIG))  ## Run all tests using 'act'.

# TODO: Factor out cruft command into function.
test-act-%: $(VENV_ACTIVATE) $(ACT)
	$(PYTHON) -m cruft create --config-file test-configs/$*.yml --output-dir build --no-input --overwrite-if-exists .


$(ACT): $(GO)
	GO111MODULE=on GOROOT=$(PWD)/build/go GOPATH=$(PWD)/build/go/work $(GO) install github.com/nektos/act@latest

$(GO):
	[[ -d build ]] || mkdir build
	cd build && curl -O https://dl.google.com/go/go1.16.8.linux-amd64.tar.gz && tar xvf go1.16.8.linux-amd64.tar.gz

$(VENV_ACTIVATE):
	python3 -m venv $(VENV)
	$(PIP) install -U -r requirements-dev.in

.PHONY: clean
clean:  ## Remove all build, test, coverage and Python artifacts.
	rm -rf build $(VENV)
