module engine.assets.TextAsset;

import std.string;
import sdl;
import sdl_image;
import sdl_ttf;
import engine;

class TextAsset: Asset {
  TTF_Font* font;
  private int size;

  this(string path, int ptSize){
    size = ptSize;
    font = TTF_OpenFont(path.toStringz,size);
  }
  
  ~this(){
    TTF_CloseFont(font);
  }
}
