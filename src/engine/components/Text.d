module engine.components.Text;

import std.string;
import sdl;
import sdl_image;
import sdl_ttf;
import engine;

class Text: Component{
  private TextAsset font;
  private string text;
  private SDL_Surface* surface;
  private SDL_Texture* texture;

  SDL_Color c;

  private void cleateTexture(){
    if(!go.has!Transform || text == null){
      return;
    }
    
    surface = TTF_RenderUTF8_Blended(font.font, text.toStringz, c);
    texture = SDL_CreateTextureFromSurface(go.ctx.r, surface);

    int iw,ih;
    SDL_QueryTexture(texture, null, null, &iw, &ih);

    auto pos = go.component!Transform.pos;
    SDL_Rect txtRect;
    txtRect.h = ih;
    txtRect.w = iw;

    SDL_Rect pasteRect;
    pasteRect.x = cast(int)pos.x;
    pasteRect.y = cast(int)pos.y;
    pasteRect.h = ih;
    pasteRect.w = iw;

    SDL_RenderCopy(go.ctx.r, texture, &txtRect, &pasteRect);
  }

  this(TextAsset asset){
    font = asset;
    c.a = 255;
  }

  void setFont(TextAsset font){
    this.font = font;
    cleateTexture;
  }

  void setText(string text){
    this.text = text;
    cleateTexture;
  }

  void setColor(ubyte r, ubyte g, ubyte b, ubyte a = 255){
    c.r = r, c.g = g, c.b = b, c.a = a;
    cleateTexture;
  }
}
