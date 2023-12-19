module engine.core.media.Image;

import sdl;
import sdl_image;

class Image {
  package const SDL_Surface* data;

  this(string path) {
    data = IMG_Load(path.toStringz);
  }

  ~this() {
    SDL_FreeSurface(data);
  }
}
