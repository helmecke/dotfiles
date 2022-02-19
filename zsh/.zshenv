export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

ZDOTDIR=${XDG_CONFIG_HOME:=~/.config}/zsh

export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="kitty"

export GOPATH=~/Go
export GOROOT=/usr/lib/go
export GO111MODULE=on

export PATH=$PATH:$GOPATH/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/bin

export KEYID=0x69182E24A9EF4C5A

export FZF_DEFAULT_OPTS="--reverse --height=8 --no-info --color='bg+:-1,hl:4,hl+:4,fg:7,fg+:7,pointer:4,marker:4,prompt:1'"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
