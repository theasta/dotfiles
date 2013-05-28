#!/bin/bash

echo 'Dotfiles - Sync'

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP

Usage: $(basename "$0")
HELP
exit; fi

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

if [[ ! "$OSTYPE" =~ ^darwin ]]; then
    e_error "This script is meant to be run on a mac"
    exit 1;
fi

# Ensure that we can actually, like, compile anything
which -s gcc
if [[ $? != 0 ]] ; then
  e_error "The XCode Command Line Tools must be installed first."
  exit 1
fi

# If rvm is not installed...
which -s rvm
if [[ $? != 0 ]] ; then
  e_header "Installing RVM"
  curl -L https://get.rvm.io | bash -s stable --ruby
fi


# If brew is not installed
which -s brew
if [[ $? != 0 ]] ; then
  # brew link won't work if user doesn't have proper permissions so ask for them
  sudo chown -R ${USER} /usr/local/bin
  sudo chown -R ${USER} /usr/local/opt
  sudo chown -R ${USER} /usr/local/lib
  e_header "Installing Homebrew"
  true | /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

  # If Brew isn't installed by now, something exploded. We gots to quit!
  which -s brew
  if [[ $? != 0 ]] ; then
      e_error "Brew should be installed. It isn't. Aborting."
      exit 1
  fi
else
    # Make sure we’re using the latest Homebrew
    e_header "Updating Homebrew"
    brew update
fi

e_header "Running Homebrew doctor"
brew doctor
if [[ $? != 0 ]] ; then
    e_error "Brew Doctor threw a warning. Aborting."
    exit 1;
fi

# Upgrade any already-installed formulae
e_header "Upgrading Homebrew formulae"
brew upgrade

# If Git is not installed or is Apple version
git --version &>/dev/null
GIT_EXIT=$?
GIT_PATH=$(which git)
if [[ $GIT_EXIT != 0 || $GIT_PATH == '/usr/bin/' ]] ; then
  e_header "Installing Git"
  brew install git
fi

# If Git isn't installed by now, something exploded. We gots to quit!
git --version &>/dev/null
if [[ $? != 0 ]] ; then
  e_error "Git should be installed. It isn't. Aborting."
  exit 1
fi

if [ ! -d "$HOME/.vim/bundle" ]; then
  mkdir -p $HOME/.vim/bundle
fi

if [ ! -d "$HOME/.vim/bundle/neobundle.vim" ]; then
  e_header 'Installing Shougo/NeoBundle'
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# vimproc
# cd $HOME/.vim/bundle/vimproc && make -f make_mac.mak

# if no .vimrc.bundles.local, create one
if [ ! -f ~/.vimrc.bundles.local ] ; then
    echo "let g:spf13_bundle_groups=['general']" >> ~/.vimrc.bundles.local
    echo "\"let g:spf13_bundle_groups=['general', 'neocomplcache', 'programming', 'javascript', 'node', 'less', 'html', 'misc']" >> ~/.vimrc.bundles.local
fi


which -s wget
if [[ $? != 0 ]] ; then
    e_header 'Installing wget'
    brew install wget --enable-iri
fi

which -s ag
if [[ $? != 0 ]] ; then
    e_header 'Installing the_silver_searcher'
    brew install the_silver_searcher
fi

which -s ctags
CTAGS_EXIT=$?
CTAGS_PATH=$(which ctags)
if [[ $CTAGS_EXIT != 0 || $CTAGS_PATH == '/usr/bin/ctags' ]] ; then
  e_header "Installing Ctags"
  brew install ctags
fi

which -s tree
if [[ $? != 0 ]] ; then
    e_header 'Installing tree'
    brew install tree
fi

which -s mongod
if [[ $? != 0 ]] ; then
    e_header 'Installing mongodb'
    brew install mongodb
fi

# Remove outdated versions from the cellar
e_header "Cleaning Homebrew"
brew cleanup

# https://github.com/jamiew/git-friendly
which -s push
if [[ $? != 0 ]] ; then
    e_header 'Installing git-friendly'
    bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)
fi

#https://github.com/defunkt/hub
which -s hub
if [[ $? != 0 ]] ; then
    e_header 'Installing hub'
    brew install hub
fi

which -s node
if [[ $? != 0 ]] ; then
    e_header 'Installing node'
    brew install node
fi

which -s node
if [[ $? != 0 ]] ; then
  e_error "node should be installed. It isn't. Aborting."
  exit 1
fi

which -s npm
if [[ $? != 0 ]] ; then
  e_error "npm should be installed. It isn't. Aborting."
  exit 1
fi

# NPM INSTALL

which -s grunt
if [[ $? != 0 ]] ; then
  e_header 'Installing grunt-cli'
  npm install -g grunt-cli
fi

which -s grunt-init
if [[ $? != 0 ]] ; then
  e_header 'Installing grunt-init'
  npm install -g grunt-init
fi

which -s nave
if [[ $? != 0 ]] ; then
  e_header 'Installing nave'
  npm install -g nave
fi

which -s volo
if [[ $? != 0 ]] ; then
  e_header 'Installing volo'
  npm install -g volo
fi

which -s subl
if [[ $? != 0 ]] ; then
    e_header 'Symlinking Sublime to subl'
    ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
fi

GOODIES=$HOME/.goodies

if [ ! -d "$GOODIES/z" ]; then
  e_header 'Installing z script'
  mkdir -p $GOODIES/z
  curl https://raw.github.com/rupa/z/master/z.sh > $GOODIES/z/z.sh
fi

if [ ! -d "$GOODIES/spotifyControl" ]; then
  e_header 'Installing Spotify Script'
  git clone git://github.com/dronir/SpotifyControl.git $GOODIES/spotifyControl
fi

# If Pygments is not installed...
# for the c alias (syntax highlighted cat)
which -s pygmentize
if [[ $? != 0 ]] ; then
  e_header 'Installing Pygments'
  sudo easy_install Pygments
fi
