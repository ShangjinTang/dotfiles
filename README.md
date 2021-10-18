# dotfiles

Dotfiles for macOS and Linux(Ubuntu).

Managed by [dotbot](https://github.com/anishathalye/dotbot).

## How to use

```bash
$ git clone --depth 1 https://github.com/ShangjinTang/dotfiles ~/.dotfiles
$ ~/.dotfiles/install
```

Note:

This will enable proxy by default.

To disable proxy, type command `unsetproxy && touch ~/.noproxy.flag`.

## Customization

1. Add configuration files.
2. Edit `install.conf.yaml` to create symlink.
