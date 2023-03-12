FROM archlinux:latest

LABEL maintainer="Shangjin Tang <shangjin.tang@gmail.com>" \
      license="Copyright (c) 2012-2023, Matt Godbolt"

EXPOSE 10240

# use manual copy mirrorlist
# ADD ./copyfiles/etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist
# RUN pacman -Syu --noconfirm

# use reflector instead of manual copy mirrorlist
RUN echo "*** Update mirrorlist ***" \
    && pacman -Sy reflector --noconfirm \
    && reflector -c "China" -l 100 -p "http" --sort rate --save /etc/pacman.d/mirrorlist

RUN echo "*** Installing essential packages ***" \
    && pacman -Sy wget ca-certificates nodejs npm git make vim clang --noconfirm \
    && pacman -Sc --noconfirm

# use tag gh-6329 to avoid npm compile error on latest tag gh-6747:
#     compiler-explorer  | [tsl] ERROR in /compiler-explorer/static/panes/editor.ts(1213,46)
#     compiler-explorer  |       TS2339: Property 'autoCloseQuotes' does not exist on type 'SiteSettings'.
Run echo "*** Cloning Compiler-Explorer from github ***" \
    && git clone https://github.com/compiler-explorer/compiler-explorer.git /compiler-explorer --depth=1 --branch gh-6329

Run echo "*** Add NodeJS dependencies ***" \
    && cd /compiler-explorer \
    && npm i @sentry/node \
    && npm run webpack

RUN echo "*** Installing C++ libraries ***" \
    && pacman -Sy doctest fmt gtest --noconfirm \
    && pacman -Sc --noconfirm

COPY copyfiles/ /

WORKDIR /compiler-explorer

ENV NODE_DIR=/usr

# Language Options: https://github.com/compiler-explorer/compiler-explorer/blob/main/lib/languages.ts
ENTRYPOINT make EXTRA_ARGS='--language c,c++'

CMD ["run"]
