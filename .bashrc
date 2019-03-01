export PATH=$PATH:/root/scripts:/usr/share/metasploit-framework/tools/exploit

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

neofetch

# Fill with underscore ___ or minuses ---
# (this is recalculated every time the prompt is shown in function prompt_command):
fill="___ "
reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
command_style=$reset_style
prompt_style=$reset_style'\[\033[1;29m\]' # bold black

#PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\[\e[1;33m\][\[\e[m\]\[\e[1;34m\]\u\[\e[m\]\[\e[1;33m\]@\[\e[m\]\[\e[1;34m\]\h\[\e[m\]\[\e[1;33m\]:\[\e[m\] \[\e[1;34m\]\W\[\e[m\]\[\e[1;33m\]]\[\e[m\]\[\e[1;33m\]\\$\[\e[m\]'"$command_style "
PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\[\033[38;5;247m\][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;247m\]@\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;15m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;247m\]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;247m\]]\\$\[$(tput sgr0)\]'"$command_style "

# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\033[00m"' DEBUG

function prompt_command {
	# create a $fill of all screen width minus the time string and a space:
	let fillsize=${COLUMNS}-9
	fill=""

	while [ "$fillsize" -gt "0" ]
	do
		fill="-${fill}" # fill with underscores to work on
		let fillsize=${fillsize}-1
	done
}

PROMPT_COMMAND=prompt_command
