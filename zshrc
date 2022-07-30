# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
source ~/.znap/zsh-snap/znap.zsh
# Download Znap, if it's not there yet.
[[ -f ~/.local/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/znap

# Aliases
alias finder="open /System/Library/CoreServices/Finder.app"
alias canary="cd ~/.local/powercord; yarn run unplug; yarn run plug; open /Applications/Discord\ Canary.app"
alias ytbest='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]"'
# Prompt
PROMPT="%F{039}%n@%m %F{141}%~ » %f"
alias startmongo="nohup mongod --dbpath ~/.db/mongo &>/dev/null &"
# Plugins
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting


# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Add toaster to path :)
export PATH="$HOME/.toaster/bin:$PATH"

source "$HOME/.cargo/env"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

alias cc="clang++"
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
