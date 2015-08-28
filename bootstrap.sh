#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "fonts/" \
        --exclude ".osx" --exclude "brew.sh" --exclude "init" -avh --no-perms . ~;
    if [ `uname` == "Darwin" ]; then
        cp fonts/SourceCodePro-Medium.otf $HOME/Library/Fonts/;
    elif [ `uname` == "Linux" ]; then
        if apt-get -v > /dev/null 2>&1; then
            sudo apt-get update
            sudo apt-get install -y vim bash-completion
        fi;
    fi;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
