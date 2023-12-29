FROM alpine

RUN apk add --no-cache clang lld libc++-dev \
  cmake ninja make autoconf automake libtool

ENV CC=clang \
  LD=ld.lld \
  CFLAGS="-Ofast -flto" \
  CXXFLAGS="-stdlib=libc++" \
  LDFLAGS="-fuse-ld=lld -Wl,-O2 -Wl,--as-needed"

WORKDIR /deps

ARG SDL=release-2.28.5
RUN wget -O - https://github.com/libsdl-org/SDL/archive/${SDL}.tar.gz | tar xz && \
  cmake -GNinja -Bsdl SDL-${SDL} && \
  cmake --build sdl && \
  cmake --install sdl

ARG SDL_IMAGE=release-2.8.1
RUN wget -O - https://github.com/libsdl-org/SDL_image/archive/${SDL_IMAGE}.tar.gz | tar xz && \
  cmake -GNinja -Bsdl_image SDL_image-${SDL_IMAGE} -DBUILD_SHARED_LIBS=OFF && \
  cmake --build sdl_image && \
  cmake --install sdl_image

ARG OPUSFILE=0.12
RUN apk add --no-cache libogg-dev opus-dev && \
  wget -O - https://github.com/xiph/opusfile/archive/v${OPUSFILE}.tar.gz | tar xz && \
  cd opusfile-${OPUSFILE} && \
  ./autogen.sh && \
  ./configure --disable-http && \
  make install

ARG SDL_MIXER=release-2.6.3
RUN apk add --no-cache flac-dev libmodplug-dev fluidsynth-dev && \
  wget -O - https://github.com/libsdl-org/SDL_mixer/archive/${SDL_MIXER}.tar.gz | tar xz && \
  CFLAGS="${CFLAGS} -I/usr/include/opus" && \
  cmake -GNinja -Bsdl_mixer SDL_mixer-${SDL_MIXER} -DBUILD_SHARED_LIBS=OFF -DSDL2MIXER_CMD=OFF && \
  cmake --build sdl_mixer && \
  cmake --install sdl_mixer

ARG SDL_TTF=release-2.20.2
RUN apk add --no-cache freetype-dev && \
  wget -O - https://github.com/libsdl-org/SDL_ttf/archive/${SDL_TTF}.tar.gz | tar xz && \
  cmake -GNinja -Bsdl_ttf SDL_ttf-${SDL_TTF} -DBUILD_SHARED_LIBS=OFF && \
  cmake --build sdl_ttf && \
  cmake --install sdl_ttf

WORKDIR /app

RUN apk add --no-cache dub ldc \
  llvm-libunwind-static freetype-static libpng-static bzip2-static brotli-static

ENV DFLAGS="-static -Xcc=-Ofast -Xcc=-flto -Xcc=-fuse-ld=lld -L-O2 -L--as-needed \
  -L-lfreetype -L-lpng -L-lbz2 -L-lbrotlidec -L--unresolved-symbols=ignore-in-object-files"

COPY . .

RUN dub build -b release
