# README

- This note is only for x86_64 binaries.
- Binary file permission is 0755.

## Executables for NeoVIM LSP

## Compressed Prebuilt Executables

| Executables | Download Link                                     | Version | ArchLinux | Ubuntu 22.04 |
| ----------- | ------------------------------------------------- | ------- | :-------: | :----------: |
| buf         | https://github.com/bufbuild/buf/releases          | 1.23.1  |     √     |      -       |
| buildifier  | https://github.com/bazelbuild/buildtools/releases | 6.1.2   |     √     |      -       |
| cbfmt       | https://github.com/lukas-reineke/cbfmt/releases   | 0.2.0   |     √     |      -       |
| shellcheck  | https://github.com/koalaman/shellcheck/releases   | 0.9.0   |     √     |      -       |
| shfmt       | https://github.com/mvdan/sh/releases              | 3.7.0   |     √     |      -       |
| stylua      | https://github.com/JohnnyMorganz/StyLua/releases  | 0.18.0  |     √     |      -       |

## Manual Install Executables

| Executables               | pip       | npm                | pacman       | apt          | Why not use compressed binary   |
| ------------------------- | --------- | ------------------ | ------------ | ------------ | ------------------------------- |
| beautysh                  | beautysh  | -                  | -            | -            | No prebuilt executable provided |
| black                     | black     | -                  | python-black | black        | Size > 20MB                     |
| cmake-format / cmake-lint | cmakelang | -                  | -            | -            | No prebuilt executable provided |
| clang-format              | -         | -                  | clang        | clang-format | Large Size                      |
| google-java-format        | -         | google-java-format | -            | -            | No prebuilt executable provided |
| prettier                  | -         | buildifier         | -            | -            | No prebuilt executable provided |

## Others

- `rustfmt`: `rustup component add rustfmt`
