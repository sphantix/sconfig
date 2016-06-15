#!/bin/bash
# author : sphantix

os=`uname`
mac_bash_profile="$HOME/.bash_profile"

copy_file() {
    cp -rf ./.vim ~/
    cp -rf ./.vimrc ~/
    cp -rf ./.bashrc ~/
    cp -rf ./.bash_aliases ~/
    cp -rf ./.tool ~/
    cp -rf ./.gitconfig ~/
    cp -rf ./.spacemacs.d/ ~/
    cp -rf ./.tmux.conf ~/

    if [ -d ~/.fonts ]; then
        cp -f ./.fonts/* ~/.fonts/
    else
        cp -rf ./.fonts ~/
    fi
}

git_init() {
    #Install Vundle
    if [ ! -d ~/.vim/bundle ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    #Install spacemacs config
    if [ ! -d ~/.emacs.d ]; then
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    fi
}

# main routines
echo "install all config.."
# copy files & dirs
copy_file
# git clone
git_init

# For differences
if [ $os = "Darwin" ]; then
    touch $mac_bash_profile
    r=`grep '.bashrc' $mac_bash_profile`
    if [ "x$r" = "x" ]; then
        echo 'if [ -f ~/.bashrc ]; then' >> $mac_bash_profile
        echo '   source ~/.bashrc' >> $mac_bash_profile
        echo 'fi' >> $mac_bash_profile
    fi
fi

echo "complete!"
