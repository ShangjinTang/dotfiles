FROM archlinux:latest

LABEL maintainer="Shangjin Tang <shangjin.tang@gmail.com>" \
      license="Copyright (c) 2012-2023, Matt Godbolt"

EXPOSE 10240

RUN echo "*** Installing Compiler Explorer ***" \
    && pacman -Syu wget ca-certificates nodejs npm make git vim clang make cmake --noconfirm \
    # TODO: add libs: fmt abseil-cpp boost gtest doctest
    && pacman -Sc --noconfirm \
    && git clone https://github.com/compiler-explorer/compiler-explorer.git /compiler-explorer --depth=1 \
    && cd /compiler-explorer \
    && echo "Add missing dependencies" \
    && npm i @sentry/node \
    && npm run webpack \
    && echo "*** Installation finished ***"

ADD customized/etc/config/c.local.properties /compiler-explorer/etc/config/c.local.properties
ADD customized/etc/config/c++.local.properties /compiler-explorer/etc/config/c++.local.properties
ADD customized/etc/config/compiler-explorer.local.properties /compiler-explorer/etc/config/compiler-explorer.local.properties
ADD customized/views/index.pug /compiler-explorer/views/index.pug

WORKDIR /compiler-explorer

ENV NODE_DIR=/usr

# Language Options: https://github.com/compiler-explorer/compiler-explorer/blob/main/lib/languages.ts
ENTRYPOINT make EXTRA_ARGS='--language c,c++'

CMD ["run"]
