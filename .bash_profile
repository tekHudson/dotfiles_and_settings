# Tek's .bash_profile
source ~/.profile

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Branch auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Set the title for the window
function tabtitle {
    if [ -z "$1" ];
    then
        echo -ne "\033]0;"${PWD##*/}"\007"
    else
        echo -ne "\033]0;"$*"\007"
    fi
}

# git branch parsing for pretty terminal
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export -f parse_git_branch

# Add history searching to up and down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# User specific aliases and functions
alias lsa='ls -lha'
alias blog='cd ~/ps/tekked-out-blog'
alias dbreset='rake db:drop db:create db:migrate db:seed'
alias spec='bin/rails test -v'

# pretify my terminal prompt
PS1='\[\033[01;32m\]\u\[\033[00m\]\[\033[0;35m\]@mac\[\033[00m\] \[\033[33m\]$(parse_git_branch)\[\033[00m\]\n\[\033[01;34m\]\w\[\033\
[00m\] \$ '
