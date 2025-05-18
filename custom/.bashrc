
source /etc/bash_completion.d/git-prompt
export PS1='\[[1;31m\]$(if [ $? != 0 ]; then echo "󰯆 "; fi)\[[1;35m\]\u@\h\[[0;37m\] \[[7;37m\]$(__git_ps1 "%s")\[[0;37m\] \[[1;34m\]\w\[[m\] \$ '
export PATH=/root/go/bin:$PATH
