# Download Znap, if it's not there yet.
[[ -f ~/.local/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/znap

# Start Znap
source ~/.local/znap/znap.zsh  # Start Znap

# `znap prompt` makes your prompt visible in just 15-40ms!
znap prompt sindresorhus/pure

# Aliases
alias finder="open /System/Library/CoreServices/Finder.app"

# Prompt
PROMPT="%F{039}%n@%m %F{141}%~ » %f"

# Plugins
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# Add toaster to path :)
export PATH="$HOME/.toaster/bin:$PATH"

# Add toaster to path :)
export PATH="$HOME/.toaster/bin:$PATH"
