module engine.components.SpriteRenderer;

import sdl;
import sdl_image;
import engine;

class SpriteRenderer: Component {
  private SDL_Surface* surface;
  SDL_Rect rect;

  this(ImageAsset asset) {
    surface = asset.surface;
    rect.w = surface.w;
    rect.h = surface.h;
  }

  override void loop() {
    auto tform = go.component!Transform;
    auto pos = tform.worldPos;
    auto texture = SDL_CreateTextureFromSurface(go.ctx.r, surface);
    scope(exit) SDL_DestroyTexture(texture);

    rect.x = cast(int)pos.x;
    rect.y = cast(int)pos.y;
    rect.w = cast(int)(surface.w * tform.scale.x);
    rect.h = cast(int)(surface.h * tform.scale.y);

    SDL_RenderCopyEx(go.ctx.r, texture, null, &rect, cast(double)tform.rot, null, SDL_FLIP_NONE);
  }
}
