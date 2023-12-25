module engine.components.SpriteRenderer;

import sdl;
import engine;

class SpriteRenderer: Component {
  private ImageAsset image;
  private SDL_Rect rect;

  this(ImageAsset image) {
    this.image = image;
    rect.w = image.surface.w;
    rect.h = image.surface.h;
  }

  override void loop() {
    auto tform = go.component!Transform;
    auto pos = tform.worldPos;

    rect.x = cast(int)pos.x;
    rect.y = cast(int)pos.y;
    rect.w = cast(int)(image.surface.w * tform.scale.x);
    rect.h = cast(int)(image.surface.h * tform.scale.y);

    auto texture = new Texture(go.ctx.r, image.surface);
    SDL_RenderCopyEx(go.ctx.r, texture.data, null, &rect, cast(double)tform.rot, null, SDL_FLIP_NONE);
  }

 debug:

  override void debugLoop() {
    color(0, 255, 0);
    line(Vec2(rect.x, rect.y), Vec2(rect.x, rect.y + rect.h));
    line(Vec2(rect.x, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y + rect.h));
    line(Vec2(rect.x + rect.w, rect.y + rect.h), Vec2(rect.x + rect.w, rect.y));
    line(Vec2(rect.x + rect.w, rect.y), Vec2(rect.x, rect.y));
  }
}
