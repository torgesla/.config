DOTFILES := $(HOME)/.dotfiles
INSTALL  := bash $(DOTFILES)/install.sh

.PHONY: help install restow delete adopt doctor stow brew

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

install: ## Symlink all packages for this OS (backs up any colliding real files)
	@$(INSTALL) install

restow: ## Re-stow everything (use after moving files inside packages)
	@$(INSTALL) restow

delete: ## Remove all symlinks this repo created (unstow)
	@$(INSTALL) delete

adopt: ## Pull existing real files into the repo, then symlink back (clean tree only)
	@$(INSTALL) adopt

doctor: ## Dry-run: report conflicts without changing anything
	@$(INSTALL) doctor

stow: ## Stow a single package: make stow PKG=nvim
	@$(INSTALL) stow "$(PKG)"

brew: ## Install Homebrew packages from brew/Brewfile
	@$(INSTALL) brew
