# Keep 1000 lines in .bash_history (default is 500)
export HISTSIZE=1000
export HISTFILESIZE=1000

# Stop bash from caching duplicate lines.
HISTCONTROL=ignoredups

# Aktualizacja oprogramowania
alias update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'

# grep recursively words with line nubers without binary files
alias gr='grep -rwnI'

# create ctags
alias ct='ctags -R --exclude=.git --exclude=vendor --exclude=bin --exclude=var --exclude=public'
