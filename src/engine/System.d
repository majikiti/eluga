module engine.System;

import core.time;
import sdl;
import sdl_mixer;
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
    auto ares = Mix_OpenAudio(22050, MIX_DEFAULT_FORMAT, 2, 4096);
  }

  ~this() {
    Mix_CloseAudio();
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

    GameObject[] gos;
    ctx.root.everyone!((e) {
      if(e.components!BoxCollider) gos ~= e;
    });
    foreach(i, jewish; gos){
      foreach(j, palestine; gos[i+1..$]){
        if(isObjectsConflict(jewish, palestine)){
          jewish.onCollisionEnter(palestine);
          palestine.onCollisionEnter(jewish);
        }
      }
    }


    //BackGround
    SDL_SetRenderDrawColor(ctx.r,0,0,0,255);
    SDL_RenderClear(ctx.r);

    ctx.root.realLoop;
    SDL_RenderPresent(ctx.r);
  }

  bool isObjectsConflict(GameObject obj1, GameObject obj2){
    Vec2[4] globalVertex1, globalVertex2; // Upper Left: idx0, Upper Right: idx1, Lower Left: idx2, Lower Right: idx3
    Vec2 signVect = new Vec2(1.0L, 0);

    globalVertex1[0] = obj1.components!Transform.pos - obj1.components!BoxCollider.size/2.0L;
    globalVertex1[3] = obj1.components!Transform.pos + obj1.components!BoxCollider.size/2.0L;
    globalVertex1[1] = absRegion1[0] + obj1.components!BoxCollider.size * signVect;
    globalVertex1[2] = absRegion1[3] - obj1.components!BoxCollider.size * signVect;

    globalVertex2[0] = obj2.components!Transform.pos - obj2.components!BoxCollider.size/2.0L;
    globalVertex2[3] = obj2.components!Transform.pos + obj2.components!BoxCollider.size/2.0L;
    globalVertex2[1] = absRegion2[0] + obj2.components!BoxCollider.size * signVect;
    globalVertex2[2] = absRegion2[3] - obj2.components!BoxCollider.size * signVect;

    bool retval = false;
    foreach(i, ivtx; globalVertex1){
      retval &= (ivtx.x>= globalVertex2[0].x && ivtx.x<=globalVertex2[3].x) && (ivtx.y>=globalVertex2[0].y && ivtx.y<=globalVertex2[3].y);
    }
    foreach(i, ivtx; globalVertex2){
      retval &= (ivtx.x>= globalVertex1[0].x && ivtx.x<=globalVertex1[3].x) && (ivtx.y>=globalVertex1[0].y && ivtx.y<=globalVertex1[3].y);
    }
    return retval;
  }
}
