module engine.components.SpriteRenderer;

import sdl;
import engine;

class SpriteRenderer: Component {
  private ImageAsset image;
  private SDL_Rect rect;
  bool invisdrawing;

  this(ImageAsset image, bool invisdrawing = false) {
    this.image = image;
    rect.w = image.surface.w;
    rect.h = image.surface.h;
    this.invisdrawing = invisdrawing;
  }

  override void loop() {
    auto tform = go.component!Transform;
    auto pos = tform.campos;

    rect.x = cast(int)pos.x;
    rect.y = cast(int)pos.y;
    rect.w = cast(int)(image.surface.w * tform.scale.x);
    rect.h = cast(int)(image.surface.h * tform.scale.y);

    if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdrawing) return; // 範囲外 Render もうやめて

    auto texture = new Texture(go.ctx.r, image.surface);
    go.renderEx(texture, &rect, tform.rot);
  }

  Vec2 size() const => Vec2(rect.w, rect.h);

 debug:
  bool debugFrame = true;

  override void debugLoop() {
    if(!debugFrame) return;
    color(0, 255, 0);
    auto tform = go.component!Transform;
    if(!tform.isin(Vec2(rect.w, rect.h)) && !invisdrawing) return; // 範囲外 Render もうやめて
    line(Vec2(rect.x, rect.y), Vec2(rect.x, rect.y + rect.h));
    line(Vec2(rect.x, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y + rect.h));
    line(Vec2(rect.x + rect.w, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y));
    line(Vec2(rect.x + rect.w, rect.y), Vec2(rect.x, rect.y));
  }
}
