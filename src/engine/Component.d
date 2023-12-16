module engine.Component;

import engine;

class Component: Loggable {
  package GameObject go;
  protected bool active = true;

  // override this!
  void setup() {}
  void loop() {}

  final package void realLoop() {
    if(active) loop;
  }
}
