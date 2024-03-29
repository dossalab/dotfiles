# Profile file. Runs on login. Environmental variables are set here

# Default programs:
export MENU="bemenu"
export EDITOR="helix"
export TERMINAL="alacritty"
export READER="zathura"
export FILE="ranger"
export BROWSER="firefox"
export PAGER="less -i"

export COLORTERM=24bit

# Not sure who exports this, but for simplicity's sake let's provide some defaults
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share/"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config/"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache/"

# Add some common directories to the PATH
export PATH="$XDG_DATA_HOME/cargo/bin/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"

# ~/ Clean-up:
export ZDOTDIR="${XDG_CONFIG_HOME}zsh"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}gtk-2.0/gtkrc-2.0"
export GRADLE_USER_HOME="${XDG_DATA_HOME}gradle"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}docker"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME}java"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}password-store"
export PARALLEL_HOME="${XDG_CONFIG_HOME}parallel"
export EM_CACHE="${XDG_CACHE_HOME}emscripten/cache"
export WGETRC="${XDG_CONFIG_HOME}wgetrc"
export KODI_DATA="${XDG_DATA_HOME}kodi"
export WINEPREFIX="${XDG_DATA_HOME}wineprefixes/default"
export DXVK_STATE_CACHE_PATH="${XDG_CACHE_HOME}dxvk/cache"
export GOPATH="${XDG_DATA_HOME}go"
export SQLITE_HISTORY="${XDG_DATA_HOME}sqlite_history"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}node_repl_history"
export RUSTUP_HOME="${XDG_DATA_HOME}rustup"
export CARGO_HOME="${XDG_DATA_HOME}cargo"

# It's useful to have a custom python initialization - you can pre-import some modules or
# even declare your own custom functions.
export PYTHONSTARTUP="${XDG_CONFIG_HOME}pythonrc"

# Some applications need specific env in order to use native Wayland instead of X emulation
case $XDG_SESSION_TYPE in
"wayland")
  export MOZ_ENABLE_WAYLAND=1
  ;;

"x11")
  # Enable hardware acceleration in firefox
  export MOZ_X11_EGL=1
  export MOZ_USE_XINPUT2=1
  ;;
esac

# Scaling
export QT_ENABLE_HIGHDPI_SCALING=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# This really depends on your system - increase or decrease if you have HiDPI screens
export GDK_DPI_SCALE=1.1

# Export PyWal colors globally so applications like dmenu can be colorized
[ -f "${XDG_CACHE_HOME}wal/colors.sh" ] && . "${XDG_CACHE_HOME}wal/colors.sh"
