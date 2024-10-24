# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

# Main settings
export ZSH=~/.oh-my-zsh

# Theme settings
ZSH_THEME=""

# Library settings
HIST_STAMPS="yyyy-mm-dd"

# Plugins
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Homebrew needs to be loaded before plugins for brew packages
  plugins+=(brew)
fi

plugins+=(
  starship
  pyenv
  rbenv
)

# Aliases
# https://github.com/ohmyzsh/ohmyzsh#skip-aliases
zstyle ':omz:plugins:brew' aliases no
zstyle ':omz:plugins:rbenv' aliases no

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# OS-specific configuration

# Windows Subsystem for Linux
if [[ $(grep -s microsoft /proc/version) ]]; then
  # Workaround to open CWD in new tabs for Windows Terminal
  # https://github.com/microsoft/terminal/issues/3158#issuecomment-986826132
  [[ -n "$WT_SESSION" ]] && {
    precmd() {
      printf "\e]9;9;%s\e\\" "$PWD"
    }
  }

  # Set up X11 forwarding for WSL2
  # https://stackoverflow.com/a/61110604
  export DISPLAY=$(ip route list default | awk '{print $3}'):3

  # Workaround X11-unix socket mounted as read-only
  # https://github.com/microsoft/WSL/issues/9303#issuecomment-1345615675
  sudo mount -o remount,rw /tmp/.X11-unix

  # Include Python user binaries
  export PATH=$PATH:~/.local/bin

  # Set MinIO data directory
  MINIO_DATA_DIR="/mnt/c/Users/weimeng/Documents/Dev/minio"

  alias "cd~"="cd /mnt/c/Users/weimeng"
# macOS
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Workaround for duplicate command on tab completion
  # https://github.com/sindresorhus/pure/issues/300
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8

# Linux
# elif [[ "$OSTYPE" == "linux-gnu" ]]; then
fi

# rails
function berc () {
  if [ -f ./bin/rails ]; then
    bin/rails console
  else
    bundle exec rails console
  fi
}

function bers () {
  if [ -f ./bin/rails ]; then
    bin/rails server -b 0.0.0.0
  else
    bundle exec rails server -b 0.0.0.0
  fi
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias be="bundle exec"
alias pgr="pg_restore --verbose --clean --no-acl --no-owner -h localhost -d"
alias start-minio="MINIO_ROOT_USER=admin MINIO_ROOT_PASSWORD=password minio server $MINIO_DATA_DIR --console-address ':9001'"
