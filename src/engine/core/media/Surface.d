module engine.core.media.Surface;

import sdl;

class Surface {
  package const SDL_Surface* data;

  this(SDL_Surface* data) {
    this.data = data;
  }

  ~this() {
    SDL_FreeSurface(data);
  }
}
