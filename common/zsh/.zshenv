# ~/.zshenv — read for every zsh invocation, before .zshrc.
# Must live at $HOME because ZDOTDIR is not known until this file sets it.

# XDG base directories (note: use $HOME, NOT ~, which does not expand in quotes)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Keep the rest of the zsh config (.zshrc, .zsh_plugins.txt, company-specific.zsh)
# under ~/.config/zsh. zsh reads $ZDOTDIR/.zshrc next.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
