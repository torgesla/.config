# Config

Personal dotfiles and configuration files for macOS development environment.

## Table of Contents

- [Quick Start](#quick-start)
- [Setup on New Mac](#setup-on-new-mac)
- [Tools & Configuration](#tools--configuration)
  - [Terminal & Shell](#terminal--shell)
  - [Text Editors](#text-editors)
  - [Window Management](#window-management)
  - [Development Tools](#development-tools)
  - [Package Management](#package-management)
  - [Other Tools](#other-tools)
- [Directory Structure](#directory-structure)
- [Installation](#installation)

## Quick Start

```bash
# Clone this repository
git clone git@github.com:yourusername/config.git ~/.config

# Install dependencies and setup symlinks
make install

# Or manually install with Homebrew
brew bundle install --file=brew/Brewfile
```

## Setup on New Mac

1. Generate new SSH key and paste the public key into [GitHub](https://github.com/settings/keys).
2. Configure SSO so the key has the right privileges for the current workplace.
3. Clone this repository to `~/.config`
4. Run `make install` to install tools and create symlinks
5. Restart your terminal

## Tools & Configuration

### Terminal & Shell

#### **Ghostty** - Modern GPU-accelerated Terminal Emulator
A blazing-fast, native terminal emulator written in Zig with GPU acceleration. Features include:
- Native macOS performance with Metal rendering
- True color support and ligatures
- Catppuccin theme with transparency
- Configuration: `ghostty/config`

#### **Alacritty** - Alternative Terminal Emulator
Cross-platform, GPU-accelerated terminal emulator focused on simplicity and performance.
- TOML-based configuration
- Configuration: `alacritty/alacritty.toml`

#### **Zsh** - Z Shell
Default shell on macOS with Oh My Zsh framework and Powerlevel10k theme.
- Main config: `.zshrc` (root level)
- Company-specific config: `zsh/company-specific.zsh`
- Environment variables: `.zshenv`

#### **Fish** - Friendly Interactive Shell
User-friendly shell with syntax highlighting and autosuggestions out of the box.
- Configuration: `fish/config.fish`
- Custom functions: `fish/functions/`

#### **Tmux** - Terminal Multiplexer
Enables multiple terminal sessions in a single window with session persistence.
- Configuration: `tmux/tmux.conf`
- Plugins: Catppuccin theme, tmux-resurrect, tmux-continuum
- Key features: Mouse support, session restoration, popup integration with lazygit

### Text Editors

#### **Neovim** - Hyperextensible Vim-based Text Editor
Modern Vim fork with Lua configuration and LSP support.
- Configuration: `nvim/init.lua`
- Plugin manager: Lazy.nvim
- Features: LSP, Tree-sitter, telescope, multiple language servers
- Configuration: `nvim/lua/` for modular setup

#### **Neovide** - Neovim GUI Client
Graphical frontend for Neovim with smooth animations and ligature support.
- Configuration: `neovide/config.toml`

### Window Management

#### **AeroSpace** - Tiling Window Manager for macOS
i3-like tiling window manager designed for macOS, providing keyboard-driven window management.
- Configuration: `aerospace/aerospace.toml`
- Custom scripts for workspace management and focus control
- Features: Auto-tiling, workspace switching, monitor management
- Scripts: `aerospace/*.sh` for custom behaviors

#### **Karabiner Elements** - Keyboard Customization
Powerful keyboard customizer for macOS allowing complex key remapping.
- Configuration: `karabiner/karabiner.json`
- Enables custom key mappings and shortcuts

### Development Tools

#### **Lazygit** - Terminal UI for Git
Beautiful terminal interface for Git with intuitive keybindings.
- Configuration: `lazygit/config.yml`
- Features: Visual branch graph, interactive rebase, custom diff tool (difftastic)
- Editor integration: Neovim

#### **Lazydocker** - Terminal UI for Docker
Simple terminal UI for Docker and Docker Compose management.
- Configuration: `lazydocker/config.yml`
- Provides visual interface for containers, images, volumes, and logs

#### **Yazi** - Blazing Fast Terminal File Manager
Modern file manager with image preview and Vim-like keybindings.
- Configuration: `yazi/yazi.toml`, `yazi/keymap.toml`, `yazi/theme.toml`
- Features: File previews, batch operations, plugin support

### Package Management

#### **Homebrew** - Package Manager for macOS
The de facto package manager for macOS, managing CLI tools, GUI applications, and fonts.
- Main Brewfile: `brew/Brewfile`
- Installs: CLI tools, casks (GUI apps), fonts, VS Code extensions
- Includes development tools: Docker, PHP, Python, Node.js tooling

#### **Volta** - JavaScript Tool Manager
Hassle-free JavaScript tool version manager (alternative to nvm).
- Manages Node.js and npm versions per project

### Other Tools

#### **Git Delta** - Syntax-highlighting Git Diff Pager
Improves git diff and git show output with syntax highlighting and line numbers.

#### **Bat** - Cat Clone with Syntax Highlighting
A `cat` replacement with syntax highlighting and Git integration.

#### **Ripgrep (rg)** - Fast Search Tool
Extremely fast recursive search tool, respects `.gitignore`.

#### **Fzf** - Fuzzy Finder
Command-line fuzzy finder for files, history, processes, etc.

#### **Zoxide** - Smarter CD Command
A faster way to navigate directories, learns your most-used paths.

#### **Htop** - Interactive Process Viewer
Better alternative to `top` for monitoring system resources.
- Configuration: `htop/htoprc`

#### **LSD** - Modern LS Replacement
Next-gen `ls` command with colors, icons, and tree view.

#### **GitHub CLI (gh)** - GitHub from Terminal
Official GitHub CLI for managing repositories, PRs, and issues from terminal.
- Configuration: `gh/config.yml`, `gh/hosts.yml`

## Directory Structure

```
~/.config/
├── aerospace/          # AeroSpace window manager config
├── alacritty/          # Alacritty terminal config
├── brew/               # Homebrew bundle file
├── fish/               # Fish shell config
├── ghostty/            # Ghostty terminal config
├── htop/               # htop process viewer config
├── karabiner/          # Karabiner Elements keyboard customizer
├── lazydocker/         # Lazydocker TUI config
├── lazygit/            # Lazygit TUI config
├── neovide/            # Neovide GUI config
├── nvim/               # Neovim config (Lua-based)
├── tmux/               # Tmux config and plugins
├── yazi/               # Yazi file manager config
├── zed/                # Zed editor config
├── zellij/             # Zellij terminal multiplexer config
├── zsh/                # Zsh shell additional config
├── .zshrc              # Zsh main config
├── .zshenv             # Zsh environment variables
├── Brewfile            # Legacy Brewfile (use brew/Brewfile)
└── ReadMe.md           # This file
```

**Note:** Some directories are gitignored:
- `gcloud/` - Google Cloud credentials and cache
- `raycast/` - Raycast settings (may contain sensitive data)
- `nvm/` - Node Version Manager installation
- `configstore/` - Various tool state files
- `.copilot/` - GitHub Copilot cache

## Installation

### Automated Installation

```bash
# Install all tools and setup configurations
make install

# Or install individual components
make install-brew      # Install Homebrew packages
make install-symlinks  # Create symlinks to home directory
make backup            # Backup existing configs
```

### Manual Installation

1. Install Homebrew if not already installed:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Install packages from Brewfile:
   ```bash
   brew bundle install --file=~/.config/brew/Brewfile
   ```

3. Create symlinks for dotfiles (adjust paths as needed):
   ```bash
   ln -sf ~/.config/.zshrc ~/.zshrc
   ln -sf ~/.config/.zshenv ~/.zshenv
   ```

4. Reload your shell configuration:
   ```bash
   source ~/.zshrc
   ```

## Contributing

This is a personal configuration repository. Feel free to fork and adapt for your own use.
