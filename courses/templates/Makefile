# Makefile: GitHub repo bootstrap for the dual template
# Requires: gh CLI, git
# Usage:
#   make init        # initialize local git repo
#   make create      # create GitHub repo (PUBLIC=1 for public)
#   make push        # push initial commit and main branch
#   make protect     # set basic branch protections on main
#   make badges      # inject CI badges into README
#   make all         # init + create + push + protect + badges

SHELL := /usr/bin/env bash -euo pipefail

OWNER ?= $(shell gh api user --jq .login 2>/dev/null || echo "")
REPO  ?= $(notdir $(CURDIR))
VISIBILITY := $(if $(PUBLIC),public,private)

all: init create push protect badges

init:
	@if [ ! -d .git ]; then \
	  git init -b main; \
	  git add .; \
	  git commit -m "chore: initial import (C++ + Rust dual template)"; \
	else \
	  echo "Git repo already initialized."; \
	fi

create:
	@gh auth status >/dev/null
	@if gh repo view "$(OWNER)/$(REPO)" >/dev/null 2>&1; then \
	  echo "Repo $(OWNER)/$(REPO) already exists on GitHub."; \
	else \
	  gh repo create "$(OWNER)/$(REPO)" --$(VISIBILITY) --source=. --disable-wiki --disable-issues=false --push=false; \
	fi

push:
	@gh auth status >/dev/null
	@git branch -M main
	@git remote | grep -q origin || git remote add origin "https://github.com/$(OWNER)/$(REPO).git"
	@git push -u origin main

protect:
	@gh auth status >/dev/null
	@echo "Applying branch protection rules to main..."
	@gh api -X PUT "repos/$(OWNER)/$(REPO)/branches/main/protection" \
	  -H "Accept: application/vnd.github+json" \
	  -f required_status_checks.strict=true \
	  -f enforce_admins=true \
	  -f required_pull_request_reviews.dismiss_stale_reviews=true \
	  -f required_pull_request_reviews.required_approving_review_count=1 \
	  -f restrictions= \
	  -F required_status_checks.contexts[]="CI"

badges:
	@echo "Injecting CI badges into README.md..."
	@OWNER="$(OWNER)" REPO="$(REPO)" awk 'BEGIN{owner=ENVIRON["OWNER"]; repo=ENVIRON["REPO"]; badge=sprintf("[![CI](https://github.com/%s/%s/actions/workflows/ci.yml/badge.svg)](https://github.com/%s/%s/actions/workflows/ci.yml)", owner, repo, owner, repo)} \
	/^\# / && !p {print; print ""; print badge; p=1; next} {print}' README.md > README.md.tmp && mv README.md.tmp README.md
	@git add README.md && git commit -m "docs: add CI badge" || true
	@git push

.PHONY: init create push protect badges all
