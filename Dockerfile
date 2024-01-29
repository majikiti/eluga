FROM ubuntu:xenial

# https://wiki.libsdl.org/SDL2/README/linux
RUN apt-get update && \
  apt-get install -y build-essential curl git make autoconf automake libtool \
    pkg-config cmake ninja-build gnome-desktop-testing libasound2-dev libpulse-dev \
    libaudio-dev libjack-dev libsndio-dev libsamplerate0-dev libx11-dev libxext-dev \
    libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev libwayland-dev \
    libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev \
    libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev fcitx-libs-dev

WORKDIR /deps

ARG MAKEOPTS=-j8

ARG DMD_URL=https://downloads.dlang.org/releases/2.x/2.106.1/dmd_2.106.1-0_amd64.deb
RUN curl -Lo /tmp/dmd.deb $DMD_URL && \
  apt-get install -y /tmp/dmd.deb

ARG APPIMAGE_BUILDER=1.1.0
RUN curl -Lo /tmp/appimage-builder https://github.com/AppImageCrafters/appimage-builder/releases/download/v$APPIMAGE_BUILDER/appimage-builder-$APPIMAGE_BUILDER-x86_64.AppImage \
 && chmod +x /tmp/appimage-builder \
 && /tmp/appimage-builder --appimage-extract \
 && ln -s $PWD/squashfs-root/AppRun /usr/local/bin/appimage-builder

ARG SDL=release-2.28.5
RUN curl -L https://github.com/libsdl-org/SDL/archive/$SDL.tar.gz | tar xz && \
  cd SDL-$SDL && \
  ./configure && \
  make $MAKEOPTS install

ARG SDL_IMAGE=release-2.8.2
RUN curl -L https://github.com/libsdl-org/SDL_image/archive/$SDL_IMAGE.tar.gz | tar xz && \
  cd SDL_image-$SDL_IMAGE && \
  external/download.sh && \
  ./configure && \
  make $MAKEOPTS install

ARG SDL_MIXER=release-2.8.0
RUN curl -L https://github.com/libsdl-org/SDL_mixer/archive/$SDL_MIXER.tar.gz | tar xz && \
  cd SDL_mixer-$SDL_MIXER && \
  external/download.sh && \
  ./configure && \
  make $MAKEOPTS install

ARG SDL_TTF=release-2.22.0
RUN curl -L https://github.com/libsdl-org/SDL_ttf/archive/$SDL_TTF.tar.gz | tar xz && \
  cd SDL_ttf-$SDL_TTF && \
  external/download.sh && \
  ./configure && \
  make $MAKEOPTS install

WORKDIR /app

COPY . .
RUN appimage-builder
