# -- Variables --
TIMEZONE="America/New_York"
LOCALE="en_US.UTF-8"
PREFERRED_SHELL="/bin/zsh"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# -- Functions --
abort() {
    echo "${1} Aborting..."
    exit 1
}

# Install doas
if ! command -v doas >& /dev/null; then
    echo "Installing doas. Enter your root password below, if prompted"
    su -c 'pacman -Sy --noconfirm; pacman -S doas --noconfirm' || abort "Failed to install doas."

    echo "Configuring doas. Enter your root password below, if prompted"
    su -c "echo 'permit persist :wheel' > /etc/doas.conf" || abort "Failed to configure doas"
fi

echo "Removing sudo..."
if pacman -Qi sudo >&/dev/null; then
    doas pacman -R sudo --noconfirm || abort "Failed to remove sudo."
    doas ln -s /usr/bin/doas /usr/bin/sudo || abort "Failed to link sudo to doas"
fi

# Install paru
if ! command -v paru >& /dev/null; then
    echo "Installing paru..."
    cd /tmp
    git clone https://aur.archlinux.org/paru-bin.git || abort "Failed to download paru"
    cd paru-bin
    makepkg -si || abort "Failed to install paru."
    echo "Installation complete!"
else
    echo "Paru already installed!"
fi

# Update mirrors for paru
echo "Updating mirrors..."
paru -Sy --noconfirm || abort "Failed to update paru mirrors"

echo "Installing packages..."
paru -S --needed $(< arch_pkglist.txt) || abort "Failed to install packages"

# Change preferred shell
echo "Changing shell to ${PREFERRED_SHELL}..."
chsh -s ${PREFERRED_SHELL} || abort "Failed to change shell."

# Set locale
doas localectl set-locale LANG=${LOCALE}
