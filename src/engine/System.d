module engine.System;

import core.time;
import sdl;
import engine;
import utils;

class System {
  GameObject root;
  InputManager input;
  Context ctx;

  this(GameObject root) {
    SDL_Init(SDL_INIT_VIDEO);
    this.root = root;
    this.input = new InputManager;
    ctx.createWin;
    ctx.createRdr;
  }

  ~this() {
    SDL_Quit;
  }

  void run() {
    root.realSetup(&ctx);
    ctx.updated = MonoTime.currTime;

    loop; // 初回レンダリング
    while(ctx.running) {
      auto cur = MonoTime.currTime;
      auto elapsed = cur - ctx.updated;
      ctx.updated = cur;
      ctx.elapsed = elapsed;

      loop;
    }
  }

  void loop() {
    SDL_Event e;
    SDL_PollEvent(&e);

    switch(e.type) {
      case SDL_KEYDOWN:
      case SDL_KEYUP:
        e.key;
        break;

      case SDL_MOUSEMOTION:
        e.motion;
        break;

      case SDL_MOUSEBUTTONDOWN:
      case SDL_MOUSEBUTTONUP:
        e.button;
        break;

      case SDL_QUIT:
        ctx.running = false;
        break;

      default:
    }

    root.realLoop;
    SDL_RenderPresent(ctx.r);
  }
}
