module engine.System;

import core.time;
import sdl;
import engine;
import utils;

class System {
  Context ctx;

  this(GameObject root) {
    SDL_Init(SDL_INIT_VIDEO);
    ctx.root = root;
    ctx.im = new InputManager;
    ctx.createWin;
    ctx.createRdr;
  }

  ~this() {
    SDL_Quit;
  }

  void run() {
    ctx.root.realSetup(&ctx);
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
        auto key = e.key;
        break;

      case SDL_MOUSEMOTION:
        auto motion = e.motion;
        break;

      case SDL_MOUSEBUTTONDOWN:
      case SDL_MOUSEBUTTONUP:
        auto btn = e.button;
        break;

      case SDL_QUIT:
        ctx.running = false;
        break;

      default:
    }

    //BackGround
    SDL_SetRenderDrawColor(ctx.r,0,0,0,255);
    SDL_RenderClear(ctx.r);

    ctx.root.realLoop;
    SDL_RenderPresent(ctx.r);
  }
}
