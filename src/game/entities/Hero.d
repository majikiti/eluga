module game.entities.Hero;

import engine;

class Hero: GameObject {
  int id;
  int life;
  int type;

  this() {
    register(new Transform);
  }

  override void setup() {
  }

  override void loop() {
  }
}
