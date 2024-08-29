# If not running interactively, don't do anything



#~ Initilization Conditions

[[ "$-" != *i* ]] && return

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    source /usr/share/bash-completion/bash_completion

#~# Git 

export GIT_CONFIG_GLOBAL=~/.config/.gitconfig

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash

#~History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"

#~# Plugin config.


#~## Micro Editor 
#!These variables must be placed here before (Zsh Auto Notify section).
export EDITOR='micro'
export VISUAL='micro'


#~## FZF

readonly show_file_or_dir_preview="if [[ -d {} ]]; then lsd --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"


#~### Variables
export FZF_DEFAULT_COMMAND="fd --path-separator=/ --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'" 

export FZF_ALT_C_COMMAND="fd --path-separator=/ --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'lsd --tree | head -200'"

#~ ### Functions

_fzf_compgen_path() {
	  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
 _fzf_compgen_dir() {
 	  fd --type=d --hidden --exclude .git . "$1"
}



 _fzf_comprun() {
 
 	  local command=$1
 	  shift

case "$command" in
cd)           fzf --preview 'lsd --tree --color=always {} | head -200' "$@" ;;
export|unset) fzf --preview "eval 'echo $'{}"  "$@" ;;
*)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
esac
}
 



#~## Bat 

#~### Variables

export BAT_THEME="Dracula"

#~### Function 

bat() {
local index

local args=("$@")

for index in $(seq 0 ${#args[@]}) ; do
	case "${args[index]}" in
	-*) continue;;
	*)  [ -e "${args[index]}" ] && args[index]="$(cygpath --windows "${args[index]}")";;
	esac
done
command bat "${args[@]}"

}



#~## Bashunit

#~# Aliases

# ! To make bashunit work from anywhere
alias bashunit="bash ~/.basher/cellar/packages/TypedDevs/bashunit/bashunit"


#~## Ble.sh


#~### Commands

source ~/.local/share/blesh/ble.sh


## Dot File Config 

# This section is dedicated to commands that are associated with editing dotfiles
#! I decided to do this because I might change my tool for.
# Updating dot files. 

alias dfc="yadm" 



# Final Execution Commands

eval "$(starship init bash)"

export PATH="$HOME/.basher/bin:$PATH"   

eval "$(basher init - bash)"

eval "$(zoxide init bash)"

eval "$(fnm env --use-on-cd --shell bash)"

# ---- FZF -----

eval "$(fzf --bash)"


#~Aliases
#
# Default to human readable figures

alias df='df -h'
alias du='du -h'
alias grep='grep --color'        # show differences in colour
alias egrep='egrep --color=auto' # show differences in colour
alias fgrep='fgrep --color=auto' # show differences in colour

#~## This section is for aliases that aren't
# Worth creating a section for sections for

# Zoxide alias

alias cd="z"

# Some shortcuts for different directory listings
alias ls="lsd --tree -a --depth=${depth:-3}"     # classify files in colour
alias lsl='lsd -l'    # long list
alias lsa='lsd -A --header --blocks'    # all but . and ..
alias lsperm='lsd  --permission'
alias lssize='lsd  --size'
alias lsdate='lsd  --date'
alias lsdir='lsd  --directory-only'                    
 
