# Download Znap, if it's not there yet.
[[ -f ~/.local/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/zsh-snap

source ~/.local/zsh-snap/znap.zsh  # Start Znap

PROMPT="%F{039}%n@%m %F{141}%~ » %f"
znap prompt

# Plugins
znap source Aloxaf/fzf-tab
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting
znap source marlonrichert/zsh-autocomplete
znap source ohmyzsh/ohmyzsh lib/history.zsh

# Aliases
# - macOS -
alias finder="open /System/Library/CoreServices/Finder.app"
alias canary="cd ~/.local/replugged; yarn run unplug canary; yarn run plug canary; open /Applications/Discord\ Canary.app"

# - Generic -
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
alias startmongo="nohup mongod --dbpath ~/.db/mongo &>/dev/null &"
alias uuidhex='python3 -c "import uuid; print(uuid.uuid4().hex)"'
alias vim="nvim"

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
