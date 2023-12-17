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

  this(TextAsset asset){
    font = asset;
    c.a = 255;
  }

  void createTexture(){
    if(go.ctx == null || font is null)return;

    SDL_DestroyTexture(texture);
    SDL_FreeSurface(surface);
    
    surface = TTF_RenderUTF8_Blended(font.font, text.toStringz, c);
    texture = SDL_CreateTextureFromSurface(go.ctx.r, surface);
  }

  void setFont(TextAsset font){
    this.font = font;
    createTexture();
  }

  void setText(string text){
    this.text = text;
    createTexture();
  }

  void setColor(ubyte r, ubyte g, ubyte b, ubyte a = 255){
    c.r = r, c.g = g, c.b = b, c.a = a;
    createTexture();
  }

  override void loop(){
    if(!go.has!Transform || text == null || go.ctx == null || surface == null || texture == null){
      return;
    }
    int iw,ih;
    SDL_QueryTexture(texture, null, null, &iw, &ih);

    auto tform = go.component!Transform;
    auto pos = tform.worldPos;
    auto scale = tform.scale;
    SDL_Rect txtRect;
    txtRect.h = ih;
    txtRect.w = iw;

    SDL_Rect pasteRect;
    pasteRect.x = cast(int)pos.x;
    pasteRect.y = cast(int)pos.y;
    pasteRect.h = cast(int)(ih * scale.x);
    pasteRect.w = cast(int)(iw*scale.y);

    SDL_RenderCopyEx(go.ctx.r, texture, &txtRect, &pasteRect, cast(double)tform.rot, null, SDL_FLIP_NONE);
  }
}
