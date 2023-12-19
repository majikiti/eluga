module engine.assets.TextAsset;

import std;
import sdl;
import sdl_ttf;
import engine;

class TextAsset: Asset {
  package Font font;
  package int pt;

  this(string path, int pt) {
    this.font = new Font(path, pt);
    this.pt = pt;
  }

  Surface render(string text, SDL_Color c) {
    auto surface = TTF_RenderUTF8_Blended(font.data, text.toStringz, c);
    return new Surface(surface);
  }
}
