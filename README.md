# dotfiles

Dotfiles for [ArchLinux][ArchLinux] x86_64 & [Ubuntu 24.04][Ubuntu 24.04] x86_64, managed by [dotbot][dotbot].

An out-of-the-box configuration with multiple features, easy to install and customize.

Notes:

1. **It's not a light-weight configuration; and only support for [zsh][zsh].**
2. **If you are in China Mainland, recommend to use a proxy set `PROXY_IP` and `PROXY_ENABLED`.**
3. **There is no uninstall script yet.**. Before installation please try in docker or virtual machine first.
4. **Suggest to use [latest release](https://github.com/ShangjinTang/dotfiles/releases).**

## Supported OS

Fully supported and keep up-to-date:

- **[ArchLinux][ArchLinux] x86_64** (also supported in WSL2)
- **[Ubuntu 24.04][Ubuntu 24.04] x86_64** (also supported in WSL2)

Note: for Ubuntu, only recently Ubuntu LTS version is supported, as the required tools/packages are hard to maintain across different Ubuntu versions.

Partially supported:

- **Other Ubuntu x86_64 Versions**
  - Even running on Ubuntu 16.04 (offline, no root permission) can be OK with almost full features enabled
    - see: [How to Install on an Old-school Server](https://github.com/ShangjinTang/dotfiles/wiki/How-to-Install-on-an-Oldschool-Server)
  - Essential Packages:
    - executables: **zsh**, **rust & cargo**, **mise**, **nodejs**, **tmux**, **rg(ripgrep)**, **fd(fd-find)**
  - You can download x86_64 prebuilt executables in [CLI Prebuilts](https://github.com/ShangjinTang/cli-prebuilts).

## Installation

1. Setup a proxy (China Mainland only)

   If you are in China Mainland, please use a proxy to bypass GFW before installation. Otherwise some steps may fail.

   ```bash
   vim ~/.zshrc.private
   ```

   ```bash
   export PROXY_IP="127.0.0.1:7890"
   export PROXY_ENABLED=1
   ```

   For more customized environments, see [zshrc.pre](https://github.com/ShangjinTang/dotfiles/blob/master/configs/zsh/zshrc.pre)

2. Add essential required packages

   - **Arch Linux x86_64**

     ```bash
     sudo pacman -Sy base-devel python git zsh vim net-tools wget xclip curl ripgrep
     chsh -s $(which zsh)
     ```

   - **Ubuntu 24.04 x86_64**

     ```bash
     sudo apt update
     sudo apt install -y build-essential python git zsh vim net-tools wget xclip curl ripgrep
     ```

3. Change shell to zsh

   ```bash
   chsh -s $(which zsh)
   ```

   Log out and re-login to make sure the shell is changed to `zsh`.

4. Clone this repository and install

   ```bash
   git clone https://github.com/ShangjinTang/dotfiles ~/.dotfiles --depth=1 --recurse-submodules --shallow-submodules
   ~/.dotfiles/install && source ~/.zshrc

   # recommend to use mise to unify python versions across different machines
   mise use --global python@3.12
   ```

## Core Features

- [dotbot][dotbot]
  - settings with multi-stages
  - automatically download some [nerdfonts][nerdfonts] to `~/.fonts`
- [zsh][zsh], based on [oh-my-zsh][oh-my-zsh]
  - useful plugins such as:
    - `fzf-tab`
    - `zsh-autosuggestions`
    - `zsh-syntax-highlighting`
  - settings with multi-stages
    - `~/.zshrc.pre` -> `~/.zshrc` -> `~/.zshrc.private` -> `~/.zshrc.post`
  - support customized settings (in `~/zshrc.private`)
- [mise][mise]
  - [mise][mise] is like [asdf][asdf], but much more fast and user-friendly
  - use `~/.tool-versions` to install essential packages
- [tmux][tmux] (>=3.3a)
  - customized theme and bar
  - [gitmux][gitmux] support
  - [tmuxp][tmuxp] support
- unified theme Catppuccin Frappe (dark background) with transparency
  - customized theme for `tmux` & `gitmux`
  - customized theme for shell prompt
  - third-party (`bat`, `radare2`) built-in dark theme

## Features

- simplify proxy settings
  - preset: `$PROXY_IP` `$PROXY_ENABLED`
  - toggle: `setproxy` `unsetproxy`
- simplify `$PATH` settings
  - use `_PATHAPPEND`, `_PATHPREPEND` to modify PATHs
  - use `_DIRCREATE` to create a directory if not exists
- auto code format on save using `neoformat`
  - C / C++ (based on `~/.clang-format`)
  - Python
  - Java
  - Bash
  - Lua
  - ...

## Customization

1. Add configuration files
2. Edit `install.conf.yaml` to create symlink
3. Edit `install.pre` or `install.post` to customize the behavior before or after installation
4. For configurations override, see [How to Create Override Configurations](https://github.com/ShangjinTang/dotfiles/wiki/How-to-Create-Override-Configurations)

## Tips & Issue Fix

### took too long to start in WSL

1. Remove `xclip` and `xsel`.
2. Install `win32yank` and add it to Windows PATH. Ensure `win32yank` can be accessed in WSL.

### mise

- If you have issue with `mise` packages, please remove the issue package from `.tool-versions` and manually install it.
- If you need to use a different version in a folder, use `mise local <some-package>@<version-number>`.
- `mise` support all [asdf-plugins][asdf-plugins].

[dotbot]: https://github.com/anishathalye/dotbot
[ArchLinux]: https://archlinux.org/
[Ubuntu 24.04]: https://releases.ubuntu.com/noble/
[zsh]: https://www.zsh.org/
[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh
[mise]: https://mise.jdx.dev/
[asdf]: https://asdf-vm.com/
[asdf-plugins]: https://github.com/asdf-vm/asdf-plugins
[tmux]: https://github.com/tmux/tmux/wiki
[gitmux]: https://github.com/arl/gitmux
[tmuxp]: https://github.com/tmux-python/tmuxp
[nerdfonts]: https://www.nerdfonts.com/
