module engine.System;

import sdl;
import engine;

class System {
  GameObject root;
  Context ctx;

  this(GameObject root) {
    SDL_Init(SDL_INIT_VIDEO);
    this.root = root;
    ctx.createWin;
  }

  ~this() {
    SDL_Quit;
  }

  auto run() {
    root.realSetup(&ctx);

    while(true) {
      SDL_Event e;
      SDL_PollEvent(&e);

      switch(e.type) {
        case SDL_QUIT: return;
        default: break;
      }

      root.realLoop;
    }
  }
}
