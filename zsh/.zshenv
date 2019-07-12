export VISUAL="vim"
export EDITOR="vim"

export GCE_INI_PATH=~/Documents/Ansible/gce.ini

export XKB_DEFAULT_LAYOUT=de
export XKB_DEFAULT_OPTIONS=ctrl:nocaps

export GOPATH=~/Documents/Go
export GOROOT=/usr/lib/go
export GO111MODULE=on

export PATH=$PATH:$GOPATH/bin

export FZF_DEFAULT_OPTS='--layout=default'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
