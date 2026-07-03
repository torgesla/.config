# --- Powerlevel10k Instant Prompt ---
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Environment Variables ---
# Set fundamental environment variables first.
# XDG_CONFIG_HOME / ZDOTDIR are exported in .zshenv (read before this file).
export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export ZSH="$HOME/.oh-my-zsh" # Define ZSH path before sourcing oh-my-zsh


# Source company-specific zsh configurations (which will in turn source env vars)
if [ -f "$XDG_CONFIG_HOME/zsh/company-specific.zsh" ]; then
  source "$XDG_CONFIG_HOME/zsh/company-specific.zsh"
fi

# --- Completions fpath ---
# Docker CLI completions — must be before compinit (called by Oh My Zsh).
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

# --- Oh My Zsh Setup ---
# Theme and plugins for Oh My Zsh.
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  npm
  # zsh-autosuggestions and zsh-syntax-highlighting are sourced manually later.
)

source "$ZSH/oh-my-zsh.sh" # Source Oh My Zsh framework.

# --- Path Configurations ---
# Add directories to PATH. These should generally come before sourcing other tools
# that might modify PATH further.
# DYLD_LIBRARY_PATH is a macOS dynamic-linker var; only meaningful on macOS + Homebrew.
if [[ "$OSTYPE" == darwin* ]] && command -v brew >/dev/null 2>&1; then
  export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun" # Bun completions


# pnpm (mac keeps its home under ~/Library, Linux under XDG data dir)
if [[ "$OSTYPE" == darwin* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pipx
export PATH="$PATH:$HOME/.local/bin" # Created by `pipx`

# --- Plugin/Tool Initializations ---
# Source plugins and initialize tools that are not part of Oh My Zsh's plugin system.
# Guarded on brew so a Linux box without linuxbrew just skips these.
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
  [ -f "$BREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh" ] && source "$BREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
  [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

eval "$(zoxide init zsh)" # zoxide

source <(fzf --zsh)     # fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fzf completions

# --- Powerlevel10k Configuration ---
# This needs to be sourced after Oh My Zsh and its plugins are set up.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- fzf-tab Configuration ---
# Required: prevent zsh showing its built-in menu so fzf-tab can capture completions.
# Must match OMZ's specificity (`:completion:*:*:*:*:*`) to override its `menu select`.
zstyle ':completion:*:*:*:*:*' menu no

# --- Aliases ---
# Group your aliases by category for better readability.
# OS-specific aliases (clipboard, screensaver, local IP) live in os/{darwin,linux}.zsh.
# General
alias cat="bat"
alias see='fzf --preview="bat --color=always {}"'
alias explore="yazi"
alias v="nvim"
alias f="fzf"
alias cd="z"
alias diff="colordiff"
alias lg="lazygit"
alias ld="lazydocker"
alias zshrc="nvim ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc"
alias config="nvim ~/.config/"
alias pac="bat package.json | fzf --layout reverse-list"
alias pn="pnpm"

# NPM
alias build="npm run build"
alias dev="npm run dev"

# Confirmation Aliases (Important to keep together)
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'

# Miscellaneous
alias sudo='sudo ' # Allows sudo for all aliases
alias path='echo -e ${PATH//:/\\n}' # List all paths registered
alias cls="clear && printf '\e[3J'" # Clears the screen and buffer

# Information
alias ip='curl -s https://ipinfo.io/ip'
alias speedtest='speedtest --simple'
alias week='date +%V'

# bun
alias b="bun"
alias bi="bun install"
alias ba="bun add"
alias bad="bun add --save-dev"
alias bl="bun link"
alias brm="bun remove"
alias bu="bun update"
alias bul="bun unlink"
alias brb="bun run build"
alias brc="bun run clean"
alias brcl="bun run clean:lock"
alias brd="bun run dev"
alias brf="bun run format"
alias brl="bun run lint"
alias brt="bun run test"

# Directories
alias mkd="mkd(){ mkdir -p '$1'; cd '$1' }; mkd "
alias finder='ofd'

# Git
alias nah='git reset --hard;git clean -df'
alias pull="git pull"
alias stash="git stash --include-untracked"
alias unstash="git stash pop"

# --- Functions ---
# Interactive Package Manager Independent Script Runner
function run() {
  if [ ! -f package.json ]; then
    echo "No package.json found."
    return 1
  fi

  # 1. Use jq to format the output as "key": "value" and feed it to fzf (no preview window)
  local selection=$(jq -r '.scripts | to_entries | .[] | "\"\(.key)\": \"\(.value)\""' package.json | fzf --height 40% --reverse --prompt="🚀 Run script: ")

  if [[ -z "$selection" ]]; then
    return 0
  fi

  # 2. Extract ONLY the script name from the chosen line.
  # awk splits the string by quotes (") and prints the 2nd piece, which is the script name.
  local script=$(echo "$selection" | awk -F'"' '{print $2}')

  # 3. Detect the package manager
  local pkg_manager="npm"
  if [ -f "bun.lockb" ] || [ -f "bun.lock" ]; then
    pkg_manager="bun"
  elif [ -f "pnpm-lock.yaml" ]; then
    pkg_manager="pnpm"
  elif [ -f "yarn.lock" ]; then
    pkg_manager="yarn"
  fi

  # 4. Execute the script
  echo "🚀 Running: $pkg_manager run $script"
  $pkg_manager run "$script"
}

function rebase() {
    git fetch origin "$1" && git rebase origin/"$1"
}

function merge() {
    git fetch origin "$1" && git merge origin/"$1"
}

function checkout() {
    git checkout "$1"
}

# Fuzzy-focus an AeroSpace window (macOS window manager only)
if [[ "$OSTYPE" == darwin* ]]; then
  function ff() {
      aerospace list-windows --all --format '%{window-id}%{right-padding} | %{app-name}%{right-padding} | %{window-title}%{right-padding} | %{workspace}' | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
  }
fi

# --- Tmux Autostart ---
# Automatically start or attach to tmux session in ghostty
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  # Try to attach to existing session, or create new one
  tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi

# --- OS-specific config (clipboard, screensaver, network helpers) ---
if [[ "$OSTYPE" == darwin* ]]; then
  [ -f "${ZDOTDIR:-$HOME/.config/zsh}/os/darwin.zsh" ] && source "${ZDOTDIR:-$HOME/.config/zsh}/os/darwin.zsh"
else
  [ -f "${ZDOTDIR:-$HOME/.config/zsh}/os/linux.zsh" ] && source "${ZDOTDIR:-$HOME/.config/zsh}/os/linux.zsh"
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# volta — after nvm so its shim takes precedence
export VOLTA_HOME="$HOME/.volta"
export VOLTA_FEATURE_PNPM=1
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
