#!/bin/bash
# author : sphantix

os=`uname`
mac_bash_profile="$HOME/.bash_profile"

make_dirs() {
    mkdir /home/sphantix/go
}

copy_file() {
    cp -rf ./.vim ~/
    cp -rf ./.vimrc ~/
    cp -rf ./.bashrc ~/
    cp -rf ./.bash_aliases ~/
    cp -rf ./.bash_environment ~/
    cp -rf ./.tool ~/
    cp -rf ./.gitconfig ~/
    cp -rf ./.spacemacs.d/ ~/
    cp -rf ./.tmux.conf ~/

    if [ -d ~/.fonts ]; then
        cp -f ./.fonts/* ~/.fonts/
    else
        cp -rf ./.fonts ~/
    fi

    #copy system files
    sudo cp ./sys/51-android.rules /etc/udev/rules.d/
    sudo cp ./sys/hosts /etc/hosts
    sudo cp ./sys/proxychains.conf /etc/
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

install_softwares() {
    sudo apt update
    #c
    sudo apt-get install ctags
    sudo apt-get install cscope
    sudo apt-get install clang
    #python
    sudo apt install python3-dev python3-pip
    #go
    sudo apt install golang-go
    go get -u -v github.com/nsf/gocode
    go get -u -v github.com/rogpeppe/godef
    #go get -u -v golang.org/x/tools/cmd/guru
    #go get -u -v golang.org/x/tools/cmd/gorename
    #go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v github.com/alecthomas/gometalinter
    gometalinter --install --update
    #thefuck
    sudo pip3 install thefuck
    #proxychains
    sudo apt install proxychains
}

# main routines
echo "install all config.."
# make dirs
make_dirs
# copy files & dirs
copy_file
# git clone
git_init
# update environments
source ~/.bashrc
# install softwares
install_softwares

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
