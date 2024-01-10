module engine.components.Window;

import sdl;
import engine;

class Window: Component {
  auto get() => ctx.w;

  auto size() {
    int h, w;
    SDL_GL_GetDrawableSize(ctx.w, &w, &h);
    return Vec2(w, h);
  }
}
