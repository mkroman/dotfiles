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
#
fpath=(~/.zsh/completion $fpath)

## Zsh modules
# Load and initialize the `colors' environment variable with ANSI colors
autoload -Uz colors && colors
# Load and initialize tab-completion
autoload -Uz compinit && compinit
setopt completealiases
zstyle ':completion:*' menu select
# Load the url-quote-magic module that automagically adds quotes when a
# URL is inserted as an argument
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

## Zsh options
# Automatically push `cd' dirs to the stack`
setopt autopushd pushdminus pushdsilent pushdtohome
# Allow commands like `..' to act like `cd ..'
setopt autocd
# Enable variable substitution in PROMPT and RPROMPT
setopt prompt_subst

## Environment
# History options
export HISTFILE=~/.history HISTSIZE=2000 SAVEHIST=2000
# Set the left part of the prompt.
export PROMPT="%F{cyan}%n@%m%f %~ %# "
# Print a grey ¬ (U+00AC) when trying to preserve a partial line
export PROMPT_EOL_MARK="%F{59}¬%f"
# Set the default browser
export BROWSER=firefox
# Set the default editor
export EDITOR=vim
export SYSTEMD_EDITOR=$EDITOR
# Set the default terminal
export TERMINAL=termite
# Print the wall-time for a process when it runs for a longer period of time
export REPORTTIME=4

# Load directory colors for `ls'
[ -e ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

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
if [ -e ~/.cargo/bin ]; then
  export PATH="${HOME}/.cargo/bin:${PATH}"
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi


# {{{ Ruby-specific stuff

# Initialize rbenv if it's installed locally
if [ -e ~/.rbenv/bin/rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"

  eval "$(rbenv init -)"
fi

# Ruby aliases
alias be='bundle exec'

# }}}

# Initialize rbenv if it's installed locally
function pyenv-init() {
  if [ -e ~/.pyenv ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"

    eval "$(pyenv init - )"
  fi
}

# {{{ Node.js specific stuff
#
# Initialize nodenv if it's installed locally
if [ -e ~/.nodenv ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"

  eval "$(nodenv init -)"

fi

# Add executable dirs to PATH
[ -e ~/.node/bin ] && export PATH="${HOME}/.node/bin:${PATH}"
[ -d ~/.npm-packages ] && export PATH="${HOME}/.npm-packages/bin:${PATH}"

# }}}

## Aliases

# Unix aliases
alias ls='ls --color=auto -F'
alias ll='exa -l'
alias grep='grep --color=auto'
alias gdb='gdb -q'
alias vim=nvim

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
# Docker aliases
alias dm='docker-machine'
# Taskwarrior aliases
alias t='task'
alias bat='bat --style=plain'
alias gpg='gpg2'

alias :e='vim' # :e <file>

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

bindkey '^R' history-incremental-search-backward
bindkey '^B' backward-word

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

if [ -e "${HOME}/.restic/${HOST}.key" ]; then
  export RESTIC_REPOSITORY="${HOME}/Backups"
  export RESTIC_PASSWORD_FILE="${HOME}/.restic/${HOST}.key"
fi

[ -e ~/.zshrc.local ] && source ~/.zshrc.local
[ -e ~/.local/bin ] && export PATH="${HOME}/.local/bin:${PATH}"

if [ -e /usr/share/fzf/shell/key-bindings.zsh ]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

if [ -e ~/.zsh/fzf-completion.zsh ]; then
  source ~/.zsh/fzf-completion.zsh
fi

# https://github.com/thestinger/termite#user-content-id2
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

if [ -x ~/.bin/mc ]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C ~/.bin/mc mc
fi

