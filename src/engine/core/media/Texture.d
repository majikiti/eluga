module engine.core.media.Texture;

import sdl;
import engine;

class Texture {
  SDL_Texture* data;

  this(SDL_Renderer* r, Surface s) {
    this(r, s.data);
  }

  this(SDL_Renderer* r, SDL_Surface* s) {
    data = SDL_CreateTextureFromSurface(r, s);
  }

  ~this() {
    SDL_DestroyTexture(data);
  }

  auto size() {
    int w, h;
    SDL_QueryTexture(data, null, null, &w, &h);
    return Vec2fixed(w, h);
  }
}
