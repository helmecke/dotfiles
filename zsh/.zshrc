#{ XDG
if [[ -n "$XDG_CACHE_HOME/zsh" ]]; then
  mkdir -p "$XDG_CACHE_HOME/zsh"
fi

if [[ -n "$XDG_DATA_HOME/zsh" ]]; then
  mkdir -p "$XDG_DATA_HOME/zsh"
fi

#{ Enable emacs style keybinds
bindkey -e

#{ Enable autocomplete
autoload -U +X compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
autoload -Uz +X bashcompinit && bashcompinit -d "$XDG_CACHE_HOME/zsh/bcompdump-$ZSH_VERSION"

fpath=($XDG_DATA_HOME/zsh/completion/ $fpath)
zstyle ':completion:*' menu select

#{{ Add completions
complete -o nospace -C /usr/bin/terraform terraform
complete -o nospace -C /usr/bin/aws_completer aws

compdef _rg hg

#{ Options
# Disable beep
unsetopt beep
# Treat the '!' character specially during expansion.
setopt BANG_HIST
# Write to the history file immediately not when the shell exits.
setopt INC_APPEND_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS
# Don't execute immediately upon history expansion.
setopt HIST_VERIFY
# Disable globbing
setopt NO_NOMATCH

# Save history to xdg data home
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=12500000
SAVEHIST=10000000

#{ Prompt
autoload -Uz promptinit
promptinit
PS1="%B%(!.#.$)%b "
PS2="%B>%b "
PS3='%B?#%b '
PS4='%B+>%b '

#{ Enable Ctrl-x-e to edit command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

#{ Colors
autoload -Uz colors && colors
if [ -f "~/.dircolors" ]; then
  if ! type sw_vers > /dev/null 2>&1; then
    eval `dircolors ~/.dircolors`
  fi
fi

#{ Aliases
if ! type sw_vers > /dev/null 2>&1; then
  alias ls="ls --hyperlink=auto --color=auto"
else
  alias ls="ls --hyperlink=auto"
fi
alias l="ls -h"
alias ll="ls -lh"
alias lla="ls -lha"

# A trailing space in VALUE causes the next word to be checked for alias substitution when the alias is expanded.
alias watch="watch "
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias pac-rank-mirror="sudo reflector --verbose --country 'Germany' -l 200 -p https --sort rate --save /etc/pacman.d/mirrorlist"
alias dos2unixdir="find . -type f -exec dos2unix {} \;"
alias vim="nvim"
alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"

#{ Exports
export k="app.kubernetes.io"
export h="helm.sh"

#{ Custom functions
#{{ mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
  mkdir -p "$*"
  cd "$*"
}

#{{ change window title to host on ssh
# Make short hostname only if its not an IP address
__tm_get_hostname(){
    local HOST="$(echo $* | rev | cut -d ' ' -f 1 | rev)"
    if echo $HOST | grep -P "^([0-9]+\.){3}[0-9]+" -q; then
        echo $HOST
    else
        echo $HOST| cut -d . -f 1
    fi
}

__tm_get_current_window(){
    tmux list-windows| awk -F : '/\(active\)$/{print $1}'
}

# Rename window according to __tm_get_hostname and then restore it after the command
__tm_command() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=| cut -d : -f 1)" = "tmux" ]; then
        __tm_window=$(__tm_get_current_window)
        # Use current window to change back the setting. If not it will be applied to the active window
        trap "tmux set-window-option -t $__tm_window automatic-rename on 1>/dev/null" EXIT
        tmux rename-window "$(__tm_get_hostname $*)"
    fi
    command "$@"
}

ssh() {
    __tm_command ssh "$@"
}

ec2ssh() {
    __tm_command ec2ssh "$@"
}

#{{ term title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;term - %1~\a'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;term - %1~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz chpwd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# {{ pet snippets
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

#{{ ghq-fzf
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    cd $(ghq root)/${selected_dir}
    zle redisplay
    # zle accept-line
  fi

  zle reset-prompt
}
zle -N ghq-fzf
bindkey '\eg' ghq-fzf

#{ ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

#{ kitty ssh fix
if [[ $TERM == "xterm-kitty" ]] then;
  kitty + complete setup zsh | source /dev/stdin
  # alias ssh="kitty +kitten ssh"
  alias ssh='TERM=xterm-256color ssh'
fi

#{ conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($XDG_DATA_HOME'/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$XDG_DATA_HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$XDG_DATA_HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$XDG_DATA_HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#{ FZF
if [ -f "/usr/share/fzf/completion.zsh" ]; then
  source "/usr/share/fzf/completion.zsh"
fi

if [ -f "/usr/share/fzf/key-bindings.zsh" ]; then
  source "/usr/share/fzf/key-bindings.zsh"
fi
