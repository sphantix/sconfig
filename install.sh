#!/bin/bash
# author : sphantix

echo "install all config.."
cp ./.vim/ ~/ -rf
cp ./.vimrc ~/ -rf
cp ./.bashrc ~/ -rf
cp ./.bash_aliases ~/ -rf
cp ./.tool/ ~/ -rf
cp ./.gitconfig ~/ -rf
echo "complete!"
