# dotfiles

Dotfiles for macOS and Linux (ArchLinux & Ubuntu), managed by [dotbot](https://github.com/anishathalye/dotbot).

An out-of-the-box configuration with multiple features, easy to install and customize.

## Supported OS

Fully support and keep up-to-date:

- ArchLinux x86_64 (also supported in WSL2)

Partial support:

- Ubuntu 22.04 x86_64
  - Almost all functionalities should work, but the installation instructions is not complete and hard to maintain
  - Some packages require manual install (e.g. `neovim` / `tmux`)
- macOS 10.13 ~ 10.15 x86_64 (might be removed in the future)

## Installation (ArchLinux)

```bash
sudo pacman -Sy zsh git neovim
chsh -s $(which zsh)
```

Log out and relogin to make sure the shell is changed to `zsh`.

```bash
git clone https://github.com/ShangjinTang/dotfiles ~/.dotfiles --depth=1
~/.dotfiles/install && source ~/.zshrc
sudo mpac install
```

After entering nvim the first time, execute `:UpdateRemotePlugins` (for `wilder.nvim`).

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
  - **macOS**: see [hammerspoon readme](https://github.com/ShangjinTang/dotfiles/blob/master/macos/hammerspoon/README.md)
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
  - `rc` / `rcxx` to run C / C++ files under current directory with provided flags
  - `cbuild` / `crun` to build / run files under PROJECTROOT
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

## Packages required for non-ArchLinux OS

Caution: this web page is not under maintained. For macOS / Ubuntu, you need to install the essential packages.

<details>

  <summary>macOS x86_64</summary>

    <!-- TODO: add more packages -->
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
    brew install sshpass vim git tmux zsh curl wget tree reattach-to-user-namespace tldr
    ```

</details>

<details>

  <summary>Ubuntu 22.04 x86_64</summary>

    <!-- TODO: add more packages -->
    ```bash
    sudo apt update
    sudo apt install -y vim git zsh curl wget tree xclip aria2 ripgrep tree rsync python3-pip fuse pkg-config python3-venv pyenv net-tools
    sudo apt install -y clang clang-format libstdc++-12-dev gcc g++ make cmake universal-ctags cscope ninja-build
    sudo apt install -y libgtest-dev openjdk-17-jdk
    pip3 install pynvim tldr
    ```

    Manual install neovim with `nvim.appimage`. `fuse` pacakge above is for running nvim.

    See: https://github.com/neovim/neovim/releases/tag/v0.9.0

    Install nodejs/npm:

    ```bash
    cd ~
    curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
    sudo apt -y install nodejs
    ```

    Install tmux:

    ```bash
    sudo apt remove tmux
    sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config
    wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
    tar zxvf tmux-3.3a.tar.gz && cd tmux-3.3a
    ./configure
    make -j16 && sudo make install
    cd .. && rm -rf tmux-3.3a tmux-3.3a.tar.gz
    ```

</details>

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

This can solve issues, e.g.:

```plain
treesitter/highlighter: Error executing lua:
.../share/nvim/runtime/lua/vim/treesitter/query.lua:161: query: invalid node type at position
```
