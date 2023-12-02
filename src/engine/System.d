module engine.System;

import sdl;
import engine;

class System {
  GameObject root;
  SDL_Window* w;

  this(GameObject root) {
    SDL_Init(SDL_INIT_VIDEO);
    this.root = root;
    this.w = SDL_CreateWindow("game",
                              SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                              100, 100,
                              SDL_WINDOW_SHOWN);
  }

  ~this() {
    SDL_Quit;
  }

  auto run() {
    import std;
    writeln("hello syste!");
    stdout.flush;
    root.realSetup;

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
