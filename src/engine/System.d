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

    if(!keyUpdate)ctx.im.once ^= ctx.im.once;

    // Collider
    auto gos = ctx.root.everyone.filter!(e => e.has!BoxCollider && e.has!Transform).array;
    foreach(i, p; gos) {
      foreach(j, q; gos[i+1..$]) {
        auto c = objectsConflict(p, q);
        if(c.a && c.b) {
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

Pair!bool objectsConflict(GameObject obj1, GameObject obj2) {
  // generate Vertex
  auto pos1 = obj1.component!Transform.pos;
  auto v1 = obj1.component!RigidBody.v;
  auto size1 = obj1.component!BoxCollider.size / 2;

  auto pos2 = obj2.component!Transform.pos;
  auto v2 = obj2.component!RigidBody.v;
  auto size2 = obj2.component!BoxCollider.size / 2;

  // checking Vertex Confliction
  auto touched(Vec2 pos1, Vec2 pos2) =>
    (abs(pos1.x - pos2.x) < size1.x + size2.x) &&
    (abs(pos1.y - pos2.y) < size1.y + size2.y);

  auto res1 = touched(pos1 + v1 * Vec2(0, 1), pos2 + v2 * Vec2(0, 1));
  auto res2 = touched(pos1 + v1 * Vec2(1, 0), pos2 + v2 * Vec2(1, 0));

  auto res = Pair!bool(res1, res2);
  if(!res1 && !res2) {
    if(touched(pos1 + v1, pos2 + v2)) res = Pair!bool(true, true);
  }

  return res;
}
