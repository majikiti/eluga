module engine.extra.Timer;

import sdl;

class Timer {
  ulong started = 0;

  this(bool autostart = true) {
    if(autostart) start;
  }

  auto start() => started = SDL_GetTicks64;
  auto cur() => SDL_GetTicks64 - started;
}
