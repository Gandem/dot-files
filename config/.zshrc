# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=/Users/gandem/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="253"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="027"
POWERLEVEL9K_DIR_BACKGROUND="123"
POWERLEVEL9K_CARRIAGE_RETURN_ICON=$'\u2718'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

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

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

################
# 1. Aliases   #
################

# Asking for confirmation before deleting a file
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Some 'ls' aliases
alias ls='ls -hGFw'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Aliases
alias e='emacs'
alias c='clear'
alias less='less -q'
alias s='cd ..'
alias df='df -h'
alias du='du -h'

####################
# 2. zsh options   #
####################

# Ask confirmation for 'rm *'
unsetopt rm_star_silent

######################
# 3. Overriding path #
######################

# Setting GOPATH
export GOPATH=$HOME/.local
PATH=$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH

################################
# 4. Creating correct git conf #
################################

GIT_PATH=$(which git)

function git() {
    for i do
        lastArgument=$i
    done

    args=
    for arg in "$@";
    do
        args="$args '$arg'"
    done

    eval $GIT_PATH $args

    if [[ $? -eq 0 ]]
    then
        if [[ "$1" = "init" || "$1" = "clone" ]]
        then
            if [[ -d "$lastArgument" ]]
            then
                cd $lastArgument
            else if [[ "$lastArgument" != "init" && "$lastArgument" != "clone" ]]
            then
                cd $(echo $lastArgument | awk -F/ '{ print $NF }' | rev | sed 's/tig.//' | rev)
            fi
            fi
        git-email-prompt.sh
        fi
    else
        return $?
    fi
}

################################
# 5. Start Wunderline          #
################################

# wunderline.sh
