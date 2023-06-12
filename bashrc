# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\033[01;33m\][\D{%y-%m-%d} \t]\[\033[00m\]\[\033[01;32m\][\!]\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;37m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w \[\033[00m\]\n \[\033[05;35m\]\$ \[\033[00m\]"
    #PS1="\h@\u \w \$ "
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lh'
alias la='ls -alt'
alias l='ls -CF'
alias lt='ls -latF'
alias lh='ls -lhF'
alias cman='man -M /usr/share/man/zh_CN'
alias v='/home/ypy/scripts/dealstr_vim.sh'
alias g='/home/ypy/scripts/dealstr_gvim.sh'
alias vscode='/snap/bin/code'

alias mp='screen /home/ypy/tools/os/p95v298b6/mprime &'
alias s='screen'

alias vb='vim ~/.bashrc'
alias sb='source ~/.bashrc && echo Bash config reloaded'
alias eclipse='/home/ypy/tools/os/eclipse/eclipse &'
alias bc='/home/ypy/scripts/bcompare_run.sh &'
alias bcompare='/bin/rm -rf /home/ypy/.config/bcompare/registry.dat; /usr/bin/bcompare '
alias rm='/home/ypy/scripts/rm_file.sh'
alias rmrm='/bin/rm'

alias astyle='astyle -A1 -s4 -S -N -j -m0 -M40 -c -U -H -p -n -q '
alias gencsfile='find `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files'
# tag generate
alias tgg='echo "tag generate ..."; ctags -R *; find `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files; cscope -Rbq; echo "Finish."'
# tag clean
alias tgc='echo "tag cleaned"; rm cscope.* tags'
alias duall='du -h --max-depth=1'

alias mk='make clean; make'
alias backupfile='/home/ypy/code/backupfile.sh'
alias grep-c='grep $1 -rn --include="*.c" --include="*.h" --include="*.hpp" --include="*.cpp" --include="*.cxx" --include="*.cc" --include="Makefile*"'
alias grep-p='grep $1 -rn --include="*.py"'
alias grep-g='grep $1 -rn --include="*.peg"'
alias find-c='find . -name "*.h" -o -name "*.c"'
alias python='python3'
#alias mkcd='foo(){ echo "xx" }; foo'
alias install='sudo apt-get install'
alias update='sudo apt-get install update; sudo apt-get upgrade'
alias ..='cd ..'
alias ...='cd ../../'
alias fd='fdfind'
alias pwgen='pwgen -s'
alias hh='cat -n ~/help; cp ~/help ~/help.bk'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi
