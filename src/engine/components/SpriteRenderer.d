module engine.components.SpriteRenderer;

import sdl;
import sdl_image;
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
    rect.w = cast(int)(surface.w * tform.scale.x);
    rect.h = cast(int)(surface.h * tform.scale.y);

    auto texture = new Texture(go.ctx.r, surface);
    SDL_RenderCopyEx(go.ctx.r, texture.data, null, &rect, cast(double)tform.rot, null, SDL_FLIP_NONE);
  }
}
