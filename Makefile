install:
	config-files
	bin-files
	apps
	shell-improvements
	customize-osx

config-files:
	@sh ~/.dotfiles/install/config-files.sh

bin-files:
	@sh ~/.dotfiles/install/bin-files.sh

shell-improvements:
	@sh ~/.dotfiles/install/shell-improvements.sh

apps:
	@sh ~/.dotfiles/install/apps.sh

customize-osx:
	@sh ~/.dotfiles/install/customize-osx.sh
