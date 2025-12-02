# --- Powerlevel10k Instant Prompt ---
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Environment Variables ---
# Set fundamental environment variables first.
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export ZSH="$HOME/.oh-my-zsh" # Define ZSH path before sourcing oh-my-zsh


# Source company-specific zsh configurations (which will in turn source env vars)
if [ -f "$XDG_CONFIG_HOME/zsh/company-specific.zsh" ]; then
  source "$XDG_CONFIG_HOME/zsh/company-specific.zsh"
fi

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
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/torgeir/.bun/_bun" ] && source "/Users/torgeir/.bun/_bun" # Bun completions

# volta
export VOLTA_HOME="$HOME/.volta"
export VOLTA_FEATURE_PNPM=1
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/torgeir/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pipx
export PATH="$PATH:/Users/torgeir/.local/bin" # Created by `pipx`

# --- Plugin/Tool Initializations ---
# Source plugins and initialize tools that are not part of Oh My Zsh's plugin system.
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

eval "$(zoxide init zsh)" # zoxide

source <(fzf --zsh)     # fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fzf completions

# --- Powerlevel10k Configuration ---
# This needs to be sourced after Oh My Zsh and its plugins are set up.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Aliases ---
# Group your aliases by category for better readability.
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
alias zshrc="nvim ~/.zshrc"
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
alias copy="tr -d '\n' | pbcopy" # Removes the new-line added by pbcopy
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app" # Starts screensaver
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew" # Fixes 'brew doctor' bug for Pyenv
alias cls="clear && printf '\e[3J'" # Clears the screen and buffer

# Information
alias ip='curl -s https://ipinfo.io/ip'
alias localip='ipconfig getifaddr en0'
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

# SSH
alias pubkey='pbcopy < $HOME/.ssh/id_rsa.pub; echo "Public SSH key copied"'

# Git
alias nah='git reset --hard;git clean -df'
alias pull="git pull"
alias stash="git stash --include-untracked"
alias unstash="git stash pop"

# --- Functions ---
# Group your functions together.
function rebase() {
    git fetch origin "$1" && git rebase origin/"$1"
}
function merge() {
    git fetch origin "$1" && git merge origin/"$1"
}
function checkout() {
    git checkout "$1"
}
function ff() {
    aerospace list-windows --all --format '%{window-id}%{right-padding} | %{app-name}%{right-padding} | %{window-title}%{right-padding} | %{workspace}' | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

# --- Tmux Autostart ---
# Automatically start or attach to tmux session in ghostty
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  # Try to attach to existing session, or create new one
  tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi

# --- Custom Source Files (if any) ---
# If you decide to split your config into smaller files, source them here.
# for file in $HOME/.dotfiles/zsh/.{exports,functions,path,config,aliases}.zsh; do
#   [ -r "$file" ] && [ -f "$file" ] && source "$file"
# done

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/torgeir.laurvik/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
