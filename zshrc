# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/usr/local/google/home/kylelund/.oh-my-zsh"

ZSH_THEME="bira"

# Case and hyphen sensitive completion
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

# Plugins, see https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# vi mode
bindkey -v
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

# Ignore duplicates in command history
# Note: This increases the command prompt loading time
setopt HIST_IGNORE_ALL_DUPS

# Aliases
alias find-in-file="find -type f -print0 | xargs -0 grep -s"
alias find-file="find -type f | grep -s"
alias :q=exit
alias vim=nvim
function replace {
  find -type f | xargs sed -i -e "s/${1}/${2}/g"
}

# FZF config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
