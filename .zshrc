# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

# Main settings
export ZSH=~/.oh-my-zsh

# Theme settings
ZSH_THEME="spaceship"

SPACESHIP_TIME_SHOW=true
SPACESHIP_DOCKER_SHOW=false
if [[ $(grep -s microsoft /proc/version) ]]; then
  # http://blog.miguelalexcantu.com/2020/12/fixing-upower-warning-wslzshspaceship.html
  SPACESHIP_BATTERY_SHOW=false
fi

# Library settings
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(git)

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Homebrew needs to be loaded before plugins for brew packages
  plugins+=(brew)
fi

plugins+=(
  nodenv
  pyenv
  rbenv
)

# Aliases
# https://github.com/ohmyzsh/ohmyzsh#skip-aliases
zstyle ':omz:plugins:brew' aliases no
zstyle ':omz:plugins:git' aliases no
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

# if [[ "$OSTYPE" == "linux-gnu" ]]; then
if [[ $(grep -s microsoft /proc/version) ]]; then
  # Workaround to open CWD in new tabs for Windows Terminal
  # Source: https://github.com/microsoft/terminal/issues/3158#issuecomment-986826132
  [[ -n "$WT_SESSION" ]] && {
    precmd() {
      printf "\e]9;9;%s\e\\" "$PWD"
    }
  }

  # Set up X11 forwarding for WSL2
  # https://stackoverflow.com/a/61110604
  export DISPLAY=$(ip route list default | awk '{print $3}'):3

  # Workaround X11-unix socket mounted as read-only
  # Source: https://github.com/microsoft/WSL/issues/9303#issuecomment-1345615675
  sudo mount -o remount,rw /tmp/.X11-unix

  MINIO_DATA_DIR="/mnt/c/Users/weimeng/Documents/Dev/minio"

  # Include Python user binaries
  export PATH=$PATH:~/.local/bin

  export PATH=$PATH:/usr/local/go/bin

  export VAGRANT_DEFAULT_PROVIDER=hyperv
  export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/Users/weimeng/go/bin:$PATH"

  # Workaround for duplicate command on tab completion
  # https://github.com/sindresorhus/pure/issues/300
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8

  # For brew installed coreutils
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

  # For brew installed google-cloud-sdk
  export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"

  GCLOUD_SDK_PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  if [ -f "$GCLOUD_SDK_PATH" ]; then . "$GCLOUD_SDK_PATH"; fi

  GCLOUD_COMPLETION_PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  if [ -f "$GCLOUD_COMPLETION_PATH" ]; then . "$GCLOUD_COMPLETION_PATH"; fi

  # For GitLab Development Kit
  # export PATH="/usr/local/opt/postgresql/bin:$PATH"
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
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
