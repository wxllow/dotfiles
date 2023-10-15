case "${unameOut}" in
    Darwin*)    machine=Mac;;
    *)          machine=Linux;;
esac

HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit

print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}

# ---- Load antidote (zsh plugin manager) ----
# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=$HOME/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins

prompt_newline='%666v'
PROMPT=" $PROMPT"

# Aliases
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
alias uuidhex='python3 -c "import uuid; print(uuid.uuid4().hex)"'
alias vim="nvim"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export GOPATH="$HOME/Projects"

# ---- macOS Specific ----
if [ "$machine" = "Mac" ]; then
  # -- Aliases
  alias finder="open /System/Library/CoreServices/Finder.app"
  
  # Homebrew opts
  export HOMEBREW_CASK_OPTS="--no-quarantine"

  # -- PATH
  # Homebrew
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

  # Crossover
  export PATH="/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/CrossOver-Hosted Application/:$PATH"

  # Cargo
  source "$HOME/.cargo/env"
  export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
  export PATH="/opt/homebrew/opt/pyqt@5/5.15.4_1/bin:$PATH"
fi
