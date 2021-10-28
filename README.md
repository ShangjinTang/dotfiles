# dotfiles

Dotfiles for macOS and Linux(Ubuntu).

Managed by [dotbot](https://github.com/anishathalye/dotbot).

## Installation

### Pre-Install

```bash
# macOS
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  # install homebrew
brew install vim git tmux zsh reattach-to-user-namespace
```

```bash
# Linux
sudo apt update
sudo apt install vim git tmux zsh ripgrep
```

### Dotfiles Install

```bash
# First time install
git clone --depth 1 https://github.com/ShangjinTang/dotfiles ~/.dotfiles && ~/.dotfiles/install

# Update (if some errors are occured after update, sometimes need to manually remove old symlinks in $HOME directory)
git pull && ~/.dotfiles/install
```

### Post-Install


```bash
~/.fzf/install # (Y/Y/N)
vim +PlugInstall
```

---

## dotfiles customization

1. Add configuration files.
2. Edit `preinstall` to create flags to dynamic control fuctions (platform-independent) on or off.
3. Edit `install.conf.yaml` to create symlink.

---

## Main Functions

Note: Terminal colors (tmux/vim) are based on light theme.

### [tmux](https://github.com/gpakosz/.tmux.git)

- settings:
  - `.tmux.conf.local`: cross-platform settings 
  - `.tmux.conf.local.os`: os-based settings
- plugins:
  - gitmux: show git status in tmux bar
  - gitmux.config: status bar color/font configurations
- theme: self-customized, adjust to papercolor-theme light
- aliases:
  - `tl`: list all sessions
  - `tk`: kill all sessions except session 0

### vim with [vim-plug](https://github.com/junegunn/vim-plug)

- plugins:
  - 'vim-airline/vim-airline'
  - 'vim-airline/vim-airline-themes'
  - 'tpope/vim-fugitive'
  - 'junegunn/fzf'
  - 'junegunn/fzf.vim'
  - 'tpope/vim-commentary'
  - 'preservim/nerdtree'
  - 'NLKNguyen/papercolor-theme'
- theme:
  - papercolor-light
- map keys (LEADER: Space):
  - CTRL-T: fzf
  - LEADER-l: git commits
  - LEADER LEADER: nerdtree

### [fzf](https://github.com/junegunn/fzf)

use fzf as rg(ripgrep)'s backend


### shellrc (zshrc / bashrc)

- add ~/bin to path
- use similar aliases in zsh & bash
- setproxy/unsetproxy on port 1080
- ssh to VPS machines


#### [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

- plugins:
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- theme:
  - self-customized theme 'sol-light'


### hammerspoon for macOS

See [hammerspoon readme](https://github.com/ShangjinTang/dotfiles/blob/master/macos/hammerspoon/README.md)