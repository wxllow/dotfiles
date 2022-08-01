# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
source ~/.znap/zsh-snap/znap.zsh
# Download Znap, if it's not there yet.
[[ -f ~/.local/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/znap

# Prompt
PROMPT="%F{039}%n@%m %F{141}%~ » %f"

# Znap update
(&>/dev/null znap pull &)

# Plugins
znap source Aloxaf/fzf-tab
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting
znap source marlonrichert/zsh-autocomplete

# Aliases
# - macOS -
alias finder="open /System/Library/CoreServices/Finder.app"
alias canary="cd ~/.local/powercord; yarn run unplug; yarn run plug; open /Applications/Discord\ Canary.app"
# - Generic -
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
alias startmongo="nohup mongod --dbpath ~/.db/mongo &>/dev/null &"

# PATH
# - macOS -
# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# - Generic -
# Add toaster to path :)
export PATH="$HOME/.toaster/bin:$PATH"
source "$HOME/.cargo/env"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
