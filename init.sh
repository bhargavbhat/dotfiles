#!/bin/bash

# remove vim, if installed and install from the pi-rho ppa
sudo apt-get remove --purge vim* vim-*
sudo apt-add-repository ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install vim-nox

# get dependencies (lua) : for exact versions and package names check: "pi-rho vim buildlog"
sudo apt-get install lua5.2 liblua5.2-dev luajit libluajit-5.1-dev

# get ctags
sudo apt-get install exuberant-ctags

# init & fetch the plugins
git submodule init && git submodule update

# compile vim-proc
cd ./vimfiles/bundle/vimproc
make

# backup old files
mv ~/.vimrc  ~/oldvimrc
mv ~/.gvimrc ~/oldgvimrc
mv ~/.agignore ~/oldagingore
mv ~/.bashrc ~/oldbashrc
mv ~/.vim ~/oldvimfolder

# create soft links
ln -s ./vimrc ~/.vimrc
ln -s ./gvimrc ~/.gvimrc
ln -s ./agignore ~/.agignore
ln -s ./bashrc  ~/.bashrc
ln -s ./gvimrc ~/.gvimrc
ln -s ./vimfolder ~/.vim
