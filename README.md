# dotfiles

Dotfiles for macOS and Linux(Ubuntu).

Managed by [dotbot](https://github.com/anishathalye/dotbot).

## Pre-Install

### macOS

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install vim git tmux zsh reattach-to-user-namespace
```

### Linux

```bash
sudo apt update
sudo apt install vim git tmux zsh
```

## Install

```bash
git clone --depth 1 https://github.com/ShangjinTang/dotfiles ~/.dotfiles
~/.dotfiles/install
```

## Post-Install


```bash
~/.fzf/install # (Y/Y/N)
vim +PlugInstall
```

## Customization

1. Add configuration files.
2. Edit `install.conf.yaml` to create symlink.
