# dotfiles

Dotfiles for macOS and Linux(Ubuntu).

Managed by [dotbot](https://github.com/anishathalye/dotbot).

## How to use

```bash
$ git clone --depth 1 https://github.com/ShangjinTang/dotfiles ~/.dotfiles
$ ~/.dotfiles/install
```


## Customization

1. Add configuration files.
2. Edit `install.conf.yaml` to create symlink.


### Proxy

Proxy is enabled by default at port 1080. To disable proxy, type command:

```bash
$ unsetproxy && touch ~/.noproxy.flag
```
