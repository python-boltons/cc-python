.DELETE_ON_ERROR:
.SHELLFLAGS := -eu -o pipefail -c
.SUFFIXES:
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

ACT := $(PWD)/build/go/work/bin/act
ALL_TEST_CONFIGS := $(shell ls test-configs | xargs -I '{}'  basename '{}' .yml)
GO := $(PWD)/build/go/bin/go
PIP = $(SOURCE_VENV) python -m pip
PYTHON = $(SOURCE_VENV) python
SOURCE_VENV = source $(VENV_ACTIVATE);
VENV := .venv
VENV_ACTIVATE = $(VENV)/bin/activate

define cruft_create
	$(PYTHON) -m cruft create --config-file test-configs/$(1).yml --output-dir build --no-input --overwrite-if-exists .
endef

define init_act_config
	printf -- "-P ubuntu-latest=catthehacker/ubuntu:act-latest\n-P ubuntu-20.04=catthehacker/ubuntu:act-20.04\n-P ubuntu-18.04=catthehacker/ubuntu:act-18.04\nubuntu-16.04=catthehacker/ubuntu:act-16.04" > .actrc
endef

.PHONY: help
help:  ## Print this message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: test
test: test-make test-act  ## Runs tests by generating projects using this cookiecutter.

.PHONY: test-make
test-make:  $(foreach TEST_CONFIG,$(ALL_TEST_CONFIGS),test-make-$(TEST_CONFIG))  ## Run all tests using 'make'.

test-make-%: $(VENV_ACTIVATE)
	$(call cruft_create,$*)
	cd build/$* && make all

.PHONY: test-make
test-act:  $(foreach TEST_CONFIG,$(ALL_TEST_CONFIGS),test-act-$(TEST_CONFIG))  ## Run all tests using 'act'.

test-act-%: $(VENV_ACTIVATE) $(ACT)
	$(call cruft_create,$*)
	cd build/$* && $(call init_act_config) && $(ACT) -j test

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
