module engine.System;

import core.time;
import std;
import sdl;
import sdl_mixer;
import sdl_ttf;
import engine;
import utils;

shared static this() {
  SDL_Init(SDL_INIT_AUDIO | SDL_INIT_VIDEO);
  Mix_OpenAudio(22050, MIX_DEFAULT_FORMAT, 2, 4096);
}

shared static ~this() {
  Mix_CloseAudio;
  SDL_Quit;
}

class System: Loggable {
  Context ctx;

  this(GameObject root) {
    ctx.root = root;
    ctx.im = new InputManager;
    ctx.createWin;
    ctx.createRdr;
  }

  void run() {
    ctx.updated = SDL_GetTicks64;
    ctx.root.realSetup(&ctx);
    debug ctx.root.register(new DebugView);

    loop; // 初回レンダリング
    while(ctx.running) {
      auto cur = SDL_GetTicks64;
      auto elapsed = cur - ctx.updated;
      if(elapsed < ctx.dur) {
        import core.thread.osthread;
        Thread.sleep(800.usecs);
        continue;
      }
      ctx.updated = cur;
      ctx.elapsed = elapsed;

      loop;
    }
  }

  void loop() {
    auto keyUpdated = false;

    SDL_Event e;
    while(SDL_PollEvent(&e)) {
      switch(e.type) {
        case SDL_KEYDOWN:
          auto key = cast(char)e.key.keysym.sym;
          auto state = ctx.im.state;
          auto once = ctx.im.once;

          if(!state[key]) once[key] = true;
          else once[key] = false;

          state[key] = true;
          keyUpdated = true;
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
    }

    if(!keyUpdated)ctx.im.once ^= ctx.im.once;

    // Collider
    auto gos = ctx.root.everyone.filter!(e => e.has!BoxCollider && e.has!Transform).array;
    foreach(i, p; gos) {
      foreach(j, q; gos[i+1..$]) {
        if(objectsConflict(p, q)) {
          p.collide(q);
          q.collide(p);
        }
      }
    }

    //BackGround
    SDL_SetRenderDrawColor(ctx.r,0,0,0,255);
    SDL_RenderClear(ctx.r);

    ctx.root.realLoop;
    SDL_RenderPresent(ctx.r);
  }
}

bool objectsConflict(GameObject obj1, GameObject obj2) {
  auto pos1 = obj1.component!Transform.pos;
  auto pos2 = obj2.component!Transform.pos;
  auto size1 = obj1.component!BoxCollider.size;
  auto size2 = obj2.component!BoxCollider.size;
  return (abs(pos1.x - pos2.x) < size1.x + size2.x) &&
         (abs(pos1.y - pos2.y) < size1.y + size2.y);
}
