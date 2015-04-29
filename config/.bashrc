# Turn off console beep.
echo -ne '\033[11;0]'
xset -b

# Prompt looks
PS1="\[\e[36m\]\u@\h \${?} \$:\w\n%\[\e[33m\] "
EDITOR='vim'

alias mplayer="mplayer -fs"
alias ls="ls --color=never -F -h -X"
alias stick="cd /media/seth/GreenStick/p; ls; source /media/seth/GreenStick/x/env.sh"

clear
echo -n " ▶ "; ls
echo
