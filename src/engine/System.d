module engine.System;

import core.time;
import sdl;
import engine;
import utils;

class System: Loggable {
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

    auto keyUpdate = false;
    switch(e.type) {
      case SDL_KEYDOWN:
        auto key = cast(char)e.key.keysym.sym;
        auto state = ctx.im.state;
        auto once = ctx.im.once;

        if(ctx.im.oldKey == key) break;

        if(!state[key]) once[key] = true;
        else once[key] = false;

        state[key] = true;
        keyUpdate = true;
        break;

      case SDL_KEYUP:
        ctx.im.state[cast(char)e.key.keysym.sym] = false;
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
    if(!keyUpdate){
      ctx.im.oldKey = 0;
      ctx.im.once ^= ctx.im.once;
    }
    //BackGround
    SDL_SetRenderDrawColor(ctx.r,0,0,0,255);
    SDL_RenderClear(ctx.r);

    ctx.root.realLoop;
    SDL_RenderPresent(ctx.r);
  }
}
