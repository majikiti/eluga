module engine.System;

import core.time;
import std;
import sdl;
import sdl_mixer;
import sdl_ttf;
import engine;

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

    // Collider
    auto gos = ctx.root.everyone.filter!(e => e.has!BoxCollider && e.has!Transform).array;
    foreach(i, jewish; gos){
      foreach(j, palestine; gos[i+1..$]){
        if(isObjectsConflict(jewish, palestine)){
          jewish.collide(palestine);
          palestine.collide(jewish);
        }
      }
    }

    //BackGround
    SDL_SetRenderDrawColor(ctx.r,0,0,0,255);
    SDL_RenderClear(ctx.r);

    ctx.root.realLoop;
    SDL_RenderPresent(ctx.r);
  }

  Vec2 isObjectsConflict(GameObject obj1, GameObject obj2){
    Vec2 pos1, pos2, size1, size2, v1, v2, new1, new2;
    //Vec2[4] vertex1, vertex2; // Upper Left: idx0, Upper Right: idx1, Lower Left: idx2, Lower Right: idx3
    Vec2 signVect = Vec2(1.0L, 0);
    Vec2 cosVect = Vec2(0, 1.0L);

    // generate Vertex
    pos1 = obj1.component!Transform.pos;
    v1 = obj1.component!RigidBody.v;
    size1 = obj1.component!BoxCollider.size/2.0L;

    pos2 = obj2.component!Transform.pos;
    v2 = obj2.component!RigidBody.v;
    size2 = obj2.component!BoxCollider.size/2.0L;

    // checking Vertex Confliction
    Vec2 retval = Vec2(0, 0);
    foreach(x; [0, 1]){
      foreach(y; [0, 1]){
        if(x == 0 && y == 0) continue;
        new1 = pos1 + v1 * (x * signVect + y * cosVect);
        new2 = pos2 + v2 * (x * signVect + y * cosVect);
        if((abs(new1.x-new2.x) < size1.x+size2.x) || (abs(new1.y-new2.y) < size1.y+size2.y)){
          retval.x |= x;
          retval.y |= y;
        }
      }
    }
    return retval;
  }
}
