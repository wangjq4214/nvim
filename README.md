# AstroNvim Configuration for QUAN

**NOTE:** This is used for AstroNvim v4+

This project is form [AstroNvim](https://github.com/AstroNvim/AstroNvim) template.

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
git clone https://github.com/wangjq4214/nvim ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

## Additional

Maybe need to install [lazygit](https://github.com/jesseduffield/lazygit), and the cmds are as follows:

```shell
# For mac
brew install lazygit

# For Ubuntu
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```
