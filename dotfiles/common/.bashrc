#
# ~/.bashrc
#

## INIT {{{

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Check if root for functions & aliases
_isroot=false
[[ $UID -eq 0 ]] && _isroot=true

PROMPT_COMMAND="$PROMPT_COMMAND; pwd > /tmp/.last_dir"

# Colors
fg=('\e[0;30m\' '\[\e[0;31m\]' '\[\e[0;32m\]' '\[\e[0;33m\]'
    '\[\e[0;34m\]' '\[\e[0;35m\]' '\[\e[0;36m\]' '\[\e[0;37m\]'
    '\[\e[1;30m\]' '\[\e[1;31m\]' '\[\e[1;32m\]' '\[\e[1;33m\]'
    '\[\e[1;34m\]' '\[\e[1;35m\]' '\[\e[1;36m\]' '\[\e[1;37m\]')
nofg='\[\e[0m\]'
fd=${fg[1]}

# use auto-completion after those words
complete -cf sudo
complete -cf man
complete -cf killall
complete -cf pkill
complete -cf fakeroot
complete -cf respawn
complete -cf pgrep
complete -cf bunzip2
complete -cf g
# }}}

## FUNCTIONS {{{

# . dir sizes
dirsize () {
	du -hd 1
}

# consult vim's help
:h () {
	vim +"h $1" +only +'map q ZQ'
}

wiki () {
	links "http://en.wikipedia.org/w/index.php?search=${*// /+}"
}
ddg() {
	links "http://duckduckgo.com/lite?q=${*// /+}"
}
## }}}

## ALIASES {{{

## Pacman
if ! $_isroot; then
	alias pacman="sudo pacman"
fi
alias orphans="pacman -Qtd"
alias owninstallations="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)"

## Terminal
alias quit="exit"
alias c="clear"

alias :q="quit"
alias cd..="cd .."
alias df="df -h"
alias ping="ping -c 5"
alias perkele="quit"

# Make output colorful
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias la="ls -alhF"
alias lm="la | less"
alias ccal="cal | grep -C5 --color=auto "`date +%d | sed s/^0/\ /`""

# job control
alias mtop="ps --no-header -eo pmem,size,vsize,comm | sort -nr | sed 10q"
alias ctop="ps --no-header -eo pcpu,comm | sort -nr | sed 10q"

alias homelab="ssh homelab.codecornerapps.com -p 45654"
alias desktop="ssh -X robinm8.ddns.net -p 39901"

alias plz="sudo !!"

alias pull="git pull"
alias push="git push"
alias update="pacaur -Syyu"

alias fetchbg="ruby ~/fetch.rb"

alias refresh_workspaces="./refresh_workspaces.sh"

alias g="git"

alias vboxcompact="VBoxManage modifyhd --compact ~/VirtualBox/Windows\ 7\ New/Windows\ 7\ New.vdi"


## }}}


## EXPORTS {{{

# colored manpages
if $_isxrunning; then
	export PAGER=less
	export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
	export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
	export LESS_TERMCAP_me=$'\E[0m'           # end mode
	export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
	export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
	export LESS_TERMCAP_ue=$'\E[0m'           # end underline
	export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
fi

# make multiple shell share same history file
export HISTSIZE=10000           # bash history will save N commands
export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history:c'

export EDITOR="vim"
#export PATH=/usr/share/local/bin:$PATH
export PATH=/home/mark/scripts:$PATH
export PATH="`ruby -e 'print Gem.user_dir'`/bin:$PATH"
#export PS1="${fd}> ${nofg}"
export XDG_MUSIC_DIR=/home/mark/Music

export LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so'

weather() { curl wttr.in/"$1"; }

#eval $(ssh-agent)
#ssh-add

#fun

eval $(thefuck --alias)

#PS1='┌──╼ [\w]\n└─────╼ '

if [ -f /usr/lib/bash-git-prompt/gitprompt.sh ]; then
               # To only show the git prompt in or under a repository directory
               # GIT_PROMPT_ONLY_IN_REPO=1
               # To use upstream's default theme
               # GIT_PROMPT_THEME=Default
               # To use upstream's default theme, modified by arch maintainer
               GIT_PROMPT_THEME="Custom"
               source /usr/lib/bash-git-prompt/gitprompt.sh
fi

# added by travis gem
[ -f /home/mark/.travis/travis.sh ] && source /home/mark/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
