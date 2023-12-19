module engine.core.media.Image;

import std;
import sdl;
import sdl_image;

class Image {
  SDL_Surface* data;

  this(string path) {
    data = IMG_Load(path.toStringz);
  }

  ~this() {
    SDL_FreeSurface(data);
  }
}
