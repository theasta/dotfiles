# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{bash_extra,bash_prompt,bash_exports,bash_aliases,bash_functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# init rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# init z   https://github.com/rupa/z
if [ -d "$HOME/.goodies/z" ]; then
  . $HOME/.goodies/z/z.sh
fi

## Grunt auto-completion
which -s grunt
if [[ $? == 0 ]] ; then
  eval "$(grunt --completion=bash)"
fi

