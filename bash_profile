source /usr/local/bin/virtualenvwrapper.sh
export VIRTUALENV_USE_DISTRIBUTE=true
export PYTHONDONTWRITEBYTECODE=1
export PATH=~/bin:/usr/local/sbin:/Library/PostgreSQL8/bin:~/Dropbox/Documents/DotFiles/bin:$PATH
export PS1='<\[\033[0;35m\]\h\[\033[0m\]:\[\033[0;33m\]\u\[\033[0m\] : \[\033[1;36m\]\w\[\033[0m\] \[\033[0;35m\]$(gitify)\[\033[0m\]> '
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git-branch-name {
	echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function git-dirty {
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st != "nothing to commit (working directory clean)" ]]
    then
        echo "*"
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

alias ll="ls -l"
alias la="ls -la"
alias so="source ~/.bash_profile"
alias sub='open -a "Sublime Text 2"'
alias atv="ssh root@Apple-tv.local"

alias rs="make server"
alias rsip="php -S 0.0.0.0:9001 -t web"
alias rsgb="gb && foreman start"

alias wphp="php app/console assetic:dump --env=dev --watch"
alias cphp="php app/console --env=dev cache:clear"

#Git Aliases
alias co="git checkout"
alias push="git push"
alias pull="git pull"
alias ci="git commit -a -m"
alias stat="git status"
alias add="git add"
alias merge="git merge"
alias reset="git reset --hard"
alias diff="git diff"
alias stash="git stash"
alias pop="git stash pop"

#CBS Git Aliases
alias pcbs="cd ~/cbs && gg pull"
alias scbs="cd ~/cbs && gg status"
alias rcbs="cd ~/cbs && gg rel"

# Compass Aliases
alias watch="compass watch"
alias force="compass compile --force && watch"
# Compass Force Compile GB
alias fgb="gb && compass compile --force -c src/Giantbomb/SiteBundle/Resources/sass/config.rb"

# Path Aliases
alias cbs="cd ~/cbs"
alias bc="cd ~/cbs/beacon"
alias cr="cd ~/cbs/core"
alias gb="cd ~/cbs/giantbomb"

alias vines="cd ~/whiskey/vines"
alias gb2="cd ~/whiskey/giantbomb"

alias ag="cd ~/Sites/alexisgallisa"

# Misc Aliases
alias ve="workon whiskey"
alias profile="mate ~/Dropbox/Documents/DotFiles/bash_profile"

EVENT_NOKQUEUE=1
