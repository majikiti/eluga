FROM archlinux
RUN pacman -Sy --noconfirm dub ldc sdl2 sdl2_image sdl2_mixer sdl2_ttf

WORKDIR /opt/appimage-builder
ARG APPIMAGE_BUILDER=1.1.0
RUN pacman -S --noconfirm fakeroot gtk-update-icon-cache \
 && curl -Lo /tmp/appimage-builder https://github.com/AppImageCrafters/appimage-builder/releases/download/v$APPIMAGE_BUILDER/appimage-builder-$APPIMAGE_BUILDER-x86_64.AppImage \
 && chmod +x /tmp/appimage-builder \
 && /tmp/appimage-builder --appimage-extract \
 && ln -s /opt/appimage-builder/squashfs-root/AppRun /usr/local/bin/appimage-builder \
 && ln -s libfakeroot.so /usr/lib/libfakeroot/libfakeroot-sysv.so \
 && ln -s faked /usr/bin/faked-sysv

WORKDIR /app
COPY . .
RUN appimage-builder --skip-tests
