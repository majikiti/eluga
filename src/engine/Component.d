module engine.Component;

import sdl;
import engine;

class Component: Loggable {
  package GameObject go;
  bool active = true;

  // override this!
  void setup() {}
  void loop() {}
  void bye() {}
  void resurrection() {}

  void debugSetupPre() {}
  void debugSetup() {}
  void debugLoopPre() {}
  void debugLoop() {}

  package void realSetup() {
    if(ctx.debugging) {
      go.layer++;
      debugSetupPre;
      go.layer--;
    }

    try setup;
    catch(Exception e) err("Component exception in setup()\n", e);

    if(ctx.debugging) {
      go.layer++;
      debugSetup;
      go.layer--;
    }
  }

  package void realLoop() {
    if(!active) return;

    if(ctx.debugging) {
      go.layer++;
      debugLoopPre;
      go.layer--;
    }

    try loop;
    catch(Exception e) err("Component exception in loop()\n", e);

    if(ctx.debugging) {
      go.layer++;
      debugLoop;
      go.layer--;
    }
  }

  // utils

  void color(ubyte r, ubyte g, ubyte b, ubyte a = 255) => go.color(r, g, b, a);
  void color(ubyte[] c) => c.length != 4 ? warn("Compornent utils-color got wrong array") : go.color(c[0], c[1], c[2], c[3]);
  auto line(A...)(A args) {
    // color(0, 255, 0); // Green
    return go._line(args);
  }
}
