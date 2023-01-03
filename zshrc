# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

_fix_cursor() {
  echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Ignore duplicates in command history
# Note: This increases the command prompt loading time
setopt HIST_IGNORE_ALL_DUPS

# Aliases
alias find-in-file="find -type f -print0 | xargs -0 grep -s"
alias find-file="find -type f | grep -s"
alias :q=exit
function replace {
  find -type f | xargs sed -i -e "s/${1}/${2}/g"
}

# FZF config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'
# checkout git branch
function gch() {
  local branches branch
  branches=$(git --no-pager branch) &&
    branch=$(echo "$branches" | fzf +m --reverse --height 20%) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
# checkout and track remote branch
function gtr() {
  local branches branch
  branches=$(git --no-pager branch -r) &&
    branch=$(echo "$branches" | fzf +m --reverse --height 20%) &&
    git checkout --track $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
function gl() {
  local gitlog
  gitlog=$(git --no-pager log --oneline --graph -n 100)
  echo "$gitlog" | fzf +m --reverse --height 50%
}

alias nvreset='sudo modprobe -r nvidia_uvm && sudo modprobe nvidia_uvm'

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

#modify path
function add_to_path_if_exists() {
  [ -d "$1" ] && export PATH=$PATH:"$1"
}
add_to_path_if_exists $HOME/bin

# allow unlimited core file size
ulimit -c unlimited

export EDITOR='nvim'
alias vim=nvim

function mp4_to_gif {
  ffmpeg -i $1 -vf "fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $2
}

alias copy='xclip -i -selection clipboard'
alias paste='xclip -o -selection clipboard'

# automatically start tmux
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux
# fi
