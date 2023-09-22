# dotfiles

Dotfiles for macOS and Linux (ArchLinux & Ubuntu), managed by [dotbot](https://github.com/anishathalye/dotbot).

An out-of-the-box configuration with multiple features, easy to install and customize.

## Supported OS

Fully supported and keep up-to-date:

- ArchLinux x86_64 (also supported in WSL2)
  - script `mpac install` to install all essential packages
- Ubuntu 22.04 x86_64 (also supported in WSL2)
  - only focus on one recently LTS version, because the installation steps are hard to maintain across different Ubuntu versions

Partially supported:

- macOS 10.13 ~ 10.15 x86_64 (might be removed in the future)

## Installation

### Arch Linux x86_64

```bash
sudo pacman -Sy zsh git neovim
chsh -s $(which zsh)
```

Log out and relogin to make sure the shell is changed to `zsh`.

```bash
git clone https://github.com/ShangjinTang/dotfiles ~/.dotfiles --depth=1
~/.dotfiles/install && source ~/.zshrc

pip3 install hydra-core "typer[all]" pynvim
sudo mpac install
```

### Ubuntu 22.04 x86_64

```bash
sudo apt update
sudo apt install zsh git
chsh -s $(which zsh)
```

Log out and relogin to make sure the shell is changed to `zsh`.

```bash
sudo apt update
curl https://pyenv.run | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```

```bash
git clone https://github.com/ShangjinTang/dotfiles ~/.dotfiles --depth=1
~/.dotfiles/install && source ~/.zshrc

pip3 install hydra-core "typer[all]" pynvim
sudo mapt install
```

#### install neovim on Ubuntu 22.04 x86_64

Manual download neovim binary from [Neovim Releases](https://github.com/neovim/neovim/releases).
`fuse` package is an essential dependency for running nvim.

```bash
NVIM_VERSION=v0.9.2

sudo apt install -y fuse
wget https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage
mkdir ~/bin
mv ./nvim.appimage ~/bin/nvim
chmod 755 ~/bin/nvim
```

#### Install [nodejs/npm](https://github.com/nodesource/distributions) on Ubuntu 22.04 x86_64

```bash
NODE_MAJOR=20 # 16/18/20

sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y
```

#### Install tmux on Ubuntu 22.04 x86_64

```bash
TMUX_VERSION=3.3a

sudo apt remove tmux
sudo apt install -y libevent-dev ncurses-dev build-essential bison pkg-config
wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar zxvf tmux-${TMUX_VERSION}.tar.gz && cd tmux-${TMUX_VERSION}
./configure
make -j16 && sudo make install
cd .. && rm -rf tmux-${TMUX_VERSION} tmux-${TMUX_VERSION}.tar.gz
```

#### Install lazygit on Ubuntu 22.04 x86_64

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
```

#### Install sd on Ubuntu 22.04 x86_64

```bash
cargo install sd
```

#### Install croc on Ubuntu 22.04 x86_64

```bash
curl https://getcroc.schollz.com | bash
```

## NVIM Plugins Installation

1. Entering nvim, and wait the plugins to be installed.

- First install: LunarVim plugins
- Second install cycle: Customized plugins

2. Execute `:UpdateRemotePlugins` (for `wilder.nvim`).

Note: NVIM sometimes might be buggy, because some error just appears in the first-time installation. Scroll to bottom to see some fix tips.

## Core Features

- AI support to speed up development
  - copilot-cmp (type `:Copilot auth` for first time use)
  - ChatGPT.nvim (requires `$OPENAI_API_KEY`)
  - `sgpt` CLI tool by python3 pip package `shell-gpt` (requires `$OPENAI_API_KEY`)
- ArchLinux
  - Provide a script `mpac` with pre-set multi pacman installation
  - Provide a script `mpip` with pre-set multi pip installation
- dotbot
  - settings with multi-stages
  - support customized settings (in `~/.dotfiles.local`)
  - automatically download nerd fonts to `~/.fonts`
- zsh
  - based on on-my-zsh, with useful plugins such as:
    - `zsh-abbr`
    - `zsh-autosuggestions`
    - `zsh-syntax-highlighting`
  - settings with multi-stages
    - `~/.zshrc.pre` -> `~/.zshrc` -> `~/zshrc.local` -> `~/.zshrc.post`
  - support customized settings (in `~/zshrc.local`)
- nvim (>=0.9)
  - based on **LunarVim**, but without manual installation
  - LSPs are auto installed using mason-lspconfig
  - add fuzzy prompt for cmdline (wilder) and modern notice (noice)
  - customized key-bindings and seperated from original key-bindings
  - auto format on file save
  - toggleterm with `Ctrl-\`, `Alt-1`, `Alt-2`, `Alt-3`
- tmux (>=3.3a)
  - customized theme and bar
  - gitmux support
  - tmuxp support
- unified theme Catppuccin Frappe (dark background) with transparency
  - support white(non-transparent) & dark(transparent) theme with lualine, nvim-tree, toggleterm
  - Customized theme for `tmux` & `gitmux`
  - customized theme for shell prompt
  - third-party (`nnn`, `bat`, `radare2`) built-in dark theme
- Key Mappings (CapsLock as Escape or Hyper)
  - **Windows**: see [AutoHotkey Settings](https://github.com/ShangjinTang/dotfiles/blob/master/windows/autohotkey/sol.ahk)
  - **macOS**: see [Hammerspoon Readme](https://github.com/ShangjinTang/dotfiles/blob/master/macos/hammerspoon/README.md)
  - **Ubuntu 22.04**: not support

## Features for Simplify Workflow

- global `.gitconfig` and `.gitignore`
- simplify proxy settings
  - preset: `$PROXY_IP` `$PROXY_ENABLED`
  - toggle: `setproxy|unsetproxy`
- simplify tmux session manupilations
  - `t`: open session 0 (default session-name); if attach fail, will create
  - `t <session-name>`: open session with _session-name_; if attach fail, will create
  - `tl`: list all sessions
  - `tk`: kill all sessions except session 0
- add auto edit for fzf
  - use ALT-V to quick edit without typing `v xxx` (`v` is alias for `nvim`)
- use zsh abbreviations to replace some alias
- simplify `$PATH` settings
  - use `_PATHAPPEND`, `_PATHPREPEND` to modify PATHs
  - use `_DIRCREATE` to create a directory if not exists
- simplify change between directories
  - `cu` (short for `cdup`)
    - `cu NUMBER`: e.g. `cu 3` => `cd ../../..`
    - `cu UPPER_DIR_NAME`: cd up to nearest `UPPER_DIR_NAME`
  - `cg` : cd to git root directory
  - `cf` (short for `cdup_contain_file`)

## Features for Simplify Software Development

- simplify C / C++ development
  - `rc` / `rcpp` to run C / C++ files under current directory with provided flags
  - `cmakeb` / `cmaker` to build / run cmake projects under PROJECTROOT
    - auto generate `compile_commands.json`
  - docker with **compiler-explorer** using latest ArchLinux clang / gcc
  - `.clang-tidy` support
- auto code format on save using `neoformat`
  - C / C++ (based on `~/.clang-format`)
  - Python
  - Java
  - Bash
  - Lua
  - ...
- simplify large code-base view
  - docker with local **OpenGrok**
- simplify python development
  - docker with local **Jupyter Lab**
- simplify tasks
  - asynctask: compilation in side nvim under PROJECTROOT based on `.tasks`

## Customization

1. Add configuration files
2. Edit `install.conf.yaml` to create symlink
3. Edit `pre_install` or `post_install` to customize the behaviour before or after installation
4. Add files in `~/.dotfiles.local/` for local override
   - Step 1: Create files in .dotfiles.local with same architecture in home directory
   - Step 2: Run `install` or `post_install`, symlinks will created from ~/ to ~/.dotfiles.local/, e.g.
   - /.gitconfig (generated symlink) -> ~/.dotfiles.local/.gitconfig (created in Step 1)
   - ~/bin/rg (generated symlink) -> ~/.dotfiles.local/bin/rg (created in Step 1)

## Tips & Issue Fix

### nvim

#### nvim plugins

Sometimes you need to update plugins to fix plugin issues by executing `LvimSyncCorePlugins` in nvim.

#### nvim treesitter

Sometimes you need to update treesitter to fix it's issues by executing `:TSUpdate` in nvim.

This can solve issue as below:

```plain
treesitter/highlighter: Error executing lua:
.../share/nvim/runtime/lua/vim/treesitter/query.lua:161: query: invalid node type at position XXX
```

## Desktop Software

### Ubuntu 22.04 x86_64 Desktop

#### Gnome Tweaks

```bash
sudo add-apt-repository universe
sudo apt install gnome-tweaks
```

CapsLock as esc: Tweaks -> Keyboard & Mouse -> Additional Layout Options -> Caps Lock behaviour

Font: Tweaks -> Fonts

#### Install CopyQ on Ubuntu 22.04 x86_64

```bash
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
sudo apt install copyq
```

#### Install [vscode](https://code.visualstudio.com/docs/setup/linux) on Ubuntu 22.04 x86_64

```bash
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```
