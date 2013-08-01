#!/bin/zsh
#
# .zshrc
# John Toohey

[ -n "$INHERIT_ENV" ] && return 0


# {{{ What version are we running?

if ! (( $+ZSH_VERSION_TYPE )); then
  if [[ $ZSH_VERSION == 3.0.<->* ]]; then ZSH_STABLE_VERSION=yes; fi
  if [[ $ZSH_VERSION == 3.1.<->* ]]; then ZSH_DEVEL_VERSION=yes;  fi

  ZSH_VERSION_TYPE=old
  if [[ $ZSH_VERSION == 3.1.<6->* ||
        $ZSH_VERSION == 3.<2->.<->*  ||
        $ZSH_VERSION == 4.<->* ]]
  then
    ZSH_VERSION_TYPE=new
  fi
fi


# {{{ Options


setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end        \
        append_history       \
        auto_cd              \
        auto_list            \
        auto_menu            \
     NO_auto_name_dirs       \
        auto_param_keys      \
        auto_param_slash     \
        auto_pushd           \
        auto_remove_slash    \
     NO_auto_resume          \
        bad_pattern          \
        bang_hist            \
     NO_beep                 \
     NO_brace_ccl            \
        correct_all          \
     NO_bsd_echo             \
        cdable_vars          \
     NO_chase_links          \
     NO_clobber              \
        complete_aliases     \
        complete_in_word     \
     NO_correct              \
        correct_all          \
        csh_junkie_history   \
     NO_csh_junkie_loops     \
     NO_csh_junkie_quotes    \
     NO_csh_null_glob        \
        equals               \
        extended_glob        \
        extended_history     \
        function_argzero     \
        glob                 \
     NO_glob_assign          \
        glob_complete        \
     NO_glob_dots            \
        glob_subst           \
        hash_cmds            \
        hash_dirs            \
        hash_list_all        \
        hist_allow_clobber   \
        hist_beep            \
        hist_ignore_dups     \
        hist_ignore_space    \
        extended_history     \
     NO_hist_no_store        \
        hist_verify          \
     NO_hup                  \
     NO_ignore_braces        \
     NO_ignore_eof           \
        interactive_comments \
     NO_ksh_glob             \
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
        nomatch              \
        notify               \
     NO_null_glob            \
        numeric_glob_sort    \
     NO_overstrike           \
        path_dirs            \
        posix_builtins       \
     NO_print_exit_value     \
     NO_prompt_cr            \
        prompt_subst         \
        pushd_ignore_dups    \
     NO_pushd_minus          \
        pushd_silent         \
        pushd_to_home        \
        rc_expand_param      \
     NO_rc_quotes            \
     NO_rm_star_silent       \
        share_history        \
     NO_sh_file_expansion    \
        sh_option_letters    \
        short_loops          \
        sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle

if [[ $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt                       \
        hist_expire_dups_first \
        hist_ignore_all_dups   \
     NO_hist_no_functions      \
     NO_hist_save_no_dups      \
        inc_append_history     \
        list_packed            \
     NO_rm_star_wait
fi

if [[ $ZSH_VERSION == 3.0.<6->* || $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt \
        hist_reduce_blanks
fi

# }}}
# {{{ Environment
# Git prompt support
autoload -U colors && colors
setopt prompt_subst
setopt notransient_rprompt
source ~/jt-dots/gitstatus.zsh

LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
#JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
ANT_HOME=~/Dev-tools/ant
ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'
IRCNICK=cuchallin
IRCNAME=cuchallin
MULE_HOME=~/Dev-tools/mule
DEV_TOOLS_HOME=~/Dev-tools
LS_COLORS='no=00;37:fi=00;90:di=32;40:ln=34;40:pi=40;30:so=01;30:do=01;30:bd=40;33;30:cd=4;01:ex=01;91:*.tar=01;30:*.tgz=01;94:*.arj=01;94:*.taz=01;94:*.lzh=01;94:*.zip=01;94:*.z=01;94:*.Z=01;94:*.gz=01;94:*.bz2=01;94:*.deb=01;94:*.rpm=01;94:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.java=01;33::*.h=01;33*.m=01;33:*.py=01;33:*.clj=01;33:*.lisp=01;33:*.xml=01;33;:*.xlt=01;33:*.sh=01;33:';

CLICOLOR=1
LSCOLORS=dafacadabaeaedabaggaha
GREP_COLOR='01;32'
EC2_HOME=~/Dev-tools/ec2-api-tools
EC2_PRIVATE_KEY=`ls ~/.ec2/pk-*.pem`
EC2_CERT=`ls ~/.ec2/cert-*.pem`
CLOJURESCRIPT_HOME=~/Dev/repos/git/clojurescript
COPYFILE_DISABLE=true
export LESS="-F -X -R"

export PS1=$'
%{\e[0;34m%}∴ $(prompt_git_info)%{\e[0;34m%}%d%{\e[0m%}
%Bλ '

export CLOJURESCRIPT_HOME COPYFILE_DISABLE EC2_HOME EC2_PRIVATE_KEY EC2_CERT JAVA_HOME ANT_HOME IRCNICK IRCNAME MULE_HOME LS_COLORS DEV_TOOLS_HOME CLICOLOR LSCOLORS ANT_ARGS GREP_COLOR LANG LC_CTYPE

cdpath=(~/Dev/repos/git ~/Dev/repos/nt/unstable ~/Dev/repos/parspro/unstable ~/Dev/repos/meta-spaces/git)

path=( $(brew --prefix coreutils)/libexec/gnubin /bin /sbin /usr/local/bin /usr/bin ~/bin ~/Dev-tools/ant/bin /opt/local/bin /usr/local/go/bin ~/Dev-tools/ec2-api-tools/bin ~/Dev-tools/aspectj/bin ~/Dev-tools/storm/bin)

fpath=($fpath ~/.zsh/functions)

preexec () {
    echo -ne "$reset_color"
}

precmd () {
    echo -ne "$B"
}

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi
# {{{ INFOPATH

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T INFOPATH infopath
typeset -U infopath # no duplicates
export INFOPATH
infopath=( 
          ~/local/$OSTYPE/{share/,}info(N)
          ~/{local/,}{share/,}info(N)
          /usr/{local/,}{share/,}info(N)
          $infopath
         )

# }}}
# {{{ MANPATH

manpath=(/opt/local/man /Users/jpt/man /usr/share/man /usr/local/share/man /usr/X11/man)

# }}}
# {{{ LANG
# Load the theme-able prompt system and use it to set a prompt.
# Probably only suitable for a dark background terminal.

#local _find_promptinit
#_find_promptinit=( $^fpath/promptinit(N) )
#if (( $#_find_promptinit >= 1 )) && [[ -r $_find_promptinit[1] ]]; then

#  autoload -U promptinit
#  promptinit

#  PS4="trace %N:%i> "
  #RPS1="$bold_colour$bg_red              $reset_colour"

  # Default prompt style
#  adam2_colors=( white cyan cyan green )

#  if [[ -r $zdotdir/.zsh_prompt ]]; then
#    . $zdotdir/.zsh_prompt
#  fi

 # if [[ -r /proc/$PPID/cmdline ]] &&
 #      egrep -q 'watchlogs|kates|nexus|vga' /proc/$PPID/cmdline;
 # then
    # probably OK for fancy graphic prompt
 #   if [[ "`prompt -h adam2`" == *8bit* ]]; then
 #     prompt adam2 8bit $adam2_colors
 #   else
 #     prompt adam2 $adam2_colors
 #   fi
 # else
 #   if [[ "`prompt -h adam2`" == *plain* ]]; then
 #     prompt adam2 plain $adam2_colors
 #   else
 #     prompt adam2 $adam2_colors
 #   fi
 # fi
#else
#  PS1='%n@%m %B%3~%b %# '
#fi


# }}}

# Variables used by zsh

# {{{ Choose word delimiter characters in line editor

WORDCHARS=''

# }}}
# {{{ Save a large history

HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000

# }}}
# {{{ Maximum size of completion listing

#LISTMAX=0    # Only ask if line would scroll off screen
LISTMAX=1000  # "Never" ask

# }}}


# {{{ Completions


# {{{ Set up new advanced completion system

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  autoload -U compinit
  compinit -u # use with care!!
else
  print "\nAdvanced completion system not found; ignoring zstyle settings."
  function zstyle { }
  function compdef { }

  # an antiquated, barebones completion system is better than nowt
  which zmodload >&/dev/null && zmodload zsh/compctl
fi

# }}}
# {{{ General completion technique

# zstyle ':completion:*' completer \
#   _complete _prefix _approximate:-one _ignored \
#   _complete:-extended _approximate:-four
zstyle ':completion:*' completer _complete _prefix _ignored _complete:-extended

zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

zstyle ':completion:*:approximate-one:*'  max-errors 1
zstyle ':completion:*:approximate-four:*' max-errors 4

# e.g. f-1.j<TAB> would complete to foo-123.jpeg
zstyle ':completion:*:complete-extended:*' \
  matcher 'r:|[.,_-]=* r:|=*'

# }}}
# {{{ Fancy menu selection when there's ambiguity

#zstyle ':completion:*' menu yes select interactive
#zstyle ':completion:*' menu yes=long select=long interactive
#zstyle ':completion:*' menu yes=10 select=10 interactive

# }}}
# {{{ Completion caching

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# }}}
# {{{ Expand partial paths

# e.g. /u/s/l/D/fs<TAB> would complete to
#      /usr/src/linux/Documentation/fs
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# }}}
# {{{ Include non-hidden dirs in globbed file completions for certain commands

#zstyle ':completion::complete:*' \
#  tag-order 'globbed-files directories' all-files 
#zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# }}}
# {{{ Don't complete backup files (e.g. 'bin/foo~') as executables

zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# }}}
# {{{ Don't complete uninteresting users

zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

# }}}
# {{{ Output formatting

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# }}}
# {{{ Array/association subscripts

# When completing inside array or association subscripts, the array
# elements are more useful than parameters so complete them first:
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters 

# }}}
# {{{ Completion for processes

zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always

# }}}
# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# }}}
# {{{ Usernames


zstyle ':completion:*' users $zsh_users

# }}}
# {{{ Hostnames

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  # Extract hosts from /etc/hosts
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
# _ssh_known_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi

zsh_hosts=(
    "$_etc_hosts[@]"
    localhost
)

zstyle ':completion:*' hosts $zsh_hosts

# }}}
# {{{ (user, host) account pairs

zstyle ':completion:*:my-accounts'    users-hosts "$my_accounts[@]"
zstyle ':completion:*:other-accounts' users-hosts "$other_accounts[@]"

# }}}

# {{{ pdf

compdef _pdf pdf

# }}}

# }}}
# {{{ Aliases and functions


# {{{ Motion/editing

# {{{ Better word navigation

# Remember, WORDCHARS is defined as a 'list of non-alphanumeric
# characters considered part of a word by the line editor'.

# Elsewhere we set it to the empty string.

_my_extended_wordchars='*?_-.[]~=&;!#$%^(){}<>:@,\\'
_my_extended_wordchars_space="${_my_extended_wordchars} "
_my_extended_wordchars_slash="${_my_extended_wordchars}/"

# is the current position \-quoted ?
is_backslash_quoted () {
    test "${BUFFER[$CURSOR-1,CURSOR-1]}" = "\\"
}

unquote-forward-word () {
    while is_backslash_quoted
      do zle .forward-word
    done
}

unquote-backward-word () {
    while is_backslash_quoted
      do zle .backward-word
    done
}

backward-to-space () {
    local WORDCHARS="${_my_extended_wordchars_slash}"
    zle .backward-word
    unquote-backward-word
}

forward-to-space () {
     local WORDCHARS="${_my_extended_wordchars_slash}"
     zle .forward-word
     unquote-forward-word
}

backward-to-/ () {
    local WORDCHARS="${_my_extended_wordchars}"
    zle .backward-word
    unquote-backward-word
}

forward-to-/ () {
     local WORDCHARS="${_my_extended_wordchars}"
     zle .forward-word
     unquote-forward-word
}

# Create new user-defined widgets pointing to eponymous functions.
zle -N backward-to-space
zle -N forward-to-space
zle -N backward-to-/
zle -N forward-to-/

# }}}
# {{{ kill-region-or-backward-(big-)word

# autoloaded
zle -N kill-region-or-backward-word
zle -N kill-region-or-backward-big-word

# }}}
# {{{ kill-big-word

kill-big-word () {
    local WORDCHARS="${_my_extended_wordchars_slash}"
    zle .kill-word
}

zle -N kill-big-word

# }}}
# {{{ transpose-big-words

# autoloaded
zle -N transpose-big-words

# }}}
# {{{ magic-forward-char

zle -N magic-forward-char

# }}}
# {{{ magic-forward-word

zle -N magic-forward-word

# }}}
# {{{ incremental-complete-word

# doesn't work?
zle -N incremental-complete-word

# }}}

# }}}
# {{{ zrecompile

autoload zrecompile

# }}}
# {{{ which/where

# reverse unwanted aliasing of `which' by distribution startup
# files (e.g. /etc/profile.d/which*.sh); zsh's 'which' is perfectly
# good as is.

alias which >&/dev/null && unalias which

# }}}
# {{{ zcalc

autoload zcalc

###########################################
#   iTerm Tab and Title Customization     #
###########################################

# Put the penultimate and current directory in the iterm tab:
function settab { echo -ne "\e]1;$PWD:h:t/$PWD:t\a" }

# Put the string " [zsh]   hostname::/full/directory/path" in the title bar:
function settitle { echo -ne "\e]2;[zsh]   $HOST:r:r::$PWD\a" }

# This updates after each change of directory:
function chpwd { settab;settitle }

# {{{ Restarting zsh or bash; reloading .zshrc or functions

# Git stuff
#source ~/bin/git-sync-lib

function extract {
    echo Extracting $1 ...
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1  ;;
            *.tar.gz)    tar xzf $1  ;;
            *.bz2)       bunzip2 $1  ;;
            *.rar)       rar x $1    ;;
            *.gz)        gunzip $1   ;;
            *.tar)       tar xf $1   ;;
            *.tbz2)      tar xjf $1  ;;
            *.tgz)       tar xzf $1  ;;
            *.zip)       unzip $1   ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1  ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function jv()
{
    [[ $#@ -eq 1 ]] || { echo Give exactly one argument, the jar file FQN ; return 1 }
    test -e "$1" || { echo No such file or directory: "$1" ; return 1 }
    unzip -q -c $1 META-INF/MANIFEST.MF | grep 'Implementation-Version' | cut -d ':' -f 2
}

function my_ip() # get IP adresses
{
    MY_IP=$(ifconfig en0 | awk '/inet / { print $2 } ' | sed -e s/addr://)
}

function ii()   # get current host related info
{
    echo -e "\nYou are logged on ${BLUE}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo
}

folsym() 
{
    if [[ -e $1 || -h $1 ]]; then
	file=$1
    else
	file=`which $1`
    fi
    if [[ -e $file || -L $file ]]; then
	if [[ -L $file ]]; then
	    echo `ls -ld $file | perl -ane 'print $F[7]'` '->'
	    folsym `perl -le '$file = $ARGV[0];
$dest = readlink $file;
if ($dest !~ m{^/}) 
    {
	$file =~ s{(/?)[^/]*$}{$1$dest};
    } else 
    {
	$file = $dest;
    }
    $file =~ s{/{2,}}{/}g;
    while ($file =~ s{[^/]+/\.\./}{}) 
    {
	;
    }
    $file =~ s{^(/\.\.)+}{};
    print $file' $file`
	    
	else
	    ls -d $file
	fi
    else
	echo $file
    fi
}

bash () {
  NO_SWITCH="yes" command bash "$@"
}

restart () {
  if jobs | grep . >/dev/null; then
    echo "Jobs running; won't restart." >&2
  else
    exec $SHELL $SHELL_ARGS "$@"
  fi
}

profile () {
  ZSH_PROFILE_RC=1 $SHELL "$@"
}

reload () {
  if [[ "$#*" -eq 0 ]]; then
    . ~/.zshrc
  else
    local fn
    for fn in "$@"; do
      unfunction $fn
      autoload -U $fn
    done
  fi
}
compdef _functions reload

# }}}

alias ls='ls --color'
alias l='ls -lh'
alias ll='ls -GFhl'
alias la='ls -lha'
alias lla='ls -la'
alias lsa='ls -ah'
alias lsd='ls -d'
alias lsh='ls -dh .*'
alias lsr='ls -Rh'
alias ld='ls -ldh'
alias lt='ls -lth'
alias llt='ls -lt'
alias lrt='ls -lrth'
alias llrt='ls -lrt'
alias lart='ls -larth'
alias llart='ls -lart'
alias lr='ls -lRh'
alias llr='ls -lR'
alias lsL='ls -L'
alias lL='ls -Ll'
alias lS='ls -lSh'
alias lrS='ls -lrSh'
alias llS='ls -lS'
alias llrS='ls -lrS'


# }}}
# {{{ File management/navigation

# {{{ Changing/making/removing directory

alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
# blegh
alias ..='cd ..'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'
alias ../../../../..='cd ../../../../..'

alias cd/='cd /'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

# Sweet trick from zshwiki.org :-)
cd () {
  if (( $# != 1 )); then
    builtin cd "$@"
    return
  fi

  if [[ -f "$1" ]]; then
    builtin cd "$1:h"
  else
    builtin cd "$1"
  fi
}

z () {
  cd ~/"$1"
}

alias md='mkdir -p'
alias rd=rmdir
alias crontab='VIM_CRONTAB=true crontab'
alias d='dirs -v'

po () {
  popd "$@"
  dirs -v
}

# }}}
# {{{ Renaming

autoload zmv
alias mmv='noglob zmv -W'

# }}}
# {{{ tree

alias tre='tree -C'

# }}}

# }}}
# {{{ Job/process control

alias jj='jobs -l'
alias dn=disown
alias openports='sudo /usr/sbin/lsof -i -P'

# }}}
# {{{ History

alias h='history 1 | less +G'
alias hh='history'

# }}}
# {{{ Environment

alias ts=typeset
compdef _typeset ts
alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'

# }}}
# {{{ Terminal
export TERM=xterm-color
alias cls='clear'
alias term='echo $TERM'
# {{{ Changing terminal window/icon titles

which cx >&/dev/null || cx () { }

if [[ "$TERM" == ([Ex]term*|screen*) ]]; then
  # Could also look at /proc/$PPID/cmdline ...
  cx
fi

# }}}
alias sc=screen

# }}}
# {{{ Other users

compdef _users lh

alias f='finger -m'
compdef _finger f
alias whois='whois -h whois.geektools.com'

# }}}
# {{{ No spelling correction

alias man='nocorrect man'
alias ant='nocorrect ant'
alias mysql='nocorrect mysql'
alias mysqlshow='nocorrect mysqlshow'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias lien='nocorrect lien'

# }}}
# {{{ X windows related

# {{{ export DISPLAY=:0.0

alias sd='export DISPLAY=:0.0'

# }}}

# }}}

# }}}
# {{{ MIME handling

autoload zsh-mime-setup
zsh-mime-setup

autoload -U zargs

# }}}
# {{{ Other programs

# {{{ less

alias v=less
alias vs='less -S'

# }}}
# {{{ mutt

m () {
  setopt local_traps
  trap 'cxx' INT EXIT QUIT KILL
  cx -l mutt
  mutt "$@"
}

compdef _mutt m

# }}}
# {{{ editors

# emacs, windowed
e () {
  if [[ -n "$OTHER_USER" ]]; then
    emacs -l $ZDOTDIR/.emacs "$@" &!
  else
    dsa
    dga
    emacs "$@" &!
  fi
}

alias ec='emacsclient --no-wait'

# enable ^Z
alias pico='/usr/bin/pico -z'

if which vim >&/dev/null; then
  alias vi=vim
fi

# }}}
# {{{ remote logins


# Best to run this from .zshrc.local
#dsa >&DN || echo "ssh-agent setup failed; run dsa."

# }}}
# {{{ ftp

if which lftp >&/dev/null; then
  alias ftp=lftp
elif which ncftp >&/dev/null; then
  alias ftp=ncftp
fi

# }}}
# {{{ watching log files

alias log='less +F -f -R'
alias tf='less +F'
alias tfs='less -S +F'

# }}}
# {{{ arch

if which larch >&/dev/null; then
  alias a=larch
  compdef _larch a
fi

# }}}
# {{{ bzip2

alias bz=bzip2
alias buz=bunzip2

# }}}

# }}}

# {{{ grep, xargs

alias -g G='| egrep --color'
alias -g Gi='| egrep --color -i'
alias -g Gl='| egrep --color -l'
alias -g Gv='| egrep --color -v'
alias -g EG='|& egrep --color'
alias -g EGv='|& egrep --color -v'

alias g='egrep --color'
alias gi='egrep --color -i'
alias gr='egrep --color -r'
alias gl='egrep --color -l'
alias gir='egrep --color -ir'
alias gil='egrep --color -il'
alias glr='egrep --color -lr'
alias gilr='egrep --color -ilr'
alias grep='grep --color'

alias -g XA='| xargs'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep --color'
alias -g XGv='| xargs egrep --color -v'
alias -g X0G='| xargs -0 egrep --color'
alias -g X0Gv='| xargs -0 egrep --color -v'

# }}}
# {{{ awk

alias -g A='| awk '
alias -g A1="| awk '{print \$1}'"
alias -g A2="| awk '{print \$2}'"
alias -g A3="| awk '{print \$3}'"
alias -g A4="| awk '{print \$4}'"
alias -g A5="| awk '{print \$5}'"
alias -g A6="| awk '{print \$6}'"
alias -g A7="| awk '{print \$7}'"
alias -g A8="| awk '{print \$8}'"
alias -g A9="| awk '{print \$9}'"
alias -g EA='|& awk '
alias -g EA1="|& awk '{print \$1}'"
alias -g EA2="|& awk '{print \$2}'"
alias -g EA3="|& awk '{print \$3}'"
alias -g EA4="|& awk '{print \$4}'"
alias -g EA5="|& awk '{print \$5}'"
alias -g EA6="| awk '{print \$6}'"
alias -g EA7="| awk '{print \$7}'"
alias -g EA8="| awk '{print \$8}'"
alias -g EA9="| awk '{print \$9}'"

# }}}

# }}}

# }}}
# {{{ Key bindings 


bindkey -s '^X^Z' '%-^M'
bindkey -s '^[H' ' --help'
bindkey -s '^[V' ' --version'
bindkey '^[e' expand-cmd-path
#bindkey -s '^X?' '\eb=\ef\C-x*'
bindkey '^[^I'   reverse-menu-complete
bindkey '^X^N'   accept-and-infer-next-history
bindkey '^[p'    history-beginning-search-backward
bindkey '^[n'    history-beginning-search-forward
bindkey '^[P'    history-beginning-search-backward
bindkey '^[N'    history-beginning-search-forward
bindkey '^w'     kill-region-or-backward-word
bindkey '^[^W'   kill-region-or-backward-big-word
bindkey '^[T'    transpose-big-words
bindkey '^I'     complete-word
bindkey '^Xi'    incremental-complete-word
bindkey '^F'     magic-forward-char
# bindkey '^[b'    emacs-backward-word
# bindkey '^[f'    emacs-forward-word
bindkey '^[f'    magic-forward-word
bindkey '^[B'    backward-to-space
bindkey '^[F'    forward-to-space
bindkey '^[^b'   backward-to-/
bindkey '^[^f'   forward-to-/
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word

bindkey '^[D'  kill-big-word

if zmodload zsh/deltochar >&/dev/null; then
  bindkey '^[z' zap-to-char
  bindkey '^[Z' delete-to-char
fi


# }}}
# {{{ Miscellaneous


# {{{ ls colours

if which dircolors >&/dev/null && [[ -e "${zdotdir}/.dircolors" ]]; then
  eval "`dircolors -b $zdotdir/.dircolors`"
fi

if [[ $ZSH_VERSION > 3.1.5 ]]; then
  zmodload -i zsh/complist

#  zstyle ':completion:*' list-colors ''

  zstyle ':completion:*:*:*:*:processes' list-colors \
    '=(#b) #([0-9]#)*=0=01;31'

  # completion colours
  zstyle ':completion:*' list-colors "$LS_COLORS"
  # pager for too many completions
  zstyle ':completion:*default' list-prompt '%S%M matches%s'
fi  

# }}}
# {{{ Don't always autologout

if [[ "${TERM}" == ([Ex]term*|dtterm|screen*) ]]; then
  unset TMOUT
fi

# }}}

# }}}

# {{{ Specific to local setups


# }}}

# {{{ Clear up after status display

if [[ $TERM == tgtelnet ]]; then
  echo
else
  echo -n "\r"
fi

# }}}
# {{{ Profile report

if [[ -n "$ZSH_PROFILE_RC" ]]; then
  zprof >! ~/zshrc.zprof
  exit
fi

# }}}

# {{{ Search for history loosing bug

which check_hist_size >&/dev/null && check_hist_size

# }}}
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
