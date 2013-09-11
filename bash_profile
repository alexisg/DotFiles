# Set path for brew, then use Dropbox Dotfiles, then android sdk
export PATH=/usr/local/bin:/usr/local/sbin:~/Dropbox/Documents/DotFiles/bin:~/android/sdk/tools:$PATH

# Fancy sweet ass colors in terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Set Path in terminal to show current user logged in current path - current git branch - git status if dirty
export PS1='<\[\033[0;35m\]\h\[\033[0m\]:\[\033[0;33m\]\u\[\033[0m\] : \[\033[1;36m\]\w\[\033[0m\] \[\033[0;35m\]$(gitify)\[\033[0m\]> '


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


# Edit bash profile in dropbox and then reload using source in terminal
# mate assumes you have Textmate command line tools set but you could also use VI,VIM,PICO,EMACS,Sublime,etc
# To point your bash profile to a file hosted on dropbox make a symbolic link like so
# ---------------------------------------------------------------
# ln -s ~/Dropbox/Documents/DotFiles/bash_profile ~/.bash_profile
# ---------------------------------------------------------------
    alias so="source ~/.bash_profile"
    alias profile="mate ~/Dropbox/Documents/DotFiles/bash_profile"

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
    alias pull="git pull --rebase"
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

    # CBS Git Aliases
    # Recursively run pull in all directories found in CBS dir
    alias pcbs="cd ~/cbs && gg pull && ph"
    # Recursively run pull in gb needed directories only
    alias pgb="ph && co master && pull && gb && co master && pull && make js && ph"
    alias pgs="ph && co triforce && pull && gs && co master && pull"
    alias pcv="ph && co master && pull && cv && co master && pull && make js && ph"

    alias pgball="gb && co prod && pull && co master && pull && ph && co prod-gb && pull && co master && pull"

    # Status of all cbs repositories using git wtf
    alias scbs="cd ~/cbs && gg wtf && ph"
    alias sph="gb && co prod && wtf && co master && wtf && ph && co prod-gb && wtf && co master && wtf"

    # Make Resources, Vendor Update and Cache Clear
    alias mr="make resources"
    alias vu="make vendor-update"
    alias cache="make cache-clear"
    alias mc="make cache-clear"

    # Boot up node for chat server
    alias chat="cd ~/cbs/Chat-o-saurus && node app.js"

    # Tail the gb dev.log
    alias tailgb="gb && tail -f app/logs/dev.log"

    # Watch Assetic JS
    alias wjs="php app/console assetic:dump --watch"


# Compass Style Aliases - Eveyone should use a css compiler
# ---------------------------------------------------------
    alias watch="compass watch"
    alias force="compass compile --force && watch"

    # Compass Compile Status, Watch and Force commands
    alias sgb="gb && compass stats -c src/Giantbomb/SiteBundle/Resources/sass/config.rb --output-style compressed --force"
    alias wgb="gb && compass watch -c src/Giantbomb/SiteBundle/Resources/sass/config.rb"
    alias fgb="gb && compass compile -c src/Giantbomb/SiteBundle/Resources/sass/config.rb --force"

    alias scv="cv && compass stats -c src/Comicvine/SiteBundle/Resources/sass/config.rb --output-style compressed --force"
    alias wcv="cv && compass watch -c src/Comicvine/SiteBundle/Resources/sass/config.rb"
    alias fcv="cv && compass compile -c src/Comicvine/SiteBundle/Resources/sass/config.rb --force"
    
    alias sph="gb && compass stats -c vendor/phoenix/Phoenix/CmsBundle/Resources/sass/config.rb --output-style compressed --force"
    alias wph="gb && compass watch -c vendor/phoenix/Phoenix/CmsBundle/Resources/sass/config.rb"
    alias fph="gb && compass compile -c vendor/phoenix/Phoenix/CmsBundle/Resources/sass/config.rb --force"

    alias sgs="gs && compass stats -c src/Gamespot/SiteBundle/Resources/sass/config.rb --output-style compressed --force"
    alias wgs="gs && compass compile -c src/Gamespot/SiteBundle/Resources/sass/config.rb --force && compass watch -c src/Gamespot/SiteBundle/Resources/sass/config.rb"
    alias fgs="gs && compass compile -c src/Gamespot/SiteBundle/Resources/sass/config.rb --force"


    # Use sassymedia.py to recompile all 8000 media queries into only as many that are needed (less than 10)
    alias sassy="fgb && python ~/Dropbox/Documents/DotFiles/sassymedia.py ~/cbs/giantbomb/src/Giantbomb/SiteBundle/Resources/public/css/giantbomb_white.css"


# Path Aliases
# -------------
    alias cbs="cd ~/cbs"
    alias ph="cd ~/cbs/phoenix"
    alias gb="cd ~/cbs/giantbomb"
    alias cv="cd ~/cbs/comicvine"
    alias gs="cd ~/cbs/gamespot"
    alias cg="cd ~/git/"
    alias home="cd ~"

    

# Misc Aliases Edit Hosts and nginx files with TextMate - SSH into appletv for jailbreaking
# -----------------------------------------------------------------------------------------
    alias edithosts="sudo mate /etc/hosts"
    alias editng="sudo mate /usr/local/etc/nginx/nginx.conf"
    alias editphp="sudo mate /usr/local/etc/php/5.4/php.ini"
    alias atv="ssh root@Apple-tv.local"
    alias cphp="php app/console --env=dev cache:clear"
    
    # Sometime PHP and Nginx are jerks and need to be rebooted
    alias phpstart="launchctl unload -w ~/Library/LaunchAgents/php54.plist && launchctl load -w ~/Library/LaunchAgents/php54.plist"
    alias ngstart="nginx -s reload"
    alias webstart="ngstart && phpstart"

# Push to production
alias deployph="ph && co master && pull && co prod-gb && git merge master && push && co prod-cv && git merge master && push && co master && gb && co master && pull && co prod && pull && git merge master && co master && cv && co master && pull && co prod && pull && git merge master && co master"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
