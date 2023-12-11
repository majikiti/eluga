module engine.Context;

import std.string;
import sdl;

struct Context {
  SDL_Window* w;

  SDL_Window* createWin(string title = "game", int w = 640, int h = 480) =>
    this.w = SDL_CreateWindow(title.toStringz,
                              SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                              w, h,
                              SDL_WINDOW_SHOWN);
}
