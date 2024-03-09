# Set locale to UTF to fix some warnings
set LC_ALL en_US.UTF-8

# Path to dotfiles
set DOTFILES "$HOME"

# Set default editors
set EDITOR "nano"
set VEDITOR "code"

# Configure Xdebug
set XDEBUG_CONFIG "idekey=VSCODE"

# Lazy load NVM to improve shell startup time
set NVM_LAZY_LOAD true

# Miscellaneous
alias sudo='sudo ' # Allows sudo for all aliases
alias copy="tr -d '\n' | pbcopy" # Removes the new-line added by pbcopy
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app" # Starts screensaver
alias cls='clear && printf "\e[3J"';
alias fishfig = 'nano ~/Users/torgeir/.config/fish/config.fish'
   
# Information
alias ip='curl -s https://ipinfo.io/ip'
alias localip='ipconfig getifaddr en0'
alias speedtest='speedtest --simple'
alias week='date +%V'

# Directories
alias finder='ofd'

# Files
alias a='$EDITOR $DOTFILES/.aliases.zshrc'
alias zshrc='$EDITOR $HOME/.zshrc'
alias brewfile='$EDITOR $HOME/.brewfile'
alias sshconfig='$EDITOR $HOME/.ssh/config'
alias hostfile='sudo $EDITOR /etc/hosts'

# SSH
alias pubkey='pbcopy < $HOME/.ssh/id_rsa.pub; echo "Public SSH key copied"'

# Git
alias nah='git reset --hard;git clean -df'

# JavaScript
alias jest='./node_modules/.bin/jest'

# Torgeir
alias antib="antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh"
alias bb="arch -arm64 brew bundle --global --no-lock --file=~/.brewfile"
alias reload="source ~/.zshrc"
alias dontsleep="caffeinate -dimsu&"
alias dosleep="pkill caffeinate"
alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
alias ..="cd .."
alias ...="cd ../.."
alias dl='cd ~/Downloads'

# Postgres 
alias pgup="brew services start postgresql"
alias pgdown="brew services stop postgresql"

# Get macOS Software Updates, update Homebrew and its installed packages
alias update='sudo softwareupdate -i -a; brew update; bb; brew upgrade; brew upgrade --cask; brew cleanup; mas upgrade'

# Check if I've got outdated versions of applications
alias outdated='brew outdated; mas outdated'

# Flush Directory Service (DNS) cache
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# typos
alias yarb="yarn "
alias yearn="yarn "

function git_current_branch -d 'Prints a human-readable representation of the current branch'
    set -l ref (git symbolic-ref HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    if test -n "$ref"
        echo $ref | sed -e s,refs/heads/,,
        return 0
    end
end

function git_prompt
    if git rev-parse --show-toplevel >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color yellow
        printf '%s' (git_current_branch)
        set_color green
        #git_prompt_status
        set_color normal
    end
end

#function orig_fish_prompt
#    set_color white
#    echo -n (whoami)
#    set_color normal
#    echo -n @
#    set_color $fish_color_hostname
#    echo -n (hostname -s)
#    #set_color normal
#    echo -n ' % '
#end

#function fish_right_prompt
#    set_color $fish_color_cwd
#    echo -n (prompt_pwd)
#end

# Auto push/pop of directories {{{

#
# Unfortunately, fish's pushd/popd behaviour seems a little buggy, and since
# pushd uses "cd" under the covers, I'm unable to alias cd to be pushd under
# the hood, so I've reimplemented this myself, using the $dirprev env variable.
#
function po --description 'Pop back to previous directory on the dir stack'
    set -l last $dirprev[-1]

    # "Pop" the last one off
    set -e dirprev[-1]

    # Switch to the last dir
    cd $last

    # Then discard this switch (which gets recorded in the dir history)
    set -e dirprev[-1]
end

# }}}

# Key bindings {{{
function fish_user_key_bindings
    bind \ec append-copy
    bind \ep prepend-paste
    bind \ev prepend-vim
    bind \ea search-for-pboard
    bind \ey 'commandline -b | pbcopy'
    bind \e'>' 'commandline -a -- "| shiftr"'
    bind \e'<' 'commandline -a -- "| shiftl"'
end
# }}}

if status is-interactive
    set CDPATH . ~/Projects/liveblocks/liveblocks/packages ~/Projects/liveblocks/liveblocks ~/Projects/liveblocks ~/Projects
end
# }}}

# iTerm shell integration {{{
test -e ~/.iterm2_shell_integration.fish; and source ~/.iterm2_shell_integration.fish
# }}}

set -gx __fish_initialized 1
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
