# macOS-specific zsh config (sourced from .zshrc when $OSTYPE == darwin*).

# Clipboard — pbcopy/pbpaste are built in on macOS
alias copy="tr -d '\n' | pbcopy"                 # copy stdin, stripping the trailing newline
alias pubkey='pbcopy < "$HOME/.ssh/id_rsa.pub"; echo "Public SSH key copied"'

# Start the screensaver (lock/AFK)
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

# Local network IP (Wi-Fi interface)
alias localip='ipconfig getifaddr en0'

# Work around `brew doctor` complaining about pyenv shims on PATH
if command -v brew >/dev/null 2>&1 && command -v pyenv >/dev/null 2>&1; then
  alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
fi
