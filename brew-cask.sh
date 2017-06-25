#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

brew install caskroom/cask/brew-cask
# brew tap caskroom/versions

# daily
brew cask install spotify
brew cask install dropbox
brew cask install 1password
brew cask install evernote
brew cask install spectacle
brew cask install rescuetime
# brew cask install alfred

# dev
brew cask install iterm2
brew cask install virtualbox
brew cask install webstorm
brew cask install visual-studio-code
brew cask install dash
brew cask install imagealpha
brew cask install imageoptim

# fun
brew cask install slack
brew cask install ngrok
brew cask install skype

# browsers
brew cask install google-chrome
brew cask install firefox
# brew cask install torbrowser

# less often
# brew cask install disk-inventory-x

# quick look
brew cask install qlmarkdown
brew cask install quicklook-csv
brew cask install quicklook-json

# fonts
brew tap caskroom/fonts 
brew cask install font-fira-code

