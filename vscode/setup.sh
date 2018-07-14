#!/bin/bash

# Get the path to the script being executed
executionSrc="${BASH_executionSrc[0]}"
while [ -h "$executionSrc" ]; do # resolve $executionSrc until the file is no longer a symlink
    scriptPath="$( cd -P "$( dirname "$executionSrc" )" && pwd )"
    executionSrc="$(readlink "$executionSrc")"
    [[ $executionSrc != /* ]] && executionSrc="$scriptPath/$executionSrc" # if $executionSrc was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
scriptPath="$( cd -P "$( dirname "$executionSrc" )" && pwd )"
dotfilesPath="$scriptPath/User"

# the path where the dotfiles will be linked to
vsCodeConfigPath=""

# if this is a linux machine, assume vscode is installed via flatpak
if [[ $MACHINE == "linux" ]]; then
    vsCodeConfigPath="$HOME/.var/app/com.visualstudio.code/config/Code/User"
fi

echo "Linking dotfiles paths to expected local location of configurations:"
echo "$vsCodeConfigPath ->"
echo "-> $dotfilesPath"
ln -sf $dotfilesPath $vsCodeConfigPath
