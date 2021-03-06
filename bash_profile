# Set path for brew, then use Dropbox Dotfiles, then android sdk
PATH=/usr/local/bin:~/Dropbox\ \(Personal\)/Documents/DotFiles/bin:$PATH

# To point your bash profile to a file hosted on dropbox make a symbolic link like so
# Replace the path with your own drive path
# -----------------------------------------------------------------------------------
# ln -s ~/Dropbox\ \(Personal\)/Documents/DotFiles/bash_profile ~/.bash_profile

# Edit bash profile in dropbox using vscode `code` and then use source  quickly with `so`
# --------------------------------------------------------------------------------------
alias profile="code ~/Dropbox\ \(Personal\)/Documents/DotFiles/bash_profile"
alias so="source ~/.bash_profile"


# Fancy colors in terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Set Path in terminal to show current user logged in current path - current git branch - git status if dirty
export PS1='\[\033[1;36m\]\w\[\033[0m\] \[\033[0;35m\]$(gitify)\[\033[0m\] =^.^= : '

# Use Brew Bash Autocomplete `brew install bash-completion`
# --------------------------------------------------------
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Source git completion bash from git and other source files as needed
# --------------------------------------------------------------------
source ~/Dropbox\ \(Personal\)/Documents/DotFiles/git-completion.bash
source ~/Dropbox\ \(Personal\)/Documents/DotFiles/bash_profile_android.bash

# Function Aliases
# ----------------

# These functions are run to populate the path in terminal
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git-branch-name {
	echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function git-dirty {
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st != "nothing to commit, working tree clean" ]]
    then
        echo " *SHIT TODO"
    fi
}

function git-unpushed {
    brinfo=$(git branch -v | grep $(git-branch-name))
    if [[ $brinfo =~ ("[ahead "([[:digit:]]*)) ]]
    then
        echo "(${BASH_REMATCH[2]})"
    fi
}

function gitify {
    status=$(git status 2>/dev/null | tail -n 1)
    if [[ $status == "" ]]
    then
        echo ""
    else
        echo $(git-branch-name)$(git-dirty)$(git-unpushed)
    fi
}

# This function allows you to run git commands recursively through directories
function gg() {
    find . \
        -mindepth 1 -maxdepth 2 \
        -type d -name .git \
    | while read git_dir; do
        dir=`dirname $git_dir`
        echo $dir:
        cd $dir
        git $*
        cd - >/dev/null
        echo ""
    done
}

# Kill rails when it gets stuck by parsing its server pid file
function killrails() {
    kill -9 $(cat ~/twitch/web/tmp/pids/server.pid)
}

# Kill 8888 when it gets stuck
function kill8888() {
    kill -9 $(lsof -ti tcp:8888)
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
    alias dt="git difftool"
    alias stash="git stash"
    alias pop="git stash pop"
    alias wtf="gg wtf"
    alias gsub="git submodule update --recursive"
    alias yi="yarn"
    alias ys="yarn start"
    alias yb="yarn build"
    alias yis="yarn && yarn start"
    alias svg="svgo --config=/Users/alexisgallisa/.svgo-config.yml"
    alias gmuv="git fetch origin && git merge origin/ultraviolet"

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
    alias ag="cd ~/webhook/alexisgallisa"

# Twitch Aliases
# --------------

    alias tw="cd ~/twitch/twilight"
    alias tc="cd ~/twitch/core-ui"
    alias tu="cd ~/twitch/ui-prototype-tool"
    alias ts="cd ~/twitch/styles"
    # alias grunts="grunt base --live-reload false"
    alias gopen="grunt open:styles"

    alias con="cd ~/twitch/twitchcon"
    alias con2="cd ~/twitch/twitchcon-static"

    alias nes="npm install && ember serve"
    alias es="ember serve --live-reload false"
    alias rs="bundle exec rails s"

    # Grab CSS stats on TW css
    alias statapp="stylestats ~/twitch/styles/static/css/application.css"
    alias statsg="stylestats ~/twitch/styles/static/css/styleguide.css"
    alias statweb="stylestats https://web-cdn.ttvnw.net/styles/application.css"

# Misc Aliases Edit Hosts and nginx files with TextMate - SSH into appletv for jailbreaking
# -----------------------------------------------------------------------------------------
    alias edithosts="code /etc/hosts"
    alias editng="code /usr/local/etc/nginx/nginx.conf"
    alias editphp="code /usr/local/etc/php/5.4/php.ini"
    alias atv="ssh root@Apple-tv.local"

    # Sometime PHP and Nginx are jerks and need to be rebooted or cleared
    alias phpstart="launchctl unload -w ~/Library/LaunchAgents/php54.plist && launchctl load -w ~/Library/LaunchAgents/php54.plist"
    alias ngstart="nginx -s reload"
    alias webstart="ngstart && phpstart"
    alias cphp="php app/console --env=dev cache:clear"
    alias simpleserve="python -m SimpleHTTPServer 8000"


# Use NVM for Node management
# ---------------------------
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"


# Use GVM for Go management
# -------------------------
[[ -s "/Users/agallisa/.gvm/scripts/gvm" ]] && source "/Users/agallisa/.gvm/scripts/gvm"
export GOPATH=~/go
PATH=$GOPATH/bin:$PATH
