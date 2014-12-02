# Turn off console beep.
echo -ne '\033[11;0]'
xset -b

# Prompt looks (DD MMM HH:MM {user}@{host} {last return code} $:{path} newline % {prompt}
# Prompt is teal, while text is yellow/orange
PS1="\[\e[36m\]$(date +%d\ %b\ %H:%M) \u@\h \${?} \$:\w\n%\[\e[33m\] "
EDITOR='vim'

export GOPATH=$HOME/.go

export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.bin

alias mplayer="mplayer -fs"
alias ls="ls --color"

clear
