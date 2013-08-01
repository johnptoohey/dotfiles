# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PATH=~/bin:~/.dotfiles/bin:/usr/local/bin:/sbin:$PATH

if [ -d "~/.rbenv" ]; then
    export PATH=~/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
    rbenv global 1.9.3-p392
fi

# alias truecrypt on os x machines
if [[ "$OSTYPE" =~ ^darwin ]]; then
    alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'
fi
