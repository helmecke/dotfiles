# dotfiles

> :warning: I moved [nvim](https://github.com/helmecke/nvim-config), [awesome](https://github.com/helmecke/awesome-config) and [qtile](https://github.com/helmecke/qtile-config) config to seperate repositories.

## Getting Started

I manage _dotfiles_ using [(GNU Stow)](http://www.gnu.org/software/stow/).

Install _dotfiles_ by cloning the git repository. I recommand using [ghq](https://github.com/x-motemen/ghq).

```bash
ghq get https://github.com/helmecke/dotfiles.git

# or

git clone https://github.com/helmecke/dotfiles.git ~/.dotfiles
```

You can now symlink any configurations you wish to use:

```bash
# Enter repository folder
cd $(ghq list -p | grep helmecke/dotfiles)

# Symlink sway config
stow -t ~ sway

# Remove sway symlink
stow -t ~ -D sway
```
