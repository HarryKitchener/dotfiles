DOTFILES_DIR := $(shell pwd)
.DEFAULT_GOAL := help

.PHONY: help install link brew-install update brew-dump list macos

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: brew-install link ## Full install: brew packages + symlinks

link: ## Create all symlinks (backs up existing files)
	@bash install.sh link

brew-install: ## Install all packages from Brewfile
	@brew bundle install --file=$(DOTFILES_DIR)/Brewfile

update: ## Pull latest dotfiles and re-link
	@git pull origin main && bash install.sh link

brew-dump: ## Regenerate Brewfile from currently installed packages
	@brew bundle dump --force --file=$(DOTFILES_DIR)/Brewfile
	@echo "Brewfile updated."

list: ## Show symlink status
	@bash install.sh list

macos: ## Apply macOS system defaults (requires restart for some)
	@bash macos/defaults.sh
