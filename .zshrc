export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/karl/.oh-my-zsh

export DEFAULT_USER="$USER"
export LIBGL_ALWAYS_INDIRECT=1

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
# ZSH_THEME="af-magic"
ZSH_THEME=""

# set Rust env variables
source ~/.cargo/env
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

export PATH=/home/karl/.local/bin:$PATH
export PATH=/home/karl/.cabal/bin:$PATH

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  python
  ripgrep
  shrink-path
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# set so Linux knows where the display is
# export DISPLAY=:0

# Python virtualenvrapper settings
export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

# import dir_colors
if [ -f ~/.dir_colors ]; then
    eval `dircolors ~/.dir_colors`
fi

# Activate vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M viins "jk" vi-cmd-mode
bindkey -M vicmd "^V" edit-command-line

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

export VISUAL='vim'
export EDITOR=$VISUAL

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias c="cd /mnt/c/"

alias sl="exa"
alias l="exa -lah --git"

alias zshconfig="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias home="cd /mnt/c/Users/KarlMcCarron/"
alias projects="cd /mnt/c/projects/"

# git aliases
alias gits="git status"
alias gitb="git branch"
alias gitd="git diff"
alias gitl="git log"
alias gitc="git checkout"
alias gitn="git checkout -b"
alias gc="git commit -av"
alias pruneold="git remote prune origin"

alias push="git push"
alias pull="git pull --all"

alias python="python3"

# emacs alias
# alias emacs="emacs25"

# use python3 instead of python
alias hyper="cmd.exe /c hyper"
alias remacs="~/remacs/src/remacs &"

# load "pure" prompt
fpath+=("$HOME/.zsh/pure")
autoload -U promptinit; promptinit
prompt pure

# turn off beeping
unsetopt beep
unsetopt BG_NICE

# compress directory path
# setopt prompt_subst
# PS1='%n@%m $(shrink_path -f)> '

#Change ls colours
LS_COLORS="ow=01;36;40" && export LS_COLORS

alias ls="exa"

#make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit
