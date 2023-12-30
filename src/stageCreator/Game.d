module stageCreator.Game;

import engine;
import stageCreator;

class Game: GameObject {

  this() {
  }

  override void setup(){
    register(new Cusor);
    register(new TileMap);
  }
}
