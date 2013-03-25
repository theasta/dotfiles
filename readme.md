# My dotfiles.

Based upon :
[Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles/)
[Paul Irish's dotfiles](https://github.com/paulirish/dotfiles/)
[Ben Alman's dotfiles installer](https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles)
[spf13-vim](https://github.com/spf13/spf13-vim)

## private config

Toss it into a file called `.bash_extra` which you do not commit to this repo and just keep in your `~/`

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

## overview of files

####  Automatic config
* `.ackrc` - for ack (better than grep)
* `.vimrc`, `.vim` - vim config, obv.
* `.jshintrc`, `.vim` - vim config, obv.

#### shell environement
* `.bash_aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.bash_exports`
* `.bash_functions`
* `.bash_extra` - not included, explained above

#### manual run
* `bootstrap.sh` - random apps i need installed
* `.osx` - run on a fresh osx machine

#### git
* `.git`
* `.gitattributes`
* `.gitconfig`
* `.gitignore`

* `.inputrc` - config for bash readline
* `.hushlogin` - Disable the copyright notice

## Installation

```bash
git clone https://github.com/theasta/dotfiles.git && cd dotfiles && ./sync.sh
```

To install / upgrade dependencies (homebrew, git, node, grunt and other goodies ...)

```bash
./bootstrap.sh
```

To update later on, just run the sync again.
