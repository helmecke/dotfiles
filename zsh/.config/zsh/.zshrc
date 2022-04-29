#!/bin/zsh

#{{{1 History

HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history

# If the parent directory doesn't exist, create it.
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

# Max number of entries to keep in history file.
SAVEHIST=$(( 100 * 1000 ))

# Max number of history entries to keep in memory.
HISTSIZE=$(( 1.2 * SAVEHIST ))

# Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_FCNTL_LOCK

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

# Don't remove blanks to keep indentation
unsetopt HIST_REDUCE_BLANKS

# Don't execute immediately upon history expansion.
setopt HIST_VERIFY

#{{{1 Environment variables

export LANG=en_US.UTF-8

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

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

#{{{1 Emacs Keybindings
# Must be done bevor loading plugins

bindkey -e

#{{{1 Plugins

# yay -S zsh-syntax-highlighting
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# yay -S zsh-autosuggestions
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# yay -S zsh-abbr
# INFO: import gpg with `curl -s https://github.com/olets.gpg | gpg --import`
[ -f /usr/share/zsh/plugins/zsh-abbr/zsh-abbr.zsh ] && \
  source /usr/share/zsh/plugins/zsh-abbr/zsh-abbr.zsh

# yay -S fzf
[ -f /usr/share/fzf/completion.zsh ] && \
  source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && \
  source /usr/share/fzf/key-bindings.zsh

# yay -S zsh-hist-git
[ -f /usr/share/zsh/plugins/zsh-hist/zsh-hist.plugin.zsh ] && \
  source /usr/share/zsh/plugins/zsh-hist/zsh-hist.plugin.zsh

# {{{2 Plugin settings

zstyle ':hist:*' auto-format no

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets regexp)
ZSH_HIGHLIGHT_REGEXP+=('(^| )('${(j:|:)${(k)ABBR_REGULAR_USER_ABBREVIATIONS}}')($| )' fg=blue)
ZSH_HIGHLIGHT_REGEXP+=('\<('${(j:|:)${(k)ABBR_GLOBAL_USER_ABBREVIATIONS}}')$' fg=magenta)
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan

#{{{1 Options
# Disable beep
unsetopt beep
# Disable globbing
setopt NO_NOMATCH

#{{{1 Completion

autoload -U +X compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
autoload -Uz +X bashcompinit && bashcompinit -d "$XDG_CACHE_HOME/zsh/bcompdump-$ZSH_VERSION"

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-list all
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true

#{{{2 Add completions
complete -o nospace -C /usr/bin/terraform terraform
complete -o nospace -C /usr/bin/aws_completer aws

compdef _rg hg

#{{{1 Prompt
autoload -Uz promptinit
promptinit
PS1="%B%(!.#.$)%b "
PS2="%B>%b "
PS3='%B?#%b '
PS4='%B+>%b '

#{{{1 Enable Ctrl-x-e to edit command line
autoload -Uz edit-command-line
zle -N edit-command-line

#{{{1 Colors
autoload -Uz colors && colors
if [ -f "~/.dircolors" ]; then
  if ! type sw_vers > /dev/null 2>&1; then
    eval `dircolors ~/.dircolors`
  fi
fi

#{{{1 Exports
export k="app.kubernetes.io"
export h="helm.sh"

#{{{1 Custom functions
#{{{2 mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
  mkdir -p "$*"
  cd "$*"
}

#{{{2 change window title to host on ssh
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

#{{{2 term title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;term • %1~\a'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;term • %1~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz chpwd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# {{{2 pet snippets
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon

#{{{2 ghq-fzf
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    cd $(ghq root)/${selected_dir}
    zle redisplay
    # zle accept-line
  fi

  zle reset-prompt
  chpwd
}
zle -N ghq-fzf

function chpwd () {
  # Instead of printing the current dir in each prompt, print it only when when
  # we change dirs, by using a hook function.

  RPS1=   # Clear the right side of the prompt; see next section.

  # Tell the Zsh Line Editor to ensure that our prompt and command line look
  # visually correct both before and after our output.
  zle -I

  # -P flag parses prompt escape codes.
  print -P "%F{12}%~%f"   # 12 is bright blue.
}

chpwd

#{{{1 ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

#{{{1 kitty ssh fix
if [[ $TERM == "xterm-kitty" ]] then;
  kitty + complete setup zsh | source /dev/stdin
  # alias ssh="kitty +kitten ssh"
  alias ssh='TERM=xterm-256color ssh'
fi

#{{{1 conda
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

#{{{1 Keybinds
bindkey "^q" push-line-or-edit
bindkey '^g' get-line
bindkey "^x^e" edit-command-line
bindkey '^s' pet-select
bindkey '^[g' ghq-fzf

#{{{1 Aliases
if ! type sw_vers > /dev/null 2>&1; then
  alias ls="ls --hyperlink=auto --color=auto"
else
  alias ls="ls --hyperlink=auto"
fi
alias l="ls -h"
alias la="ls -ha"
alias ll="ls -lh"
alias lla="ls -lha"

# A trailing space in VALUE causes the next word to be checked for alias substitution when the alias is expanded.
alias watch="watch "

(( $+commands[nvim] )) && alias vi="nvim" vim="nvim"
