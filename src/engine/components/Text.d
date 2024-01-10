module engine.components.Text;

import std.string;
import sdl;
import sdl_image;
import sdl_ttf;
import engine;
import utils;

class Text: Component {
  private Texture[] textures;
  private TextAsset _font;
  private string _text;
  SDL_Color c;

  this(TextAsset asset) {
    _font = asset;
    c.a = 255;
  }

  private void createTexture() {
    textures = [];
    foreach(row; _text.split('\n')) {
      if(!row.length) {
        textures ~= null;
        continue;
      }
      auto surface = _font.render(row, c);
      textures ~= new Texture(ctx.r, surface);
    }
  }

  auto font() const => _font;
  auto font(TextAsset font) {
    _font = font;
    createTexture();
    return font;
  }

  auto text() const => _text;
  auto text(string text) {
    _text = text;
    createTexture();
    return text;
  }

  deprecated
  void setFont(TextAsset font){
    this.font = font;
  }

  deprecated
  void setText(string text){
    this.text = text;
  }

  void setColor(ubyte r, ubyte g, ubyte b, ubyte a = 255){
    c.r = r, c.g = g, c.b = b, c.a = a;
    createTexture();
  }

  override void loop() {
    int voffset = 0;
    foreach(texture; textures) {
      if(texture is null) {
        voffset += _font.pt;
        continue;
      }

      auto tform = go.component!Transform;
      auto pos = tform.worldPos;
      auto scale = tform.scale;

      auto size = texture.size;
      auto dest = rect(
        pos.x,
        pos.y + voffset,
        size.x * scale.x,
        size.y * scale.y,
      );

      go.renderEx(texture, dest, tform.rot);
      voffset += size.y;
    }
  }
}
