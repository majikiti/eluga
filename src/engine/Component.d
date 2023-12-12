module engine.Component;

import engine;

class Component: Loggable {
  package GameObject go;

  // override this!
  void setup() {}
  void loop() {}
}
