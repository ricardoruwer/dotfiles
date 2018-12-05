# frozen_string_literal: true

# Based on https://github.com/mattbrictson/dotfiles

require 'fileutils'
require 'rake'
require 'shellwords'

IGNORE = %w[Rakefile README.md LICENSE].freeze

task default: 'install'

desc 'Install packages and dotfiles'
task install: %w[
  install:command_lint_tools
  install:link_dotfiles
  install:link_bins
  install:iterm_integration
  install:oh_my_zsh
  install:homebrew
]

desc 'Warn if git origin is newer'
task :check do
  next unless system('git fetch origin')
  next if `git diff HEAD origin/master`.strip.empty?
  log(:yellow, 'Working copy is out of date; consider `git pull`')
end

namespace :install do
  ################################################################################
  # Symlink all dotfiles
  ################################################################################
  desc 'OS X Softwares updating and installing Xcode Command Line tools'
  task :command_lint_tools do
    log(:blue, '=> Updating MacOS and installing Xcode Command Line tools')
    # Check and install any remaining software updates.
    system('sudo softwareupdate --install --all')

    # Install the Xcode Command Line Tools.
    system('sudo xcode-select --install')
    system('sudo sudo xcodebuild -license accept')
  end

  ################################################################################
  # Install Homebrew and apps from Brewfile
  ################################################################################
  desc 'Install Homebrew'
  task :homebrew do
    log(:blue, '=> Installing Homebrew')

    if installed?('brew')
      log(:green, '=> Homebrew already installed')
    else
      system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      Dotfile.new('Brewfile').replace!
    end

    if ask(:red, 'Would you like to install all apps from Brewfile?')
      log(:blue, '=> Installing Homebrew apps from Brewfile')
      system('brew bundle --global')
      system('brew cleanup')
    end
  end

  ################################################################################
  # Install Oh My ZSH
  ################################################################################
  desc 'Install Oh My ZSH'
  task :oh_my_zsh do
    log(:blue, '=> Installing Oh my ZSH')

    if File.directory?(File.join(ENV['HOME'], '.oh-my-zsh'))
      log(:green, '=> Oh my ZSH already installed')
    else
      system('git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh')
      system('sudo chsh -s /bin/zsh')

      system('ln -sf themes/material-shell.zsh-theme ~/.oh-my-zsh/themes/materialshell.zsh-theme')
    end
  end

  ################################################################################
  # Install iTerm shell integration
  ################################################################################
  desc 'Install iTerm shell integration'
  task :iterm_integration do
    log(:blue, '=> Installing iTerm shell integration')

    if File.exist?(File.join(ENV['HOME'], '.iterm2_shell_integration.zsh'))
      log(:green, '=> iTerm shell integration already installed')
    else
      system('curl -Ls https://iterm2.com/misc/zsh_startup.in -o ~/.iterm2_shell_integration.zsh')
    end
  end

  ################################################################################
  # Symlink bin files
  ################################################################################
  desc 'Link bin files'
  task :link_bins do
    log(:blue, '=> Linking bin files')

    bins = Dotfile.new('bin')

    case bins.status
    when :identical
      log(:green, "Identical #{bins}")
    when :missing
      bins.link!
    when :different
      bins.replace!
    end
  end

  ################################################################################
  # Symlink all dotfiles
  ################################################################################
  desc 'Link dotfiles into user’s home directory'
  task :link_dotfiles do
    log(:blue, '=> Linking dotfiles into user’s home directory')

    always_replace = false

    Dotfile.each(directory: 'configs') do |dotfile|
      case dotfile.status
      when :identical
        log(:green, "Identical #{dotfile}")
      when :missing
        dotfile.link!
      when :different
        if always_replace
          dotfile.replace!
        elsif (answer = ask(:red, "overwrite? #{dotfile}"))
          always_replace = true if answer == :always
          dotfile.replace!
        else
          log(:gray, "Skipping #{dotfile}")
        end
      end
    end
  end

  # desc "Symlink the Sublime Packages/User directory"
  # task :link_sublime do
  #   dot_sublime = File.expand_path("~/.sublime")
  #   user_packages = File.expand_path("~/Library/Application Support/Sublime Text 3/Packages/User")
  #   if !File.exist?(user_packages)
  #     log(:magenta, "mkdir Library/Application Support/Sublime Text 3/Packages/User")
  #     FileUtils.mkdir_p(user_packages)
  #   end
  #   if File.directory?(user_packages) && ! File.symlink?(user_packages)
  #     log(:magenta, "mkdir .sublime")
  #     FileUtils.mkdir_p(dot_sublime)
  #     log(:blue, "copy  Library/Application Support/Sublime Text 3/Packages/User/*")
  #     FileUtils.cp_r(Dir.glob(user_packages.shellescape + "/*"), dot_sublime)
  #     log(:magenta, "rm    Library/Application Support/Sublime Text 3/Packages/User")
  #     FileUtils.rm_rf(user_packages)
  #     log(:blue, "linking Library/Application Support/Sublime Text 3/Packages/User")
  #     FileUtils.ln_s(dot_sublime, user_packages)
  #   end
  # end
end

def log(color, message)
  colors = {
    black: "\e[0;30mMESSAGE\e[0m",
    red: "\e[0;31mMESSAGE\e[0m",
    green: "\e[0;32mMESSAGE\e[0m",
    yellow: "\e[0;33mMESSAGE\e[0m",
    blue: "\e[0;34mMESSAGE\e[0m",
    purple: "\e[0;35mMESSAGE\e[0m",
    cyan: "\e[0;36mMESSAGE\e[0m",
    white: "\e[0;37mMESSAGE\e[0m"
  }

  raise "#{color} not available" unless colors[color]

  message = colors[color].gsub('MESSAGE', message)

  puts(message)
end

def ask(color, question)
  log(color, "#{question} [yNaq]? ")

  case $stdin.gets.chomp
  when 'a'
    :always
  when 'y'
    true
  when 'q'
    exit
  else
    false
  end
end

def installed?(name)
  system("command -v #{name} &>/dev/null")
end

class Dotfile
  def self.each(directory: nil, &block)
    Dir[File.join([directory, '*'].compact)].each do |file|
      next if IGNORE.include?(file)

      if File.directory?(file)
        each(file, &block)
      else
        yield(new(file))
      end
    end
  end

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def name
    ".#{File.basename(@file)}"
  end
  alias to_s name

  def target
    File.expand_path("~/#{name}")
  end

  def status
    if File.identical?(file, target)
      :identical
    elsif File.exist?(target) || File.symlink?(target)
      :different
    else
      :missing
    end
  end

  def link!(delete_first: false)
    ensure_target_directory

    log(:blue, "Linking #{self}")
    FileUtils.rm_rf(target) if delete_first
    FileUtils.ln_s(File.absolute_path(file), target)
  end

  def replace!
    link!(delete_first: true)
  end

  def ensure_target_directory
    directory = File.dirname(target)
    return if File.directory?(directory)

    log(:magenta, "Creating directory #{File.dirname(name)}")
    FileUtils.mkdir_p(directory)
  end
end
