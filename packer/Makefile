# BUILDER to use, must be present in [platform].json
BUILDER ?= virtualbox-iso
# relevant if using qemu
export ACCELERATOR ?= kvm
# primary disk size
export DISK_SIZE ?= 25000
# which config to build
platform := ubuntu
# enable debug logging
DEBUG ?= 0

git_hash := $(shell git rev-parse --short HEAD)
dirty := $(if $(shell git status --porcelain),-dirty)
tag := $(git_hash)$(dirty)

ifeq ($(BUILDER), qemu)
	output_ext := .qcow2
endif

ifeq ($(BUILDER), virtualbox-iso)
	output_ext := .ovf
endif

vm_name := $(platform)
output_name := $(vm_name)$(output_ext)

.DEFAULT_GOAL := build

.PHONY: build
build: build/$(output_name)

.PHONY: clean
clean:
	rm -rf ./output-* ./build *.box

build/$(output_name):
	PACKER_LOG=$(DEBUG) packer build -force -only=$(BUILDER) \
						-var 'vm_name=$(output_name)' \
						-var 'git_tag=$(tag)' \
						$(platform).json
