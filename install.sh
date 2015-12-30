#!/bin/bash
# author : sphantix

os=`uname`

echo "install all config.."

cp -rf ./.vim ~/
cp -rf ./.vimrc ~/
cp -rf ./.bashrc ~/
cp -rf ./.bash_aliases ~/
cp -rf ./.tool ~/
cp -rf ./.gitconfig ~/

#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#for differences
if [ $os = "Darwin" ]; then
    r=`grep '.bashrc' ~/.bash_profiles`
    if [ -z "$$r" ]; then
        echo 'if [ -f ~/.bashrc ]; then' >> ~/.bash_profiles
        echo '   source ~/.bashrc' >> ~/.bash_profiles
        echo 'fi' >> ~/.bash_profiles
    fi
fi

echo "complete!"
