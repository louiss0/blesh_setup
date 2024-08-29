# If not running interactively, don't do anything



#~ Initilization Conditions

[[ "$-" != *i* ]] && return


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
 


eval "$(zoxide init bash)"


# ---- FZF -----

eval "$(fzf --bash)"



alias cd="z"

