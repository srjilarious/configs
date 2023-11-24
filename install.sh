#!/bin/bash

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to create symlink
create_symlink() {
    echo "Linking '$1' to '$2'..."
    src="$script_dir/$1"
    target=$2

    # Create target directory if it does not exist
    mkdir -p "$(dirname "$target")"

    # If the target file exists, backup it
    if [ -f "$target" ]; then
        if [ "$(readlink -f "$target")" != "$src" ]; then
          echo "    - Backing up existing file to '${target}.bak'"
          mv "$target" "${target}.bak"
          ln -s "$src" "$target"
        fi
    else
        # Create symlink if file does not exist.
        echo "    - Creating link."
        ln -s "$src" "$target"
    fi
}

# Create symlinks
create_symlink gitconfig "$HOME/.config/git/config"
create_symlink nvim_user.lua "$HOME/.config/nvim/lua/user/init.lua"
# create_symlink tmux.conf "$HOME/.config/nvim/lua/user/init.lua"

echo "Symlinks created successfully."

# for i in dircolors my_bashrc gitconfig tmux.conf vimrc
# do
#   create_config_link "$i" ".$i" 
# done
