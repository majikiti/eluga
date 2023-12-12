module engine.assets.ImageAsset;

import std.string;
import sdl;
import sdl_image;
import engine;

class ImageAsset: Asset {
  SDL_Surface* surface;

  this(string path) {
    surface = IMG_Load(path.toStringz);
  }
}
