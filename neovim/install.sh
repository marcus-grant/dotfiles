#!/bin/bash
################################################################################
# Install.sh
# by Marcus Grant
# 2017 - 09 - 20
# marcus.grant@patternbuffer.io
# patternbuffer.io
#
# A script that uses git & bash to clone all the appropriate repos & sets
# soft links to the correct places for the system to redirect to these dotfiles
################################################################################

# main execution block
function main() {
	# paths
	dots_path=$(config-path)
	link_path=$HOME/.config/nvim #TODO: Change to XDG_BASE_CONFIG

	# opening message
	echo
	echo "Preparing local environment for neoVim..."
	echo "Starting by linking $link_path to"
	echo "dotfiles in $dots_path."

	# check for existence of previous paths
	if $(is-file $link_path); then
		echo
		echo "File already exists in $link_path, removing it."
		rm $link_path
	elif $(is-link $link_path); then
		echo
		echo "Link already exists in $link_path, removing it."
		rm $link_path
	elif is-dir $link_path; then
		echo
		echo "Directory already exists in $link_path"
		echo "Copying directory as $link_path.bak, and deleting original"
		mv $link_path $link_path.bak
	fi

	# link dotfile directory for neovim to $link_path
	ln -s $dots_path $link_path

	# download vim plug, and place it in ./autoload/
	echo
	echo "Downloading vim-plug (the plugin manager)"
	get-vim-plug

	# TODO: Other stuff


	# complete
	echo
	echo "Done preparing neoVim for local environment!"
	echo
}

function config-path() {
	# foolproof way to figure out where this script is placed
	source="${BASH_SOURCE[0]}"
	while [ -h "$source" ]; do # resolve $source til file is no longer link
	  dir="$( cd -P "$( dirname "$source" )" && pwd )"
	  source="$(readlink "$source")"
	  # if $source was a relative symlink, we need to resolve it relative
	  # to the path where the symlink file was located
	  [[ $source != /* ]] && source="$dir/$source"
	done
	echo "$( cd -P "$( dirname "$source" )" && pwd )" #dir has script loc'n
}

function is-file() {
	if [ -e $1 ]; then
		return 0
	else
		return 1
	fi
}

function is-link() {
	if [ -L $1 ]; then
		return 0
	else
		return 1
	fi
}

function is-dir() {
	if [ -d $1 ]; then
		return 0
	else
		return 1
	fi
}

function get-vim-plug () {
    curl -fLo ./site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}



# main execution after reading in all functions - for forward declaration
main
