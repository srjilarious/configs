#!/bin/bash

SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`

# We'll be adding our changes to the user's home directory.
cd ~

function create_config_link {
  echo "Processing '~/$1'..."
  if [ ! -f "~/$2" ]; then
    echo "Creating link '~/$1' -> '$SCRIPT_PATH/$2'"
    ln -s "$SCRIPT_PATH/$1" $2
  else 
    echo "Unable to link '$1' since it already exists."
  fi
}

mkdir -p ~/.config
create_config_link nvim ".config/nvim"
create_config_link ".vim" ".vim" 

for i in dircolors my_bashrc gitconfig tmux.conf vimrc
do
  create_config_link "$i" ".$i" 
done