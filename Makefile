# Makefile — GitHub Bootstrap (gh-cli)
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eo pipefail -c

ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
CONFIG   := $(ROOT_DIR)/config/repo.env
SCRIPTS  := $(ROOT_DIR)/scripts

include $(CONFIG)

# --- Phony targets ---
.PHONY: all plan init labels milestones project views issues week push bundle clean

all: init

plan:
	@echo "Dry run checks..."
	@command -v gh >/dev/null || (echo "Missing gh CLI"; exit 1)
	@command -v jq >/dev/null || (echo "Missing jq"; exit 1)
	@echo "OWNER=$(OWNER) REPO=$(REPO) PROJECT_TITLE=$(PROJECT_TITLE)"

init: labels milestones project views issues
	@echo "Bootstrap complete ✅"

labels:
	@$(SCRIPTS)/create_labels.sh

milestones:
	@$(SCRIPTS)/create_milestones.sh

project:
	@$(SCRIPTS)/create_project.sh

views:
	@$(SCRIPTS)/create_project_views.sh

issues:
	@$(SCRIPTS)/create_issues.sh

week:
	@$(SCRIPTS)/week_increment.sh

push:
	@git add -A
	@git commit -m "chore: bootstrap sync $$(date -u +'%Y-%m-%dT%H:%M:%SZ')" || true
	@git push || true

bundle:
	@cd .. && zip -r github-setup-bundle.zip $$(basename $(ROOT_DIR))
	@echo "Wrote ../github-setup-bundle.zip"

clean:
	@rm -f ../github-setup-bundle.zip
	@echo "Cleaned artifacts"
