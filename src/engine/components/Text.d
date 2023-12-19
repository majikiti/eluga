module engine.components.Text;

import std.string;
import sdl;
import sdl_image;
import sdl_ttf;
import engine;

class Text: Component {
  private TextAsset font;
  private Texture texture;
  private string text;
  SDL_Color c;

  this(TextAsset asset) {
    font = asset;
    c.a = 255;
  }

  void createTexture(){
    auto surface = font.render(text, c);
    texture = new Texture(go.ctx.r, surface.data);
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
