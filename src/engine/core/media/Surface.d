module engine.core.media.Surface;

import sdl;

class Surface {
  SDL_Surface* data;

  this(SDL_Surface* data) {
    this.data = data;
  }

  ~this() {
    SDL_FreeSurface(data);
  }
}
