module engine.GameObject;

import engine.components;

class GameObject {
  private GameObject[] children;
  private Component[] components;

  void init() {}
  void loop() {}

  T component(T: Component)() {
    foreach(e; components)
      if(e is T) return e;
    return null;
  }
}
