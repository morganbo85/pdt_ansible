# set PATH so it includes user's private bin if it exists
if [ -d "/bmorgan/sbin" ] ; then
    export PATH="/bmorgan/sbin:$PATH"
fi

if [ -d "/bmorgan/bin" ] ; then
    export PATH="/bmorgan/bin:$PATH"
fi

if [ -d "/opt/MegaRAID" ] ; then
    export PATH=$PATH:/opt/MegaRAID/perccli
fi

#
# Combine all shell history
#
export PROMPT_COMMAND='history -a'
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%F %T "

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Read process shell functions`
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
if groups $USER | grep -q '\bdomain users\b'; then
    umask 002
fi
if groups $USER | grep -q '\bcamgian\b'; then
    umask 002
fi

