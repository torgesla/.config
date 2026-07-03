# Linux-specific zsh config (sourced from .zshrc when not on macOS).

# Clipboard — prefer Wayland (wl-copy), fall back to X11 (xclip / xsel)
if command -v wl-copy >/dev/null 2>&1; then
  alias copy="tr -d '\n' | wl-copy"
  alias pubkey='wl-copy < "$HOME/.ssh/id_rsa.pub"; echo "Public SSH key copied"'
elif command -v xclip >/dev/null 2>&1; then
  alias copy="tr -d '\n' | xclip -selection clipboard"
  alias pubkey='xclip -selection clipboard < "$HOME/.ssh/id_rsa.pub"; echo "Public SSH key copied"'
elif command -v xsel >/dev/null 2>&1; then
  alias copy="tr -d '\n' | xsel --clipboard --input"
  alias pubkey='xsel --clipboard --input < "$HOME/.ssh/id_rsa.pub"; echo "Public SSH key copied"'
fi

# Lock the session (best-effort; depends on the desktop environment / logind)
if command -v loginctl >/dev/null 2>&1; then
  alias afk='loginctl lock-session'
fi

# Local network IP (first non-loopback address)
alias localip="hostname -I | awk '{print \$1}'"
