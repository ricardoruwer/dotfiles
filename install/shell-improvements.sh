source ~/.dotfiles/shell/colors.sh

# Install Oh My ZSH
###################
echo "${Blue}=> Installing Oh my ZSH${ColorOff}"

if [ -d "$ZSH" ]; then
  echo "${Green}Oh my ZSH already installed${ColorOff}"
else
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install ASDF & plugins
########################
echo "${Blue}=> Installing asdf plugins${ColorOff}"

asdf plugin-add elixir
asdf plugin-add erlang
asdf plugin-add golang
asdf plugin-add ruby
asdf plugin-add nodejs

bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install
