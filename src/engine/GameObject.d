module engine.GameObject;

import std;
import sdl;
import engine;

class GameObject: Loggable {
  private GameObject[] children;
  private Component[] components;
  private bool alreadySetup = false;
  short layer = 0;
  private bool[string] tags;

  private GameObject _parent;
  package auto ref parent() {
    debug if(!_parent.alreadySetup) warn("parent (", _parent, ") is not set up yet!");
    return _parent;
  }

  // context

  private Context* _ctx;
  package auto ref ctx(string file = __FILE__, size_t line = __LINE__) {
    debug if(!_ctx) throw new Nullpo("ctx is null!", file, line);
    return _ctx;
  }

  real dur() const => _ctx.elapsed / 10.;
  ulong uptime() const => _ctx.updated;
  auto im() const => _ctx.im;
  auto everyone() => ctx.root.descendant;

  // todo: いい感じのRangeにするかもしれないし，しないかもしれない
  private GameObject[] descendant() => children ~ children.map!(e => e.descendant).join;

  // core functions

  void setup() {}
  void loop() {}
  void collide(GameObject go) {}

  debug {
    void debugSetupPre() {}
    void debugSetup() {}
    void debugLoopPre() {}
    void debugLoop() {}
  }

  package void realSetup(Context* ctx) {
    this._ctx = ctx;
    debug {
      layer++;
      debugSetupPre;
      layer--;
    }
    try setup;
    catch(Exception e) err("GameObject exception in setup\n", e);
    debug {
      layer++;
      debugSetup;
      layer--;
    }
    alreadySetup = true;
  }

  package void realLoop() {
    foreach(c; components) c.realLoop;
    debug {
      layer++;
      debugLoopPre;
      layer--;
    }
    try loop;
    catch(Exception e) err("GameObject exception in loop\n", e);
    debug {
      layer++;
      debugLoop;
      layer--;
    }
    foreach(e; children) e.realLoop;
  }

  // utils

  void render(Texture texture, const SDL_Rect* src, const SDL_Rect* dest) {
    ctx.layers[layer] ~= {
      SDL_RenderCopy(ctx.r, texture.data, src, dest);
    };
  }

  auto render(Texture texture, const SDL_Rect* dest) {
    return render(texture, null, dest);
  }

  void renderEx(
    Texture texture,
    const SDL_Rect* src,
    const SDL_Rect* dest,
    real rot,
    const SDL_Point* center = null,
    const SDL_RendererFlip flip = SDL_FLIP_NONE,
  ) {
    ctx.layers[layer] ~= {
      SDL_RenderCopyEx(ctx.r, texture.data, src, dest, cast(double)rot, center, flip);
    };
  }

  auto renderEx(
    Texture texture,
    const SDL_Rect* dest,
    real rot,
    const SDL_Point* center = null,
    const SDL_RendererFlip flip = SDL_FLIP_NONE,
  ) {
    return renderEx(texture, null, dest, rot, center, flip);
  }

  void color(ubyte r, ubyte g, ubyte b, ubyte a = 255) {
    ctx.layers[layer] ~= {
      SDL_SetRenderDrawColor(ctx.r, r, g, b, a);
    };
  }

  void _line(Vec2 a, Vec2 b) {
    ctx.layers[layer] ~= {
      SDL_RenderDrawLine(ctx.r, cast(int)a.x, cast(int)a.y, cast(int)b.x, cast(int)b.y);
    };
  }

  void renderRect(SDL_Rect* sdlr){
    ctx.layers[layer] ~= {
      SDL_RenderFillRect(ctx.r, sdlr);
    };
  }

  auto line(Vec2 a, Vec2 b) {
    color(255, 0, 0); // Red
    return _line(a, b);
  }

  // components

  C component(C: Component, string file = __FILE__, size_t line = __LINE__)() {
    auto res = findComponent!C.e;
    if(res) return res;
    throw new Nullpo("Component " ~ C.stringof ~ " was not found in " ~ this.toString, file, line);
  }

  bool has(C: Component)() const => findComponent!C.e !is null;

  private Tuple!(ulong, "i", C, "e") findComponent(C: Component)() const {
    foreach(i, e; components) {
      auto res = cast(C)e;
      if(res) return typeof(return)(i, res);
    }
    enum notFound = typeof(return)(0, null);
    return notFound;
  }

  // GO-tree

  auto register(A...)(A a) {
    static foreach(e; a) register(e);
    static if(!A.length) return null;
    else return a[0];
  }

  T register(T)(T[] t) {
    foreach(e; t) register(e);
    return t.length ? t.front : null;
  }

  GO register(GO: GameObject)(GO e) {
    auto go = cast(GameObject)e;
    go._parent = this;
    children ~= go;
    go.realSetup(ctx);
    return e;
  }

  C register(C: Component)(C c) {
    c.go = this;
    if(has!C) {
      warn("registering ", C.stringof, " to ", this, " is duplicate; dropping this");
      warn("hint: you can update component with upsert(component)");
      return component!C;
    }
    components ~= c;
    c.realSetup;
    return c;
  }

  C upsert(C: Component)(C c) {
    c.go = this;
    auto old = findComponent!C;
    if(old.e) components[old.i] = c;
    else components ~= c;
    c.realSetup;
    return c;
  }

  void addTag(string tag) {
    tags[tag] = true;
  }

  void removeTag(string tag){
    if(tags.get(tag,false)) tags.remove(tag);
  }

  bool getTag(string tag) => tags.get(tag,false);

  void quit(){
    ctx.running = false;
  }

  void destroy() {
    foreach(i, e; parent.children) if(e == this) {
      parent.children = parent.children.remove(i);
      return;
    }
  }
}
