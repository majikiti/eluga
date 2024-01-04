module engine.components.SpriteRenderer;

import sdl;
import engine;

class SpriteRenderer: Component {
  private ImageAsset image;
  private SDL_Rect rect;
  bool invisdraw;
  // 画像が放り込まれないと泣いてしまう対策
  Vec2 psize;
  ubyte[4] colorArr;

  // 画像が あるとき〜
  this(ImageAsset image, bool invisdraw = false) {
    this.image = image;
    rect.w = image.surface.w;
    rect.h = image.surface.h;
    this.invisdraw = invisdraw;
  }

  // 無いとき〜……
  this(Vec2 psize, ubyte[3] colorArr = [255, 255, 255], bool invisdraw = false){
    this.psize = psize;
    rect.w = cast(int)psize.x;
    rect.h = cast(int)psize.y;
    this.colorArr = colorArr ~ cast(ubyte)255;
    this.invisdraw = invisdraw;
  }

  // Vec4
  this(Vec2 psize, ubyte[4] colorArr, bool invisdraw = false){
    this.psize = psize;
    rect.w = cast(int)psize.x;
    rect.h = cast(int)psize.y;
    this.colorArr = colorArr;
    this.invisdraw = invisdraw;
  }

  override void loop() {
    auto tform = go.component!Transform;
    auto pos = tform.campos;

    rect.x = cast(int)pos.x;
    rect.y = cast(int)pos.y;

    if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdraw) return; // 範囲外 Render もうやめて

    if(image!is null){
      rect.w = cast(int)(image.surface.w * tform.scale.x);
      rect.h = cast(int)(image.surface.h * tform.scale.y);
      auto texture = new Texture(go.ctx.r, image.surface);
      go.renderEx(texture, &rect, tform.rot);
    } else {
      rect.w = cast(int)(psize.x * tform.scale.x);
      rect.h = cast(int)(psize.y * tform.scale.y);
      color(colorArr);
      go.renderRect(&rect);
    }
  }

  Vec2 size() const => Vec2(rect.w, rect.h);

 debug:
  bool debugFrame = true;

  override void debugLoop() {
    if(!debugFrame) return;
    color(0, 255, 0);
    auto tform = go.component!Transform;
    if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdraw) return; // 範囲外 Render もうやめて
    line(Vec2(rect.x, rect.y), Vec2(rect.x, rect.y + rect.h));
    line(Vec2(rect.x, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y + rect.h));
    line(Vec2(rect.x + rect.w, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y));
    line(Vec2(rect.x + rect.w, rect.y), Vec2(rect.x, rect.y));
  }
}
