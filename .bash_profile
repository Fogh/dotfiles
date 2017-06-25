export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/m-cli
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export BLOCKSIZE=1k

export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

shopt -s cdspell;

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

eval "$(direnv hook bash)"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Aliases
alias la='ls -lah'

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
export PS1='[\u \w$(__git_ps1)]\$ '
export PS2="| => "

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Fastlane completion
. ~/.fastlane/completions/completion.sh
