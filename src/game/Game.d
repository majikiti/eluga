module game.Game;

import engine;
import game;

class Game: GameObject {
  Stage stage;

  this() {
    stage = register(new Home);
  }
}
