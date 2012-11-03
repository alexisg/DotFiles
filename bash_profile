export PATH=/usr/local/bin:/usr/local/sbin:$PATH
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
    if [[ $st != "nothing to commit (working directory clean)" ]]
    then
        echo " *You have shit to add "
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

    # CBS Git Aliases
    # Recursively run pull in all directories found in CBS dir
    alias pcbs="cd ~/cbs && gg pull && ph"
    # Recursively run pull in gb needed directories only
    alias pgb="gb && pull && ph && pull"
    alias scbs="cd ~/cbs && gg status && ph"
    # alias rcbs="cd ~/cbs && gg rel && ph"
    alias mr="gb && make resources && echo '**! Made resources in giantbomb yo!**' && ph"
    alias vu="gb && make vendor-update && echo '**! Vendor Update in giantbomb yo!**' && ph"


# Compass Style Aliases - Eveyone should use a css compiler
# ---------------------------------------------------------
    alias watch="compass watch"
    alias force="compass compile --force && watch"

    # Compass Compile Giant Bomb Status, Watch and Force commands
    alias sgb="gb && compass stats -c src/Giantbomb/SiteBundle/Resources/sass/config.rb --output-style compressed --force"
    alias wgb="gb && compass watch -c src/Giantbomb/SiteBundle/Resources/sass/config.rb"
    alias wph="gb && compass watch -c vendor/phoenix/Phoenix/CmsBundle/Resources/sass/config.rb"

    alias fgb="gb && compass compile --force -c src/Giantbomb/SiteBundle/Resources/sass/config.rb"
    alias fph="gb && compass compile --force -c vendor/phoenix/Phoenix/CmsBundle/Resources/sass/config.rb"


# Path Aliases
# -------------
    alias cbs="cd ~/cbs"
    alias ph="cd ~/cbs/phoenix"
    alias gb="cd ~/cbs/giantbomb"
    alias chat="cd ~/cbs/Chat-o-saurus/"
    alias cg="cd ~/git/"
    alias home="cd ~"

    alias vines="cd ~/whiskey/vines"
    alias gb2="cd ~/whiskey/giantbomb"
    alias cv2="cd ~/whiskey/comicvine"

    alias ag="cd ~/Sites/alexisgallisa"


# Misc Aliases Edit Hosts and nginx files with TextMate - SSH into appletv for jailbreaking
# -----------------------------------------------------------------------------------------
    alias edithosts="mate /etc/hosts"
    alias ngconf="mate /usr/local/etc/nginx/nginx.conf"
    alias atv="ssh root@Apple-tv.local"

