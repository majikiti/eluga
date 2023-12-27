module engine.Component;

import sdl;
import engine;

class Component: Loggable {
  package GameObject go;
  protected bool active = true;

  // override this!
  void setup() {}
  void loop() {}

  debug {
    void debugSetupPre() {}
    void debugSetup() {}
    void debugLoopPre() {}
    void debugLoop() {}
  }

  package void realSetup() {
    debug debugSetupPre;
    try setup;
    catch(Exception e) err("Component exception in setup()\n", e);
    debug debugSetup;
  }

  package void realLoop() {
    if(!active) return;
    debug debugLoopPre;
    try loop;
    catch(Exception e) err("Component exception in loop()\n", e);
    debug debugLoop;
  }

  // utils

  auto render(A...)(A args) => go.render(args);
  auto renderEx(A...)(A args) => go.renderEx(args);

  void color(ubyte r, ubyte g, ubyte b, ubyte a = 255) => go.color(r, g, b, a);
  auto line(A...)(A args) {
    color(0, 255, 0); // Green
    return go._line(args);
  }
}
