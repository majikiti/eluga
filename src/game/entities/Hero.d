module game.entities.Hero;

import engine;

class Hero: GameObject {
  int id;
  int life;
  int type;

  this() {
    import std;
    writeln("Hero constructor");
    stdout.flush;
    register(new Transform, new Transform);
  }

  override void setup() {
    import std;
    writeln("Hero setup()");
  }

  override void loop() {
    import std;
    // writeln(".");
  }
}
