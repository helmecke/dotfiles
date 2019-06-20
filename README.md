# dotfiles

## Getting Started

I manage _dotfiles_ using [(GNU Stow)](http://www.gnu.org/software/stow/).

Install _dotfiles_ by cloning the git repository into a hidden folder in $HOME.

`git clone https://github.com/helmecke/dotfiles.git ~/.dotfiles`

You can now symlink any configurations you wish to use:

```bash
# Enter repository folder
cd ~/.dotfiles

# Symlink sway config
stow sway

# Remove sway symlink
stow -D sway
```
