module game.Game;

import engine;
import game;

class Game: GameObject {
  Stage stage;

  this() {
    import std;
    writeln("hello!");
    stdout.flush;
    stage = register(new Home);
  }
}
