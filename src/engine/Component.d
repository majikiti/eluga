module engine.Component;

import engine;

class Component {
  package GameObject go;

  auto register(A...)(A a) {
import std;
writeln("he");stdout.flush;
     go.register(a);
writeln("llo");
stdout.flush;
  }
}
