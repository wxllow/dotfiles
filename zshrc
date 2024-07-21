case "$(uname -a)" in
Darwin*) machine=Mac ;;
*) machine=Linux ;;
esac

HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups # Save each history entry immediately (protects against terminal crashes)
SAVEHIST=10000

autoload -Uz compinit
compinit

print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@"
}

# ---- Load antidote (zsh plugin manager) ----
# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

prompt_newline='%666v'
PROMPT=" $PROMPT"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search   # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Aliases
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
alias ytaudio='yt-dlp -f "bestaudio[ext=m4a]"'
alias uuidhex='python3 -c "import uuid; print(uuid.uuid4().hex)"'
alias vim="nvim"
alias dnf="dnf5"
alias xway="env -u WAYLAND_DISPLAY"
alias blessnext="sudo asahi-bless --next --set-boot 1 -y"

# bun completions
[ -s "$HOME/bun/_bun" ] && source "$HOME/.bun/_bun"

export PATH="$HOME/.local/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export GOPATH="$HOME/Projects"
export GOBIN="$HOME/go/bin"

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

  export PATH="$HOME/go/bin:$PATH"
else
  if [[ "$(tty)" == "/dev/tty1" ]]; then
    Hyprland
  fi

  
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pnpm
export PNPM_HOME="/home/wl/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
