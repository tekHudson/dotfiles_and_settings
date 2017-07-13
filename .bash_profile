# Tek's .bash_profile
source ~/.profile

# Set the title for the window
function tabtitle {
    if [ -z "$1" ];
    then
        echo -ne "\033]0;"${PWD##*/}"\007"
    else
        echo -ne "\033]0;"$*"\007"
    fi
}

# Set environment variables for wcc-membership
export STRIPE_API_KEY=sk_test_m0BO5VKjSVTu2cmGnzh2b3C4
export STRIPE_PUBLISHABLE_KEY=pk_test_VwJQIPtFvYkyMCdtXKAbERBh

# User specific aliases and functions
# alias mdev='sshfs -p 22 dev@vm:/ ~/mountpoint -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=localDev'
alias mdev='mount_vm'
alias umdev='umount ~/mountpoint'
alias fs3='ssh dev@forms-staging3.on-site.com'
alias lsa='ls -lha'
alias vm='ssh dev@vm'
alias blog='cd ~/ps/tekked-out-blog'
alias tail='tail -f log/development.log'
alias vm='ssh vm'
alias gw="ssh -i ~/.ssh/key-rsa-khudson khudson@gw1"
alias dbreset='rake db:drop db:create db:migrate db:seed'
alias blog="ssh u78199971@u78199971.1and1-data.host"
alias mount_vm='sshfs dev@vm:/home/dev /Users/keith/mountpoint/'
alias spec='bin/rails test -v'

# Branch auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# source the vm helper if it exists
VM_HELPER_FILE=~/vm_helper
test -f $VM_HELPER_FILE && source $VM_HELPER_FILE

### Added by the Heroku Toolbelt
export PATH="/usr/local/bin:$PATH"

# Load RVM into a shell session *as a function*

# git branch parsing for pretty terminal
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export -f parse_git_branch

# pretify my terminal prompt
PS1='\[\033[01;32m\]\u\[\033[00m\]\[\033[0;35m\]@mac\[\033[00m\] \[\033[33m\]$(parse_git_branch)\[\033[00m\]\n\[\033[01;34m\]\w\[\033\
[00m\] \$ '

# Add RVM to PATH for scripting

# Add adb to PATH for android development
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Add history searching to up and down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
