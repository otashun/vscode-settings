#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

# See https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations
if [ `uname` == 'Darwin' ]; then
 VSCODE_SETTING_DIR=$HOME/Library/Application\ Support/Code/User/
elif [ `uname` == 'Linux' ]; then
 VSCODE_SETTING_DIR=$HOME/.config/Code/User/
else
 echo "Your platform ($(uname -a)) is not supported."
 exit 1
fi

rm "$VSCODE_SETTING_DIR/settings.json"
ln -s "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -s "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

# uninstall extention
comm -13 <(sort extensions) <(code --list-extensions | sort) | while read line
do
 code --uninstall-extension $line
done

# install extention
cat extensions | while read line
do
 code --install-extension $line
done

code --list-extensions > extensions
