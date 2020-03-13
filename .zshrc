#Set up the prompt
export TERM="xterm-256color"

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
#bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#my aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# added postgresql10 to path
export PATH="/usr/lib/postgresql/10/bin:$PATH"

source /usr/share/powerlevel9k/powerlevel9k.zsh-theme
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias -g g='| grep'

alias gst='git status'
alias grupd='git remote update'
alias gg='git graph'

alias diff='diff --color=auto'

export OPENSSL_CONF=/etc/ssl/openssl_custom.cnf

# powerline custom elements
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir virtualenv vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ssh dir_writable root_indicator background_jobs history time)
# powerline promt to newline
export POWERLEVEL9K_PROMPT_ON_NEWLINE=true


setopt autocd

# vim as default editor
export EDITOR=$(which vim)
export VISUAL=$(which vim)

# enable emacs-mode
bindkey -e
