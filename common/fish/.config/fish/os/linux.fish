# Linux-specific fish config (sourced when not on macOS).

# Clipboard — prefer Wayland (wl-copy), fall back to X11 (xclip / xsel)
if command -q wl-copy
    alias copy="tr -d '\n' | wl-copy"
    alias pubkey='wl-copy < $HOME/.ssh/id_rsa.pub; echo "Public SSH key copied"'
else if command -q xclip
    alias copy="tr -d '\n' | xclip -selection clipboard"
    alias pubkey='xclip -selection clipboard < $HOME/.ssh/id_rsa.pub; echo "Public SSH key copied"'
else if command -q xsel
    alias copy="tr -d '\n' | xsel --clipboard --input"
    alias pubkey='xsel --clipboard --input < $HOME/.ssh/id_rsa.pub; echo "Public SSH key copied"'
end

# Lock the session (best-effort; depends on the desktop environment / logind)
if command -q loginctl
    alias afk='loginctl lock-session'
end

# Local network IP (first non-loopback address)
alias localip="hostname -I | awk '{print \$1}'"
