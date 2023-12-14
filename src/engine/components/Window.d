module engine.components.Window;

import engine;
import sdl.vulkan;


class Window: Component {
  auto get() => go.ctx.w;

  auto size(){
    int h, w;
    SDL_Vulkan_GetDrawableSize(go.ctx.w, &w, &h);
    return Vec2(w, h);
  }
}
