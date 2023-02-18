# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

if ! command -v fig &> /dev/null; then
    echo "Fig is recommended!"
fi

PROMPT="%F{039}%n@%m %F{141}%~ » "

# Aliases
# - macOS -
alias finder="open /System/Library/CoreServices/Finder.app"

# - Generic -
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
alias startmongo="nohup mongod --dbpath ~/.db/mongo &>/dev/null &"
alias uuidhex='python3 -c "import uuid; print(uuid.uuid4().hex)"'
alias vim="nvim"

# Homebrew opts
export HOMEBREW_CASK_OPTS="--no-quarantine"

# PATH
# - macOS -
# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Crossover
export PATH="/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/CrossOver-Hosted Application/:$PATH"

# - Generic -
# Add toaster to path :)
export PATH="$HOME/.toaster/bin:$PATH"

# Cargo
source "$HOME/.cargo/env"
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
export PATH="/opt/homebrew/opt/pyqt@5/5.15.4_1/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
