# macOS-specific fish config (sourced when uname = Darwin).

alias copy="tr -d '\n' | pbcopy"        # copy stdin, stripping the trailing newline
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"
alias localip='ipconfig getifaddr en0'
alias pubkey='pbcopy < $HOME/.ssh/id_rsa.pub; echo "Public SSH key copied"'
