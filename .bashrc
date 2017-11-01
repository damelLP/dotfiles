#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias vi="vim"
alias uniwork="ssh -X mbax4dl2@kilburn.cs.man.ac.uk"
alias gdbst="gdb --batch --ex run --ex bt --ex q --args"

# aws aliases
source ~/MachineLearning/fast.ai/aws-alias.sh

PS1='[\u@\h \W]\$ '
export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:~/scripts

export WORKON="~/.virtualenvs"
source /usr/bin/virtualenvwrapper.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/damel/.sdkman"
[[ -s "/home/damel/.sdkman/bin/sdkman-init.sh" ]] && source "/home/damel/.sdkman/bin/sdkman-init.sh"
export ANDROID_HOME=/home/damel/Android/Sdk

shopt -s histverify
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
alias basic_scan="nmap -sP 192.168.0.1-255"
