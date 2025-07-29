# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
# antidote load
# antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh

export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  npm
  # I initalise zsh-autosuggestions and zsh-syntax-highlighting manually later as they are installed by brew.
  # zsh-autosuggestions
  # zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
alias pn="pnpm"
alias cat="bat"
alias see='fzf --preview="bat --color=always {}"'
alias explore="yazi"
# alias v="nvim -c \"FzfLua oldfiles\""
alias v="nvim"
alias f="fzf"
alias cd="z"
alias diff="colordiff"
alias lg="lazygit"
alias ld="lazydocker"
# confirmation #
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias zshrc="nvim ~/.zshrc"
alias config="nvim ~/.config/"
alias pac="bat package.json | fzf --layout reverse-list"

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

# Git
function rebase() {
    git fetch origin "$1" && git rebase origin/"$1"
}
function merge() {
    git fetch origin "$1" && git merge origin/"$1"
}
function checkout() {
    git checkout "$1"
}

alias pull="git pull"
alias stash="git stash --include-untracked"
alias unstash="git stash pop"


# Source shell files
#for file in $HOME/.dotfiles/zsh/.{exports,functions,path,config,aliases}.zsh; do
#  [ -r "$file" ] && [ -f "$file" ] && source "$file"
#done
function ff() {
    aerospace list-windows --all --format '%{window-id}%{right-padding} | %{app-name}%{right-padding} | %{window-title}%{right-padding} | %{workspace}' | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

# Bootstrap Oh My Zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
# bun completions
[ -s "/Users/torgeir/.bun/_bun" ] && source "/Users/torgeir/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# volta
export VOLTA_HOME="$HOME/.volta"
export VOLTA_FEATURE_PNPM=1
export PATH="$VOLTA_HOME/bin:$PATH"
eval "$(zoxide init zsh)"

source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `pipx` on 2024-11-18 19:03:12
export PATH="$PATH:/Users/torgeir/.local/bin"

# pnpm
export PNPM_HOME="/Users/torgeir/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
