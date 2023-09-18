# ln -s ~/Dropbox/Documents/DotFiles/zshrc ~/.zshrc

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias profile="code ~/.zshrc"
alias so="source ~/.zshrc"

prompt_context() {
  # Custom (Random emoji)
  emojis=("💩" "💇" "🐸" "🐵" "🦄" "🌈")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment black default "${emojis[$RAND_EMOJI_N]} "
}

# List directory contents with/without invisibles
# -----------------------------------------------
    alias la="ls -la"
    alias ll="ls -l"

# Open files or directories in Sublime. Use "sub ." to open directory
# -------------------------------------------------------------------
    alias sub='open -a "Sublime Text"'

# Make Git life easier with these aliases
# ---------------------------------------
    alias co="git checkout"
    alias cours="git checkout --ours"
    alias push="git push"

    # Use rebase as base pull. If pull merge fails you may need to abort the rebase
    alias pull="git pull --rebase --stat"
    alias abort="git rebase --abort"
    alias ci="git commit -a -m"
    alias stat="git status"
    alias add="git add"
    alias merge="git merge"
    alias reset="git reset --hard"
    alias diff="git diff"
    alias difftool="git difftool"
    alias dt="git difftool -y -t Kaleidoscope"
    alias stash="git stash"
    alias pop="git stash pop"
    alias wtf="gg wtf"
    alias gsub="git submodule update --recursive"
    alias yi="yarn"
    alias ys="yarn start"
    alias yb="yarn build"
    alias yis="yarn install --force && yarn start"
    alias gmuv="git fetch origin && git merge origin/ultraviolet"
    alias gb="git branch | sed"

    #View all of user's commits
    alias logall="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --stat --author-date-order"
    alias loga="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='Alexis' --stat"
    alias logj="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='jarques' --stat"


# Path Aliases
# -------------
    alias gh="cd ~/github/"
    alias dp="cd ~/Dropbox"
    alias home="cd ~"

    alias hook="cd ~/webhook/"
    alias ag="cd ~/github/alexisg/"

# Frame Aliases
# --------------
    alias vp="cd ~/github/vapor"
    alias vd="cd ~/github/vapor/apps/sanity-docs"
    alias vn="cd ~/github/vapor-newsletters"
    alias vs="cd ~/github/vapor/packages/vapor-icons"
    alias wa="cd ~/github/web-app"


# Misc Aliases Edit Hosts and nginx files with TextMate - SSH into appletv for jailbreaking
# -----------------------------------------------------------------------------------------
    alias edithosts="code /etc/hosts"
    alias editng="code /usr/local/etc/nginx/nginx.conf"
    alias editphp="code /usr/local/etc/php/5.4/php.ini"
    alias atv="ssh root@Apple-tv.local"

    # Use scour to optimize a directory of SVGs
    alias svg="find . -name '*.svg' -type f -print0 | xargs -0 -I file scour --strip-xml-prolog --enable-id-stripping --remove-descriptions --remove-titles --remove-metadata  -i 'file' -o 'file-opt'"

    # Sometime PHP and Nginx are jerks and need to be rebooted or cleared
    alias phpstart="launchctl unload -w ~/Library/LaunchAgents/php54.plist && launchctl load -w ~/Library/LaunchAgents/php54.plist"
    alias ngstart="nginx -s reload"
    alias webstart="ngstart && phpstart"
    alias cphp="php app/console --env=dev cache:clear"
    alias simpleserve="python -m http.server 8000"
    alias es="eleventy --serve"

    # Kill Node Serve
    alias ks="killAll node"

    function https-server() {
        http-server --ssl --cert ~/.localhost-ssl/localhost.crt --key ~/.localhost-ssl/localhost.key
    }


# Use NVM for Node management
# ---------------------------
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# python3
alias python=/usr/bin/python3


# Use GVM for Go management
# -------------------------
export GOPRIVATE="github.com/Frameio"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH=~/go
PATH=$GOPATH/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Export path for yarn
# --------------------
export PATH=$PATH:~/.yarn/bin

# Load rbenv automatically by appending
# the following to ~/.zshrc:

# eval "$(rbenv init - zsh)"
