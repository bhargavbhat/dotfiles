# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# completion support
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# history options
HISTCONTROL=ignoreboth
HISTSIZE=2000
HISTFILESIZE=4000
shopt -s histappend

# misc options
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# prompt stuff
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

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
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#git completion support
[ -r /etc/bash_completion.d/git ] && . /etc/bash_completion.d/git
[ -r /usr/share/git-core/contrib/completion/git-prompt.sh ] && . /usr/share/git-core/contrib/completion/git-prompt.sh

# my functions & aliases
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        p7zip -d $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

modfiles() {
	find . -mtime -$1 -type f \( -iname \*.xml -o -iname \*.h -o -iname \*.cpp -o -iname \*.c -o -iname \*.am \)
}

zipmodfiles() {
	find . -mtime -$1 -type f \( -iname \*.xml -o -iname \*.h -o -iname \*.cpp -o -iname \*.c -o -iname \*.am \) | xargs zip /mnt/share/changeset_$(date "+%b_%d_%Y_%H_%M_%S").zip
}

codeformat() {
	# Tool from : https://github.com/x8o1Y/EclipseCCodeFormatter
	find . -mtime -$1 -type f \( -iname \*.h -o -iname \*.cpp -o -iname \*.c \)	| xargs java -jar ~/CCodeFormatterApp.jar -verbose -config ~/codingstandards.pref
}
