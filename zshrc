# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

case "$(uname -a)" in
Darwin*) machine=Mac ;;
*) machine=Linux ;;
esac

HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups # Save each history entry immediately (protects against terminal crashes)
SAVEHIST=10000

source $HOME/.antidote/antidote.zsh
antidote load

prompt_newline='%666v'
#PROMPT=" $PROMPT"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search   # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Variables
export EDITOR=nvim

# Aliases
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
alias ytaudio='yt-dlp -f "bestaudio[ext=m4a]"'
alias uuidhex='python3 -c "import uuid; print(uuid.uuid4().hex)"'
alias vim="nvim"
alias xway="env -u WAYLAND_DISPLAY"
alias blessnext="sudo asahi-bless --next --set-boot 1 -y"
alias blessnow="sudo asahi-bless --next --set-boot 1 -y && systemctl reboot"
alias sudo='sudo '
alias dnf='dnf5 '

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

  export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
  export PATH="/opt/homebrew/opt/pyqt@5/5.15.4_1/bin:$PATH"

  export PATH="$HOME/go/bin:$PATH"
else
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
  source "$HOME/.cargo/env"

# uutils
export PATH="/usr/libexec/uutils-coreutils:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LIBVIRT_DEFAULT_URI="qemu:///system"
