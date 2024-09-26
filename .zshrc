# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  yarn
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
alias pn="pnpm"
alias v="nvim"
alias f="fzf"
alias cdold="cd"
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

# Source shell files
for file in $HOME/.dotfiles/zsh/.{exports,functions,path,config,aliases}.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Load plugins using Antibody
source ~/.zsh_plugins.sh

# Bootstrap Oh My Zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


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

# if [ -z "$TMUX" ]; then
#    tmux 
# fi
source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
