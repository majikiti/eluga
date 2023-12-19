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
  private FontData font;

  this(string path, int pt) {
    auto var = path in fonts;
    if(var) {
      auto cache = pt in *var;
      if(cache) {
        font = cast(FontData)*cache;
        return;
      }
    }
    font = new FontData(path, pt);
    fonts[path][pt] = cast(shared FontData)font;
  }

  auto data() => font.data;
}

class FontData {
  private TTF_Font* data;

  this(string path, int pt) {
    data = TTF_OpenFont(path.toStringz, pt);
  }

  ~this() {
    TTF_CloseFont(data);
  }
}
