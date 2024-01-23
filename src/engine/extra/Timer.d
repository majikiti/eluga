module engine.extra.Timer;

import sdl;

// please use "components > NTimer"
deprecated class Timer {
  ulong started = 0;

  this() { reset; }

  auto reset() => started = SDL_GetTicks64;
  auto cur() => SDL_GetTicks64 - started;
}
