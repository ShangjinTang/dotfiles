# dotfiles

Dotfiles for macOS and Linux(Ubuntu).

Managed by [dotbot](https://github.com/anishathalye/dotbot).

## Installation

### Pre-Install

#### macOS

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
brew install sshpass vim git tmux zsh curl wget tree reattach-to-user-namespace tldr
```

```bash
brew install shellcheck
```

#### Linux

```bash
sudo apt update
sudo apt install -y net-tools vim git zsh curl wget tree xclip aria2 python3-pip
sudo pip3 install tldr
```

```bash
sudo apt install -y gcc gdb exuberant-ctags cscope tree shellcheck
```

### Change shell to zsh

```bash
chsh -s $(which zsh)
```

Log out and relogin after successfully change shell to zsh.

### Dotfiles Install

```bash
# First time install
git clone --depth 1 https://github.com/ShangjinTang/dotfiles ~/.dotfiles && ~/.dotfiles/install

# Update (sometimes need to manually remove old symlinks to resolve errors)
git pull && ~/.dotfiles/install
```

### Post-Install

```bash
# fzf installation
~/.fzf/install --all
# install vim plugins
vim +PlugInstall
```

---

## dotfiles customization

1. Add configuration files
2. Edit `install.conf.yaml` to create symlink
3. Edit `pre_install` or `post_install` to customize the behaviour before or after installation
4. Add files in `~/.dotfiles.local/` for local override
  - Step 1: Create files in .dotfiles.local with same archtecture in home directory
  - Step 2: Run `install` or `post_install`, symlinks will created from ~/ to ~/.dotfiles.local/, e.g.
  - /.gitconfig (generated symlink) -> ~/.dotfiles.local/.gitconfig (created in Step 1)
  - ~/bin/rg (generated symlink) -> ~/.dotfiles.local/bin/rg (created in Step 1)

---

## Main Functions

Note: Terminal colors (tmux/vim) are based on light theme.

### [tmux](https://github.com/gpakosz/.tmux.git)

- settings:
  - `.tmux.conf.local`: cross-platform settings
  - `.tmux.conf.local.os`: os-based settings
- plugins:
  - [gitmux](https://github.com/arl/gitmux): show git status in tmux bar; customize color / font in `gitmux.config`
- theme: self-customized in `.tmux.conf.local` (adjust to [papercolor-theme](https://github.com/NLKNguyen/papercolor-theme) light)
- aliases:
  - `t`: open session 0 (default session-name); if attach fail, will create
  - `t <session-name>`: open session with *session-name*; if attach fail, will create
  - `tl`: list all sessions
  - `tk`: kill all sessions except session 0
  - `ta`: attach to session with specified name
  - `tn`: create a new session with specified name

### vim with [vim-plug](https://github.com/junegunn/vim-plug)

- plugins:
  - [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
  - [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
  - [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
  - [junegunn/fzf](https://github.com/junegunn/fzf)
  - [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
  - [tpope/vim-commentary](https://github.com/tpope/vim-commentary)
  - [preservim/nerdtree](https://github.com/preservim/nerdtree)
  - [preservim/tagbar](https://github.com/preservim/tagbar)
  - [ervandew/supertab](https://github.com/ervandew/supertab)
  - [luochen1990/rainbow](https://github.com/luochen1990/rainbow)
  - [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- plugin developer tools
  - [google/vim-maktaba](https://github.com/google/vim-maktaba)
  - [google/vim-codefmt](https://github.com/google/vim-codefmt)
  - [google/vim-glaive](https://github.com/google/vim-glaive)
  - [SirVer/ultisnips](https://github.com/SirVer/ultisnips)
  - [honza/vim-snippets](https://github.com/honza/vim-snippets)
  - [skywind3000/asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)
  - [preservim/vimux](https://github.com/preservim/vimux)
- plugin theme:
  - [NLKNguyen/papercolor-theme](https://github.com/NLKNguyen/papercolor-theme) light
- map keys (LEADER: Space):
  - Ctrl-p: toggle paste
  - Ctrl-l: toggle line numbers
  - LEADER-f: fzf
  - LEADER-g: show git log with preview window
  - LEADER-LEADER: nerdtree (sidebar tree browser)
  - LEADER-t: tagbar (sidebar tag browser)
  - LEADER-q: Quit vim (close all buffers)
  - LEADER-w: Close current buffer
  - LEADER-[: Switch to previous buffer
  - LEADER-]: Switch to next buffer

### [fzf](https://github.com/junegunn/fzf)

use fzf as rg(ripgrep)'s backend

### shellrc (zshrc / bashrc)

- Edit `pre_shellrc / post_shellrc / *shrc` for synced (symlink) configurations
- Edit `~/.*shrc.local` for non-synced (local) configurations, left blank by default
- Load sequence: `pre_shellrc` -> `.*shrc` -> `~/*shrc.local` ->  `post_shellrc`

Note: `*shrc` means `zshrc` or `bashrc`.

s://github.com/ohmyzsh/ohmyzsh)

- plugins:
  - [wd](https://github.com/mfaerevaag/wd)
  - [z](https://github.com/rupa/z)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- theme:
  - self-customized theme 'light' and 'dark' (set by `TERMINAL_COLOR`)
    - vim & vim-airline
    - tmux & gitmux
    - PROMPT
    - zsh-auto-suggestions hint

### hammerspoon for macOS

See [hammerspoon readme](https://github.com/ShangjinTang/dotfiles/blob/master/macos/hammerspoon/README.md)

## Manual Install from Source

### VIM COC


<details>

  <summary>1. install vim</summary>

  vim install

  ```bash
  sudo apt remove vim
  sudo apt install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
  wget https://ftp.nluug.nl/pub/vim/unix/vim-9.0.tar.bz2
  tar xvf vim-9.0.tar.bz2 && cd vim90
  ./configure --enable-python3interp
  make -j16
  sudo make install
  cd .. && rm vim-9.0.tar.bz2 && rm -rf vim90
  ```


</details>

<details>

  <summary>2. install nodejs</summary>

  ```bash
  sudo apt remove node
  aria2c https://nodejs.org/dist/v16.17.0/node-v16.17.0-linux-x64.tar.xz
  sudo tar xvf node-v16.17.0-linux-x64.tar.xz -C /opt/
  sudo mv /opt/node-v16.17.0-linux-x64 /opt/node
  ```

  add `/opt/node/bin` to $PATH.

</details>

<details>

  <summary>3. enable coc</summary>

  ```bash
  sudo apt install -y clangd clang clang-format
  ```
  
  ```bash
  vim ~/zshrc.local
  export VIM_COC_ENABLE=1
  ```

</details>
