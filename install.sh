#!/bin/bash
# author : sphantix

os=`uname`
mac_bash_profile="$HOME/.bash_profile"

echo "install all config.."

cp -rf ./.vim ~/
cp -rf ./.vimrc ~/
cp -rf ./.bashrc ~/
cp -rf ./.bash_aliases ~/
cp -rf ./.tool ~/
cp -rf ./.gitconfig ~/

#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#For differences
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
