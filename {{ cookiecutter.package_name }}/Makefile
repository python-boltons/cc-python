.DELETE_ON_ERROR:
.SHELLFLAGS := -eu -o pipefail -c
.SUFFIXES:
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

MAKE_CMD := docker volume create docker-python-cache; docker-compose run --rm {{ cookiecutter.package_name }} make -f targets.mk

.DEFAULT:
	$(MAKE_CMD) $@

.PHONY: help
help:  ## Print this message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' targets.mk $(MAKEFILE_LIST) | sort
