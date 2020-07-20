GO    := GO111MODULE=on go
pkgs   = $(shell $(GO) list)

PREFIX                  ?= $(shell pwd)

all: format build

format:
	@echo ">> formatting code"
	@$(GO) fmt $(pkgs)

build:
	@echo ">> building binaries"
	@GOOS=$(shell uname -s | tr A-Z a-z) \
		GOARCH=$(subst x86_64,amd64,$(patsubst i%86,386,$(shell uname -m)))
	@$(GO) build $(PREFIX)

.PHONY: all format build

clean :
	rm kafka_exporter