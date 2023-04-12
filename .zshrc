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
# Load and initialize tab-completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# Load the url-quote-magic module that automagically adds quotes when a
# URL is inserted as an argument
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic
# }}}

# {{{ Zsh options

# Automatically push `cd' dirs to the stack`
setopt autopushd pushdminus pushdsilent pushdtohome
# Allow commands like `..' to act like `cd ..'
setopt autocd
# Enable variable substitution in PROMPT and RPROMPT
setopt promptsubst
# Incrementally append history so multiple zsh sessions can share a history
setopt extendedhistory appendhistory incappendhistorytime
# Disable history expansion (reduces problems when typing '!')
unsetopt banghist
# }}}

# {{{ Environment

# History options
export HISTFILE=~/.history HISTSIZE=200000000 SAVEHIST=200000000
# Set the left part of the prompt.
export PROMPT="%F{cyan}%n@%m%f %~ %# "
# Print a grey ¬ (U+00AC) when trying to preserve a partial line
export PROMPT_EOL_MARK="%F{59}¬%f"
# Set the default browser
export BROWSER=firefox
# Set the default editor
export EDITOR=nvim
export SYSTEMD_EDITOR=$EDITOR
# Set the default terminal
export TERMINAL=alacritty
# Print the wall-time for a process when it runs for a longer period of time
export REPORTTIME=4

# }}}

# Load directory colors for `ls'
[ -e ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

# {{{ PATH injection

# Add ~/.bin to the PATH stack if the directory exists
[ -d ~/.bin ] && export PATH="${HOME}/.bin:${PATH}"

[ -d ~/Projects/ESP32/xtensa-esp32-elf ] && export PATH="${PATH}:${HOME}/Projects/ESP32/xtensa-esp32-elf/bin"
[ -d ~/Projects/ESP32/esp-idf ] && export IDF_PATH="${HOME}/Projects/ESP32/esp-idf"

# Set the GOPATH if the ~/.go directory exists
if [ -d ~/.go ]; then
  export GOPATH="${HOME}/.go"
  export PATH="${HOME}/.go/bin:${PATH}"
fi

# Add the /usr/local/go bin dir to PATH if it exists
if [ -d /usr/local/go ]; then
  export PATH="/usr/local/go/bin:${PATH}"
fi

# Add cargo to PATH if ~/.cargo/bin exists
# if [ -e ~/.cargo/bin ]; then
#  export PATH="${HOME}/.cargo/bin:${PATH}"
#fi

# Initialize rbenv if it's installed locally
if [ -e ~/.rbenv/bin/rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
fi

# }}}

# {{{ Ruby tools.
rbenv-init() {
  eval "$(rbenv init -)"
}

# Ruby aliases
alias be='bundle exec'

# }}}

# {{{ Python tools.
# Initialize rbenv if it's installed locally
function pyenv-init() {
  if [ -e ~/.pyenv ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"

    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  fi
}
# }}}

# {{{ Node executables and nodenv.
#
# Initialize nodenv if it's installed on the system
if [ -e ~/.nodenv ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
fi

nodenv-init() {
  eval "$(nodenv init -)"
}

nvm-init() {
  [ -e /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
}

# Add executable dirs to PATH
[ -e ~/.node/bin ] && export PATH="${HOME}/.node/bin:${PATH}"
[ -d ~/.npm-packages ] && export PATH="${HOME}/.npm-packages/bin:${PATH}"

# }}}

## Aliases

# Unix aliases
alias ls='ls --color=auto -F'

if command -v exa >/dev/null; then
  alias ll='exa -l'
else
  alias ll='ls -l'
fi

alias grep='grep --color=auto'
alias gdb='gdb -q'

if command -v nvim >/dev/null; then
  alias vim=nvim
fi

# Git aliases
alias g='git'
alias gush='git push'
alias gushh='git push origin master'
alias gash='git stash'
alias gasha='git stash apply'
alias gush='git push'
alias gushh='git push origin master'
alias gul='git pull'
alias gull='git pull origin master'
alias ga='git commit --amend'

# Kubernetes aliases
if command -v kubectl >/dev/null; then
  source <(kubectl completion zsh)
  alias k='kubectl'
fi

# Taskwarrior aliases
alias t='task'

alias :e='vim' # :e <file>

## String manipulation aliases

# Replace all newlines with a literal '\n'.
alias escape-newlines="sed 's/$/\\\n/g' | tr -d '\n'"
# Trim whitespace at the beginning of each line.
alias trim-line-prefixes="sed 's/^\s*//g'"
# Trim whitespace at the end of each line.
alias trim-line-suffixes="sed 's/\s*$//g'"
# Trim whitespace at the beginning and end of all lines.
alias trim-lines="trim-line-prefixes | trim-line-suffixes"

# Other program aliases
alias objdump='objdump -M intel'

typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

restore-job() {
  fg
}

zle -N restore-job

bindkey '^R' history-incremental-search-backward
bindkey '^B' backward-word
bindkey '^E' forward-word
bindkey '^F' restore-job
# Unbind overwrite-mode on the insert key
bindkey -r '^[[2~'

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

function open {
  handlr open $* &!
}

if [ -e "${HOME}/.restic/${HOST}.key" ]; then
  export RESTIC_REPOSITORY="${HOME}/Backups"
  export RESTIC_PASSWORD_FILE="${HOME}/.restic/${HOST}.key"
fi

[ -e ~/.zshrc.local ] && source ~/.zshrc.local
[ -e ~/.local/bin ] && export PATH="${HOME}/.local/bin:${PATH}"
[ -e ~/.linkerd2/bin ] && export PATH="$PATH}:${HOME}/.linkerd2/bin"

if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

if [ -e /usr/share/fzf/shell/key-bindings.zsh ]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

if [ -e ~/.zsh/fzf-completion.zsh ]; then
  source ~/.zsh/fzf-completion.zsh
fi

function matrix-youtubedl {
  youtube-dl -f 'bestvideo[height<=720]+bestaudio' --merge-output-format mp4 $*
}

alias send='croc --relay croc.maero.dk send'
export RUSTC_FORCE_INCREMENTAL=1

# Load Anaconda3 if it's present
load-anaconda3() {
  [ -e "${HOME}/anaconda3/bin/conda" ] && eval "$(${HOME}/anaconda3/bin/conda shell.zsh hook)"
}


# Open the given file in binaryninja while disowning the process.
function binja() {
  binaryninja "$@" &!
}

# Generate a random alphanumeric password of LENGTH.
#
# Usage: generate-password [LENGTH]
generate-password() {
  local length="${1:-32}"
  local password="$(tr -dc '_A-Z-a-z-0-9' < /dev/urandom | head -c "${length}")"

  echo "${password}"
}

alias random-password=generate-password

esp-idf-init() {
  source ~/Projects/ESP32/esp-idf/export.sh
}

ghopen() {
  local branch=$(git symbolic-ref --short -q HEAD)
  gh browse --branch="${branch}" .
}

# Prepare a shell environment with help from a 1Password vault
#
# Prepares a shell environment by reading the `script` field from an item with
# the given NAME inside the `Environments` vault and then evaluating it in the
# current shell after injecting 1Password references.
#
# Usage:
#
# op-env <NAME>
#
# Example:
#
# op-env npm
#
# The `script` field for the `hello-world` item in the `Environments` vault:
#
# export GITHUB_ACTOR="{{ op://${vault}/GitHub/username }}"
# export GITHUB_TOKEN="{{ op://${vault}/GitHub/Personal Access Tokens/read_packages }}"
op-env() {
  local name="${1}"
  local vault="Private"

  # Read the template from the Environments vault
  local tpl=
  tpl="$(op read -n "op://Environments/${name}/script")"
  [ $? -ne 0 ] && return

  # Inject variables and evaluate 1Password references
  local script=
  script="$(echo -n "${tpl}" | vault="${vault}" env_name="${name}" op inject --cache)"
  [ $? -ne 0 ] && return

  # Print and evaluate the final script
  echo "${script}"
  eval "${script}"
}

case "$TERM" in
  xterm*|rxvt*|alacritty)
   precmd() {
     builtin print -P -n -- "\e]0;$HOST: zsh - %8~\a"
   }

   preexec() {
     builtin print -P -n -- "\e]0;$HOST: ${1[(w)1]} - %8~\a"
   }
   ;;
esac

# Fix for Java applications on i3 and sway
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export PY_COLORS=1

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/config

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"

sdkman-init() {
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

send-to-phone() {
  local device_name="Pixel 6A" input=

  if [[ $# -gt 0 ]]; then
    input="${1}"
  else
    input="$(cat -)"
  fi

  if [[ ("${input}" =~ "^\./" || "${input}" =~ "^/") && -e "${input}" ]] || [[ "${input}" =~ "^http" ]]; then
    kdeconnect-cli \
      --name "${device_name}" \
      --share "${input}"
  else
    kdeconnect-cli \
      --name "${device_name}" \
      --share-text "${input}"
  fi
}

[ -d "$HOME/rp2040/pico-sdk" ] && export PICO_SDK_PATH=$HOME/rp2040/pico-sdk

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep.conf
export MOZ_ENABLE_WAYLAND=1

[ -d "$HOME/.nix-profile/bin" ] && export PATH="$HOME/.nix-profile/bin:$PATH"

export GOPATH="${HOME}/.local/share/go"

[ ! -d "${GOPATH}" ] && mkdir -p "${GOPATH}"
[ -d "${GOPATH}/bin" ] && export PATH="${PATH}:${GOPATH}/bin"

eval "$(direnv hook zsh)"
