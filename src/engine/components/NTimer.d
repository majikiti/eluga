module engine.components.NTimer;

import std;
import sdl;
import engine;

alias F = void delegate();

class NTimer: Component {
  ulong started = 0;
  private Tuple!(ulong, "itrvl", ulong, "count")[F] counter;

  this() { reset; }

  auto reset() => started = SDL_GetTicks64;
  auto cur() => SDL_GetTicks64 - started;
  auto sched(F f, ulong itrvl) => counter[f] = tuple(itrvl, 0);

  // interrupter
  override void loop() {
    auto now = cur;
    foreach(F i; counter.keys) {
      auto ctr = &counter[i];
      if(ctr.itrvl * (ctr.count + 1) <= now) {
        i();
        ctr.count++;
      }
    }
  }
}
