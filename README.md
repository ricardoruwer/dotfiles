# @ricardoruwer .dotfiles

macOS and developer environment preferences with Homebrew/GIT/rbenv/ZSH.

## Install

Copy this command into the terminal, and the setup will start.

```bash
cd ~/
git clone https://github.com/ricardoruwer/dotfiles.git .dotfiles
cd .dotfiles && ./install.sh
```

## Sublime Text

1. Close Sublime Text
2. Open Terminal

**First machine**

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
mkdir ~/Google\ Drive/Sublime
mv User ~/Google\ Drive/Sublime/
ln -s ~/Google\ Drive/Sublime/User
```

**Other machine(s)**

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/Google\ Drive/Sublime/User
```

## Alfred

1. Open Alfred Preferences
2. Click on **Set sync folder...**
3. Choose `~/Google Drive/Alfred`

## Functions

```bash
# Display current status for Correios tracking code
$ correios <tracking_code>

# Quick shortcut to an editor
$ e <folder>

# Extract content from a compressed file
$ extract <file>

# Display the size of all files inside the current directory
$ fs

# Display the author for each branch on project
$ git-bb

# Like `cat` but for images
$ imgcat <filename>

# Executes a given command in a given number of times
$ loop_this <size> <command>

# Writes a LICENSE file with a copy of the MIT License
$ mit

# Performs `git pull` on several repositories under the given directory
$ pullall <directory>

# Find and replace by a given list of files
$ replace <find> <replace> [<files>]

# Remove merged branches both locally and remotely
$ rmb

# Add `# frozen_string_literal: true` to all `.rb` files on project
$ ruby-freeze-all

# Update the gem version, run tests and then commit it
$ update-gem <gem>

# Update all the outdated gems on the project, run tests and then commit it
$ update-gems

# Show SSID and password for the currently connected network
$ wifi

# Get the process on a given port
$ port <port>

# Start an HTTP server from a directory, optionally specifying the port
$ server <port>
```

## Aliases

[**See Git Aliases**](./files/configs/gitconfig)

```bash
# Reload ZSH configs
$ reload

# Display the External IP
$ ip

# Display the Local IP
$ lip

# Copy the SSH key to the clipboard (id_rsa.pub)
$ key

# Find the directory inside current folder
$ fd <directory>

# Find the filename inside current folder
$ ff <file>

# Open the .dotfiles in the editor
$ dotfiles
```

- [More aliases here](./files/shell/aliases.sh)

## Commands

```bash
# A faster way to navigate your filesystem
$ j <name>

# A general-purpose command-line fuzzy finder
$ <Ctrl-R>

# A tool like grep, optimized for programmers
$ ack <string>
```
