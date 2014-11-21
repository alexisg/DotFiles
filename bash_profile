# Set path for brew, then use Dropbox Dotfiles, then android sdk
export PATH=/usr/local/bin:/usr/local/sbin:~/Dropbox/Documents/DotFiles/bin:~/Library/Flex/flex_sdk_4.6/bin:~/android/sdk/tools:$PATH

# Fancy sweet ass colors in terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Set Path in terminal to show current user logged in current path - current git branch - git status if dirty
export PS1='<\[\033[0;35m\]\h\[\033[0m\]:\[\033[0;33m\]\u\[\033[0m\] : \[\033[1;36m\]\w\[\033[0m\] \[\033[0;35m\]$(gitify)\[\033[0m\]> '

# EVAL for Twitch junk
eval "$(rbenv init -)"
export CC=/usr/local/bin/gcc-4.2
export CXX=/usr/local/bin/g++-4.2

export PATH="/Users/alexisgallisa/Library/Flex/flex_sdk_4.6/bin":$PATH
export FLEX_HOME="/Users/alexisgallisa/Library/Flex/flex_sdk_4.6"


# Function Aliases
# ------------------------------------------------------------------------------

# These functions are run to populate the path in terminal
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git-branch-name {
	echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function git-dirty {
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st != "nothing to commit, working directory clean" ]]
    then
        echo " *You have shit to add or push"
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

# Project Root
projects_root=~/cbs

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

# Performs git functions on all git projects in $projects_root
# and returns user to the directory they executed gall from
function gall() {
    cd $projects_root
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
    cd -
}

# clear app cache
function delcache() {
    dir=`pwd`
    buf=${dir#*$projects_root/}
    dirlen=$((${#dir}))
    buflen=$((${#buf}))
    deleted=false

    if (( dirlen > bufflen )); then
        project=${buf%%/*}
        project_root=$projects_root/$project
        project_dir=${buf#$project}

        if [ "$project" != '' ]; then
            echo "Deleting app/cache for $project"

            cd $project_root

            appcache=`find app/cache/* -type d -maxdepth 0`

            if [ "${appcache[0]}" != '' ]; then
                rm -rf app/cache/*
                echo "...completed"
                deleted=true
            else
                echo "No app/cache to delete"
            fi

            if [ "$project_dir" != "" ] && [[ $project_dir != /app/cache/* ]]; then
                cd -
            fi
        else
            echo "Not in a project!"
        fi
    else
        echo "Not in a project!"
    fi
}

# restart PHP NGINX memcached
function restart() {
    if [ $1 == 'php' ]; then
        echo "Restarting php"
        launchctl unload -w ~/Library/LaunchAgents/php54.plist
        launchctl load -w ~/Library/LaunchAgents/php54.plist
    fi
    if [ $1 == 'nginx' ]; then
        echo "Restarting nginx"
        nginx -s reload
    fi
    if [ $1 == 'memcached' ]; then
        echo "Restarting memcached"
        killall memcached
        launchctl unload -w ~/Library/LaunchAgents/memcached.plist
        launchctl load -w ~/Library/LaunchAgents/memcached.plist
    fi
    if [ $1 == 'all' ]; then
        restart nginx
        restart php
        restart memcached
        delcache
    fi
}


# Edit bash profile in dropbox and then reload using source in terminal
# mate assumes you have Textmate command line tools set but you could also use VI,VIM,PICO,EMACS,Sublime,etc
# To point your bash profile to a file hosted on dropbox make a symbolic link like so
# ---------------------------------------------------------------
# ln -s ~/Dropbox/Documents/DotFiles/bash_profile ~/.bash_profile
# ---------------------------------------------------------------
    alias so="source ~/.bash_profile"
    alias profile="sub ~/Dropbox/Documents/DotFiles/bash_profile"

# List directory contents with/without invisibles
# -----------------------------------------------
    alias la="ls -la"
    alias ll="ls -l"

# Open files or directories in Sublime 2. Use "sub ." to open directory
# ---------------------------------------------------------------------
    alias sub='open -a "Sublime Text 2"'

# Make Git life easier with these aliases
# ---------------------------------------
    alias co="git checkout"
    alias push="git push"

    # Use rebase as base pull. If pull merge fails you may need to abort the rebase
    alias pull="git pull --stat"
    alias abort="git rebase --abort"
    alias ci="git commit -a -m"
    alias stat="git status"
    alias add="git add"
    alias merge="git merge"
    alias reset="git reset --hard"
    alias diff="git diff"
    alias stash="git stash"
    alias pop="git stash pop"
    alias wtf="gg wtf"

    # CBS Git Aliases - bye bye :(

    # Tail the gb dev.log
    alias tailgb="gb && tail -f app/logs/dev.log"
    alias tailgs="gs && tail -f app/logs/dev.log"

    #View all of user's commits
    alias loga="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='Alexis' --stat"
    alias logal="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='Allen' --stat"
    alias logj="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='jarques' --stat"
    alias logb="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='Bryan' --stat"
    alias loge="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='Elsie' --stat"
    alias logt="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=short  --all --since=1.week.ago --author='thomas' --stat"

# Path Aliases
# -------------
    alias cbs="cd ~/cbs"
    alias ph="cd ~/cbs/phoenix"
    alias gb="cd ~/cbs/giantbomb"
    alias cv="cd ~/cbs/comicvine"
    alias gs="cd ~/cbs/gamespot"
    alias es="cd ~/cbs/esports"
    alias gh="cd ~/github/"
    alias dp="cd ~/Dropbox"

    alias home="cd ~"
    alias ag="cd ~/webhook/alexisgallisa"

    alias tw="cd ~/twitch/web"


# Twitch Aliases
# --------------
    alias ptw="tw && co master && pull"
    alias ptw2="tw && co optimize-sass && pull"
    alias ptw3="tw && co nkss && pull"


# Compass Style Aliases - Eveyone should use a css compiler
# ---------------------------------------------------------
    alias watch="compass watch"
    alias force="compass compile --force && watch"

    # Compass Compile Status, Watch and Force commands

    alias sgs="gs && compass stats -c src/Gamespot/SiteBundle/Resources/sass/config.rb --output-style compressed --force"
    alias wgs="gs && compass compile -c src/Gamespot/SiteBundle/Resources/sass/config.rb --force && compass watch -c src/Gamespot/SiteBundle/Resources/sass/config.rb"
    alias fgs="gs && compass compile -c src/Gamespot/SiteBundle/Resources/sass/config.rb --force"
    alias bgs="cgs && blessc ~/cbs/gamespot/src/Gamespot/SiteBundle/Resources/public/css/gamespot_white.css --force  && blessc ~/cbs/gamespot/src/Gamespot/SiteBundle/Resources/public/css/gamespot_black.css --force"

    alias wwgs="gs && cd src/Gamespot/SiteBundle/Resources/sass && sass --compass --watch  gamespot_white.sass:../public/css/gamespot_white.css"

    # Use sassymedia.py to recompile all 8000 media queries into only as many that are needed (less than 10)
    alias sassygs="fgs && python ~/Dropbox/Documents/DotFiles/sassymedia.py ~/cbs/gamespot/src/Gamespot/SiteBundle/Resources/public/css/gamespot_white.css"

    # Grab CSS stats on GS css
    alias statgs="stylestats /Volumes/CBSi/gamespot/src/Gamespot/SiteBundle/Resources/public/css/gamespot_white.css"

    # Grab CSS stats on TW css
    alias stattw="stylestats http://localhost.twitch.tv:3000/assets/application.css?body=1"
    alias stattww="stylestats http://www-cdn.jtvnw.net/assets/application-854c668869ffcd58b7e7f06657195a91.css"

# Misc Aliases Edit Hosts and nginx files with TextMate - SSH into appletv for jailbreaking
# -----------------------------------------------------------------------------------------
    alias edithosts="sub /etc/hosts"
    alias editng="sub /usr/local/etc/nginx/nginx.conf"
    alias editphp="sub /usr/local/etc/php/5.4/php.ini"
    alias atv="ssh root@Apple-tv.local"
    alias cphp="php app/console --env=dev cache:clear"

    # Sometime PHP and Nginx are jerks and need to be rebooted
    alias phpstart="launchctl unload -w ~/Library/LaunchAgents/php54.plist && launchctl load -w ~/Library/LaunchAgents/php54.plist"
    alias ngstart="nginx -s reload"
    alias webstart="ngstart && phpstart"

# Push to production
alias deployph="ph && co master && pull && co prod-gb && git merge master && push && co prod-cv && git merge master && push && co master && gb && co master && pull && co prod && pull && git merge master && co master && cv && co master && pull && co prod && pull && git merge master && co master"

alias deploycv="ph && co master && pull && co prod-cv && git merge master && push && co master && cv && co master && pull && co prod && pull && git merge master && push && co master"

alias deploygs="ph && co master && pull && co prod-gs && pull && git merge master && push && co master && gs && co master && pull && co prod && pull && git merge master && push && co master"

alias deploygb="ph && co master && pull && co prod-gb && pull && git merge master && push && co master && gb && co master && pull && co prod && pull && git merge master && push && co master"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
