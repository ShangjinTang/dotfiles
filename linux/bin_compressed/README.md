# README

This note is only for x86_64 binaries.

Procedure Example:

- 1. change to architecture folder (`uname -m` output with lower case), e.g. `x86_64`
- 2. download [clash](https://github.com/Dreamacro/clash/releases/download/premium/clash-linux-amd64-v3-2023.08.17.gz)
- 3. unzip to binary `clash-linux-amd64-*`, and delete the original zipped file
- 4. rename the binary, e.g. `clash`
- 5. change permission to 0755
- 6. run command `tar -cJvf clash.tar.xz clash` to compress it
- 7. `~/.dotfiles/install` and the compressed file would be extracted to `~/bin/clash`

Note:

- 1. always avoid duplicate file in `../bin` and here
- 2. always update the table below on any change

## Compressed Prebuilt Executables

### Linux x86_64

| Linux x86_64 | Download Link                                           | Prebuilt Version / Tag | Reason to prebuild the executable                                              |
| ------------ | ------------------------------------------------------- | ---------------------- | ------------------------------------------------------------------------------ |
| clash        | https://github.com/Dreamacro/clash/releases/tag/premium | Premium 2023.08.17     | Needless to say                                                                |
| nnn          | https://github.com/jarun/nnn/releases/latest            | nnn v4.9 Elixir        | build with 'export LDFLAGS="-static"; make O_RESTOREPREVIEW=1' on Ubuntu 22.04 |
