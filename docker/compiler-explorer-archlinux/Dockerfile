FROM archlinux:latest

LABEL maintainer="Shangjin Tang <shangjin.tang@gmail.com>" \
      license="Copyright (c) 2012-2023, Matt Godbolt"

EXPOSE 10240

# Use customized pacman mirrorlist
ADD ./copyfiles/etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist

RUN echo "*** Installing essential packages ***" \
    && pacman -Syu wget ca-certificates nodejs npm git make vim clang --noconfirm \
    && pacman -Sc --noconfirm

Run echo "*** Cloning Compiler-Explorer from github ***" \
    && git clone https://github.com/compiler-explorer/compiler-explorer.git /compiler-explorer --depth=1

Run echo "*** Add NodeJS dependencies ***" \
    && cd /compiler-explorer \
    && npm i @sentry/node \
    && npm run webpack

RUN echo "*** Installing C++ libraries ***" \
    && pacman -Syu doctest fmt gtest --noconfirm \
    && pacman -Sc --noconfirm

COPY copyfiles/compiler-explorer/ /compiler-explorer/

WORKDIR /compiler-explorer

ENV NODE_DIR=/usr

# Language Options: https://github.com/compiler-explorer/compiler-explorer/blob/main/lib/languages.ts
ENTRYPOINT make EXTRA_ARGS='--language c,c++'

CMD ["run"]
