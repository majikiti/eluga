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
  this(GameObject root) {
    ctx.root = root;
    ctx.im = new InputManager;
    ctx.createWin;
    ctx.createRdr;
  }

  void run() {
    ctx.updated = SDL_GetTicks64;
    ctx.root.realSetup;
    debug ctx.root.register(new DebugView);
    log(ctx.windowSize);
    // カメラ(なにもわからん……、とりあえずコンポーネントとしてルートに付ける雑実装)
    ctx.root.register(new Camera(ctx.windowSize/2));
    ctx.root.component!Camera.size = ctx.windowSize;

    loop; // 初回レンダリング
    while(ctx.running) {
      auto cur = SDL_GetTicks64;
      auto elapsed = cur - ctx.updated;
      if(elapsed < ctx.dur) {
        import core.thread;
        Thread.sleep(800.usecs);
        continue;
      }
      ctx.updated = cur;
      ctx.elapsed = elapsed;

      ctx.レンダー中のボックスコライダー持ちのオブジェクト = objectPickup(&ctx,false);
      loop;
    }
  }

  void loop() {
    auto keyUpdated = false;

    SDL_Event e;
    while(SDL_PollEvent(&e)) {
      switch(e.type) {
        case SDL_MOUSEBUTTONDOWN:
        case SDL_KEYDOWN:
          char key;
          if(e.type == SDL_MOUSEBUTTONDOWN){
            auto btn = e.button;
            if(btn.button == SDL_BUTTON_LEFT) key = 253;
            else if(btn.button == SDL_BUTTON_MIDDLE) key = 254;
            else if(btn.button == SDL_BUTTON_RIGHT) key = 255;
          }
          else key = cast(char)e.key.keysym.sym;
          auto state = ctx.im.state;
          auto once = ctx.im.once;

          if(!state[key]) once[key] = true;
          else once[key] = false;

          state[key] = true;
          keyUpdated = true;
          break;

        case SDL_MOUSEBUTTONUP:
        case SDL_KEYUP:
          char key;
          if(e.type == SDL_MOUSEBUTTONUP){
            auto btn = e.button;
            if(btn.button == SDL_BUTTON_LEFT) key = 253;
            else if(btn.button == SDL_BUTTON_MIDDLE) key = 254;
            else if(btn.button == SDL_BUTTON_RIGHT) key = 255;
          }
          else key = cast(char)e.key.keysym.sym;
          ctx.im.state[key] = false;
          break;

        case SDL_MOUSEMOTION:
          auto motion = e.motion;
          break;

        case SDL_QUIT:
          ctx.running = false;
          break;

        default:
      }
    }

    if(!keyUpdated)ctx.im.once ^= ctx.im.once;

    // Collider
    auto gos = objectPickup(&ctx,true);
    foreach(i, p; gos) {
      if(!p.component!BoxCollider.active)continue;
      foreach(j, q; gos[i+1..$]) {
        if(!q.component!BoxCollider.active)continue;
        if(objectsConflict(p, q)) {
          p.collide(q);
          q.collide(p);
        }
      }
    }

    // Camera & Focus
    gos = ctx.root.everyone.filter!(e => e.has!Focus).array;
    ushort prio = ushort.max;
    GameObject gobj = null;
    foreach(i, f; gos){
      if(f.component!Focus.priority == prio) warn("Duplicate Focus priority: ", gobj, ", ", f);
      if(f.component!Focus.priority < prio && f.component!Focus.enable){
        gobj = f;
        prio = f.component!Focus.priority;
      }
    }
    if(gobj!is null) ctx.root.component!Camera.focus(gobj);

    // background
    SDL_SetRenderDrawColor(ctx.r, 0, 0, 0, 255);
    SDL_RenderClear(ctx.r);

    ctx.root.realLoop;
    foreach(layer; ctx.layers.keys.sort)
      foreach(f; ctx.layers[layer]) f();
    ctx.layers = null;

    SDL_RenderPresent(ctx.r);
  }
}

bool objectsConflict(GameObject obj1, GameObject obj2) {
    Vec2 pos1 = obj1.component!Transform.worldPos;
    Vec2 pos2 = obj2.component!Transform.worldPos;
    Vec2 size1 = obj1.component!BoxCollider.worldScale;
    Vec2 size2 = obj2.component!BoxCollider.worldScale;
    Vec2 center1 = pos1 + size1/2;
    Vec2 center2 = pos2 + size2/2;
    
    bool hFlag = abs(center1.y - center2.y) <= (size1.y + size2.y)/2 + 0.5;
    bool wFlag = abs(center1.x - center2.x) <= (size1.x + size2.x)/2 + 0.5;

    return hFlag && wFlag;
}


auto objectPickup(Context* ctx,bool trigger){
    auto gos = ctx.root.everyone.filter!(e => e.has!BoxCollider && e.has!Transform).array;
    GameObject[] res;
    foreach(i, p; gos){
      auto flag = true;
      if(!p.has!Transform) continue;
      if(!p.has!BoxCollider) continue;
      auto col = p.component!BoxCollider;
      flag &= col.active && (!col.isTrigger || trigger);
      flag &= p.has!Transform;
      flag &= p.active;
      auto tform = p.component!Transform;
      flag &= tform.isin(col.size);
      if(flag) res ~= p;
    }
    return res;
}
