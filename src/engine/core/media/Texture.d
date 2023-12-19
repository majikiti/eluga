module engine.core.media.Texture;

import sdl_ttf;
import engine;

class Texture {
  package const SDL_Texture* data;

  this(SDL_Renderer* r, SDL_Surface* s) {
    data = SDL_CreateTextureFromSurface(r, s);
  }

  ~this() {
    SDL_DestroyTexture(data);
  }
}
