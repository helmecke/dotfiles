# vim: fdm=marker

autoload -Uz compinit
compinit

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Lines configured by zsh-newuser-install
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000
ZLE_RPROMPT_INDENT=0
TERM=xterm-256color
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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

autoload edit-command-line
zle -N edit-command-line

# Prompt
autoload -U colors && colors

# Colors
if ! type sw_vers > /dev/null 2>&1; then
  eval `dircolors ~/.dircolors`
fi

if [[ -f /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme && "$DISPLAY" ]]; then
  source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

  function zle-line-init {
    powerlevel9k_prepare_prompts
    if (( ${+terminfo[smkx]} )); then
      printf '%s' ${terminfo[smkx]}
    fi
    zle reset-prompt
    zle -R
  }
# powerlevel9k {{{1
# settings {{{2
POWERLEVEL9K_MODE="nerdfont-fontconfig"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode ssh context dir rbenv virtualenv vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
POWERLEVEL9K_DIR_PATH_SEPARATOR=$' \uE0B1 '
DEFAULT_USER=jhe
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

# colors {{{2
POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_FOREGROUND="gray"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="gray"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="gray"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='11'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='11'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='11'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND="yellow"
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND="white"
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND="11"
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="white"
POWERLEVEL9K_VI_INSERT_MODE_STRING="%BINSERT%b"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="%BNORMAL%b"

fi

# keybinds {{{1
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
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
alias rdesktop="rdesktop -k de -r clipboard:PRIMARYCLIPBOARD -g 1366x738 -z"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias wanip="wget http://ipinfo.io/ip -qO -"
alias docker-clean='docker rm $(docker ps -aq --filter "status=exited"); docker rmi $(docker images -f "dangling=true" -q)'
alias pac-rank-mirror="sudo reflector --verbose --country 'Germany' -l 200 -p https --sort rate --save /etc/pacman.d/mirrorlist"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias git-remove-local-branches='git branch -D `git branch --merged | grep -v \* | xargs`'

if [[ -a /usr/bin/virtualenvwrapper.sh ]]; then
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/bin/virtualenvwrapper.sh
fi

# helper functions {{{1
alias _inline_fzf="fzf --multi --ansi -i -1 --height=50% --reverse -0 --header-lines=1 --inline-info --border"
alias _inline_fzf_nh="fzf --multi --ansi -i -1 --height=50% --reverse -0 --inline-info --border"
# kubenetes {{{1
# kubectl {{{2
alias k="kubectl"

# kubectx {{{2
alias kctx="kubectx"
alias kns="kubens"

source /opt/google-cloud-sdk/completion.zsh.inc
source /usr/share/zsh/site-functions/_minikube

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select