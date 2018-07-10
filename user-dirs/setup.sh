#!/bin/bash

function getScriptDir() {
    SOURCE="${BASH_SOURCE[0]}"
    # resolve $SOURCE until the file is no longer a symlink
    while [ -h "$SOURCE" ]; do 
        SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        # if $SOURCE was a relative symlink,
        # we need to resolve it relative to the path where...
        # ...the symlink file was located
        [[ $SOURCE != /* ]] && SOURCE="$SCRIPT_DIR/$SOURCE"
    done
    SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

getScriptDir

configPath="$HOME/.config"
dirsFilename="user-dirs.dirs"
localeDirsFilename="user-dirs.locale"
dirsDestPath="$configPath/$dirsFilename"
localeDirsDestPath="$configPath/$localeDirsFilename"
dirsSrcPath="$SCRIPT_DIR/$dirsFilename"
localeDirsSrcPath="$SCRIPT_DIR/$localeDirsFilename"

# echo "$dirsSrcPath -> $dirsDestPath"
# echo "$localeDirsSrcPath -> $localeDirsDestPath"

echo "Linking user-dirs files from"
echo "$SCRIPT_DIR to $configPath"

ln -sf $dirsSrcPath $dirsDestPath
ln -sf $localeDirsSrcPath $localeDirsDestPath
