# ~/.bashrc: executed by bash(1) for non-login shells ie. /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
#!/bin/bash
iatest=$(expr index "$-" i)

##########################
# EXPORTS(Global Settings)
#########################

#No duplicate lines in the history&not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace:ignoreboth
# History ignore various commands
export HISTIGNORE="&:c:p:x:h:r:.:..:...:cd*:lc*:cl*:ls*:ll:la:ld:l.:lab:dt:ds:dn:db:df:ps:exit:clear:history*:*--help:man *"
# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# custom scripts
export PATH="${PATH}:${HOME}/.scripts"
# local executables
export PATH="${HOME}/.local/bin:${PATH}"
# local libraries
export LD_LIBRARY_PATH="${HOME}/.local/lib64:${HOME}/.local/lib32:${HOME}/.local/lib:/usr/local/lib64:/usr/local/lib32:/usr/local/lib:${LD_LIBRARY_PATH}"

# Set the default editor&terminal
export EDITOR="vim"
export SUDO_EDITOR="${EDITOR}"
export VISUAL="${EDITOR}"
export TERM="xterm-256color"                      # getting proper colors
export BROWSER="brave-browser-nightly"
#alias vim='nvim'


# Enable colors for ls& all grep cmds  grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    alias dir='dir --color=auto'
#    alias vdir='vdir --color=auto'



##########################
# ALIAS
#########################

alias checkcommand="type -t" #check  if cmd aliased/ file/ built-in cmd
alias cp='cp -i'
alias mv='mv -i'
alias rmd='/bin/rm  --recursive --force --verbose ' # Remove dir w/all files
alias less='less -R'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias aptup="sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove"
alias aptupd="sudo apt update"
alias aptupg="sudo apt upgrade"
alias apts="sudo apt search"
alias apti="sudo apt-get install"
alias c='clear'
alias cls="sudo apt autopurge && sudo apt autoremove && sudo apt autoclean apt && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s"
alias l="ls -ahl --color=auto"
#Top ten largest files in current dir
alias lgf='ls -1Rhs | sed -e "s/^ *//" | grep "^[0-9]" | sort -hr | head -n40'
#Top10 largest files/dirs in current directory
alias lga='du -ah . | sort -rh | head -40'
alias l.="ls -A | egrep '^\.'" # Only dotfiles
alias v="vim"
alias x='exit'
alias ka="killall" \
alias sdn="sudo shutdown -h -r now" \
alias rebootforce='sudo shutdown -r -n now'
alias more='less'
#alias vi='nvim'
#alias svi='sudo vi'
#alias rm='trash -v'

#chmod
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'


alias df='df -h'         # show disk space
alias free='free -m'     # show sizes in MB
alias sudo='sudo '  # Enable aliases to be sudo’ed
# List disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'


# Local folder shortcuts
alias dt="cd ~/Desktop; ls"
alias ds="cd ~/Documents; ls"
alias dn="cd ~/Downloads; ls"
alias h="cd ~/; ls"

# List the commands you use most often
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
# Search command line history
alias h="history | grep "

# mkdir with flags: -p = make parents as needed, -v = verbose
alias mkdir='mkdir -p -v'

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Show open ports
alias openports='netstat -nape --inet'

# Ping 5 times by default
alias ping='ping -c 5'

# Userlist
alias userlist="cut -d: -f1 /etc/passwd"
alias week='date +%V'
alias ebrc='v ~/.bashrc' #edit .bashrc
# Show help for this .bashrc file
#alias hlp='less ~/.bashrc_help'
#show the date/wk#
alias dt='date "+%Y-%m-%d %A %T %Z"'
alias wk='date +%V' 

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# Colorize commands when possible.
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'
# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# get error msgs from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption to verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# To temporarily bypass an alias, we precede the command with a \ ie. ls aliased, but to use the normal ls>>type \ls

#alias YT="youtube-viewer" \
# Play audio files in current dir by type
alias playmp3='ffplay *.mp3'
alias playmp4='ffplay *.mp4'
# youtube-dl  yt-dlp
#alias yta-aac="yt-dlp --extract-audio --audio-format aac "

# SHA1
alias sha1='openssl sha1'
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
# KITTY - alias to be able to use kitty features when connecting to remote servers(e.g use tmux on remote server)
#alias kssh="kitty +kitten ssh"

# List all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

#Multidir listing
#alias la='ls -Alh' # show hidden files
#alias ls='ls -aFh --color=always' # add colors and file type extensions
#alias lx='ls -lXBh' # sort by extension
#alias lk='ls -lSrh' # sort by size
#alias lc='ls -lcrh' # sort by change time
#alias lu='ls -lurh' # sort by access time
#alias lr='ls -lRh' # recursive ls
#alias lt='ls -ltrh' # sort by date
#alias lm='ls -alh |more' # pipe through 'more'
#alias lw='ls -xAh' # wide listing format
#alias ll='ls -Fls' # long listing format
#alias labc='ls -lap' #alphabetical sort
#alias lf="ls -l | egrep -v '^d'" # files only
#alias ldir="ls -l | egrep '^d'" # directories only

#alias vifm='./.config/vifm/scripts/vifmrun'
#alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
#alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'
# Alias's for SSH
# alias SERVERNAME='ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE'
# Alias's to change the dir
#alias web='cd /var/www/html'

# Alias's to mount ISO files
# mount -o loop /home/NAMEOFISO.iso /home/ISOMOUNTDIR/
# umount /home/NAMEOFISO.iso
# (Both commands done as root only.)


##########################
# FUNCTIONS
#########################

# Creates an archive (*.tar.gz) from given directory.
function maketar() { 
    tar cvzf "${1%%/}.tar.gz" "${1%%/}/";
}
# Create a ZIP archive of a file or folder.
function makezip() { 
    zip -r "${1%%/}.zip" "$1";
}

# Auto-EXTRACTION based on type  ie. usage: ex <file>
ex () {
        for archive in "$@"; do
                if [ -f "$archive" ] ; then
                        case $archive in
                                *.tar.bz2)   tar xvjf $archive    ;;
                                *.tar.gz)    tar xvzf $archive    ;;
                                *.bz2)       bunzip2 $archive     ;;
                                *.rar)       rar x $archive       ;;
                                *.gz)        gunzip $archive      ;;
                                *.tar)       tar xvf $archive     ;;
                                *.tbz2)      tar xvjf $archive    ;;
                                *.tgz)       tar xvzf $archive    ;;
                                *.zip)       unzip $archive       ;;
                                *.Z)         uncompress $archive  ;;
                                *.7z)        7z x $archive        ;;
                                *.rar)       unrar x $1   ;;
                                *.gz)        gunzip $1    ;;
                                *.tar)       tar xf $1    ;;
                                *.deb)       ar x $1      ;;
                                *.tar.zst)   unzstd $1    ;;
                                *  )         tar czf $1   ;;
                                *  )         tar cf $1   ;;
                                *  )         tar cjf $1   ;;
                                *)           echo "Unrecogized archive '$archive'" ;;
                        esac
                else
                        echo "'$archive' is not a valid file!"
                fi
        done
}

# Empty trash
function emptytrash() {
    rm -rf ~/.local/share/Trash/expunged/*
    rm -rf ~/.local/share/Trash/files/*
    rm -rf ~/.local/share/Trash/info/*
    echo "Trash has been emptied."
}


# Set Reminder.
# Allows you to set a reminder via the terminal.
# A dialog box will show when the timer ends.
reminder() {
    echo "How many minutes from now do you want the reminder?"
    read _TIME
    echo "What should the reminder message say?"
    read _MSG
    echo "Reminder set!"
    sleep ${_TIME}m && zenity --info --text "${_MSG}" >/dev/null 2>&1
}

# Source global definitions
if [ -f /etc/bashrc ]; then
         . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells (you don't need to enable this, if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
  fi    
fi

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# Ignore case on auto-completion Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi
# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi


# beet autocompletion
command -v beet >/dev/null 2>&1 && {
  if [ -f "/usr/share/bash-completion/completions/beet" ]; then
    source "/usr/share/bash-completion/completions/beet"
  elif [ -f "${HOME}/.local/share/bash-completion/completions/beet" ]; then
    source "${HOME}/.local/share/bash-completion/completions/beet"
  else
    eval "$(beet completion)"
  fi
}

# Copy file with a progress bar
cpp()
{
        set -e
        strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
        | awk '{
        count += $NF
        if (count % 10 == 0) {
                percent = count / total_size * 100
                printf "%3d%% [", percent
                for (i=0;i<=percent;i++)
                        printf "="
                        printf ">"
                        for (i=percent;i<100;i++)
                                printf " "
                                printf "]\r"
                        }
                }
        END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}


# Copy and go to the directory
cpg ()
{
        if [ -d "$2" ];then
                cp "$1" "$2" && cd "$2"
        else
                cp "$1" "$2"
        fi
}

# Move and go to the directory
mvg ()
{
        if [ -d "$2" ];then
                mv "$1" "$2" && cd "$2"
        else
                mv "$1" "$2"
        fi
}

# Create and go to the directory
mkdirg ()
{
        mkdir -p "$1"
        cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up ()
{
        local d=""
        limit=$1
        for ((i=1 ; i <= limit ; i++))
                do
                        d=$d/..
                done
        d=$(echo $d | sed 's/^\///')
        if [ -z "$d" ]; then
                d=..
        fi
        cd $d
}

# Reset the terminal
function reload(){
    reset
    source ${HOME}/.bashrc
}

# Change directories and list contents
function lc() {
    if ! [[ -z "$1" ]]; then
        cd $1
    fi 
    ls -A --color=auto
}

# Backup dotfiles
function syncdotfiles() {
    ${HOME}/CodeLab/Utilities/sync-dotfiles.sh
}
# Sync bashrc files to git
function syncbashfiles() {
    ${HOME}/CodeLab/Utilities/sync-bashfiles.sh
}
# Sync personal files to git
function syncextras() {
    ${HOME}/CodeLab/Utilities/sync-extras.sh
}


# Automatically install the needed support files for this .bashrc file
install_bashrc_support ()
{
        local dtype
        dtype=$(distribution)

        if [ $dtype == "redhat" ]; then
                sudo yum install multitail tree joe
        elif [ $dtype == "debian" ]; then
                sudo apt-get install multitail tree joe
        elif [ $dtype == "gentoo" ]; then
                sudo emerge multitail
                sudo emerge tree
                sudo emerge joe
        else
                echo "Unknown distribution"
        fi
}

# Show current network information
netinfo ()
{
        echo "--------------- Network Information ---------------"
        /sbin/ifconfig | awk /'inet addr/ {print $2}'
        echo ""
        /sbin/ifconfig | awk /'Bcast/ {print $3}'
        echo ""
        /sbin/ifconfig | awk /'inet addr/ {print $4}'

        /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
        echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
        # Dumps a list of all IP addresses for every device
        # /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

        # Internal IP Lookup
         echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'

        # External IP Lookup
        echo -n "External IP: " ; wget http://smart-ip.net/myip -O - -q
}


#Automatically do an ls after each cd
# cd ()
# {
#       if [ -n "$1" ]; then
#               builtin cd "$@" && ls
#       else
#               builtin cd ~ && ls
#       fi
# }


# If we are on Mac OS we exit
#[ "$(uname)" == "Darwin" ] && return;

##(put all additions into a separate file ~/.bash_aliases, instead of adding directly ie. /usr/share/doc/bash-doc/examples in the bash-doc package)
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#ignore upper&lowercase when TAB completion
bind "set completion-ignore-case on"

# Update the mirrorlist
alias mirrors="sudo reflector --verbose --country 'United Kingdom' -l 20 -n 5 --sort rate --save /etc/pacman.d/mirrorlist"

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'
# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more dirs&subdirs
#shopt -s globstar

# Allow ctrl-S for history navigation (with ctrl-R)
#[[ $- == *i* ]] && stty -ixon

#####FZF as filemgr&launcher
#alias v='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs vim'  #fd, fzf tmux,vim to refine into bashrc
#alias d='compgen -c | sort -u | fzf | xargs vim #fzf replace dmenu'
#search Preview
#export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
#CLI find to get all files, excluding any filepath containing "git".
#export FZF_DEFAULT_COMMAND='find . -type f ! -path "*git*"'
#CLI fd list hidden files&exclude '.git' dir
#export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git"'
#CLI ripgrep list hidden files&exclude '.git' dir
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

########################
# Color terminal output

# color ls output based on filetype
eval "$(dircolors -b)"

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Add an "alert" alias for long running commands.  Use like so:  sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#########################
#Convert APT2NALA, add below to ~/.bashrc & /root/.bashrc (install programs with apt / nala)
apt() {
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}


# SET A CUSTOM PROMPT
#  \t - time
#  \d - date
#  \n - newline
#  \s - Shell name
#  \W - The current working directory
#  \w - The full path of the current working directory.
#  \u - The user name
#  \h - Hostname
#  \# - The command number of this command.
#  \! - The history number of the current command
# COLORS
#   \[\e[90m\]      = grey for brackets []
#   \[\e[01;36m\]   = cyan for \w path and $ prompt
#   \[\e[0m\]       = reset colors
PS1='\[\e[90m\][\[\e[0m\]\[\e[01;36m\]\w\[\e[0m\]\[\e[90m\]]\[\e[0m\]\[\e[01;36m\]\$\[\e[0m\] '



#Launch Neofetch
neofetch

