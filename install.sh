#!/usr/bin/env bash
#
# install.sh — GNU Stow bootstrapper for these dotfiles.
#
# Packages are grouped under common/ (every OS), macos/ and linux/ (OS-gated).
# Each package mirrors $HOME, e.g. common/nvim/.config/nvim -> ~/.config/nvim.
#
# Usage: ./install.sh [install|restow|delete|adopt|doctor|stow <pkg>|brew]
# Prefer the Makefile front-end: `make install`, `make doctor`, etc.

set -euo pipefail

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
TARGET="${TARGET:-$HOME}"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

log()  { printf '%s\n' "$*"; }
err()  { printf 'error: %s\n' "$*" >&2; }
die()  { err "$*"; exit 1; }

command -v stow >/dev/null 2>&1 || die "GNU stow not found. Install it: 'brew install stow' (macOS) or your distro package manager (e.g. 'sudo apt install stow')."

# Which group dirs apply to this OS. common always; macos/linux by uname.
os_groups() {
  local groups="common"
  case "$(uname -s)" in
    Darwin) groups="$groups macos" ;;
    Linux)  groups="$groups linux" ;;
    *)      err "unrecognised OS '$(uname -s)'; installing common only" ;;
  esac
  printf '%s\n' "$groups"
}

# Package names (immediate subdirs) of a group dir.
packages_in() {
  local grp="$1" d
  [ -d "$DOTFILES/$grp" ] || return 0
  for d in "$DOTFILES/$grp"/*/; do
    [ -d "$d" ] || continue
    basename "$d"
  done
}

# Find which group owns a package name (for `stow <pkg>`).
group_of() {
  local pkg="$1" grp
  for grp in common macos linux; do
    [ -d "$DOTFILES/$grp/$pkg" ] && { printf '%s\n' "$grp"; return 0; }
  done
  return 1
}

# Move a colliding real target aside into the timestamped backup dir.
# Handles symlinks explicitly (-L before -e) so a dangling/old symlink is
# preserved in the backup rather than silently lost.
backup_target() {
  local rel="$1" src="$TARGET/$1" dest
  if [ -L "$src" ] || [ -e "$src" ]; then
    dest="$BACKUP_DIR/$rel"
    mkdir -p "$(dirname "$dest")"
    mv "$src" "$dest"
    log "  backed up: $rel -> $dest"
  fi
}

# Stow one package, backing up any conflicting real files and retrying.
# Extra args (e.g. -R, --adopt, -n) are passed through to stow.
stow_pkg() {
  local grp="$1" pkg="$2"; shift 2
  local tries=0 out conflicts rel
  while :; do
    if out="$(stow --dir "$DOTFILES/$grp" --target "$TARGET" "$@" "$pkg" 2>&1)"; then
      [ -n "$out" ] && log "$out"
      return 0
    fi
    # Pull the offending target paths out of stow's conflict report.
    # stow 2.4.x:  "* cannot stow SRC over existing target REL since ..."
    # older stow:  "* existing target is ...: REL"
    conflicts="$(printf '%s\n' "$out" \
      | sed -n -e 's/.* over existing target \(.*\) since .*/\1/p' \
               -e 's/.*existing target[^:]*: \(.*\)/\1/p' \
      | sed 's/ =>.*//' | sort -u)"
    if [ -z "$conflicts" ] || [ "$tries" -ge 5 ]; then
      printf '%s\n' "$out" >&2
      die "could not resolve conflicts for $grp/$pkg"
    fi
    log "resolving conflicts for $grp/$pkg (moving real files to backup):"
    while IFS= read -r rel; do
      [ -n "$rel" ] && backup_target "$rel"
    done <<< "$conflicts"
    tries=$((tries + 1))
  done
}

# Run an action across every package for this OS.
each_pkg() {
  local action="$1"; shift
  local grp pkg
  for grp in $(os_groups); do
    for pkg in $(packages_in "$grp"); do
      "$action" "$grp" "$pkg" "$@"
    done
  done
}

cmd_install() { log "==> stow (target: $TARGET)"; each_pkg stow_pkg; log "done."; }
cmd_restow()  { log "==> restow";              each_pkg stow_pkg -R; log "done."; }
cmd_delete()  {
  log "==> unstow (delete symlinks)"
  local grp pkg
  for grp in $(os_groups); do
    for pkg in $(packages_in "$grp"); do
      stow --dir "$DOTFILES/$grp" --target "$TARGET" -D "$pkg" || true
    done
  done
  log "done."
}

cmd_adopt() {
  # --adopt MOVES existing real files into the repo, overwriting tracked copies.
  # Refuse on a dirty tree so the result is reviewable with `git diff`.
  git -C "$DOTFILES" diff --quiet && git -C "$DOTFILES" diff --cached --quiet \
    || die "working tree is dirty; commit or stash before 'adopt' (it overwrites tracked files). Review with 'git -C $DOTFILES diff' afterwards."
  log "==> adopt (pulling existing files into repo, then symlinking back)"
  each_pkg stow_pkg --adopt
  log "done. Review changes: git -C $DOTFILES diff"
}

cmd_stow() {
  local pkg="${1:-}" grp
  [ -n "$pkg" ] || die "usage: install.sh stow <package>"
  grp="$(group_of "$pkg")" || die "no package '$pkg' under common/ macos/ linux/"
  log "==> stow $grp/$pkg"
  stow_pkg "$grp" "$pkg"
  log "done."
}

cmd_doctor() {
  log "==> doctor (dry-run; no changes made)"
  local grp pkg conflicts=0 out
  for grp in $(os_groups); do
    for pkg in $(packages_in "$grp"); do
      if ! out="$(stow --dir "$DOTFILES/$grp" --target "$TARGET" -n -v "$pkg" 2>&1)"; then
        log "CONFLICT $grp/$pkg:"
        printf '%s\n' "$out" | sed 's/^/    /'
        conflicts=$((conflicts + 1))
      fi
    done
  done
  # sanity: ZDOTDIR must use $HOME, not an unexpanded ~
  if grep -q 'ZDOTDIR="~' "$DOTFILES/common/zsh/.zshenv" 2>/dev/null; then
    log "WARN: common/zsh/.zshenv sets ZDOTDIR with '~' (does not expand in quotes) — use \$HOME"
  fi
  if [ "$conflicts" -eq 0 ]; then
    log "no conflicts. 'make install' is safe."
  else
    log "$conflicts package(s) would conflict — 'make install' will back these up before stowing."
  fi
}

cmd_brew() {
  command -v brew >/dev/null 2>&1 || die "Homebrew not installed."
  log "==> brew bundle (brew/Brewfile)"
  brew bundle install --file="$DOTFILES/brew/Brewfile"
}

main() {
  local cmd="${1:-install}"; shift || true
  case "$cmd" in
    install) cmd_install ;;
    restow)  cmd_restow ;;
    delete|unstow) cmd_delete ;;
    adopt)   cmd_adopt ;;
    stow)    cmd_stow "${1:-}" ;;
    doctor)  cmd_doctor ;;
    brew)    cmd_brew ;;
    *)       die "unknown command '$cmd' (install|restow|delete|adopt|stow <pkg>|doctor|brew)" ;;
  esac
}

main "$@"
