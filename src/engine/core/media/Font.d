module engine.core.media.Font;

import std;
import sdl;
import sdl_ttf;

shared static this() {
  TTF_Init;
}

shared static ~this() {
  TTF_Quit;
}

shared FontData[int][string] fonts;

class Font {
  private const FontData font;

  this(string path, int pt) {
    auto var = path in fonts;
    if(var) {
      auto cache = pt in *var;
      if(cache) {
        font = *cache;
        return;
      }
    }
    font = fonts[path][pt] = new FontData(path, pt);
  }

  auto data() const => font.data;
}

class FontData {
  private const TTF_Font* data;

  this(string path, int pt) {
    data = TTF_OpenFont(path.toStringz, pt);
  }

  ~this() {
    TTF_CloseFont(data);
  }
}
