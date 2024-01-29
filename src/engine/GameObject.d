module engine.GameObject;

import std;
import sdl;
import engine;

class GameObject: Loggable {
  private GameObject[] children;
  private Component[] components;
  private bool ready = false;
  short layer = 0;
  private bool[string] tags;

  private GameObject _parent;

  bool active = true;
  package auto ref parent() {
    debug if(!_parent.ready) warn("parent (", _parent, ") is not set up yet!");
    return _parent;
  }

  // context

  real dur() const => ctx.elapsed / 8.;
  ulong uptime() const => ctx.updated;
  auto im() const => ctx.im;
  auto everyone() => ctx.root.descendant;
  auto ref debugging() => ctx.debugging;

  // todo: いい感じのRangeにするかもしれないし，しないかもしれない
  private GameObject[] descendant() => children ~ children.map!(e => e.descendant).join;

  // core functions

  void setup() {}
  void loop() {}
  void collide(GameObject go) {}

  void debugSetupPre() {}
  void debugSetup() {}
  void debugLoopPre() {}
  void debugLoop() {}

  package void realSetup() {
    SDL_SetRenderDrawBlendMode(ctx.r, SDL_BLENDMODE_BLEND);

    if(ctx.debugging) {
      layer++;
      debugSetupPre;
      layer--;
    }

    try setup;
    catch(Exception e) err("GameObject exception in setup\n", e);

    if(ctx.debugging) {
      layer++;
      debugSetup;
      layer--;
    }

    ready = true;
  }

  package void realLoop() {
    if(active) foreach(c; components) c.realLoop;

    if(ctx.debugging) {
      layer++;
      debugLoopPre;
      layer--;
    }

    try loop;
    catch(Exception e) err("GameObject exception in loop\n", e);

    if(ctx.debugging) {
      layer++;
      debugLoop;
      layer--;
    }

    foreach(e; children) e.realLoop;
  }

  // utils

  auto render(Texture texture, const SDL_Rect* dest) =>
    render(texture, null, dest);

  void render(Texture texture, const SDL_Rect* src, const SDL_Rect* dest) {
    ctx.layers[layer] ~= {
      SDL_RenderCopy(ctx.r, texture.data, src, dest);
    };
  }

  auto renderEx(
    Texture texture,
    const SDL_Rect* dest,
    real rot,
    const SDL_Point* center = null,
    const SDL_RendererFlip flip = SDL_FLIP_NONE,
  ) => renderEx(texture, null, dest, rot, center, flip);

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

  void color(ubyte r, ubyte g, ubyte b, ubyte a = 255) {
    ctx.layers[layer] ~= {
      SDL_SetRenderDrawColor(ctx.r, r, g, b, a);
    };
  }

  void setTextureOpac(SDL_Texture* txu, ubyte opac) {
    SDL_SetTextureAlphaMod(txu, opac);
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
    children ~= go;
    if(go.ready) {
      go.resurrection;
      return e;
    }
    go._parent = this;
    go.realSetup;
    return e;
  }

  C register(C: Component)(C c) {
    c.go = this;
    if(has!C) {
      warn("registering ", C.stringof, " to ", this, " is duplicate; dropping this");
      return component!C;
    }
    components ~= c;
    c.realSetup;
    return c;
  }

  deprecated
  alias destroy = bye;

  final void bye(bool unregister = true) {
    foreach(e; children) e.bye(false);
    foreach(c; components) c.bye;
    if(unregister) {
      foreach(i, e; parent.children) if(e == this) {
        parent.children = parent.children.remove(i);
        break;
      }
    }
  }

  final void resurrection() {
    foreach(c; components) c.resurrection;
    foreach(e; children) e.resurrection;
  }

  bool has(GO: GameObject)() const => findChildren!GO.e !is null;

  private Tuple!(ulong, "i", GO, "e") findChildren(GO: GameObject)() const {
    foreach(i, e; children) {
      auto res = cast(GO)e;
      if(res) return typeof(return)(i, res);
    }
    enum notFound = typeof(return)(0, null);
    return notFound;
  }

  // Tags

  void addTag(string tag) {
    tags[tag] = true;
  }

  void removeTag(string tag){
    if(tags.get(tag,false)) tags.remove(tag);
  }

  bool getTag(string tag) => tags.get(tag,false);

  auto getTags() => tags.keys;

  auto windowSize() => ctx.windowSize;

  auto getCamera() => ctx.camera;

  void nuke() {
    ctx.running = false;
  }
}
