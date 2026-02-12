## Recover lost stash / commit

git log --graph --decorate --pretty=oneline --abbrev-commit --all $(git fsck --no-reflogs | grep commit | cut -d' ' -f3)
