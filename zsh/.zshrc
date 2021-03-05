# vim: fdm=marker
if [[ -n "$XDG_CACHE_HOME/zsh" ]]; then
  mkdir -p "$XDG_CACHE_HOME/zsh"
fi

if [[ -n "$XDG_DATA_HOME/zsh" ]]; then
  mkdir -p "$XDG_DATA_HOME/zsh"
fi

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Lines configured by zsh-newuser-install
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000
ZLE_RPROMPT_INDENT=0
TERM=xterm-256color

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt NO_NOMATCH                # Disable globbing

unsetopt beep
#{ prompt
autoload -U promptinit
promptinit
PS1="%B%(!.#.$)%b "
PS2="%B>%b "
PS3='%B?#%b '
PS4='%B+>%b '

autoload edit-command-line
zle -N edit-command-line

# Prompt
autoload -U colors && colors

# Colors
if ! type sw_vers > /dev/null 2>&1; then
  eval `dircolors ~/.dircolors`
fi

# keybinds {{{1
bindkey -v
unsetopt MULTIBYTE
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "\e[3~" delete-char
bindkey "${terminfo[kich1]}" quoted-insert
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=20

# Easier, more vim-like editor opening
bindkey -M vicmd v edit-command-line

# aliases {{{1
if ! type sw_vers > /dev/null 2>&1; then
  alias ls="ls --color=auto"
fi
alias l="ls -h"
alias ll="ls -lh"
alias lla="ls -lha"
# A trailing space in VALUE causes the next word to be checked for alias substitution when the alias is expanded.
alias watch="watch "
alias rdesktop="rdesktop -k de -r clipboard:PRIMARYCLIPBOARD -g 1366x738 -z"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias wanip="wget http://ipinfo.io/ip -qO -"
alias docker-clean='docker rm $(docker ps -aq --filter "status=exited"); docker rmi $(docker images -f "dangling=true" -q)'
alias pac-rank-mirror="sudo reflector --verbose --country 'Germany' -l 200 -p https --sort rate --save /etc/pacman.d/mirrorlist"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias git-remove-local-branches='git branch -D `git branch --merged | grep -v \* | xargs`'
alias lzd='lazydocker'
alias vim=nvim
alias kubetail='kubetail -k false '
alias Gclean='git branch --merged | grep -v \* | xargs git branch -D'

if [[ -a /usr/bin/virtualenvwrapper.sh ]]; then
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/bin/virtualenvwrapper.sh
fi

alias helm='helm2'
alias helm3='/usr/bin/helm '

# helper functions {{{1

# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
    mkdir -p "$*"
    cd "$*"
}

# kubenetes {{{1
# kubectl {{{2
alias k="kubectl"

# kubectx {{{2
alias kctx="kubectx"
alias kns="kubens"

source /opt/google-cloud-sdk/completion.zsh.inc
source /usr/share/zsh/site-functions/_minikube

function pet-prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

eval "$(jira --completion-script-zsh)"
