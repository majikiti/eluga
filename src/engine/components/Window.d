module engine.components.Window;

import engine;
import sdl.vulkan;


class Window: Component {
  auto get() => go.ctx.w;

  auto size(){
    if(go.ctx is null){
      dbg("null");
      return Vec2(0,0);
    }
    int h, w;
    SDL_Vulkan_GetDrawableSize(go.ctx.w, &w, &h);
    return Vec2(w, h);
  }
}
