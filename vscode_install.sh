#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

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