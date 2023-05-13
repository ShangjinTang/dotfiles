# dotfiles

Dotfiles for macOS and Linux (ArchLinux & Ubuntu), managed by [dotbot](https://github.com/anishathalye/dotbot).

An out-of-box use with multiple features, easy to install and customize.

## Supported OS

Fully support and keep up-to-date:

- ArchLinux x86_64 (also supported in WSL2)

Partial support:

- Ubuntu 20.04 x86_64
- macOS 10.13 ~ 10.15 x86_64 (might remove in future)

## Installation (ArchLinux)

```bash
sudo pacman -Sy zsh git neovim
chsh -s $(which zsh)
```

Log out and relogin to make sure the shell is changed to zsh.

```bash
git clone https://github.com/ShangjinTang/dotfiles ~/.dotfiles --depth=1
~/.dotfiles/install && source ~/.zshrc
sudo pac install
nvim +PlugInstall
```

## Core Features

- ArchLinux
  - Provide a script "pac" with pre-set configurations
- dotbot
  - settings with multi-stages
  - support customized settings (in `~/.dotfiles.local`)
- zsh
  - based on on-my-zsh, with useful plugins such as:
    - zsh-abbr
    - zsh-autosuggestions
    - zsh-syntax-highlighting
  - settings with multi-stages
    - `~/.zshrc.pre` -> `~/.zshrc` -> `~/zshrc.local` ->  `~/.zshrc.post`
  - support customized settings (in `~/zshrc.local`)
- nvim (>=0.9)
  - based on LunarVim, but without manual installation
  - LSPs are auto installed using mason-lspconfig
  - add fuzzy prompt for cmdline (wilder) and modern notice (noice)
  - customized key-bindings and seperated from original key-bindings
- tmux (>=3.3a)
  - customized theme and bar
  - gitmux support
  - tmuxp support
- theme OneDark
  - Transparency with lualine, nvim-tree, toggleterm
  - customized tmux & gitmux for onedark theme
  - customized shell prompt for onedark theme
  - third-party (nnn, bat, radare2) built-in ondark theme
- Key Mappings (CapsLock as Escape or Hyper)
  - Windows: see [AutoHotkey Settings](https://github.com/ShangjinTang/dotfiles/blob/master/windows/autohotkey/sol.ahk)
  - macOS: see [hammerspoon readme](https://github.com/ShangjinTang/dotfiles/blob/master/macos/hammerspoon/README.md)
  - Ubuntu 20.04: not support

## Features for Simplify Workflow

- global `.gitconfig` and `.gitignore`
- simplify proxy settings
  - `setproxy` | `unsetproxy`
- simplify tmux session manupilations
  - `t`: open session 0 (default session-name); if attach fail, will create
  - `t <session-name>`: open session with *session-name*; if attach fail, will create
  - `tl`: list all sessions
  - `tk`: kill all sessions except session 0
- add auto edit for fzf
  -  use ALT-V to quick edit without typing `v xxx` (`v` is alias for `nvim`)
- use zsh abbreviations to replace some alias
- simplify `$PATH` settings
  - use `_PATHAPPEND`, `_PATHPREPEND` to modify PATHs
  - use `_DIRCREATE` to create a directory if not exists
- simplify change between directories
  - `cu` (short for `cdup`)
    - `cu NUMBER`: e.g. `cu 3` => `cd ../../..`
    - `cu UPPER_DIR_NAME`: cd up to nearest `UPPER_DIR_NAME`
  - `cdgitroot`
  - `cf` (short for `cdup_contain_file`)

## Features for Simplify Software Development

- simplify C / C++ compilation
  - `rc` / `rcxx` to run C / C++ files under current directory with provided flags
  - `cbuild` (short for `cmakebuild`) to run files under PROJECTROOT
    - auto generate `compile_commands.json`
  - async cmake (`<SPACE>ac`): compilation in side nvim under PROJECTROOT
  - docker with **compiler-explorer** using latest ArchLinux clang / gcc
- `.clang-tidy` support
- simplify code format
  - C / C++ / Java / ...: auto format on file saving with 4-space-indent
- simplify large code-base view
  - docker with local **OpenGrok**
- simply python development
  - docker with local **jupyter-lab**

## Packages required for non-ArchLinux OS

<details>

  <summary>macOS x86_64</summary>

    <!-- TODO: add more packages -->
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
    brew install sshpass vim git tmux zsh curl wget tree reattach-to-user-namespace tldr
    ```

</details>


<details>

  <summary>Ubuntu 20.04 x86_64</summary>

    <!-- TODO: add more packages -->
    ```bash
    sudo apt update
    sudo apt install -y net-tools vim git zsh curl wget tree xclip aria2 ripgrep tree rsync python3-pip
    sudo apt install -y gcc g++ make cmake universal-ctags cscope ninja-build
    sudo pip3 install tldr
    ```

</details>

## How to ...

<details>

  <summary>How to customize dotfiles</summary>

    1. Add configuration files
    2. Edit `install.conf.yaml` to create symlink
    3. Edit `pre_install` or `post_install` to customize the behaviour before or after installation
    4. Add files in `~/.dotfiles.local/` for local override
    - Step 1: Create files in .dotfiles.local with same archtecture in home directory
    - Step 2: Run `install` or `post_install`, symlinks will created from ~/ to ~/.dotfiles.local/, e.g.
    - /.gitconfig (generated symlink) -> ~/.dotfiles.local/.gitconfig (created in Step 1)
    - ~/bin/rg (generated symlink) -> ~/.dotfiles.local/bin/rg (created in Step 1)

</details>

<details>

  <summary>How to install tmux</summary>

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

<details>

  <summary>How to install nodejs/npm</summary>

    ```bash
    wget https://nodejs.org/dist/v16.17.0/node-v16.17.0-linux-x64.tar.xz
    sudo tar xvf node-v16.17.0-linux-x64.tar.xz -C /opt/
    sudo mv /opt/node-v16.17.0-linux-x64 /opt/node
    rm node-v16.17.0-linux-x64.tar.xz
    ```

</details>
