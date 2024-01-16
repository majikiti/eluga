module engine.core.media.Texture;

import sdl;
import engine;

class Texture {
  SDL_Texture* data;

  this(SDL_Renderer* r, Surface surface) {
    this(r, surface.data);
  }

  this(SDL_Renderer* r, SDL_Surface* rawsurface) {
    data = SDL_CreateTextureFromSurface(r, rawsurface);
  }

  this(SDL_Texture* rawtexture) {
    data = rawtexture;
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
