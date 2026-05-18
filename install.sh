#!/bin/sh

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    mkdir -p "$HOME"/.zsh
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.zsh/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.zsh/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             installing Starship prompt                    "
    echo "-----------------------------------------------------------"
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cp .zshrc "$HOME"/.zshrc
    echo "==========================================================="
    echo "             import starship config                        "
    echo "-----------------------------------------------------------"
    mkdir -p "$HOME"/.config
    cp starship.toml "$HOME"/.config/starship.toml
}

# Change time zone
sudo ln -fs /usr/share/zoneinfo/Europe/Oslo /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Copy scripts
mkdir -p "$HOME"/dev/scripts
cp push.sh "$HOME"/dev/scripts/push.sh

# Install packages
## exa (deprecated)
# curl -L https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip --output /tmp/exa-linux.zip && unzip /tmp/exa-linux.zip -d /tmp/exa-linux/ && sudo mv /tmp/exa-linux/bin/exa /usr/local/bin/ && sudo mv /tmp/exa-linux/man/exa.1 /usr/share/man/man1/ && sudo mv /tmp/exa-linux/completions/exa.zsh /usr/local/share/zsh/site-functions/
## eza (exa successor)
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
## bat (cat colors)
sudo apt install -y bat
## fzf (fuzzy finder — pairs with zsh-autosuggestions for Ctrl+R history search)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-fish
## Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Configure fonts
# Hack Nerd Font
mkdir -p "$HOME"/fontinstall
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip --output-document "$HOME"/fontinstall/Hack.zip
unzip "$HOME"/fontinstall/Hack.zip -d "$HOME"/fontinstall/HackNerdFont
sudo mkdir -p /usr/local/share/fonts/hack-nerd-font
sudo cp "$HOME"/fontinstall/HackNerdFont/*.ttf /usr/local/share/fonts/hack-nerd-font/
sudo fc-cache -fv
rm -rf "$HOME"/fontinstall/Hack.zip "$HOME"/fontinstall/HackNerdFont

# Configure ZSH
zshrc

# Adjust path
export PATH="$PATH":"$HOME"/dev/scripts

# make directly highlighting readable - needs to be after zshrc line
#echo "" >> ~/.zshrc
#echo "# remove ls and directory completion highlight color" >> ~/.zshrc
#echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
#echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
#echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc
