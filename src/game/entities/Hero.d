module game.entities.Hero;

import engine;

class Hero: GameObject {
  int id;
  int life;
  int type;

  this() {
    register(new Transform);

    auto hero0 = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void setup() {
  }

  override void loop() {
  }
}
