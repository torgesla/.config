# Dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Cross-platform (macOS + Linux): shared config lives in `common/`, OS-only config
in `macos/` / `linux/`, and the installer stows the right groups for the current OS.

## Layout

The repo is a **stow directory**; the **target** is always `$HOME`. Each tool is a
*package* whose internal tree mirrors `$HOME`, so stowing a package symlinks its
files into the right place:

```
~/.dotfiles/
├── Makefile              # front-end: make install / doctor / restow / delete / adopt
├── install.sh            # OS detection, collision backup, stow loop
├── brew/Brewfile         # Homebrew bundle (macOS)
├── common/               # stowed on every OS
│   ├── nvim/.config/nvim/…        → ~/.config/nvim
│   ├── zsh/.zshenv                → ~/.zshenv          (bootstraps ZDOTDIR)
│   ├── zsh/.config/zsh/.zshrc     → ~/.config/zsh/.zshrc
│   ├── git/.config/git/ignore     → ~/.config/git/ignore
│   ├── editorconfig/.editorconfig → ~/.editorconfig
│   └── … fish, ghostty, alacritty, wezterm, zellij, tmux, zed, neovide,
│          lazygit, lazydocker, yazi, gh, btop, caveman, topgrade
├── macos/                # stowed only on macOS
│   ├── aerospace/        # tiling WM
│   ├── karabiner/        # keyboard remapper
│   └── leaderkey/        # LeaderKey launcher (config.json → ~/.config/config.json)
└── linux/                # stowed only on Linux (currently empty)
```

### Shell config is XDG / ZDOTDIR based

`~/.zshenv` (the only zsh file at `$HOME`) sets the `XDG_*` base dirs and
`ZDOTDIR="$XDG_CONFIG_HOME/zsh"`, so the rest of the zsh config lives under
`~/.config/zsh/`. OS-specific bits (clipboard, screensaver, local-IP helpers) are
split into `common/zsh/.config/zsh/os/{darwin,linux}.zsh` and sourced by `uname`.
Fish mirrors this with `common/fish/.config/fish/os/{darwin,linux}.fish`.

## Quick start (new machine)

```bash
# 1. Install GNU Stow
brew install stow                 # macOS
# sudo apt install stow           # Debian/Ubuntu

# 2. Clone here
git clone git@github.com:torgesla/.config.git ~/.dotfiles
cd ~/.dotfiles

# 3. Preview what would change (no writes)
make doctor

# 4. Symlink everything for this OS (existing files are backed up first)
make install

# 5. (macOS) install packages
make brew

# 6. Restart your shell
```

## Make targets

| Target          | What it does                                                            |
|-----------------|-------------------------------------------------------------------------|
| `make doctor`   | Dry-run; reports conflicts without changing anything                    |
| `make install`  | Stow all packages for this OS; colliding real files → `~/.dotfiles-backup/<timestamp>/` |
| `make restow`   | Re-stow (use after adding/moving files inside a package)                |
| `make delete`   | Remove every symlink this repo created (unstow)                         |
| `make stow PKG=nvim` | Stow a single package                                              |
| `make adopt`    | Pull existing real files into the repo, then symlink back (clean tree only) |
| `make brew`     | `brew bundle` from `brew/Brewfile`                                       |

Collisions are never deleted — they are moved to a timestamped backup dir.

## Notes / gotchas

- **Secrets are never tracked.** `common/zsh/.config/zsh/company.env` (registry
  token) and `.env` files are gitignored. Copy `company.env` onto a new machine by
  hand; `company-specific.zsh` sources it only if present.
- **`~/.config` is not a symlink.** It stays a normal directory containing a mix of
  managed symlinks and untracked runtime dirs (`nvm/`, `gcloud/`, `yarn/`, …). That's
  intentional — do not try to symlink `~/.config` as a whole.
- **tmux plugins** are installed by TPM into the (folded) tmux config dir and are
  gitignored.
- **macOS-only tools** (`aerospace`, `karabiner`, `leaderkey`) are never referenced
  on Linux — `install.sh` only stows the `macos/` group when `uname` is `Darwin`.
- Stow's built-in ignore list already skips `.git`, `.gitignore`, `README.*`, etc.
