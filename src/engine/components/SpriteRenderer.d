module engine.components.SpriteRenderer;

import sdl;
import engine;
import std;

class SpriteRenderer: Component {
  enum Mode {
    Image,
    Rect,
  }

  private ImageAsset image;
  private SDL_Rect rect;
  bool invisdraw;
  bool enable = true;
  // 素の矩形を描画できるね
  Vec2 psize;
  ubyte[4] colorArr;
  private ubyte _opac = 255;
  private bool opacChanged = false;
  Mode mode;

  bool flipedH = false, flipedV = false;

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
    auto scale = tform.scale;
    int flip = 0;

    flip = cast(int)(scale.x < 0) | (cast(int)(scale.y < 0) << 1);
    
    if(image!is null){
      rect.w = cast(int)(image.surface.w * abs(tform.scale.x));
      rect.h = cast(int)(image.surface.h * abs(tform.scale.y));
    } else {
      rect.w = cast(int)(psize.x * abs(tform.scale.x));
      rect.h = cast(int)(psize.y * abs(tform.scale.y));
    }
    
    rect.x = cast(int)tform.renderPos.x;
    rect.y = cast(int)tform.renderPos.y;

    if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdraw) return; // 範囲外 Render もうやめて
    if(!enable) return; // 死ぬオブジェクト 描画 もうやめて

<<<<<<< HEAD
    if(image!is null){
      go.renderEx(image.texture, &rect, tform.rot, null, flip);
=======
    if(mode == Mode.Image){
      if(opacChanged){
        go.setTextureOpac(image.texture.data, _opac);
        opacChanged = false;
      }
      go.renderEx(image.texture, &rect, tform.rot);
>>>>>>> c9750e2 (RIP: EXPLOSION)
    } else {
      if(opacChanged){
        colorArr[3] = _opac;
        opacChanged = false;
      }
      color(colorArr);
      go.renderRect(&rect);
    }
  }

  Vec2 size() {
    auto scale = go.component!Transform.scale;
    if(image) return Vec2(cast(int)(image.surface.w * abs(scale.x)), cast(int)(image.surface.h * abs(scale.y)));
    else return Vec2(cast(int)(psize.x * abs(scale.x)), cast(int)(psize.y * abs(scale.y)));
  }

  Vec2 localSize() {
    if(image) return Vec2(cast(int)(image.surface.w), cast(int)(image.surface.h));
    else return Vec2(cast(int)(psize.x), cast(int)(psize.y));
  }

  // Opacity
  ubyte opac() const => _opac;

  void setOpac(int o){
    if(o < 0) warn("cannot set negative opacity. [in SpriteRenderer]");
    if(o > 255) warn("Opacity overflow. [in SpriteRenderer]");
    _opac = cast(ubyte)o;
    opacChanged = true;
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
