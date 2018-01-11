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

## Available Functions
- [`correios <tracking code>`](./files/bin/correios)
  - Display current status for Correio's tracking code
- [`e <folder>`](./files/bin/e)
  - Quick shortcut to an editor
- [`extract <file>`](./files/bin/extract)
  - Extract content from a compressed file
- [`fs`](./files/bin/fs)
  - Display the size of all files inside the current directory
- [`git-bb`](./files/bin/git-bb)
  - Display the author for each branch on project
- [`imgcat <filename>`](./files/bin/imgcat)
  - Like `cat` but for images
- [`loop_this <size> <command>`](./files/bin/loop_this)
  - Executes a given command in a given number of times
- [`mit`](./files/bin/mit)
  - Writes a LICENSE file with a copy of the MIT License
- [`pullall <directory>`](./files/bin/pullall)
  - Performs `git pull` on several repositories under the given directory
- [`replace <find> <replace> [<files>]`](./files/bin/replace)
  - Find and replace by a given list of files
- [`rmb`](./files/bin/rmb)
  - Nukes stale branches both locally and remotely
- [`ruby-freeze-all`](./files/bin/ruby-freeze-all)
  - Add `# frozen_string_literal: true` to all `.rb` files on project
- [`update-gem <gem>`](./files/bin/update-gem)
  - Update the gem version, run tests and then commit it
- [`update-gems`](./files/bin/update-gems)
  - Update all the outdated gems on the project, run tests and then commit it
- [`wifi`](./files/bin/wifi)
  - Show SSID and password for the currently connected network
- [`port <port>`](./files/shell/functions.sh)
  - Get the process on a given port
- [`server <port>`](./files/shell/functions.sh)
  - Start an HTTP server from a directory, optionally specifying the port

## Some Available Aliases
- `reload`
  - Reload ZSH configs
- `ip`
  - Display the External IP
- `lip`
  - Display the Internal IP
- `key`
  - Copy the SSH key to the clipboard (`id_rsa.pub`)
- `fd <directory>`
  - Find the directory inside current folder
- `ff <file>`
  - Find the filename inside current folder
- `dotfiles`
  - Open the .dotfiles in the editor
- [**Some Git Aliases**](./files/configs/gitconfig)
- [**More...**](./files/shell/aliases.sh)
