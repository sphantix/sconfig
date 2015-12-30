#!/bin/bash
# author : sphantix

echo "install all config.."
cp -rf ./.vim/ ~/
cp -rf ./.vimrc ~/
cp -rf ./.bashrc ~/
cp -rf ./.bash_aliases ~/
cp -rf ./.tool/ ~/
cp -rf ./.gitconfig ~/
#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "complete!"
