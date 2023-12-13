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
    auto pos = tform.pos;
    auto texture = SDL_CreateTextureFromSurface(go.ctx.r, surface);

    rect.x = cast(int)pos.x;
    rect.y = cast(int)pos.y;

    SDL_RenderCopy(go.ctx.r, texture, null, &rect);
  }
}
