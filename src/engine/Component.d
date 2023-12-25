module engine.Component;

import sdl;
import engine;

class Component: Loggable {
  package GameObject go;
  protected bool active = true;

  // override this!
  void setup() {}
  void loop() {}

  debug {
    void debugSetupPre() {}
    void debugSetup() {}
    void debugLoopPre() {}
    void debugLoop() {}
  }

  final package void realLoop() {
    if(active) loop;
  }

  // utils

  protected void line(Vec2 a, Vec2 b) {
    SDL_RenderDrawLine(go.ctx.r, cast(int)a.x, cast(int)a.y, cast(int)b.x, cast(int)b.y);
  }

  protected void color(ubyte r, ubyte g, ubyte b, ubyte a = 255) {
    SDL_SetRenderDrawColor(go.ctx.r, r, g, b, a);
  }
}
