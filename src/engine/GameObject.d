module engine.GameObject;

import std.typecons;
import engine;

// todo: destroy
// todo: every

class GameObject: Loggable {
  private GameObject[] children;
  private Component[] components;
  package Context* ctx;

  // core functions

  void setup() {}
  void loop() {}

  package void realSetup(Context* ctx) {
    this.ctx = ctx;
    foreach(c; components) c.setup;
    setup;
    foreach(e; children) e.realSetup(ctx);
  }

  package void realLoop() {
    foreach(c; components) c.loop;
    loop;
    foreach(e; children) e.realLoop;
  }

  // components

  private Tuple!(ulong, "i", C, "e") findComponent(C: Component)() {
    foreach(i, e; components) {
      auto res = cast(C)e;
      if(res) return typeof(return)(i, res);
    }
    return typeof(return)(0, null);
  }

  C component(C: Component)() => findComponent!C.e;

  auto register(A...)(A a) {
    static foreach(e; a) register(e);
    static if(!A.length) return null;
    else return a[0];
  }

  T register(T)(T[] t) {
    foreach(e; t) register(e);
    return t.length ? t.front : null;
  }

  GO register(GO: GameObject)(GO go) {
    children ~= go;
    return go;
  }

  C register(C: Component)(C c) {
    c.go = this;
    auto old = findComponent!C;
    if(old.e) {
      warn("registering ", C.stringof, " to ", this, " is duplicate; dropping old");
      components[old.i] = c;
    } else {
      components ~= c;
    }
    return c;
  }
}
