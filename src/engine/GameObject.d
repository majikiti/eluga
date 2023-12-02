module engine.GameObject;

import engine;

class GameObject {
  private GameObject[] children;
  private Component[] components;

  void setup() {}
  void loop() {}

  C component(C: Component)() {
    foreach(e; components)
      if(is(e == C)) return cast(C)e;
    return null;
  }

  auto register() => null;

  auto register(T...)(T t) {
    static foreach(e; t) e.register;
    static if(T.length) return null;
    else return t[0];
  }

  T register(T)(T[] t) {
    foreach(e; t) e.register;
    return t.length ? t.front : null;
  }

  GO register(GO: GameObject)(GO go) {
    children ~= go;
    return go;
  }

  C register(C: Component)(C c) {
    if(component!C) {
      writeln("dups!");
      return c;
    }
    c.go = this;
    components ~= c;
    return c;
  }

  package void realSetup() {
    setup;
    foreach(e; children) e.realSetup;
  }

  package void realLoop() {
    loop;
    foreach(e; children) e.realLoop;
  }
}
