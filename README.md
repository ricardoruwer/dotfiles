# @ricardoruwer .dotfiles

macOS and developer environment preferences with Homebrew/GIT/rbenv/ZSH.

## Install

Copy this command into the terminal, and the setup will start.

```bash
cd ~/
git clone https://github.com/ricardoruwer/dotfiles.git .dotfiles
cd .dotfiles && ./install.sh
```

## Sync Applications

### Sublime Text

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

### Alfred

1. Open Alfred Preferences
2. Click on **Set sync folder...**
3. Choose `~/Google Drive/Alfred`

## Bins

```bash
# Display current status for Correios tracking code
$ correios <tracking_code>

# Quick shortcut to an editor
$ e <folder>

# Extract content from a compressed file
$ extract <file>

# Display the size of all files inside the current directory
$ fs

# Like `cat` but for images
$ imgcat <filename>

# Find and replace by a given list of files
$ replace <find> <replace> [<files>]

# Performs `git pull` on several repositories under the given directory
$ pullall <directory>

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

# Display the biggest classes on current project
$ bigclass

# Display methods with long parameter lists
$ longparams
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

# A tool to identify unused code
# To generate tags: `git ls-files | xargs ctags`
$ unused
```
