module engine.components.SpriteRenderer;

import sdl;
import engine;

class SpriteRenderer: Component {
  enum Mode {
    Image,
    Rect,
  }

  private ImageAsset image;
  private SDL_Rect rect;
  bool invisdraw;
  // 素の矩形を描画できるね
  Vec2 psize;
  ubyte[4] colorArr;
  ubyte _opac = 255;
  Mode mode;

  // 画像が あるとき〜
  this(ImageAsset image, bool invisdraw = false) {
    this.image = image;
    rect.w = cast(int)image.surface.w;
    rect.h = cast(int)image.surface.h;
    this.colorArr = [255, 255, 255, 255];
    this.invisdraw = invisdraw;
    mode = Mode.Image;
  }

  // 無いとき〜……
  // Vec4
  this(Vec2 psize, ubyte[4] colorArr, bool invisdraw = false){
    this.psize = psize;
    rect.w = cast(int)psize.x;
    rect.h = cast(int)psize.y;
    this.colorArr = colorArr;
    this.invisdraw = invisdraw;
    mode = Mode.Rect;
  }
  
  // Vec3
  this(Vec2 psize, ubyte[3] colorArr = [255, 255, 255], bool invisdraw = false){
    this.psize = psize;
    rect.w = cast(int)psize.x;
    rect.h = cast(int)psize.y;
    this.colorArr = colorArr ~ cast(ubyte)255;
    this.invisdraw = invisdraw;
    mode = Mode.Rect;
  }

  override void loop() {
    auto tform = go.component!Transform;

    if(image!is null){
      rect.w = cast(int)(image.surface.w * tform.scale.x);
      rect.h = cast(int)(image.surface.h * tform.scale.y);
    } else {
      rect.w = cast(int)(psize.x * tform.scale.x);
      rect.h = cast(int)(psize.y * tform.scale.y);
    }
    
    rect.x = cast(int)tform.renderPos.x;
    rect.y = cast(int)tform.renderPos.y;

    if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdraw) return; // 範囲外 Render もうやめて

    if(image!is null){
      go.renderEx(image.texture, &rect, tform.rot);
    } else {
      color(colorArr);
      go.renderRect(&rect);
    }
  }

  Vec2 size() {
    auto scale = go.component!Transform.scale;
    return Vec2(rect.w * scale.x, rect.h * scale.y);
  }

  void opac(ubyte o){
    if(mode == Mode.Image) go.setTextureOpac(image.texture.data, o);
    else colorArr[3] = o;
    return;
  }

 debug:
  bool debugFrame = true;

  override void debugLoop() {
    if(!debugFrame) return;
    auto tform = go.component!Transform;
    color(255,0,0);
    auto rndPos1 = tform.renderPos;
    auto rndPos2 = tform.renderPos;

    line(rndPos1,rndPos2);
    // color(0, 255, 0);
    // if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdraw) return; // 範囲外 Render もうやめて
    // line(Vec2(rect.x, rect.y), Vec2(rect.x, rect.y + rect.h));
    // line(Vec2(rect.x, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y + rect.h));
    // line(Vec2(rect.x + rect.w, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y));
    // line(Vec2(rect.x + rect.w, rect.y), Vec2(rect.x, rect.y));
  }
}
