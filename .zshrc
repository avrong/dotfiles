# Prompt
CRLF=$'\n'

function path {
  echo "%(5~|%-1~/.../%3~|%4~)"
}

export PS1="%B$CRLF%F{32}$(path)$CRLF%F{green}>%f%b "

# Aliases
alias ls=eza

# Envars

# Fix editor
export EDITOR="hx"

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# PATH
export PATH=~/Run:$PATH
