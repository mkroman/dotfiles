# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org>


# {{{ Load Zsh modules
# Load and initialize the `colors' environment variable with ANSI colors
autoload -Uz colors && colors

# Load and initialize tab-completion.
autoload -Uz compinit
if [[ "$(uname -s)" == "Darwin" ]] && [[ "$(whoami)" == "work" ]]; then
  # Load insecure files because Homebrew is stupid.
  compinit -u
else
 compinit
fi

# Style for completion menu.
zstyle ':completion:*' menu select

# Automatically quote URLs pasted into the command line.
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic
# }}}
# {{{ Zsh Options

# Directory stack management.
setopt autopushd pushdminus pushdsilent pushdtohome

# Allow `..' to act like `cd ..'.
setopt autocd

# Enable variable substitution in prompts.
setopt promptsubst

# Incrementally append history so multiple zsh sessions can share a history
setopt extendedhistory appendhistory incappendhistorytime

# Disable history expansion to avoid issues with '!'.
unsetopt banghist

# }}}
# {{{ Environment Variables

# History file configuration.
export HISTFILE="${HOME}/.history"
export HIST_IGNORE_DUPS
export HISTSIZE=200000000
export SAVEHIST=200000000

# Prompt configuration.
export PROMPT="%F{cyan}%n@%m%f %~ %# "
export PROMPT_EOL_MARK="%F{59}¬%f" # Character for preserved partial lines.

# Default applications.
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=ghostty
export SYSTEMD_EDITOR=$EDITOR

# Report wall-time for commands running longer than 4 seconds.
export REPORTTIME=4

# Fix for Java GUI applications on tiling window managers.
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# Enable colors for Python.
export PY_COLORS=1

# Enable Wayland backend for Mozilla applications.
export MOZ_ENABLE_WAYLAND=1

# Enable ripgrep configuration file.
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/ripgrep.conf"

# SDK Paths
[ -d "$HOME/rp2040/pico-sdk" ] && export PICO_SDK_PATH="$HOME/rp2040/pico-sdk"

# }}}

# {{{ Path configuration.

# A helper function to prepend a directory to the PATH if it exists.
prepend_to_path() {
  if [ -d "$1" ]; then
    export PATH="$1:$PATH"
  fi
}

# Prepend directories to PATH.
prepend_to_path "${HOME}/.local/bin"
prepend_to_path "{$HOME}/.bin"
prepend_to_path "${KREW_ROOT:-$HOME/.krew}/bin"
prepend_to_path "{$HOME}/.npm-packages/bin"
prepend_to_path "{$HOME}/.node/bin"
prepend_to_path "{$HOME}/.bun/bin"

# Homebrew PATH setup.
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# }}}
# {{{ Aliases


# }}}

# Use fzf for selecting when typing `**<TAB>`.
if [ -e /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
fi

# Use fzf keybindings.
#
# CTRL-T - fuzzy find a file and insert it on the command line
# ALT-C  - fuzzy find and change working directory to the selected one
# CTRL-r - fuzzy find shell history
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
fi

## Aliases
alias ls='ls --color=auto -F'
alias grep='grep --color=auto'
alias gdb='gdb -q'
alias objdump='objdump -M intel'
alias :e='vim' # Quick edit alias

# Use `eza` if available for `ls` and `ll`.
if command -v eza >/dev/null; then
  alias ls='eza'
  alias ll='eza -l'
else
  alias ll='ls -l'
fi

# Use nvim instead of vim if it's installed.
if command -v nvim >/dev/null; then
  alias vim='nvim'
fi

# Git aliases.
alias gush='git push'
alias gushh='git push origin master'
alias gash='git stash'
alias gasha='git stash apply'
alias gush='git push'
alias gushh='git push origin main'
alias gul='git pull'
alias gull='git pull origin main'
alias ga='git commit --amend'

# Kubernetes command-line completion.
if command -v kubectl >/dev/null; then
  alias k='kubectl'
  source <(kubectl completion zsh)
fi

## Taskwarrior
alias t='task'

## Other Tools

# Alias for Tailscale on macOS.
if [ -x "/Applications/Tailscale.app/Contents/MacOS/Tailscale" ]; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi


# String manipulation.
alias escape-newlines="sed 's/$/\\\n/g' | tr -d '\n'" # Replace newlines with literal '\n'
alias trim-line-prefixes="sed 's/^\s*//g'"           # Trim leading whitespace
alias trim-line-suffixes="sed 's/\s*$//g'"           # Trim trailing whitespace
alias trim-lines="trim-line-prefixes | trim-line-suffixes" # Trim both ends

## Keybindings

typeset -A key
key=(
  Home      "$terminfo[khome]"
  End       "$terminfo[kend]"
  Insert    "$terminfo[kich1]"
  Backspace "$terminfo[kbs]"
  Delete    "$terminfo[kdch1]"
  Up        "$terminfo[kcuu1]"
  Down      "$terminfo[kcud1]"
  Left      "$terminfo[kcub1]"
  Right     "$terminfo[kcuf1]"
  PageUp    "$terminfo[kpp]"
  PageDown  "$terminfo[knp]"
)

# Standard keybindings.
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char


# Custom keybindings.
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^B' backward-word
bindkey '^E' forward-word
bindkey '^F' fg # Restore job
bindkey -r '^[[2~' # Unbind insert key from overwrite-mode

# Ensure the terminal is in application mode for zle.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  zle-line-init () { echoti smkx; }
  zle-line-finish () { echoti rmkx; }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

restore-job() {
  fg
}

zle -N restore-job

## Miscellaneous functions

# Usage: `mkdiff <file1> <file2>`
function mkdiff {
  diff -udrP "$1" "$2" > "diff.$(date "+%Y-%m-%d").$1"
}

# Usage: `mkcd <path>`
function mkcd {
  mkdir -p "$*" && cd "$*"
}

# Get the length of a string
function len {
  expr length "$1"
}

# use `vzf` to open a file found with fzf in vim.
function vzf {
  vim "$(fzf)"
}

# Use `handlr` to open files if `open` is already used for something else.
if ! command -v open &>/dev/null 2>&1; then
  function open {
    handlr open $* &!
  }
fi

if [ -e /usr/share/fzf/shell/key-bindings.zsh ]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

if [ -e "${HOME}/.zsh/fzf-completion.zsh" ]; then
  source "${HOME}/.zsh/fzf-completion.zsh"
fi

## Functions

# Open a file in Binary Ninja and disown the process.
binja() {
  binaryninja "${@}" &!
}

# Generate a random e-mail address using `petname` which is available at
# https://github.com/allenap/rust-petname
generate-mail() {
  echo "$(petname --separator '.' --words 3 --complexity 2)@maero.dk"
}

gen() {
  case "${1}" in
    mail)
      generate-mail
      ;;
    pass|password|pw)
      generate-password
      ;;
  esac
}

# Generate a random alphanumeric password of LENGTH.
#
# Usage: generate-password [LENGTH]
generate-password() {
  local length="${1:-32}"
  local password="$(LC_CTYPE=C tr -dc '_A-Z-a-z-0-9' < /dev/urandom | head -c "${length}")"

  echo "${password}"
}

## Prompt & Terminal Title

# Set terminal title to show current command.
case "${TERM}" in
  xterm*|rxvt*|alacritty|ghostty)
   precmd() {
     print -Pn "\e]0;${HOST}: zsh - %8~\a"
   }
   preexec() {
     print -Pn "\e]0;${HOST}: ${1[(w)1]} - %8~\a"
   }
   ;;
esac

## Plugin & Tool Integration

# Load Bun completions.
if [ -d "${HOME}/.bun" ]; then
  [ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
  export BUN_INSTALL="${HOME}/.bun"
fi

# Manage runtime versions.
if command -v mise >/dev/null; then
  eval "$(mise activate zsh)"
fi

# Create an alias to activate the ESP-IDF environment.
if [ -f "${HOME}/Projects/esp/esp-idf/export.sh" ]; then
  alias idf="source ${HOME}/Projects/esp/esp-idf/export.sh"
fi

# Load direnv hook if available.
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

## Finalization.

# Load local customizations. This sould be the last thing sourced.
[ -f "${HOME}/.zshrc.local" ] && source "${HOME}/.zshrc.local"

# Load directory colors for `ls`.
[ -f "${HOME}/.dircolors" ] && eval "$(dircolors -b "${HOME}/.dircolors")"
