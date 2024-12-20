export TERM=alacritty
export TERMINAL=$(which $TERM)

# Path to your oh-my-zsh installation.
export ZSH="/home/ralphpig/.oh-my-zsh"

bindkey -v

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"
# rkj-repos
# xiong-chiamiov
# ys
# bureau
# bira

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)



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


# 
# source
#
source $ZSH/oh-my-zsh.sh
# source <(kubectl completion zsh)
# source /usr/share/nvm/init-nvm.sh


# 
# vars
#

export PGDATA=/usr/local/pgsql/data

# 
# PATH
#
# export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$HOME/scripts:$PATH"
# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/games/bin:$PATH"
# export PATH="$(yarn global bin):$PATH"
# 
# # pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"

# 
# aliases
#

alias vim='nvim'
alias sp='sudo pacman'
alias cpwd='pwd | tee >(xclip -sel clip)' # copy and print cwd

alias config='git --git-dir=$HOME/.config.git/'

alias ssht='TERM=xterm-256color ssh'

#
# Functions
#
function pdf {
	mupdf $@ &> /dev/null &!
}

function calc {
	printf "%s\n" "$*" | bc -l
}
function bwu {
  export BW_SESSION=$(bw unlock --raw)
}

function randpass {
  LENGTH="${1:-64}"
  tr -cd '[:alnum:]' < /dev/urandom | head -c${LENGTH} | xclip -se clip
}

### Other Config
# https://superuser.com/a/767491
TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M MB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'


# nvm use --lts
source ~/.profile

# bun completions
[ -s "/home/ralphpig/.bun/_bun" ] && source "/home/ralphpig/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
