export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export VISUAL="nvim"
export EDITOR="nvim"

export GCE_INI_PATH=~/Documents/Ansible/gce.ini

export GOPATH=~/Documents/Go
export GOROOT=/usr/lib/go
export GO111MODULE=on

export PATH=$PATH:$GOPATH/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/bin

export FZF_DEFAULT_OPTS='--layout=default'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.cache,.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export KEYID=0x69182E24A9EF4C5A
